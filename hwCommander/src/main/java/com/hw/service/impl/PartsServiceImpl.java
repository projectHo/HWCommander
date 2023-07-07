package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.PartsDAO;
import com.hw.model.PartsCaseVO;
import com.hw.model.PartsCoolerVO;
import com.hw.model.PartsCpuVO;
import com.hw.model.PartsGpuVO;
import com.hw.model.PartsHddVO;
import com.hw.model.PartsMakerHistoryVO;
import com.hw.model.PartsMakerVO;
import com.hw.model.PartsMbVO;
import com.hw.model.PartsPsuVO;
import com.hw.model.PartsRamVO;
import com.hw.model.PartsSfVO;
import com.hw.model.PartsSsdVO;
import com.hw.service.PartsService;

@Service
public class PartsServiceImpl implements PartsService {
	
	@Autowired
    private PartsDAO partsDAO;
	
	/*--------------------------------------------------
	 - GPU
	*--------------------------------------------------*/
	@Override
	public Integer gpuRegistLogic(PartsGpuVO partsGpuVO) {
		int result = 0;
		partsGpuVO.setId(partsDAO.getPartsGpuVOMaxId());
		result = partsDAO.insertPartsGpuVO(partsGpuVO);
		return result;
	}
	
	@Override
	public List<PartsGpuVO> getGpuAllList() {
		PartsGpuVO searchVO = new PartsGpuVO();
		searchVO.setId(null);
		return partsDAO.getGpuAllList(searchVO);
	}
	
