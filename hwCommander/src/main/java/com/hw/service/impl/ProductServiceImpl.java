package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.ProductDAO;
import com.hw.model.BanpumMasterVO;
import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;
import com.hw.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
    private ProductDAO productDAO;
	
	@Override
	public Integer productRegistLogic(ProductMasterVO productMasterVO, List<ProductDetailVO> productDetailVOList) {
		int insertResult = 0;
		String maxId = productDAO.getProductMasterVOMaxId();
		
		for(int i = 0; i < productDetailVOList.size(); i++) {
			ProductDetailVO productDetailVO = new ProductDetailVO();
			productDetailVO = productDetailVOList.get(i); 
			productDetailVO.setId(maxId);
			productDetailVO.setSeq(i+1);
			
			if("CASE".equals(productDetailVO.getPartsId().substring(0, 4))) {
				productMasterVO.setProductImage(productDetailVO.getPartsImage());
			}
			
			productDAO.insertProductDetailVO(productDetailVO);
		}
		
		productMasterVO.setId(maxId);

		insertResult = productDAO.insertProductMasterVO(productMasterVO);
		return insertResult;
	}
	
	@Override
	public List<ProductMasterVO> getProductMasterAllList() {
		return productDAO.getProductMasterAllList();
	}
	
	@Override
	public List<ProductMasterVO> getProductMallList() {
		return productDAO.getProductMallList();
	}
	
	@Override
	public ProductMasterVO getProductMasterById(String id) {
		return productDAO.getProductMasterById(id);
	}
	
	@Override
	public List<ProductDetailVO> getProductDetailById(String id) {
		return productDAO.getProductDetailById(id);
	}
	
	@Override
	public Integer productUpdateLogic(ProductMasterVO productMasterVO, List<ProductDetailVO> productDetailVOList) {
		int updateResult = 0;
		String targetId = productMasterVO.getId();
		
		ProductDetailVO deleteVO = new ProductDetailVO();
		deleteVO.setId(targetId);
		
		int delete = productDAO.deleteProductDetailVO(deleteVO);
		
		for(int i = 0; i < productDetailVOList.size(); i++) {
			ProductDetailVO productDetailVO = new ProductDetailVO();
			productDetailVO = productDetailVOList.get(i); 
			productDetailVO.setId(targetId);
			productDetailVO.setSeq(i+1);
			
			productDAO.insertProductDetailVO(productDetailVO);
		}

		updateResult = productDAO.updateProductMasterVO(productMasterVO);
		return updateResult;
	}
	
	@Override
	public List<BanpumMasterVO> getBanpumMasterAllList() {
		BanpumMasterVO searchVO = new BanpumMasterVO();
		searchVO.setExposureYn(null);
		return productDAO.getBanpumMasterAllList(searchVO);
	}
	
	@Override
	public Integer banpumRegistLogic(BanpumMasterVO banpumMasterVO) {
		int insertResult = 0;
		String maxId = productDAO.getBanpumMasterVOMaxId();
		banpumMasterVO.setId(maxId);
		insertResult = productDAO.insertBanpumMasterVO(banpumMasterVO);
		return insertResult;
	}
	
	@Override
	public BanpumMasterVO getBanpumMasterById(String id) {
		return productDAO.getBanpumMasterById(id);
	}
	
	@Override
	public Integer banpumUpdateLogic(BanpumMasterVO banpumMasterVO) {
		int updateResult = 0;
		updateResult = productDAO.updateBanpumMasterVO(banpumMasterVO);
		return updateResult;
	}
	
	@Override
	public List<BanpumMasterVO> getBanpumMasterAllListByExposureYn(String exposureYn) {
		BanpumMasterVO searchVO = new BanpumMasterVO();
		searchVO.setExposureYn(exposureYn);
		return productDAO.getBanpumMasterAllList(searchVO);
	}
}
