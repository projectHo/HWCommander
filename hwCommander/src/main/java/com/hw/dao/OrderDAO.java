package com.hw.dao;


public interface OrderDAO {
	public String getOrderMasterVOUniqueId();
	public Integer getOrderMasterVOIdDupliChkCount(String id);
}