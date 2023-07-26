package com.hw.model;

import java.math.BigDecimal;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PartsCaseHistoryVO {
	private String id;
	private int historySeq;
	private String partsName;
	private int partsPrice;
	private String partsPriceStr;
	private String cledCd;
	private String cledCdNm;
	private String cmCd;
	private String cmCdNm;
	private String cmcCd;
	private String cmcCdNm;
	private String cscCd;
	private String cscCdNm;
//	private String caseasCd;
//	private String caseasCdNm;
	private String makerId;
	private String makerNm;
	private BigDecimal adap;
	private BigDecimal cool;
	private BigDecimal end;
	private BigDecimal conv;
	private int ff;
	private int iw;
	private int il;
	private int ih;
	private int it;
	private int fh;
	private int ft;
	private int strTwoDotFive;
	private int strThreeDotFive;
	private String partsImage;
	private String regDtm;
	private String multiBulk;
}