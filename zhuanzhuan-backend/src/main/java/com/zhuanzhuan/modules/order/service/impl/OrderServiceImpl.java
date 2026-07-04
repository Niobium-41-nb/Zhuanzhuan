package com.zhuanzhuan.modules.order.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DatePattern;
import cn.hutool.core.util.RandomUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.modules.order.dto.OrderCreateDTO;
import com.zhuanzhuan.modules.order.dto.OrderShipDTO;
import com.zhuanzhuan.modules.order.entity.Order;
import com.zhuanzhuan.modules.order.entity.OrderLog;
import com.zhuanzhuan.modules.order.mapper.OrderLogMapper;
import com.zhuanzhuan.modules.order.mapper.OrderMapper;
import com.zhuanzhuan.modules.order.service.OrderService;
import com.zhuanzhuan.modules.order.vo.OrderVO;
import com.zhuanzhuan.modules.product.entity.Product;
import com.zhuanzhuan.modules.product.mapper.ProductMapper;
import com.zhuanzhuan.modules.user.entity.Address;
import com.zhuanzhuan.modules.user.entity.User;
import com.zhuanzhuan.modules.user.mapper.AddressMapper;
import com.zhuanzhuan.modules.user.mapper.UserMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderMapper orderMapper;
    private final OrderLogMapper orderLogMapper;
    private final ProductMapper productMapper;
    private final UserMapper userMapper;
    private final AddressMapper addressMapper;

    @Override
    @Transactional
    public OrderVO create(Long buyerId, OrderCreateDTO dto) {
        Product product = productMapper.selectById(dto.getProductId());
        if (product == null) throw new BusinessException(404, "商品不存在");
        if (!"在售".equals(product.getStatus())) throw new BusinessException(2001, "商品已售出或已下架");

        // Create order
        Order order = new Order();
        order.setOrderNo(generateOrderNo());
        order.setBuyerId(buyerId);
        order.setSellerId(product.getUserId());
        order.setProductId(product.getId());
        order.setTotalPrice(product.getPrice());
        order.setStatus("待付款");
        order.setBuyerRemark(dto.getRemark());

        // Set shipping info from address
        if (dto.getAddressId() != null) {
            Address addr = addressMapper.selectById(dto.getAddressId());
            if (addr != null) {
                order.setShippingName(addr.getReceiver());
                order.setShippingPhone(addr.getPhone());
                order.setShippingAddress(addr.getProvince() + addr.getCity() + addr.getDistrict() + addr.getDetail());
            }
        }

        orderMapper.insert(order);

        // Update product status
        product.setStatus("已售出");
        productMapper.updateById(product);

        // Add order log
        addOrderLog(order.getId(), null, "待付款", "系统", "订单创建");

        return toOrderVO(order);
    }

    @Override
    public IPage<OrderVO> getOrderList(Long userId, String role, String status, int page, int size) {
        Page<Order> pageParam = new Page<>(page, size);
        LambdaQueryWrapper<Order> wrapper = new LambdaQueryWrapper<Order>()
                .eq("buyer".equals(role), Order::getBuyerId, userId)
                .eq("seller".equals(role), Order::getSellerId, userId)
                .eq(status != null && !status.isEmpty(), Order::getStatus, status)
                .orderByDesc(Order::getCreatedAt);

        Page<Order> result = orderMapper.selectPage(pageParam, wrapper);

        IPage<OrderVO> voPage = new Page<>(page, size);
        voPage.setTotal(result.getTotal());
        voPage.setRecords(result.getRecords().stream().map(this::toOrderVO).collect(Collectors.toList()));
        return voPage;
    }

    @Override
    public OrderVO getOrderDetail(Long userId, Long orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) throw new BusinessException(404, "订单不存在");
        return toOrderVO(order);
    }

    @Override
    @Transactional
    public void cancel(Long userId, Long orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) throw new BusinessException(404, "订单不存在");
        if (!order.getBuyerId().equals(userId)) throw new BusinessException(403, "无权操作");
        if (!"待付款".equals(order.getStatus())) throw new BusinessException(3001, "当前状态不允许取消");

        order.setStatus("已取消");
        orderMapper.updateById(order);
        addOrderLog(orderId, "待付款", "已取消", userMapper.selectById(userId).getUsername(), "买家主动取消");

        // Restore product status
        Product product = productMapper.selectById(order.getProductId());
        if (product != null) {
            product.setStatus("在售");
            productMapper.updateById(product);
        }
    }

    @Override
    @Transactional
    public void pay(Long userId, Long orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) throw new BusinessException(404, "订单不存在");
        if (!"待付款".equals(order.getStatus())) throw new BusinessException(3001, "订单状态异常");

        order.setStatus("待发货");
        order.setPaidAt(LocalDateTime.now());
        orderMapper.updateById(order);
        addOrderLog(orderId, "待付款", "待发货", "系统", "支付成功");
    }

    @Override
    @Transactional
    public void ship(Long userId, Long orderId, OrderShipDTO dto) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) throw new BusinessException(404, "订单不存在");
        if (!order.getSellerId().equals(userId)) throw new BusinessException(403, "无权操作");
        if (!"待发货".equals(order.getStatus())) throw new BusinessException(3001, "当前状态不允许发货");

        order.setStatus("待收货");
        order.setLogisticsCompany(dto.getLogisticsCompany());
        order.setLogisticsNo(dto.getLogisticsNo());
        order.setShippedAt(LocalDateTime.now());
        orderMapper.updateById(order);
        addOrderLog(orderId, "待发货", "待收货", "卖家", "已发货");
    }

    @Override
    @Transactional
    public void receive(Long userId, Long orderId) {
        Order order = orderMapper.selectById(orderId);
        if (order == null) throw new BusinessException(404, "订单不存在");
        if (!order.getBuyerId().equals(userId)) throw new BusinessException(403, "无权操作");
        if (!"待收货".equals(order.getStatus())) throw new BusinessException(3001, "当前状态不允许收货");

        order.setStatus("已完成");
        order.setReceivedAt(LocalDateTime.now());
        orderMapper.updateById(order);
        addOrderLog(orderId, "待收货", "已完成", "买家", "确认收货");
    }

    @Override
    public List<Map<String, Object>> getOrderLogs(Long orderId) {
        List<OrderLog> logs = orderLogMapper.selectList(
                new LambdaQueryWrapper<OrderLog>().eq(OrderLog::getOrderId, orderId).orderByAsc(OrderLog::getCreatedAt));
        return logs.stream().map(log -> {
            Map<String, Object> map = new HashMap<>();
            map.put("fromStatus", log.getFromStatus());
            map.put("toStatus", log.getToStatus());
            map.put("operator", log.getOperator());
            map.put("remark", log.getRemark());
            map.put("createdAt", log.getCreatedAt());
            return map;
        }).collect(Collectors.toList());
    }

    private String generateOrderNo() {
        String datePart = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        String randPart = RandomUtil.randomNumbers(6);
        return "ORD" + datePart + randPart;
    }

    private void addOrderLog(Long orderId, String fromStatus, String toStatus, String operator, String remark) {
        OrderLog log = new OrderLog();
        log.setOrderId(orderId);
        log.setFromStatus(fromStatus);
        log.setToStatus(toStatus);
        log.setOperator(operator);
        log.setRemark(remark);
        orderLogMapper.insert(log);
    }

    private OrderVO toOrderVO(Order order) {
        OrderVO vo = new OrderVO();
        BeanUtil.copyProperties(order, vo);
        vo.setOrderId(order.getId());

        // Product info
        Product product = productMapper.selectById(order.getProductId());
        if (product != null) {
            vo.setProductTitle(product.getTitle());
            vo.setProductImage(product.getCoverImage());
        }

        // Buyer/Seller names
        User buyer = userMapper.selectById(order.getBuyerId());
        User seller = userMapper.selectById(order.getSellerId());
        if (buyer != null) vo.setBuyerName(buyer.getNickname() != null ? buyer.getNickname() : buyer.getUsername());
        if (seller != null) vo.setSellerName(seller.getNickname() != null ? seller.getNickname() : seller.getUsername());

        return vo;
    }
}
