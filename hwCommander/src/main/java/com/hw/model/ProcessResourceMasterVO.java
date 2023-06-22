package com.hw.model;


import lombok.Data;

@Data
public class ProcessResourceMasterVO {
	private String id;
	private String processLgCd;
	private String processTypeExclusiveCd;
	private String processName;
	private String regDtm;
	private String updtDtm;
}