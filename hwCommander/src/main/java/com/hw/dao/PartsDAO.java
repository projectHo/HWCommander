package com.hw.dao;

import java.util.List;

import com.hw.model.PartsGpuVO;

public interface PartsDAO {
	public String getPartsGpuVOMaxId();
	public Integer insertPartsGpuVO(PartsGpuVO partsGpuVO);
	public List<PartsGpuVO> getGpuAllList();
}