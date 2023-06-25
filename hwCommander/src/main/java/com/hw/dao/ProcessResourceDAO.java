package com.hw.dao;

import java.util.List;

import com.hw.model.ProcessResourceTypeCodeInfoVO;

public interface ProcessResourceDAO {
	public Integer insertProcessResourceTypeCodeInfoVO(ProcessResourceTypeCodeInfoVO processResourceTypeCodeInfoVO);
	public List<ProcessResourceTypeCodeInfoVO> getProcessResourceTypeCodeInfoAllList();
	public ProcessResourceTypeCodeInfoVO getProcessResourceTypeCodeInfoByProcessTypeExclusiveCd(String processTypeExclusiveCd);
}