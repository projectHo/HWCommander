package com.hw.service;

import java.util.List;
import java.util.Map;

import com.hw.model.PartsGpuVO;

public interface AdminService {
	public List<Map<String, String>> getComnCdDetailList(String comnCd);
}