	@Override
	public PartsGpuVO getPartsGpuVOById(String id) {
		PartsGpuVO resultVO = null;
		PartsGpuVO searchVO = new PartsGpuVO();
		
		searchVO.setId(id);
		List<PartsGpuVO> resultList = partsDAO.getGpuAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer gpuUpdateLogic(PartsGpuVO partsGpuVO) {
		int result = 0;
		result = partsDAO.updatePartsGpuVO(partsGpuVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - CPU
	*--------------------------------------------------*/
	@Override
	public Integer cpuRegistLogic(PartsCpuVO partsCpuVO) {
		int result = 0;
		partsCpuVO.setId(partsDAO.getPartsCpuVOMaxId());
		result = partsDAO.insertPartsCpuVO(partsCpuVO);
		return result;
	}
	
	@Override
	public List<PartsCpuVO> getCpuAllList() {
		PartsCpuVO searchVO = new PartsCpuVO();
		searchVO.setId(null);
		return partsDAO.getCpuAllList(searchVO);
	}
	
	@Override
	public PartsCpuVO getPartsCpuVOById(String id) {
		PartsCpuVO resultVO = null;
		PartsCpuVO searchVO = new PartsCpuVO();
		
		searchVO.setId(id);
		List<PartsCpuVO> resultList = partsDAO.getCpuAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer cpuUpdateLogic(PartsCpuVO partsCpuVO) {
		int result = 0;
		result = partsDAO.updatePartsCpuVO(partsCpuVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - MB
	*--------------------------------------------------*/	
	@Override
	public Integer mbRegistLogic(PartsMbVO partsMbVO) {
		int result = 0;
		partsMbVO.setId(partsDAO.getPartsMbVOMaxId());
		result = partsDAO.insertPartsMbVO(partsMbVO);
		return result;
	}
	
	@Override
	public List<PartsMbVO> getMbAllList() {
		PartsMbVO searchVO = new PartsMbVO();
		searchVO.setId(null);
		return partsDAO.getMbAllList(searchVO);
	}
	
	@Override
	public PartsMbVO getPartsMbVOById(String id) {
		PartsMbVO resultVO = null;
		PartsMbVO searchVO = new PartsMbVO();
		
		searchVO.setId(id);
		List<PartsMbVO> resultList = partsDAO.getMbAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer mbUpdateLogic(PartsMbVO partsMbVO) {
		int result = 0;
		result = partsDAO.updatePartsMbVO(partsMbVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - RAM
	*--------------------------------------------------*/
	@Override
	public Integer ramRegistLogic(PartsRamVO partsRamVO) {
		int result = 0;
		partsRamVO.setId(partsDAO.getPartsRamVOMaxId());
		result = partsDAO.insertPartsRamVO(partsRamVO);
		return result;
	}
	
	@Override
	public List<PartsRamVO> getRamAllList() {
		PartsRamVO searchVO = new PartsRamVO();
		searchVO.setId(null);
		return partsDAO.getRamAllList(searchVO);
	}
	
	@Override
	public PartsRamVO getPartsRamVOById(String id) {
		PartsRamVO resultVO = null;
		PartsRamVO searchVO = new PartsRamVO();
		
		searchVO.setId(id);
		List<PartsRamVO> resultList = partsDAO.getRamAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer ramUpdateLogic(PartsRamVO partsRamVO) {
		int result = 0;
		result = partsDAO.updatePartsRamVO(partsRamVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - PSU
	*--------------------------------------------------*/
	@Override
	public Integer psuRegistLogic(PartsPsuVO partsPsuVO) {
		int result = 0;
		partsPsuVO.setId(partsDAO.getPartsPsuVOMaxId());
		result = partsDAO.insertPartsPsuVO(partsPsuVO);
		return result;
	}
	
	@Override
	public List<PartsPsuVO> getPsuAllList() {
		PartsPsuVO searchVO = new PartsPsuVO();
		searchVO.setId(null);
		return partsDAO.getPsuAllList(searchVO);
	}
	
	@Override
	public PartsPsuVO getPartsPsuVOById(String id) {
		PartsPsuVO resultVO = null;
		PartsPsuVO searchVO = new PartsPsuVO();
		
		searchVO.setId(id);
		List<PartsPsuVO> resultList = partsDAO.getPsuAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer psuUpdateLogic(PartsPsuVO partsPsuVO) {
		int result = 0;
		result = partsDAO.updatePartsPsuVO(partsPsuVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - CASE
	*--------------------------------------------------*/
	@Override
	public Integer caseRegistLogic(PartsCaseVO partsCaseVO) {
		int result = 0;
		partsCaseVO.setId(partsDAO.getPartsCaseVOMaxId());
		result = partsDAO.insertPartsCaseVO(partsCaseVO);
		return result;
	}
	
	@Override
	public List<PartsCaseVO> getCaseAllList() {
		PartsCaseVO searchVO = new PartsCaseVO();
		searchVO.setId(null);
		return partsDAO.getCaseAllList(searchVO);
	}
	
	@Override
	public PartsCaseVO getPartsCaseVOById(String id) {
		PartsCaseVO resultVO = null;
		PartsCaseVO searchVO = new PartsCaseVO();
		
		searchVO.setId(id);
		List<PartsCaseVO> resultList = partsDAO.getCaseAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer caseUpdateLogic(PartsCaseVO partsCaseVO) {
		int result = 0;
		result = partsDAO.updatePartsCaseVO(partsCaseVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - COOLER
	*--------------------------------------------------*/
	@Override
	public Integer coolerRegistLogic(PartsCoolerVO partsCoolerVO) {
		int result = 0;
		partsCoolerVO.setId(partsDAO.getPartsCoolerVOMaxId());
		result = partsDAO.insertPartsCoolerVO(partsCoolerVO);
		return result;
	}
	
	@Override
	public List<PartsCoolerVO> getCoolerAllList() {
		PartsCoolerVO searchVO = new PartsCoolerVO();
		searchVO.setId(null);
		return partsDAO.getCoolerAllList(searchVO);
	}
	
	@Override
	public PartsCoolerVO getPartsCoolerVOById(String id) {
		PartsCoolerVO resultVO = null;
		PartsCoolerVO searchVO = new PartsCoolerVO();
		
		searchVO.setId(id);
		List<PartsCoolerVO> resultList = partsDAO.getCoolerAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer coolerUpdateLogic(PartsCoolerVO partsCoolerVO) {
		int result = 0;
		result = partsDAO.updatePartsCoolerVO(partsCoolerVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - HDD
	*--------------------------------------------------*/
	@Override
	public Integer hddRegistLogic(PartsHddVO partsHddVO) {
		int result = 0;
		partsHddVO.setId(partsDAO.getPartsHddVOMaxId());
		result = partsDAO.insertPartsHddVO(partsHddVO);
		return result;
	}
	
	@Override
	public List<PartsHddVO> getHddAllList() {
		PartsHddVO searchVO = new PartsHddVO();
		searchVO.setId(null);
		return partsDAO.getHddAllList(searchVO);
	}
	
	@Override
	public PartsHddVO getPartsHddVOById(String id) {
		PartsHddVO resultVO = null;
		PartsHddVO searchVO = new PartsHddVO();
		
		searchVO.setId(id);
		List<PartsHddVO> resultList = partsDAO.getHddAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer hddUpdateLogic(PartsHddVO partsHddVO) {
		int result = 0;
		result = partsDAO.updatePartsHddVO(partsHddVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - SSD
	*--------------------------------------------------*/
	@Override
	public Integer ssdRegistLogic(PartsSsdVO partsSsdVO) {
		int result = 0;
		partsSsdVO.setId(partsDAO.getPartsSsdVOMaxId());
		result = partsDAO.insertPartsSsdVO(partsSsdVO);
		return result;
	}
	
	@Override
	public List<PartsSsdVO> getSsdAllList() {
		PartsSsdVO searchVO = new PartsSsdVO();
		searchVO.setId(null);
		return partsDAO.getSsdAllList(searchVO);
	}
	
	@Override
	public PartsSsdVO getPartsSsdVOById(String id) {
		PartsSsdVO resultVO = null;
		PartsSsdVO searchVO = new PartsSsdVO();
		
		searchVO.setId(id);
		List<PartsSsdVO> resultList = partsDAO.getSsdAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer ssdUpdateLogic(PartsSsdVO partsSsdVO) {
		int result = 0;
		result = partsDAO.updatePartsSsdVO(partsSsdVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - SF
	*--------------------------------------------------*/
	@Override
	public Integer sfRegistLogic(PartsSfVO partsSfVO) {
		int result = 0;
		partsSfVO.setId(partsDAO.getPartsSfVOMaxId());
		result = partsDAO.insertPartsSfVO(partsSfVO);
		return result;
	}
	
	@Override
	public List<PartsSfVO> getSfAllList() {
		PartsSfVO searchVO = new PartsSfVO();
		searchVO.setId(null);
		return partsDAO.getSfAllList(searchVO);
	}
	
	@Override
	public PartsSfVO getPartsSfVOById(String id) {
		PartsSfVO resultVO = null;
		PartsSfVO searchVO = new PartsSfVO();
		
		searchVO.setId(id);
		List<PartsSfVO> resultList = partsDAO.getSfAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer sfUpdateLogic(PartsSfVO partsSfVO) {
		int result = 0;
		result = partsDAO.updatePartsSfVO(partsSfVO);
		return result;
	}
	
	/*--------------------------------------------------
	 - MAKER
	*--------------------------------------------------*/
	@Override
	public Integer makerRegistLogic(PartsMakerVO partsMakerVO) {
		int result = 0;
		partsMakerVO.setId(partsDAO.getPartsMakerVOMaxId());
		result = partsDAO.insertPartsMakerVO(partsMakerVO);
		
		// 최초 insert 시 이력 등록
		if(1 == result) {
			PartsMakerHistoryVO partsMakerHistoryVO = new PartsMakerHistoryVO();
			partsMakerHistoryVO.setId(partsMakerVO.getId());
			partsMakerHistoryVO.setHistorySeq(1);
			partsMakerHistoryVO.setMakerName(partsMakerVO.getMakerName());
			partsMakerHistoryVO.setAsScore(partsMakerVO.getAsScore());
			result += partsDAO.insertPartsMakerHistoryVO(partsMakerHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public List<PartsMakerVO> getMakerAllList() {
		PartsMakerVO searchVO = new PartsMakerVO();
		searchVO.setId(null);
		return partsDAO.getMakerAllList(searchVO);
	}
	
	@Override
	public PartsMakerVO getPartsMakerVOById(String id) {
		PartsMakerVO resultVO = null;
		PartsMakerVO searchVO = new PartsMakerVO();
		
		searchVO.setId(id);
		List<PartsMakerVO> resultList = partsDAO.getMakerAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer makerUpdateLogic(PartsMakerVO partsMakerVO) {
		int result = 0;
		result = partsDAO.updatePartsMakerVO(partsMakerVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsMakerHistoryVO partsMakerHistoryVO = new PartsMakerHistoryVO();
			partsMakerHistoryVO.setId(partsMakerVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsMakerHistoryVOMaxHistorySeq(partsMakerVO.getId());
			partsMakerHistoryVO.setHistorySeq(maxHistorySeq);
			partsMakerHistoryVO.setMakerName(partsMakerVO.getMakerName());
			partsMakerHistoryVO.setAsScore(partsMakerVO.getAsScore());
			result += partsDAO.insertPartsMakerHistoryVO(partsMakerHistoryVO);
		}
		return result;
	}
}
