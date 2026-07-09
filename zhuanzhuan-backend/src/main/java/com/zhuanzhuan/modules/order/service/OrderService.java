package com.zhuanzhuan.modules.order.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.zhuanzhuan.modules.order.dto.OrderCreateDTO;
import com.zhuanzhuan.modules.order.dto.OrderShipDTO;
import com.zhuanzhuan.modules.order.entity.Order;
import com.zhuanzhuan.modules.order.vo.OrderVO;
import java.util.List;
import java.util.Map;

public interface OrderService {
    OrderVO create(Long buyerId, OrderCreateDTO dto);
    IPage<OrderVO> getOrderList(Long userId, String role, String status, int page, int size);
    OrderVO getOrderDetail(Long userId, Long orderId);
    void cancel(Long userId, Long orderId);
    void pay(Long userId, Long orderId);
    void ship(Long userId, Long orderId, OrderShipDTO dto);
    void receive(Long userId, Long orderId);
    List<Map<String, Object>> getOrderLogs(Long userId, Long orderId);
}
