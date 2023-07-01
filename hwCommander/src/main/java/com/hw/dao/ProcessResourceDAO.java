package com.hw.dao;

import java.util.List;

import com.hw.model.ProcessResourceDetailVO;
import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;

public interface ProcessResourceDAO {
	public Integer getCheckDupliChkCount(String checkCode);
	public Integer insertProcessResourceTypeCodeInfoVO(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO);
	public List<ProcessResourceTypeCodeInfoVO> getProcessResourceTypeCodeInfoAllList(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO);
	public Integer updateProcessResourceTypeCodeInfoVO(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO);
	
	public String getProcessResourceMasterVOMaxId();
	public Integer insertProcessResourceMasterVO(ProcessResourceMasterVO processResourceMasterVO);
	public List<ProcessResourceMasterVO> getProcessResourceMasterAllList(ProcessResourceMasterVO processResourceMasterVO);
	public Integer updateProcessResourceMasterVO(ProcessResourceMasterVO processResourceMasterVO);
	
	public Integer insertProcessResourceDetailVO(ProcessResourceDetailVO processResourceDetailVO);
	public List<ProcessResourceDetailVO> getProcessResourceDetailAllList(ProcessResourceDetailVO processResourceDetailVO);
}