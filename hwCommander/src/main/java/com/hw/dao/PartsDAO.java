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
	public List<PartsGpuVO> getGpuAllList();
	public String getPartsCpuVOMaxId();
	public Integer insertPartsCpuVO(PartsCpuVO partsCpuVO);
	public List<PartsCpuVO> getCpuAllList();
	public String getPartsMbVOMaxId();
	public Integer insertPartsMbVO(PartsMbVO partsMbVO);
	public List<PartsMbVO> getMbAllList();
	public String getPartsRamVOMaxId();
	public Integer insertPartsRamVO(PartsRamVO partsRamVO);
	public List<PartsRamVO> getRamAllList();
	public String getPartsPsuVOMaxId();
	public Integer insertPartsPsuVO(PartsPsuVO partsPsuVO);
	public List<PartsPsuVO> getPsuAllList();
	public String getPartsCaseVOMaxId();
	public Integer insertPartsCaseVO(PartsCaseVO partsCaseVO);
	public List<PartsCaseVO> getCaseAllList();
	public String getPartsCoolerVOMaxId();
	public Integer insertPartsCoolerVO(PartsCoolerVO partsCoolerVO);
	public List<PartsCoolerVO> getCoolerAllList();
	public String getPartsHddVOMaxId();
	public Integer insertPartsHddVO(PartsHddVO partsHddVO);
	public List<PartsHddVO> getHddAllList();
	public String getPartsSsdVOMaxId();
	public Integer insertPartsSsdVO(PartsSsdVO partsSsdVO);
	public List<PartsSsdVO> getSsdAllList();
	public String getPartsSfVOMaxId();
	public Integer insertPartsSfVO(PartsSfVO partsSfVO);
	public List<PartsSfVO> getSfAllList();
}