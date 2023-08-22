package com.hw.service;

import java.util.List;

import com.hw.model.PartsCaseVO;
import com.hw.model.PartsCoolerVO;
import com.hw.model.PartsCpuVO;
import com.hw.model.PartsGpuVO;
import com.hw.model.PartsHddVO;
import com.hw.model.PartsMakerVO;
import com.hw.model.PartsMbHistoryVO;
import com.hw.model.PartsMbVO;
import com.hw.model.PartsPsuVO;
import com.hw.model.PartsRamHistoryVO;
import com.hw.model.PartsRamVO;
import com.hw.model.PartsSfVO;
import com.hw.model.PartsSsdVO;

public interface PartsService {
	public Integer gpuRegistLogic(PartsGpuVO partsGpuVO);
	public List<PartsGpuVO> getGpuAllList();
	public PartsGpuVO getPartsGpuVOById(String id);
	public Integer gpuUpdateLogic(PartsGpuVO partsGpuVO);
	
	public Integer cpuRegistLogic(PartsCpuVO partsCpuVO);
	public List<PartsCpuVO> getCpuAllList();
	public PartsCpuVO getPartsCpuVOById(String id);
	public Integer cpuUpdateLogic(PartsCpuVO partsCpuVO);
	
	public Integer mbRegistLogic(PartsMbVO partsMbVO);
	public List<PartsMbVO> getMbAllList();
	public PartsMbVO getPartsMbVOById(String id);
	public Integer mbUpdateLogic(PartsMbVO partsMbVO);
	public PartsMbHistoryVO getPartsMbHistoryVOByIdAndHistorySeq(PartsMbHistoryVO partsMbHistoryVO);
	
	public Integer ramRegistLogic(PartsRamVO partsRamVO);
	public List<PartsRamVO> getRamAllList();
	public PartsRamVO getPartsRamVOById(String id);
	public Integer ramUpdateLogic(PartsRamVO partsRamVO);
	public PartsRamHistoryVO getPartsRamHistoryVOByIdAndHistorySeq(PartsRamHistoryVO partsRamHistoryVO);
	
	public Integer psuRegistLogic(PartsPsuVO partsPsuVO);
	public List<PartsPsuVO> getPsuAllList();
	public PartsPsuVO getPartsPsuVOById(String id);
	public Integer psuUpdateLogic(PartsPsuVO partsPsuVO);
	
	public Integer caseRegistLogic(PartsCaseVO partsCaseVO);
	public List<PartsCaseVO> getCaseAllList();
	public PartsCaseVO getPartsCaseVOById(String id);
	public Integer caseUpdateLogic(PartsCaseVO partsCaseVO);
	
	public Integer coolerRegistLogic(PartsCoolerVO partsCoolerVO);
	public List<PartsCoolerVO> getCoolerAllList();
	public PartsCoolerVO getPartsCoolerVOById(String id);
	public Integer coolerUpdateLogic(PartsCoolerVO partsCoolerVO);
	
	public Integer hddRegistLogic(PartsHddVO partsHddVO);
	public List<PartsHddVO> getHddAllList();
	public PartsHddVO getPartsHddVOById(String id);
	public Integer hddUpdateLogic(PartsHddVO partsHddVO);
	
	public Integer ssdRegistLogic(PartsSsdVO partsSsdVO);
	public List<PartsSsdVO> getSsdAllList();
	public PartsSsdVO getPartsSsdVOById(String id);
	public Integer ssdUpdateLogic(PartsSsdVO partsSsdVO);
	
	public Integer sfRegistLogic(PartsSfVO partsSfVO);
	public List<PartsSfVO> getSfAllList();
	public PartsSfVO getPartsSfVOById(String id);
	public Integer sfUpdateLogic(PartsSfVO partsSfVO);
	
	public Integer makerRegistLogic(PartsMakerVO partsMakerVO);
	public List<PartsMakerVO> getMakerAllList();
	public PartsMakerVO getPartsMakerVOById(String id);
	public Integer makerUpdateLogic(PartsMakerVO partsMakerVO);
}