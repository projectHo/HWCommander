package com.hw.model;


import lombok.Data;

@Data
public class UserInfoVO {
	private String id;
	private String pw;
	private String userTypeCd;
	private String sexCd;
	private String name;
	private String birth;
	private String hpNumber;
	private String jibunAddr;
	private String roadAddr;
	private String detailAddr;
	private String zipcode;
	private String mail;
	private String mailKey;
	private String mailConfirm;
	private String regDtm;
	private String updtDtm;
	private String di;
	private String delYn;
	private String delDtm;
}