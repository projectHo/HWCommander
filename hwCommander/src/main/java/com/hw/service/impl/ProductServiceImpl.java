package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.PartsDAO;
import com.hw.dao.ProductDAO;
import com.hw.model.PartsCaseVO;
import com.hw.model.PartsCoolerVO;
import com.hw.model.PartsCpuVO;
import com.hw.model.PartsGpuVO;
import com.hw.model.PartsHddVO;
import com.hw.model.PartsMbVO;
import com.hw.model.PartsPsuVO;
import com.hw.model.PartsRamVO;
import com.hw.model.PartsSfVO;
import com.hw.model.PartsSsdVO;
import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;
import com.hw.service.PartsService;
import com.hw.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
    private ProductDAO productDAO;
	
	@Override
	public Integer productRegistLogic(ProductMasterVO productMasterVO, List<ProductDetailVO> productDetailVOList) {
		int result = 0;
		String maxId = productDAO.getProductMasterVOMaxId();
		
		for(int i = 0; i < productDetailVOList.size(); i++) {
			ProductDetailVO productDetailVO = new ProductDetailVO();
			productDetailVO = productDetailVOList.get(i); 
			productDetailVO.setId(maxId);
			productDetailVO.setSeq(i+1);
			
			productDAO.insertProductDetailVO(productDetailVO);
		}
		
		productMasterVO.setId(maxId);

		result = productDAO.insertProductMasterVO(productMasterVO);
		return result;
	}
	
	@Override
	public List<ProductMasterVO> getProductMasterAllList() {
		return productDAO.getProductMasterAllList();
	}
	
	@Override
	public List<ProductMasterVO> getEventMallList() {
		return productDAO.getEventMallList();
	}
	
	@Override
	public ProductMasterVO getProductMasterById(String id) {
		return productDAO.getProductMasterById(id);
	}
	
	@Override
	public List<ProductDetailVO> getProductDetailById(String id) {
		return productDAO.getProductDetailById(id);
	}
}
