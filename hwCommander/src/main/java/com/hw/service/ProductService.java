package com.hw.service;

import java.util.List;

import com.hw.model.BanpumMasterVO;
import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;

public interface ProductService {
	public Integer productRegistLogic(ProductMasterVO productMasterVO, List<ProductDetailVO> productDetailVOList);
	public List<ProductMasterVO> getProductMasterAllList();
	public List<ProductMasterVO> getProductMallList();
	public ProductMasterVO getProductMasterById(String id);
	public List<ProductDetailVO> getProductDetailById(String id);
	public Integer productUpdateLogic(ProductMasterVO productMasterVO, List<ProductDetailVO> productDetailVOList);
	
	public List<BanpumMasterVO> getBanpumMasterAllList();
	public Integer banpumRegistLogic(BanpumMasterVO banpumMasterVO);
	public BanpumMasterVO getBanpumMasterById(String id);
	public Integer banpumUpdateLogic(BanpumMasterVO banpumMasterVO);
	public List<BanpumMasterVO> getBanpumMasterAllListByExposureYn(String exposureYn);
	public Integer banpumDeleteLogic(String id);
}