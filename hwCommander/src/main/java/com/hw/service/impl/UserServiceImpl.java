package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.hw.dao.UserDAO;
import com.hw.mail.MailHandler;
import com.hw.mail.TempKey;
import com.hw.model.BanpumMasterVO;
import com.hw.model.PartsGpuVO;
import com.hw.model.UserEscasStorageVO;
import com.hw.model.UserInfoVO;
import com.hw.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
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
		int diChkCount = 0; 
		
		diChkCount = userDAO.getDiDupliChkCount(userInfoVO.getDi());
		
		if(diChkCount > 0) {
			result = 2;
		}else {
			userInfoVO.setUserTypeCd("02");
			userInfoVO.setMailConfirm("N");
			userDAO.insertUserInfo(userInfoVO);
			sendMailByMailConfirm(userInfoVO);
			result = 1;
		}
		
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
	
	@Override
	public List<UserEscasStorageVO> getUserEscasStorageAllList() {
		UserEscasStorageVO searchVO = new UserEscasStorageVO();
		searchVO.setUserId(null);
		return userDAO.getUserEscasStorageAllList(searchVO);
	}
	
	@Override
	public Integer userEscasStorageRegistLogic(UserEscasStorageVO userEscasStorageVO) {
		int insertResult = 0;
		int maxSeq = userDAO.getUserEscasStorageVOMaxSeq(userEscasStorageVO.getUserId());
		userEscasStorageVO.setSeq(maxSeq);
		insertResult = userDAO.insertUserEscasStorageVO(userEscasStorageVO);
		return insertResult;
	}
	
	@Override
	public List<UserEscasStorageVO> getUserEscasStorageVOByUserId(String userId) {
		UserEscasStorageVO searchVO = new UserEscasStorageVO();
		
		searchVO.setUserId(userId);
		List<UserEscasStorageVO> resultList = userDAO.getUserEscasStorageAllList(searchVO);
		
		return resultList;
	}
	
	@Override
	public Integer userEscasStorageUpdateLogic(UserEscasStorageVO userEscasStorageVO) {
		int updateResult = 0;
		updateResult = userDAO.updateUserEscasStorageVO(userEscasStorageVO);
		return updateResult;
	}
	
	@Override
	public Integer userEscasStorageMaxRegistLogic(UserEscasStorageVO userEscasStorageVO) {
		int insertResult = 0;
		int maxSize = 50;
		
		List<UserEscasStorageVO> userEscasStorageVOList = getUserEscasStorageVOByUserId(userEscasStorageVO.getUserId());
		
		if(maxSize != userEscasStorageVOList.size()) {
			return -1;
		}else {
			// max delete 후 받은 vo insert
			UserEscasStorageVO deleteUserEscasStorageVO = userEscasStorageVOList.get(userEscasStorageVOList.size()-1);
			userDAO.deleteUserEscasStorageVO(deleteUserEscasStorageVO);

			insertResult = userEscasStorageRegistLogic(userEscasStorageVO);
			return insertResult;
		}
	}
	
	@Override
	public Integer userEscasStorageDeleteLogic(UserEscasStorageVO userEscasStorageVO) {
		int deleteResult = 0;
		userDAO.deleteUserEscasStorageVO(userEscasStorageVO);
		deleteResult = 1;
		return deleteResult;
	}
	
	private void sendMailByMailConfirm(UserInfoVO userInfoVO) {
		userInfoVO.setMailKey(new TempKey().generateKey(30));
		userDAO.updateMailKey(userInfoVO);
		
		String mailtext = "<h1>HW_COMMANDER 메일인증</h1>"
				+ "<br>"
				+ "<br>" + userInfoVO.getId() + "님, 환영합니다!"
				+ "<br>아래 [이메일 인증]을 눌러주세요."
				+ "<br><a href='http://hwcommander.com/user/mailConfirmLogic.do?mail="+userInfoVO.getMail()
				+ "&mailKey="+userInfoVO.getMailKey()
				+ "' target='_blank'>이메일 인증</a>";
		
		MailHandler mailHandler;
		try {
			mailHandler = new MailHandler(javaMailSender);
			mailHandler.setSubject("[HW_COMMANDER 인증메일 입니다.]");
			mailHandler.setText(mailtext);
			mailHandler.setFrom("hwcommander1@gmail.com" ,"HW_COMMANDER");
			mailHandler.setTo(userInfoVO.getMail());
			mailHandler.send();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
