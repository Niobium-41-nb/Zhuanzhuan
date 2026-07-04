package com.zhuanzhuan.modules.product.service;

import com.zhuanzhuan.modules.product.vo.CategoryVO;
import java.util.List;

public interface CategoryService {
    List<CategoryVO> getCategoryTree();
}
