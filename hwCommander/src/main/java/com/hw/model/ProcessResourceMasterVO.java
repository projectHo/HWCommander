package com.hw.model;


import lombok.Data;

@Data
public class ProcessResourceMasterVO {
	private String id;
	private String processLgCd;
	private String processLgCdNm;
	private String processTypeExclusiveCd;
	private String processTypeExclusiveCdNm;
	private String processName;
	private String regDtm;
	private String updtDtm;
	private int detailHistoryCnt;
}