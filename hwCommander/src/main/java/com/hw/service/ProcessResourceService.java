package com.hw.service;

import java.util.List;

import com.hw.model.ProcessResourceDetailVO;
import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;

public interface ProcessResourceService {
	public Integer processResourceTypeCodeInfoRegistLogic(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO);
	public List<ProcessResourceTypeCodeInfoVO> getProcessResourceTypeCodeInfoAllList();
	public ProcessResourceTypeCodeInfoVO getProcessResourceTypeCodeInfoByProcessTypeExclusiveCd(String processTypeExclusiveCd);
	public List<ProcessResourceTypeCodeInfoVO> getProcessResourceTypeCodeInfoByUseYn(String useYn);
	public Integer processResourceTypeCodeInfoUpdateLogic(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO);
	
	public Integer processResourceMasterRegistLogic(ProcessResourceMasterVO processResourceMasterVO);
	public List<ProcessResourceMasterVO> getProcessResourceMasterAllList();
	public ProcessResourceMasterVO getProcessResourceMasterById(String id);
	public Integer processResourceMasterUpdateLogic(ProcessResourceMasterVO processResourceMasterVO);
	
	public Integer processResourceDetailRegistLogic(ProcessResourceDetailVO processResourceDetailVO);
	public List<ProcessResourceDetailVO> getProcessResourceDetailAllList();
	public ProcessResourceDetailVO getProcessResourceDetailByIdAndSeq(String id, int seq);
	public Integer processResourceDetailUpdateLogic(ProcessResourceDetailVO processResourceDetailVO);
}