package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.ProcessResourceDAO;
import com.hw.model.PartsGpuVO;
import com.hw.model.PartsMakerHistoryVO;
import com.hw.model.ProcessResourceDetailHistoryVO;
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
		int result = 0;
		int checkCodeCnt = processResourceDAO.getCheckDupliChkCount(processResourceTypeCodeInfoVO.getProcessTypeExclusiveCd());
		
		if(checkCodeCnt == 0) {
			result = processResourceDAO.insertProcessResourceTypeCodeInfoVO(processResourceTypeCodeInfoVO);
		}else {
			result = -2;
		}
		
		return result;
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
		int result = 0;
		processResourceMasterVO.setId(processResourceDAO.getProcessResourceMasterVOMaxId());
		result = processResourceDAO.insertProcessResourceMasterVO(processResourceMasterVO);
		return result;
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
		int result = 0;
		
		int seq = processResourceDAO.getProcessResourceDetailVOMaxSeq(processResourceDetailVO.getId());
		processResourceDetailVO.setSeq(seq);
		
		result = processResourceDAO.insertProcessResourceDetailVO(processResourceDetailVO);
		
		// 최초 insert 시 이력 등록
		if(1 == result) {
			ProcessResourceDetailHistoryVO processResourceDetailHistoryVO = new ProcessResourceDetailHistoryVO();
			processResourceDetailHistoryVO.setId(processResourceDetailVO.getId());
			processResourceDetailHistoryVO.setSeq(processResourceDetailVO.getSeq());
			processResourceDetailHistoryVO.setHistorySeq(1);
			processResourceDetailHistoryVO.setVariableChk(processResourceDetailVO.getVariableChk());
			processResourceDetailHistoryVO.setResourceName(processResourceDetailVO.getResourceName());
			processResourceDetailHistoryVO.setResourceMappingValue(processResourceDetailVO.getResourceMappingValue());
			processResourceDetailHistoryVO.setResourceScore(processResourceDetailVO.getResourceScore());
			result += processResourceDAO.insertProcessResourceDetailHistoryVO(processResourceDetailHistoryVO);
		}
		
		return result;
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
		int result = 0;
		result = processResourceDAO.updateProcessResourceDetailVO(processResourceDetailVO);
		
		// update 시 이력등록
		if(1 == result) {
			ProcessResourceDetailHistoryVO processResourceDetailHistoryVO = new ProcessResourceDetailHistoryVO();
			processResourceDetailHistoryVO.setId(processResourceDetailVO.getId());
			processResourceDetailHistoryVO.setSeq(processResourceDetailVO.getSeq());
			
			int maxHistorySeq = processResourceDAO.getProcessResourceDetailHistoryVOMaxHistorySeq(processResourceDetailVO);
			processResourceDetailHistoryVO.setHistorySeq(maxHistorySeq);
			processResourceDetailHistoryVO.setVariableChk(processResourceDetailVO.getVariableChk());
			processResourceDetailHistoryVO.setResourceName(processResourceDetailVO.getResourceName());
			processResourceDetailHistoryVO.setResourceMappingValue(processResourceDetailVO.getResourceMappingValue());
			processResourceDetailHistoryVO.setResourceScore(processResourceDetailVO.getResourceScore());
			result += processResourceDAO.insertProcessResourceDetailHistoryVO(processResourceDetailHistoryVO);
		}
		
		return result;
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
	
	@Override
	public Integer resourceMappingValueDupliChk(ProcessResourceDetailVO processResourceDetailVO) {
		return processResourceDAO.resourceMappingValueDupliChk(processResourceDetailVO);
	}
	
	@Override
	public List<ProcessResourceDetailVO> qudtlsTlqkf(String id) {
		ProcessResourceDetailVO searchVO = new ProcessResourceDetailVO();
		
		searchVO.setId(id);
		searchVO.setSeq(0);
		
		return processResourceDAO.getProcessResourceDetailAllList(searchVO);
	}
}
