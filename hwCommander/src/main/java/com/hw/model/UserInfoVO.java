package com.hw.model;

import java.util.Date;

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
	private String addr;
	private String mail;
	private String mailKey;
	private String mailConfirm;
	private Date regDtm;
	private Date updtDtm;
}