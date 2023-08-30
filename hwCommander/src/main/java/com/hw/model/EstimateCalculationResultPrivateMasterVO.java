package com.hw.model;

import lombok.Data;

@Data
public class EstimateCalculationResultPrivateMasterVO {
	private Boolean errChk;
	private String errMsg;
	private EstimateCalculationResultPrivateDetailVO selectProduct;
	private String createProductId;
}