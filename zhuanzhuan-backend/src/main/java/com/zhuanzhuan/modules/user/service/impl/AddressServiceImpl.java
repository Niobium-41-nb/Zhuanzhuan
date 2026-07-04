package com.zhuanzhuan.modules.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.modules.user.entity.Address;
import com.zhuanzhuan.modules.user.mapper.AddressMapper;
import com.zhuanzhuan.modules.user.service.AddressService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AddressServiceImpl extends ServiceImpl<AddressMapper, Address> implements AddressService {

    @Override
    public List<Address> getUserAddresses(Long userId) {
        return lambdaQuery().eq(Address::getUserId, userId).list();
    }

    @Override
    @Transactional
    public Address addAddress(Long userId, Address address) {
        address.setUserId(userId);
        address.setId(null);
        long count = lambdaQuery().eq(Address::getUserId, userId).count();
        if (count == 0) {
            address.setIsDefault(1);
        }
        save(address);
        return address;
    }

    @Override
    @Transactional
    public Address updateAddress(Long userId, Long addressId, Address address) {
        Address existing = getById(addressId);
        if (existing == null || !existing.getUserId().equals(userId)) {
            throw new BusinessException("地址不存在");
        }
        address.setId(addressId);
        address.setUserId(userId);
        updateById(address);
        return getById(addressId);
    }

    @Override
    @Transactional
    public void deleteAddress(Long userId, Long addressId) {
        Address existing = getById(addressId);
        if (existing == null || !existing.getUserId().equals(userId)) {
            throw new BusinessException("地址不存在");
        }
        removeById(addressId);
    }

    @Override
    @Transactional
    public void setDefault(Long userId, Long addressId) {
        // Clear all default
        lambdaUpdate().eq(Address::getUserId, userId).set(Address::getIsDefault, 0).update();
        // Set new default
        lambdaUpdate().eq(Address::getId, addressId).eq(Address::getUserId, userId)
                .set(Address::getIsDefault, 1).update();
    }
}
