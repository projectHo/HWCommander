package com.hw.service;

import java.util.List;

import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;

public interface ProcessResourceService {
	public Integer processResourceTypeCodeInfoRegistLogic(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO);
	public List<ProcessResourceTypeCodeInfoVO> getProcessResourceTypeCodeInfoAllList();
	public ProcessResourceTypeCodeInfoVO getProcessResourceTypeCodeInfoByProcessTypeExclusiveCd(String processTypeExclusiveCd);
	
	public Integer processResourceMasterRegistLogic(ProcessResourceMasterVO processResourceMasterVO);
	public List<ProcessResourceMasterVO> getProcessResourceMasterAllList();
	public ProcessResourceMasterVO getProcessResourceMasterById(String id);
}