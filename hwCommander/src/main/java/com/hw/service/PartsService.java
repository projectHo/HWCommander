package com.hw.service;

import java.util.List;

import com.hw.model.PartsGpuVO;

public interface PartsService {
	public Integer gpuRegistLogic(PartsGpuVO partsGpuVO);
	public List<PartsGpuVO> getGpuAllList();
}