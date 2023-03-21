package com.hw.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.AdminDAO;
import com.hw.service.AdminService;
import com.hw.model.PartsGpuVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
    private AdminDAO adminDAO;
	
	@Override
	public List<Map<String, String>> getComnCdDetailList(String comnCd) {
		return adminDAO.getComnCdDetailList(comnCd);
	}
}
