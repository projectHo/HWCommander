package com.hw.service;

import java.util.List;

import com.hw.model.PartsCaseVO;
import com.hw.model.PartsCoolerVO;
import com.hw.model.PartsCpuVO;
import com.hw.model.PartsGpuVO;
import com.hw.model.PartsHddVO;
import com.hw.model.PartsMbVO;
import com.hw.model.PartsPsuVO;
import com.hw.model.PartsRamVO;
import com.hw.model.PartsSfVO;
import com.hw.model.PartsSsdVO;

public interface PartsService {
	public Integer gpuRegistLogic(PartsGpuVO partsGpuVO);
	public List<PartsGpuVO> getGpuAllList();
	public Integer cpuRegistLogic(PartsCpuVO partsCpuVO);
	public List<PartsCpuVO> getCpuAllList();
	public Integer mbRegistLogic(PartsMbVO partsMbVO);
	public List<PartsMbVO> getMbAllList();
	public Integer ramRegistLogic(PartsRamVO partsRamVO);
	public List<PartsRamVO> getRamAllList();
	public Integer psuRegistLogic(PartsPsuVO partsPsuVO);
	public List<PartsPsuVO> getPsuAllList();
	public Integer caseRegistLogic(PartsCaseVO partsCaseVO);
	public List<PartsCaseVO> getCaseAllList();
	public Integer coolerRegistLogic(PartsCoolerVO partsCoolerVO);
	public List<PartsCoolerVO> getCoolerAllList();
	public Integer hddRegistLogic(PartsHddVO partsHddVO);
	public List<PartsHddVO> getHddAllList();
	public Integer ssdRegistLogic(PartsSsdVO partsSsdVO);
	public List<PartsSsdVO> getSsdAllList();
	public Integer sfRegistLogic(PartsSfVO partsSfVO);
	public List<PartsSfVO> getSfAllList();
}