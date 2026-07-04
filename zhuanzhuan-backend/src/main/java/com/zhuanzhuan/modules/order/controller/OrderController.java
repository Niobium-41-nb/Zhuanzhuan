package com.zhuanzhuan.modules.order.controller;

import com.zhuanzhuan.common.result.PageResult;
import com.zhuanzhuan.common.result.Result;
import com.zhuanzhuan.modules.order.dto.OrderCreateDTO;
import com.zhuanzhuan.modules.order.dto.OrderShipDTO;
import com.zhuanzhuan.modules.order.dto.ReviewDTO;
import com.zhuanzhuan.modules.order.service.OrderService;
import com.zhuanzhuan.modules.order.service.ReviewService;
import com.zhuanzhuan.modules.order.vo.OrderVO;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/order")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;
    private final ReviewService reviewService;

    private Long getCurrentUserId() {
        return (Long) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    }

    @PostMapping
    public Result<OrderVO> createOrder(@Valid @RequestBody OrderCreateDTO dto) {
        return Result.success("下单成功", orderService.create(getCurrentUserId(), dto));
    }

    @GetMapping("/list")
    public PageResult<OrderVO> getOrderList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(defaultValue = "buyer") String role,
            @RequestParam(required = false) String status) {
        var result = orderService.getOrderList(getCurrentUserId(), role, status, page, size);
        return PageResult.success(result.getRecords(), result.getTotal(), page, size);
    }

    @GetMapping("/{id}")
    public Result<OrderVO> getOrderDetail(@PathVariable Long id) {
        return Result.success(orderService.getOrderDetail(getCurrentUserId(), id));
    }

    @PutMapping("/{id}/cancel")
    public Result<Void> cancelOrder(@PathVariable Long id) {
        orderService.cancel(getCurrentUserId(), id);
        return Result.success("订单已取消");
    }

    @PutMapping("/{id}/pay")
    public Result<Void> payOrder(@PathVariable Long id) {
        orderService.pay(getCurrentUserId(), id);
        return Result.success("支付成功");
    }

    @PutMapping("/{id}/ship")
    public Result<Void> shipOrder(@PathVariable Long id, @Valid @RequestBody OrderShipDTO dto) {
        orderService.ship(getCurrentUserId(), id, dto);
        return Result.success("发货成功");
    }

    @PutMapping("/{id}/receive")
    public Result<Void> receiveOrder(@PathVariable Long id) {
        orderService.receive(getCurrentUserId(), id);
        return Result.success("收货成功");
    }

    @PostMapping("/{id}/review")
    public Result<Map<String, Object>> reviewOrder(@PathVariable Long id, @Valid @RequestBody ReviewDTO dto) {
        return Result.success(reviewService.createReview(getCurrentUserId(), id, dto));
    }

    @GetMapping("/{id}/log")
    public Result<List<Map<String, Object>>> getOrderLogs(@PathVariable Long id) {
        return Result.success(orderService.getOrderLogs(id));
    }
}
