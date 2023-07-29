package com.hw.dao;

import java.util.List;

import com.hw.model.PartsCaseHistoryVO;
import com.hw.model.PartsCoolerHistoryVO;
import com.hw.model.PartsCpuHistoryVO;
import com.hw.model.PartsGpuHistoryVO;
import com.hw.model.PartsHddHistoryVO;
import com.hw.model.PartsMbHistoryVO;
import com.hw.model.PartsPsuHistoryVO;
import com.hw.model.PartsRamHistoryVO;
import com.hw.model.PartsSfHistoryVO;
import com.hw.model.PartsSsdHistoryVO;
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
	
	/*--------------------------------------------------
	 - 견적산출 시 필요한 부품리스트 이력테이블에서 시점조회
	*--------------------------------------------------*/
	public List<PartsGpuHistoryVO> getGpuHistoryAllListByTargetDate(String targetDate);
	public List<PartsCpuHistoryVO> getCpuHistoryAllListByTargetDate(String targetDate);
	public List<PartsMbHistoryVO> getMbHistoryAllListByTargetDate(String targetDate);
	public List<PartsRamHistoryVO> getRamHistoryAllListByTargetDate(String targetDate);
	public List<PartsPsuHistoryVO> getPsuHistoryAllListByTargetDate(String targetDate);
	public List<PartsCaseHistoryVO> getCaseHistoryAllListByTargetDate(String targetDate);
	public List<PartsCoolerHistoryVO> getCoolerHistoryAllListByTargetDate(String targetDate);
	public List<PartsHddHistoryVO> getHddHistoryAllListByTargetDate(String targetDate);
	public List<PartsSsdHistoryVO> getSsdHistoryAllListByTargetDate(String targetDate);
	public List<PartsSfHistoryVO> getSfHistoryAllListByTargetDate(String targetDate);
	
}