package com.hw.service;

import java.util.List;

import com.hw.model.UserEscasStorageVO;
import com.hw.model.UserInfoVO;

public interface UserService {
	public Integer getIdDupliChkCount(String id);
	public Integer signUpLogic(UserInfoVO userInfoVO);
	public Integer updateMailKey(UserInfoVO userInfoVO);
	public Integer updateMailConfirm(UserInfoVO userInfoVO);
	public Integer getMailConfirmChkCount(String id);
	public Integer mailConfirmLogic(UserInfoVO userInfoVO);
	public UserInfoVO getUserInfoByIdAndPw(UserInfoVO userInfoVO);
	
	public List<UserEscasStorageVO> getUserEscasStorageAllList();
	public Integer userEscasStorageRegistLogic(UserEscasStorageVO userEscasStorageVO);
	public UserEscasStorageVO getUserEscasStorageVOByUserId(String userId);
	public Integer userEscasStorageUpdateLogic(UserEscasStorageVO userEscasStorageVO);
}