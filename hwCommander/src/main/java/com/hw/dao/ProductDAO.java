package com.hw.dao;

import java.util.List;

import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;

public interface ProductDAO {
	public String getProductMasterVOMaxId();
	public Integer insertProductMasterVO(ProductMasterVO productMasterVO);
	public List<ProductMasterVO> getProductMasterAllList();
	public ProductMasterVO getProductMasterById(String id);
	public Integer updateProductMasterVO(ProductMasterVO productMasterVO);
	
	public Integer insertProductDetailVO(ProductDetailVO productDetailVO);
	public List<ProductDetailVO> getProductDetailById(String id);
	public Integer deleteProductDetailVO(ProductDetailVO productDetailVO);
	
	public List<ProductMasterVO> getEventMallList();
}