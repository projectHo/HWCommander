package com.hw.dao;

import java.util.List;

import com.hw.model.ProcessResourceDetailHistoryVO;
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
	
	public Integer getProcessResourceDetailVOMaxSeq(String id);
	public Integer insertProcessResourceDetailVO(ProcessResourceDetailVO processResourceDetailVO);
	public List<ProcessResourceDetailVO> getProcessResourceDetailAllList(ProcessResourceDetailVO processResourceDetailVO);
	public Integer updateProcessResourceDetailVO(ProcessResourceDetailVO processResourceDetailVO);
	public Integer resourceMappingValueDupliChk(ProcessResourceDetailVO processResourceDetailVO);
	
	public Integer insertProcessResourceDetailHistoryVO(ProcessResourceDetailHistoryVO processResourceDetailHistoryVO);
	public Integer getProcessResourceDetailHistoryVOMaxHistorySeq(ProcessResourceDetailVO processResourceDetailVO);
	
	/*--------------------------------------------------
	 - 견적산출 시 필요한 프로세스 리소스 디테일 이력테이블에서 시점조회
	*--------------------------------------------------*/
	public List<ProcessResourceDetailHistoryVO> getProcessResourceDetailHistoryAllListByTargetDate(String targetDate);
}