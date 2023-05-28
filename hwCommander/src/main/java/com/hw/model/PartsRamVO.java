package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsRamVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String rledCd;
	private String rledCdNm;
	private String rmcCd;
	private String rmcCdNm;
	private String rscCd;
	private String rscCdNm;
	private int cl;
	private float lt;
	private String prCd;
	private String prCdNm;
	private String memSocCd;
	private String memSocCdNm;
	private int ddr4MaxRange;
	private int ddr5MaxRange;
	private String partsImage;
	private String regDtm;
	private String updtDtm;
	private String multiBulk;
	private int volume;
}