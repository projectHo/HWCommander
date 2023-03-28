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
	
	@Override
	public Integer gpuRegistLogic(PartsGpuVO partsGpuVO) {
		int result = 0;
		partsGpuVO.setId(partsDAO.getPartsGpuVOMaxId());
		partsDAO.insertPartsGpuVO(partsGpuVO);
		result = 1;
		return result;
	}
	
	public List<PartsGpuVO> getGpuAllList() {
		return partsDAO.getGpuAllList();
	}
	
	@Override
	public Integer cpuRegistLogic(PartsCpuVO partsCpuVO) {
		int result = 0;
		partsCpuVO.setId(partsDAO.getPartsCpuVOMaxId());
		partsDAO.insertPartsCpuVO(partsCpuVO);
		result = 1;
		return result;
	}
	
	public List<PartsCpuVO> getCpuAllList() {
		return partsDAO.getCpuAllList();
	}
	
	@Override
	public Integer mbRegistLogic(PartsMbVO partsMbVO) {
		int result = 0;
		partsMbVO.setId(partsDAO.getPartsMbVOMaxId());
		partsDAO.insertPartsMbVO(partsMbVO);
		result = 1;
		return result;
	}
	
	public List<PartsMbVO> getMbAllList() {
		return partsDAO.getMbAllList();
	}
	
	@Override
	public Integer ramRegistLogic(PartsRamVO partsRamVO) {
		int result = 0;
		partsRamVO.setId(partsDAO.getPartsRamVOMaxId());
		partsDAO.insertPartsRamVO(partsRamVO);
		result = 1;
		return result;
	}
	
	public List<PartsRamVO> getRamAllList() {
		return partsDAO.getRamAllList();
	}
	
	@Override
	public Integer psuRegistLogic(PartsPsuVO partsPsuVO) {
		int result = 0;
		partsPsuVO.setId(partsDAO.getPartsPsuVOMaxId());
		partsDAO.insertPartsPsuVO(partsPsuVO);
		result = 1;
		return result;
	}
	
	public List<PartsPsuVO> getPsuAllList() {
		return partsDAO.getPsuAllList();
	}
	
	@Override
	public Integer caseRegistLogic(PartsCaseVO partsCaseVO) {
		int result = 0;
		partsCaseVO.setId(partsDAO.getPartsCaseVOMaxId());
		partsDAO.insertPartsCaseVO(partsCaseVO);
		result = 1;
		return result;
	}
	
	public List<PartsCaseVO> getCaseAllList() {
		return partsDAO.getCaseAllList();
	}
	
	@Override
	public Integer coolerRegistLogic(PartsCoolerVO partsCoolerVO) {
		int result = 0;
		partsCoolerVO.setId(partsDAO.getPartsCoolerVOMaxId());
		partsDAO.insertPartsCoolerVO(partsCoolerVO);
		result = 1;
		return result;
	}
	
	public List<PartsCoolerVO> getCoolerAllList() {
		return partsDAO.getCoolerAllList();
	}
	
	@Override
	public Integer hddRegistLogic(PartsHddVO partsHddVO) {
		int result = 0;
		partsHddVO.setId(partsDAO.getPartsHddVOMaxId());
		partsDAO.insertPartsHddVO(partsHddVO);
		result = 1;
		return result;
	}
	
	public List<PartsHddVO> getHddAllList() {
		return partsDAO.getHddAllList();
	}
	
	@Override
	public Integer ssdRegistLogic(PartsSsdVO partsSsdVO) {
		int result = 0;
		partsSsdVO.setId(partsDAO.getPartsSsdVOMaxId());
		partsDAO.insertPartsSsdVO(partsSsdVO);
		result = 1;
		return result;
	}
	
	public List<PartsSsdVO> getSsdAllList() {
		return partsDAO.getSsdAllList();
	}
	
	@Override
	public Integer sfRegistLogic(PartsSfVO partsSfVO) {
		int result = 0;
		partsSfVO.setId(partsDAO.getPartsSfVOMaxId());
		partsDAO.insertPartsSfVO(partsSfVO);
		result = 1;
		return result;
	}
	
	public List<PartsSfVO> getSfAllList() {
		return partsDAO.getSfAllList();
	}
}
