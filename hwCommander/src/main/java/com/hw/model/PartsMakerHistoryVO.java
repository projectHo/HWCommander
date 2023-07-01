package com.hw.model;

import lombok.Data;

@Data
public class PartsMakerHistoryVO {
	private String id;
	private int historySeq;
	private String makerName;
	private int asScore;
	private String regDtm;
	private String updtDtm;
}