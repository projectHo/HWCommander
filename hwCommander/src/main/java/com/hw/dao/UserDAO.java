package com.hw.dao;

import java.util.List;

import com.hw.model.UserInfoVO;

public interface UserDAO {
	public Integer getIdDupliChkCount(String id);
	public Integer insertUserInfo(UserInfoVO userInfoVO);
	public Integer updateMailKey(UserInfoVO userInfoVO);
	public Integer updateMailConfirm(UserInfoVO userInfoVO);
	public Integer getMailConfirmChkCount(String id);
	public List<UserInfoVO> getIdListByMailAndMailKey(UserInfoVO userInfoVO);
	public UserInfoVO getUserInfoByIdAndPw(UserInfoVO userInfoVO);
	public Integer getDiDupliChkCount(String di);
}