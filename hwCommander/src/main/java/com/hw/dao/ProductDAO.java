package com.hw.dao;

import java.util.List;

import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;

public interface ProductDAO {
	public String getProductMasterVOMaxId();
	public Integer insertProductMasterVO(ProductMasterVO productMasterVO);
	public List<ProductMasterVO> getProductMasterAllList();
	public Integer insertProductDetailVO(ProductDetailVO productDetailVO);
	public List<ProductDetailVO> getProductDetailAllList(ProductMasterVO productMasterVO);
}