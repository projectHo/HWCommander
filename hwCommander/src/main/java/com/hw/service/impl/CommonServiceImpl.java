package com.hw.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.CommonDAO;
import com.hw.service.CommonService;

@Service
public class CommonServiceImpl implements CommonService {
	
	@Autowired
    private CommonDAO commonDAO;
	
	@Override
	public List<Map<String, String>> getComnCdDetailList(String comnCd) {
		return commonDAO.getComnCdDetailList(comnCd);
	}
}
