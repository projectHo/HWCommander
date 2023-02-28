package com.hw.service;

import com.hw.model.UserInfoVO;

public interface PartsService {
	public Integer getIdDupliChkCount(String id);
	public Integer signUpLogic(UserInfoVO userInfoVO);
	public Integer updateMailKey(UserInfoVO userInfoVO);
	public Integer updateMailConfirm(UserInfoVO userInfoVO);
	public Integer getMailConfirmChkCount(String id);
	public Integer mailConfirmLogic(UserInfoVO userInfoVO);
	public UserInfoVO getUserInfoByIdAndPw(UserInfoVO userInfoVO);
}