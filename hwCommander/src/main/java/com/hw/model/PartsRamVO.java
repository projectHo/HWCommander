package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsRamVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String rledCd;
	private String rmcCd;
	private String rscCd;
	private int cl;
	private float lt;
	private String prCd;
	private String memSocCd;
	private int ddr4MaxRange;
	private int ddr5MaxRange;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}