package com.hw.service;

import java.util.List;

import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;

public interface ProductService {
	public Integer productRegistLogic(ProductMasterVO productMasterVO, List<ProductDetailVO> productDetailVOList);
	public List<ProductMasterVO> getProductMasterAllList();
	public List<ProductDetailVO> getProductDetailAllList(ProductMasterVO productMasterVO);
}