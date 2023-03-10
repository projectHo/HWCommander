package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.hw.dao.UserDAO;
import com.hw.mail.MailHandler;
import com.hw.mail.TempKey;
import com.hw.model.UserInfoVO;
import com.hw.service.PartsService;
import com.hw.service.UserService;

@Service
public class PartsServiceImpl implements PartsService {
	
	@Autowired
    private UserDAO userDAO;
	
	@Autowired
    private JavaMailSender javaMailSender;
	
	@Override
	public Integer getIdDupliChkCount(String id) {
		return userDAO.getIdDupliChkCount(id);
	}
	
	@Override
	public Integer signUpLogic(UserInfoVO userInfoVO) {
		int result = 0;
		userInfoVO.setUserTypeCd("02");
		userInfoVO.setMailConfirm("N");
		userDAO.insertUserInfo(userInfoVO);
		sendMailByMailConfirm(userInfoVO);
		result = 1;
		return result;
	}
	
	@Override
	public Integer updateMailKey(UserInfoVO userInfoVO) {
		return userDAO.updateMailKey(userInfoVO);
	}
	
	@Override
	public Integer updateMailConfirm(UserInfoVO userInfoVO) {
		return userDAO.updateMailConfirm(userInfoVO);
	}
	
	@Override
	public Integer getMailConfirmChkCount(String id) {
		return userDAO.getMailConfirmChkCount(id);
	}
	
	@Override
	public Integer mailConfirmLogic(UserInfoVO userInfoVO) {
		int result = 0;
		List<UserInfoVO> userInfoVOList = userDAO.getIdListByMailAndMailKey(userInfoVO);
		
		if(userInfoVOList.size() == 1) {
			userInfoVO.setMailConfirm("Y");
			userDAO.updateMailConfirm(userInfoVO);
			result = 1;
		}
		return result;
	}
	
	@Override
	public UserInfoVO getUserInfoByIdAndPw(UserInfoVO userInfoVO) {
		UserInfoVO result = null;
		result = userDAO.getUserInfoByIdAndPw(userInfoVO);
		if(result == null) {
			result = new UserInfoVO();
			result.setMailConfirm("fail");
		}
		return result;
	}
	
	private void sendMailByMailConfirm(UserInfoVO userInfoVO) {
		userInfoVO.setMailKey(new TempKey().generateKey(30));
		userDAO.updateMailKey(userInfoVO);
		
		String mailtext = "<h1>HW_COMMANDER ????????????</h1>"
				+ "<br>"
				+ "<br>" + userInfoVO.getId() + "???, ???????????????!"
				+ "<br>?????? [????????? ??????]??? ???????????????."
				//todo wonho ????????? ???????????? ????????? ????????????.
				+ "<br><a href='http://localhost:8080/user/mailConfirmLogic.do?mail="+userInfoVO.getMail()
				+ "&mailKey="+userInfoVO.getMailKey()
				+ "' target='_blank'>????????? ??????</a>";
		
		MailHandler mailHandler;
		try {
			mailHandler = new MailHandler(javaMailSender);
			mailHandler.setSubject("[HW_COMMANDER ???????????? ?????????.]");
			mailHandler.setText(mailtext);
			mailHandler.setFrom("hwcommander1@gmail.com" ,"HW_COMMANDER");
			mailHandler.setTo(userInfoVO.getMail());
			mailHandler.send();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
