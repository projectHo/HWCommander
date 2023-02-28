package com.hw.model;

import java.util.Date;

import lombok.Data;

@Data
public class PartsMbVO {
	private String id;
	private String partsName;
	private int partsPrice;
	private String mledCd;
	private String mmcCd;
	private String mscCd;
	private String mbasCd;
	private int port;
	private int scal;
	private int bios;
	private String cpuSocCd;
	private float vrmRange;
	private String memSocCd;
	private String scsCd;
	private int ff;
	private int pl;
	private int sata;
	private String partsImage;
	private Date regDtm;
	private Date updtDtm;
}