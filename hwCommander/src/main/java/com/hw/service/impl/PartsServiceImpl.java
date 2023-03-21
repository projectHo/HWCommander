package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.PartsDAO;
import com.hw.model.PartsGpuVO;
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
}
