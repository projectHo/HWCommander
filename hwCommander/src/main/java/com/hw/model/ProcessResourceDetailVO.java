package com.hw.model;


import java.math.BigDecimal;

import lombok.Data;

@Data
public class ProcessResourceDetailVO {
	private String id;
	private int seq;
	private String processTypeExclusiveCd;
	private String processTypeExclusiveCdNm;
	private String processName;
	private String variableChk;
	private String variableChkNm;
	private String resourceName;
	private String resourceMappingValue;
	private BigDecimal resourceScore;
	private String regDtm;
	private String updtDtm;
}