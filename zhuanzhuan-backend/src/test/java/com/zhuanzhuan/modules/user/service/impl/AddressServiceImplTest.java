package com.zhuanzhuan.modules.user.service.impl;

import com.zhuanzhuan.common.exception.BusinessException;
import com.zhuanzhuan.modules.user.entity.Address;
import com.zhuanzhuan.modules.user.mapper.AddressMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AddressServiceImplTest {

    @Mock
    private AddressMapper addressMapper;

    private AddressServiceImpl addressService;

    @BeforeEach
    void setUp() {
        addressService = new AddressServiceImpl();
        // Set the baseMapper so MyBatis-Plus lambdaQuery/lambdaUpdate works
        ReflectionTestUtils.setField(addressService, "baseMapper", addressMapper);
    }

    @Test
    void testAddAddress_FirstAsDefault() {
        when(addressMapper.selectCount(any())).thenReturn(0L);
        when(addressMapper.insert(any(Address.class))).thenReturn(1);

        Address address = new Address();
        address.setReceiver("测试用户");
        address.setPhone("13800138000");
        address.setDetail("测试地址");

        Address result = addressService.addAddress(1L, address);

        assertEquals(1, result.getIsDefault());
        assertEquals(1L, result.getUserId());
        assertEquals("测试用户", result.getReceiver());
        assertNull(result.getId());
    }

    @Test
    void testAddAddress_NotDefault() {
        when(addressMapper.selectCount(any())).thenReturn(3L);
        when(addressMapper.insert(any(Address.class))).thenReturn(1);

        Address address = new Address();
        address.setReceiver("另一个用户");

        Address result = addressService.addAddress(1L, address);

        assertNull(result.getIsDefault());
    }

    @Test
    void testUpdateAddress_Success() {
        Address existing = new Address();
        existing.setId(1L);
        existing.setUserId(1L);

        when(addressMapper.selectById(1L)).thenReturn(existing, existing);

        Address update = new Address();
        update.setReceiver("新收件人");

        Address result = addressService.updateAddress(1L, 1L, update);

        assertNotNull(result);
        verify(addressMapper).updateById(any(Address.class));
    }

    @Test
    void testUpdateAddress_NotFound() {
        when(addressMapper.selectById(999L)).thenReturn(null);

        assertThrows(BusinessException.class,
                () -> addressService.updateAddress(1L, 999L, new Address()));
    }

    @Test
    void testUpdateAddress_NotOwned() {
        Address existing = new Address();
        existing.setId(1L);
        existing.setUserId(2L);

        when(addressMapper.selectById(1L)).thenReturn(existing);

        assertThrows(BusinessException.class,
                () -> addressService.updateAddress(1L, 1L, new Address()));
    }

    @Test
    void testDeleteAddress_Success() {
        Address existing = new Address();
        existing.setId(1L);
        existing.setUserId(1L);

        when(addressMapper.selectById(1L)).thenReturn(existing);

        addressService.deleteAddress(1L, 1L);

        verify(addressMapper).deleteById(1L);
    }

    @Test
    void testDeleteAddress_NotFound() {
        when(addressMapper.selectById(999L)).thenReturn(null);

        assertThrows(BusinessException.class,
                () -> addressService.deleteAddress(1L, 999L));
    }

    @Test
    void testSetDefault() {
        addressService.setDefault(1L, 2L);

        verify(addressMapper, atLeast(2)).update(any(), any());
    }
}
