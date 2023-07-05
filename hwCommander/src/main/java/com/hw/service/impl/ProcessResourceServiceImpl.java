package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.ProcessResourceDAO;
import com.hw.model.PartsGpuVO;
import com.hw.model.ProcessResourceDetailVO;
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
		ProcessResourceTypeCodeInfoVO searchVO = new ProcessResourceTypeCodeInfoVO();
		searchVO.setProcessTypeExclusiveCd(null);
		searchVO.setUseYn(null);
		return processResourceDAO.getProcessResourceTypeCodeInfoAllList(searchVO);
	}
	
	@Override
	public ProcessResourceTypeCodeInfoVO getProcessResourceTypeCodeInfoByProcessTypeExclusiveCd(String processTypeExclusiveCd) {
		ProcessResourceTypeCodeInfoVO resultVO = null;
		ProcessResourceTypeCodeInfoVO searchVO = new ProcessResourceTypeCodeInfoVO();
		
		searchVO.setProcessTypeExclusiveCd(processTypeExclusiveCd);
		List<ProcessResourceTypeCodeInfoVO> resultList = processResourceDAO.getProcessResourceTypeCodeInfoAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public List<ProcessResourceTypeCodeInfoVO> getProcessResourceTypeCodeInfoByUseYn(String useYn) {
		ProcessResourceTypeCodeInfoVO searchVO = new ProcessResourceTypeCodeInfoVO();
		searchVO.setUseYn(useYn);
		return processResourceDAO.getProcessResourceTypeCodeInfoAllList(searchVO);
	}
	
	@Override
	public Integer processResourceTypeCodeInfoUpdateLogic(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO) {
		return processResourceDAO.updateProcessResourceTypeCodeInfoVO(processResourceTypeCodeInfoVO);
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
		ProcessResourceMasterVO searchVO = new ProcessResourceMasterVO();
		searchVO.setId(null);
		return processResourceDAO.getProcessResourceMasterAllList(searchVO);
	}
	
	@Override
	public ProcessResourceMasterVO getProcessResourceMasterById(String id) {
		ProcessResourceMasterVO resultVO = null;
		ProcessResourceMasterVO searchVO = new ProcessResourceMasterVO();
		
		searchVO.setId(id);
		List<ProcessResourceMasterVO> resultList = processResourceDAO.getProcessResourceMasterAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer processResourceMasterUpdateLogic(ProcessResourceMasterVO processResourceMasterVO) {
		return processResourceDAO.updateProcessResourceMasterVO(processResourceMasterVO);
	}
	
	@Override
	public Integer processResourceDetailRegistLogic(ProcessResourceDetailVO processResourceDetailVO) {
		int insertResult = 0;
		insertResult = processResourceDAO.insertProcessResourceDetailVO(processResourceDetailVO);
		return insertResult;
	}
	
	@Override
	public List<ProcessResourceDetailVO> getProcessResourceDetailAllList() {
		ProcessResourceDetailVO searchVO = new ProcessResourceDetailVO();
		searchVO.setId(null);
		searchVO.setSeq(0);
		return processResourceDAO.getProcessResourceDetailAllList(searchVO);
	}
	
	@Override
	public Integer processResourceDetailUpdateLogic(ProcessResourceDetailVO processResourceDetailVO) {
		return processResourceDAO.updateProcessResourceDetailVO(processResourceDetailVO);
	}
	
	@Override
	public ProcessResourceDetailVO getProcessResourceDetailByIdAndSeq(String id, int seq) {
		ProcessResourceDetailVO resultVO = null;
		ProcessResourceDetailVO searchVO = new ProcessResourceDetailVO();
		
		searchVO.setId(id);
		searchVO.setSeq(seq);
		
		List<ProcessResourceDetailVO> resultList = processResourceDAO.getProcessResourceDetailAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		return resultVO;
	}
	
}
