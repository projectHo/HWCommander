package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsMbVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String mledCd;
	private String mledCdNm;
	private String mmcCd;
	private String mmcCdNm;
	private String mscCd;
	private String mscCdNm;
	private String mbasCd;
	private String mbasCdNm;
	private int port;
	private int scal;
	private int bios;
	private String cpuSocCd;
	private String cpuSocCdNm;
	private float vrmRange;
	private String memSocCd;
	private String memSocCdNm;
	private String scsCd;
	private String scsCdNm;
	private int ff;
	private int pl;
	private int sata;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
	private String multiBulk;
	private int wifi;
}