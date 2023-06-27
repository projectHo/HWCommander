package com.hw.dao;

import java.util.List;

import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;

public interface ProcessResourceDAO {
	public Integer getCheckDupliChkCount(String checkCode);
	public Integer insertProcessResourceTypeCodeInfoVO(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO);
	public List<ProcessResourceTypeCodeInfoVO> getProcessResourceTypeCodeInfoAllList();
	public ProcessResourceTypeCodeInfoVO getProcessResourceTypeCodeInfoByProcessTypeExclusiveCd(String processTypeExclusiveCd);
	
	public String getProcessResourceMasterVOMaxId();
	public Integer insertProcessResourceMasterVO(ProcessResourceMasterVO processResourceMasterVO);
	public List<ProcessResourceMasterVO> getProcessResourceMasterAllList();
	public ProcessResourceMasterVO getProcessResourceMasterById(String id);
}