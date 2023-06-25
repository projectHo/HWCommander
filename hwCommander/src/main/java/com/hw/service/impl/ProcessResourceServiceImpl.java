package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.ProcessResourceDAO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;
import com.hw.service.ProcessResourceService;

@Service
public class ProcessResourceServiceImpl implements ProcessResourceService {
	
	@Autowired
    private ProcessResourceDAO processResourceDAO;
	
	@Override
	public Integer processResourceTypeCodeInfoRegistLogic(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO) {
		int insertResult = 0;
		insertResult = processResourceDAO.insertProcessResourceTypeCodeInfoVO(processResourceTypeCodeInfoVO);
		return insertResult;
	}
	
	@Override
	public List<ProcessResourceTypeCodeInfoVO> getProcessResourceTypeCodeInfoAllList() {
		return processResourceDAO.getProcessResourceTypeCodeInfoAllList();
	}
	
	
	@Override
	public ProcessResourceTypeCodeInfoVO getProcessResourceTypeCodeInfoByProcessTypeExclusiveCd(String processTypeExclusiveCd) {
		return processResourceDAO.getProcessResourceTypeCodeInfoByProcessTypeExclusiveCd(processTypeExclusiveCd);
	}
	
}
