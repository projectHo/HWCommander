package com.hw.dao;

import java.util.List;

import com.hw.model.PartsCaseHistoryVO;
import com.hw.model.PartsCaseVO;
import com.hw.model.PartsCoolerHistoryVO;
import com.hw.model.PartsCoolerVO;
import com.hw.model.PartsCpuHistoryVO;
import com.hw.model.PartsCpuVO;
import com.hw.model.PartsGpuHistoryVO;
import com.hw.model.PartsGpuVO;
import com.hw.model.PartsHddHistoryVO;
import com.hw.model.PartsHddVO;
import com.hw.model.PartsMakerHistoryVO;
import com.hw.model.PartsMakerVO;
import com.hw.model.PartsMbHistoryVO;
import com.hw.model.PartsMbVO;
import com.hw.model.PartsPsuHistoryVO;
import com.hw.model.PartsPsuVO;
import com.hw.model.PartsRamHistoryVO;
import com.hw.model.PartsRamVO;
import com.hw.model.PartsSfHistoryVO;
import com.hw.model.PartsSfVO;
import com.hw.model.PartsSsdHistoryVO;
import com.hw.model.PartsSsdVO;

public interface PartsDAO {
	public String getPartsGpuVOMaxId();
	public Integer insertPartsGpuVO(PartsGpuVO partsGpuVO);
	public List<PartsGpuVO> getGpuAllList(PartsGpuVO partsGpuVO);
	public Integer updatePartsGpuVO(PartsGpuVO partsGpuVO);
	public Integer getPartsGpuHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsGpuHistoryVO(PartsGpuHistoryVO partsGpuHistoryVO);
	
	public String getPartsCpuVOMaxId();
	public Integer insertPartsCpuVO(PartsCpuVO partsCpuVO);
	public List<PartsCpuVO> getCpuAllList(PartsCpuVO partsCpuVO);
	public Integer updatePartsCpuVO(PartsCpuVO partsCpuVO);
	public Integer getPartsCpuHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsCpuHistoryVO(PartsCpuHistoryVO partsCpuHistoryVO);
	
	public String getPartsMbVOMaxId();
	public Integer insertPartsMbVO(PartsMbVO partsMbVO);
	public List<PartsMbVO> getMbAllList(PartsMbVO partsMbVO);
	public Integer updatePartsMbVO(PartsMbVO partsMbVO);
	public Integer getPartsMbHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsMbHistoryVO(PartsMbHistoryVO partsMbHistoryVO);
	
	public String getPartsRamVOMaxId();
	public Integer insertPartsRamVO(PartsRamVO partsRamVO);
	public List<PartsRamVO> getRamAllList(PartsRamVO partsRamVO);
	public Integer updatePartsRamVO(PartsRamVO partsRamVO);
	public Integer getPartsRamHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsRamHistoryVO(PartsRamHistoryVO partsRamHistoryVO);
	
	public String getPartsPsuVOMaxId();
	public Integer insertPartsPsuVO(PartsPsuVO partsPsuVO);
	public List<PartsPsuVO> getPsuAllList(PartsPsuVO partsPsuVO);
	public Integer updatePartsPsuVO(PartsPsuVO partsPsuVO);
	public Integer getPartsPsuHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsPsuHistoryVO(PartsPsuHistoryVO partsPsuHistoryVO);
	
	public String getPartsCaseVOMaxId();
	public Integer insertPartsCaseVO(PartsCaseVO partsCaseVO);
	public List<PartsCaseVO> getCaseAllList(PartsCaseVO partsCaseVO);
	public Integer updatePartsCaseVO(PartsCaseVO partsCaseVO);
	public Integer getPartsCaseHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsCaseHistoryVO(PartsCaseHistoryVO partsCaseHistoryVO);
	
	public String getPartsCoolerVOMaxId();
	public Integer insertPartsCoolerVO(PartsCoolerVO partsCoolerVO);
	public List<PartsCoolerVO> getCoolerAllList(PartsCoolerVO partsCoolerVO);
	public Integer updatePartsCoolerVO(PartsCoolerVO partsCoolerVO);
	public Integer getPartsCoolerHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsCoolerHistoryVO(PartsCoolerHistoryVO partsCoolerHistoryVO);
	
	public String getPartsHddVOMaxId();
	public Integer insertPartsHddVO(PartsHddVO partsHddVO);
	public List<PartsHddVO> getHddAllList(PartsHddVO partsHddVO);
	public Integer updatePartsHddVO(PartsHddVO partsHddVO);
	public Integer getPartsHddHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsHddHistoryVO(PartsHddHistoryVO partsHddHistoryVO);
	
	public String getPartsSsdVOMaxId();
	public Integer insertPartsSsdVO(PartsSsdVO partsSsdVO);
	public List<PartsSsdVO> getSsdAllList(PartsSsdVO partsSsdVO);
	public Integer updatePartsSsdVO(PartsSsdVO partsSsdVO);
	public Integer getPartsSsdHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsSsdHistoryVO(PartsSsdHistoryVO partsSsdHistoryVO);
	
	public String getPartsSfVOMaxId();
	public Integer insertPartsSfVO(PartsSfVO partsSfVO);
	public List<PartsSfVO> getSfAllList(PartsSfVO partsSfVO);
	public Integer updatePartsSfVO(PartsSfVO partsSfVO);
	public Integer getPartsSfHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsSfHistoryVO(PartsSfHistoryVO partsSfHistoryVO);
	
	public String getPartsMakerVOMaxId();
	public Integer insertPartsMakerVO(PartsMakerVO partsMakerVO);
	public List<PartsMakerVO> getMakerAllList(PartsMakerVO partsMakerVO);
	public Integer updatePartsMakerVO(PartsMakerVO partsMakerVO);
	public Integer getPartsMakerHistoryVOMaxHistorySeq(String id);
	public Integer insertPartsMakerHistoryVO(PartsMakerHistoryVO partsMakerHistoryVO);
}