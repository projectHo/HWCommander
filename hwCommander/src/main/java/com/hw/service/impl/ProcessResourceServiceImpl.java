package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.ProcessResourceDAO;
import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;
import com.hw.service.ProcessResourceService;

@Service
public class ProcessResourceServiceImpl implements ProcessResourceService {
	
	@Autowired
    private ProcessResourceDAO processResourceDAO;
	
	@Override
	public Integer processResourceTypeCodeInfoRegistLogic(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO) {
		int insertResult = 0;
		int checkCodeCnt = processResourceDAO.getCheckDupliChkCount(processResourceTypeCodeInfoVO.getProcessTypeExclusiveCd());
		
		if(checkCodeCnt == 0) {
			insertResult = processResourceDAO.insertProcessResourceTypeCodeInfoVO(processResourceTypeCodeInfoVO);
		}else {
			insertResult = -2;
		}
		
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
	
	
	@Override
	public Integer processResourceMasterRegistLogic(ProcessResourceMasterVO processResourceMasterVO) {
		int insertResult = 0;
		processResourceMasterVO.setId(processResourceDAO.getProcessResourceMasterVOMaxId());
		insertResult = processResourceDAO.insertProcessResourceMasterVO(processResourceMasterVO);
		return insertResult;
	}
	
	@Override
	public List<ProcessResourceMasterVO> getProcessResourceMasterAllList() {
		return processResourceDAO.getProcessResourceMasterAllList();
	}
	
	@Override
	public ProcessResourceMasterVO getProcessResourceMasterById(String id) {
		return processResourceDAO.getProcessResourceMasterById(id);
	}
	
}
