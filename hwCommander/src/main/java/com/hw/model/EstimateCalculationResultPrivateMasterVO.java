package com.hw.model;

import java.util.List;

import lombok.Data;

@Data
public class EstimateCalculationResultPrivateMasterVO {
	private boolean errChk;
	private String errMsg;
	private List<EstimateCalculationResultPrivateDetailVO> estimateCalculationResultPrivateDetailVOList;
	private EstimateCalculationResultPrivateDetailVO selectProduct;
}