package com.hw.model;

import lombok.Data;

@Data
public class UserEscasStorageVO {
	// model
	private String userId;
	private int seq;
	private String escasStorageDescription;
	private String escasUrlParameter;
	private String escasLogicVersion;
	private String regDtm;
	private String updtDtm;
}