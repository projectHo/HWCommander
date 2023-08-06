package com.hw.model;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class EstimateCalculationResultPrivateDetailVO {
	private String gpuId;
	private String cpuId;
	private String mbId;
	private String coolerId;
	private String caseId;
	private String psuId;
	private String ramId;
	private String ssdId;
	private int gpuHistorySeq;
	private int cpuHistorySeq;
	private int mbHistorySeq;
	private int coolerHistorySeq;
	private int caseHistorySeq;
	private int psuHistorySeq;
	private int ramHistorySeq;
	private int ssdHistorySeq;
	private BigDecimal gpuValue;
	private BigDecimal cpuValue;
	private BigDecimal mbValue;
	private BigDecimal coolerValue;
	private BigDecimal caseValue;
	private BigDecimal psuValue;
	private BigDecimal ramValue;
	private BigDecimal ssdValue;
	private BigDecimal totalValue;
}