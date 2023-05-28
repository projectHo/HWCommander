package com.hw.dao;

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

public interface PartsDAO {
	public String getPartsGpuVOMaxId();
	public Integer insertPartsGpuVO(PartsGpuVO partsGpuVO);
	public List<PartsGpuVO> getGpuAllList(PartsGpuVO partsGpuVO);
	public Integer updatePartsGpuVO(PartsGpuVO partsGpuVO);
	
	public String getPartsCpuVOMaxId();
	public Integer insertPartsCpuVO(PartsCpuVO partsCpuVO);
	public List<PartsCpuVO> getCpuAllList(PartsCpuVO partsCpuVO);
	public Integer updatePartsCpuVO(PartsCpuVO partsCpuVO);
	
	public String getPartsMbVOMaxId();
	public Integer insertPartsMbVO(PartsMbVO partsMbVO);
	public List<PartsMbVO> getMbAllList(PartsMbVO partsMbVO);
	public Integer updatePartsMbVO(PartsMbVO partsMbVO);
	
	public String getPartsRamVOMaxId();
	public Integer insertPartsRamVO(PartsRamVO partsRamVO);
	public List<PartsRamVO> getRamAllList(PartsRamVO partsRamVO);
	public Integer updatePartsRamVO(PartsRamVO partsRamVO);
	
	public String getPartsPsuVOMaxId();
	public Integer insertPartsPsuVO(PartsPsuVO partsPsuVO);
	public List<PartsPsuVO> getPsuAllList(PartsPsuVO partsPsuVO);
	public Integer updatePartsPsuVO(PartsPsuVO partsPsuVO);
	
	public String getPartsCaseVOMaxId();
	public Integer insertPartsCaseVO(PartsCaseVO partsCaseVO);
	public List<PartsCaseVO> getCaseAllList(PartsCaseVO partsCaseVO);
	public Integer updatePartsCaseVO(PartsCaseVO partsCaseVO);
	
	public String getPartsCoolerVOMaxId();
	public Integer insertPartsCoolerVO(PartsCoolerVO partsCoolerVO);
	public List<PartsCoolerVO> getCoolerAllList(PartsCoolerVO partsCoolerVO);
	public Integer updatePartsCoolerVO(PartsCoolerVO partsCoolerVO);
	
	public String getPartsHddVOMaxId();
	public Integer insertPartsHddVO(PartsHddVO partsHddVO);
	public List<PartsHddVO> getHddAllList(PartsHddVO partsHddVO);
	public Integer updatePartsHddVO(PartsHddVO partsHddVO);
	
	public String getPartsSsdVOMaxId();
	public Integer insertPartsSsdVO(PartsSsdVO partsSsdVO);
	public List<PartsSsdVO> getSsdAllList(PartsSsdVO partsSsdVO);
	public Integer updatePartsSsdVO(PartsSsdVO partsSsdVO);
	
	public String getPartsSfVOMaxId();
	public Integer insertPartsSfVO(PartsSfVO partsSfVO);
	public List<PartsSfVO> getSfAllList(PartsSfVO partsSfVO);
	public Integer updatePartsSfVO(PartsSfVO partsSfVO);
}