package com.zhuanzhuan.modules.user.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zhuanzhuan.modules.user.entity.Address;
import java.util.List;

public interface AddressService extends IService<Address> {
    List<Address> getUserAddresses(Long userId);
    Address addAddress(Long userId, Address address);
    Address updateAddress(Long userId, Long addressId, Address address);
    void deleteAddress(Long userId, Long addressId);
    void setDefault(Long userId, Long addressId);
}
