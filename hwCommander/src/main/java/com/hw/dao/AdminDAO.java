package com.hw.dao;

import java.util.List;
import java.util.Map;

import com.hw.model.PartsGpuVO;

public interface AdminDAO {
	public List<Map<String, String>> getComnCdDetailList(String comnCd);
}