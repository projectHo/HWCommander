package com.hw.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hw.dao.PartsDAO;
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
import com.hw.service.PartsService;

@Service
public class PartsServiceImpl implements PartsService {
	
	@Autowired
    private PartsDAO partsDAO;
	
	/*--------------------------------------------------
	 - GPU
	*--------------------------------------------------*/
	@Override
	public Integer gpuRegistLogic(PartsGpuVO partsGpuVO) {
		int result = 0;
		partsGpuVO.setId(partsDAO.getPartsGpuVOMaxId());
		result = partsDAO.insertPartsGpuVO(partsGpuVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsGpuHistoryVO partsGpuHistoryVO = new PartsGpuHistoryVO();
			partsGpuHistoryVO.setId(partsGpuVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsGpuHistoryVOMaxHistorySeq(partsGpuVO.getId());
			partsGpuHistoryVO.setId(partsGpuVO.getId());
			partsGpuHistoryVO.setHistorySeq(maxHistorySeq);
			partsGpuHistoryVO.setPartsName(partsGpuVO.getPartsName());
			partsGpuHistoryVO.setPartsPrice(partsGpuVO.getPartsPrice());
			partsGpuHistoryVO.setPartsPriceStr(partsGpuVO.getPartsPriceStr());
			partsGpuHistoryVO.setGledCd(partsGpuVO.getGledCd());
			partsGpuHistoryVO.setGn(partsGpuVO.getGn());
			partsGpuHistoryVO.setGmcCd(partsGpuVO.getGmcCd());
			partsGpuHistoryVO.setGscCd(partsGpuVO.getGscCd());
			partsGpuHistoryVO.setGsv(partsGpuVO.getGsv());
			partsGpuHistoryVO.setMakerId(partsGpuVO.getMakerId());
			partsGpuHistoryVO.setQc(partsGpuVO.getQc());
			partsGpuHistoryVO.setTdp(partsGpuVO.getTdp());
			partsGpuHistoryVO.setBn(partsGpuVO.getBn());
			partsGpuHistoryVO.setIl(partsGpuVO.getIl());
			partsGpuHistoryVO.setGpl(partsGpuVO.getGpl());
			partsGpuHistoryVO.setTwelvePin(partsGpuVO.getTwelvePin());
			partsGpuHistoryVO.setPartsImage(partsGpuVO.getPartsImage());
			partsGpuHistoryVO.setMultiBulk(partsGpuVO.getMultiBulk());
			partsGpuHistoryVO.setGc(partsGpuVO.getGc());
			
			result += partsDAO.insertPartsGpuHistoryVO(partsGpuHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public List<PartsGpuVO> getGpuAllList() {
		PartsGpuVO searchVO = new PartsGpuVO();
		searchVO.setId(null);
		return partsDAO.getGpuAllList(searchVO);
	}
	
	@Override
	public PartsGpuVO getPartsGpuVOById(String id) {
		PartsGpuVO resultVO = null;
		PartsGpuVO searchVO = new PartsGpuVO();
		
		searchVO.setId(id);
		List<PartsGpuVO> resultList = partsDAO.getGpuAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer gpuUpdateLogic(PartsGpuVO partsGpuVO) {
		int result = 0;
		result = partsDAO.updatePartsGpuVO(partsGpuVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsGpuHistoryVO partsGpuHistoryVO = new PartsGpuHistoryVO();
			partsGpuHistoryVO.setId(partsGpuVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsGpuHistoryVOMaxHistorySeq(partsGpuVO.getId());
			partsGpuHistoryVO.setId(partsGpuVO.getId());
			partsGpuHistoryVO.setHistorySeq(maxHistorySeq);
			partsGpuHistoryVO.setPartsName(partsGpuVO.getPartsName());
			partsGpuHistoryVO.setPartsPrice(partsGpuVO.getPartsPrice());
			partsGpuHistoryVO.setPartsPriceStr(partsGpuVO.getPartsPriceStr());
			partsGpuHistoryVO.setGledCd(partsGpuVO.getGledCd());
			partsGpuHistoryVO.setGn(partsGpuVO.getGn());
			partsGpuHistoryVO.setGmcCd(partsGpuVO.getGmcCd());
			partsGpuHistoryVO.setGscCd(partsGpuVO.getGscCd());
			partsGpuHistoryVO.setGsv(partsGpuVO.getGsv());
			partsGpuHistoryVO.setMakerId(partsGpuVO.getMakerId());
			partsGpuHistoryVO.setQc(partsGpuVO.getQc());
			partsGpuHistoryVO.setTdp(partsGpuVO.getTdp());
			partsGpuHistoryVO.setBn(partsGpuVO.getBn());
			partsGpuHistoryVO.setIl(partsGpuVO.getIl());
			partsGpuHistoryVO.setGpl(partsGpuVO.getGpl());
			partsGpuHistoryVO.setTwelvePin(partsGpuVO.getTwelvePin());
			partsGpuHistoryVO.setPartsImage(partsGpuVO.getPartsImage());
			partsGpuHistoryVO.setMultiBulk(partsGpuVO.getMultiBulk());
			partsGpuHistoryVO.setGc(partsGpuVO.getGc());
			
			result += partsDAO.insertPartsGpuHistoryVO(partsGpuHistoryVO);
		}
		return result;
	}
	
	/*--------------------------------------------------
	 - CPU
	*--------------------------------------------------*/
	@Override
	public Integer cpuRegistLogic(PartsCpuVO partsCpuVO) {
		int result = 0;
		partsCpuVO.setId(partsDAO.getPartsCpuVOMaxId());
		result = partsDAO.insertPartsCpuVO(partsCpuVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsCpuHistoryVO partsCpuHistoryVO = new PartsCpuHistoryVO();
			partsCpuHistoryVO.setId(partsCpuVO.getId());

			int maxHistorySeq = partsDAO.getPartsCpuHistoryVOMaxHistorySeq(partsCpuVO.getId());
			partsCpuHistoryVO.setId(partsCpuVO.getId());
			partsCpuHistoryVO.setHistorySeq(maxHistorySeq);
			partsCpuHistoryVO.setPartsName(partsCpuVO.getPartsName());
			partsCpuHistoryVO.setPartsPrice(partsCpuVO.getPartsPrice());
			partsCpuHistoryVO.setPartsPriceStr(partsCpuVO.getPartsPriceStr());
			partsCpuHistoryVO.setCsv(partsCpuVO.getCsv());
			partsCpuHistoryVO.setIaCd(partsCpuVO.getIaCd());
			partsCpuHistoryVO.setThermal(partsCpuVO.getThermal());
			partsCpuHistoryVO.setBn(partsCpuVO.getBn());
			partsCpuHistoryVO.setCpuSocCd(partsCpuVO.getCpuSocCd());
			partsCpuHistoryVO.setVrmRange(partsCpuVO.getVrmRange());
			partsCpuHistoryVO.setDdr4MaxRange(partsCpuVO.getDdr4MaxRange());
			partsCpuHistoryVO.setDdr5MaxRange(partsCpuVO.getDdr5MaxRange());
			partsCpuHistoryVO.setPartsImage(partsCpuVO.getPartsImage());
			partsCpuHistoryVO.setMultiBulk(partsCpuVO.getMultiBulk());
			partsCpuHistoryVO.setApu(partsCpuVO.getApu());
			
			result += partsDAO.insertPartsCpuHistoryVO(partsCpuHistoryVO);
		}
		return result;
	}
	
	@Override
	public List<PartsCpuVO> getCpuAllList() {
		PartsCpuVO searchVO = new PartsCpuVO();
		searchVO.setId(null);
		return partsDAO.getCpuAllList(searchVO);
	}
	
	@Override
	public PartsCpuVO getPartsCpuVOById(String id) {
		PartsCpuVO resultVO = null;
		PartsCpuVO searchVO = new PartsCpuVO();
		
		searchVO.setId(id);
		List<PartsCpuVO> resultList = partsDAO.getCpuAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer cpuUpdateLogic(PartsCpuVO partsCpuVO) {
		int result = 0;
		result = partsDAO.updatePartsCpuVO(partsCpuVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsCpuHistoryVO partsCpuHistoryVO = new PartsCpuHistoryVO();
			partsCpuHistoryVO.setId(partsCpuVO.getId());

			int maxHistorySeq = partsDAO.getPartsCpuHistoryVOMaxHistorySeq(partsCpuVO.getId());
			partsCpuHistoryVO.setId(partsCpuVO.getId());
			partsCpuHistoryVO.setHistorySeq(maxHistorySeq);
			partsCpuHistoryVO.setPartsName(partsCpuVO.getPartsName());
			partsCpuHistoryVO.setPartsPrice(partsCpuVO.getPartsPrice());
			partsCpuHistoryVO.setPartsPriceStr(partsCpuVO.getPartsPriceStr());
			partsCpuHistoryVO.setCsv(partsCpuVO.getCsv());
			partsCpuHistoryVO.setIaCd(partsCpuVO.getIaCd());
			partsCpuHistoryVO.setThermal(partsCpuVO.getThermal());
			partsCpuHistoryVO.setBn(partsCpuVO.getBn());
			partsCpuHistoryVO.setCpuSocCd(partsCpuVO.getCpuSocCd());
			partsCpuHistoryVO.setVrmRange(partsCpuVO.getVrmRange());
			partsCpuHistoryVO.setDdr4MaxRange(partsCpuVO.getDdr4MaxRange());
			partsCpuHistoryVO.setDdr5MaxRange(partsCpuVO.getDdr5MaxRange());
			partsCpuHistoryVO.setPartsImage(partsCpuVO.getPartsImage());
			partsCpuHistoryVO.setMultiBulk(partsCpuVO.getMultiBulk());
			partsCpuHistoryVO.setApu(partsCpuVO.getApu());
			
			result += partsDAO.insertPartsCpuHistoryVO(partsCpuHistoryVO);
		}
		return result;
	}
	
	/*--------------------------------------------------
	 - MB
	*--------------------------------------------------*/	
	@Override
	public Integer mbRegistLogic(PartsMbVO partsMbVO) {
		int result = 0;
		partsMbVO.setId(partsDAO.getPartsMbVOMaxId());
		result = partsDAO.insertPartsMbVO(partsMbVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsMbHistoryVO partsMbHistoryVO = new PartsMbHistoryVO();
			partsMbHistoryVO.setId(partsMbVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsMbHistoryVOMaxHistorySeq(partsMbVO.getId());
			partsMbHistoryVO.setHistorySeq(maxHistorySeq);
			partsMbHistoryVO.setPartsName(partsMbVO.getPartsName());
			partsMbHistoryVO.setPartsPrice(partsMbVO.getPartsPrice());
			partsMbHistoryVO.setMledCd(partsMbVO.getMledCd());
			partsMbHistoryVO.setMmcCd(partsMbVO.getMmcCd());
			partsMbHistoryVO.setMscCd(partsMbVO.getMscCd());
			partsMbHistoryVO.setMakerId(partsMbVO.getMakerId());
			partsMbHistoryVO.setPort(partsMbVO.getPort());
			partsMbHistoryVO.setScal(partsMbVO.getScal());
			partsMbHistoryVO.setBios(partsMbVO.getBios());
			partsMbHistoryVO.setCpuSocCd(partsMbVO.getCpuSocCd());
			partsMbHistoryVO.setVrmRange(partsMbVO.getVrmRange());
			partsMbHistoryVO.setMemSocCd(partsMbVO.getMemSocCd());
			partsMbHistoryVO.setScsCd(partsMbVO.getScsCd());
			partsMbHistoryVO.setFf(partsMbVO.getFf());
			partsMbHistoryVO.setPl(partsMbVO.getPl());
			partsMbHistoryVO.setSata(partsMbVO.getSata());
			partsMbHistoryVO.setPartsImage(partsMbVO.getPartsImage());
			partsMbHistoryVO.setMultiBulk(partsMbVO.getMultiBulk());
			partsMbHistoryVO.setWifi(partsMbVO.getWifi());
			partsMbHistoryVO.setMc(partsMbVO.getMc());
			partsMbHistoryVO.setLimVrm(partsMbVO.getLimVrm());
			
			result += partsDAO.insertPartsMbHistoryVO(partsMbHistoryVO);
		}
		return result;
	}
	
	@Override
	public List<PartsMbVO> getMbAllList() {
		PartsMbVO searchVO = new PartsMbVO();
		searchVO.setId(null);
		return partsDAO.getMbAllList(searchVO);
	}
	
	@Override
	public PartsMbVO getPartsMbVOById(String id) {
		PartsMbVO resultVO = null;
		PartsMbVO searchVO = new PartsMbVO();
		
		searchVO.setId(id);
		List<PartsMbVO> resultList = partsDAO.getMbAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer mbUpdateLogic(PartsMbVO partsMbVO) {
		int result = 0;
		result = partsDAO.updatePartsMbVO(partsMbVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsMbHistoryVO partsMbHistoryVO = new PartsMbHistoryVO();
			partsMbHistoryVO.setId(partsMbVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsMbHistoryVOMaxHistorySeq(partsMbVO.getId());
			partsMbHistoryVO.setHistorySeq(maxHistorySeq);
			partsMbHistoryVO.setPartsName(partsMbVO.getPartsName());
			partsMbHistoryVO.setPartsPrice(partsMbVO.getPartsPrice());
			partsMbHistoryVO.setMledCd(partsMbVO.getMledCd());
			partsMbHistoryVO.setMmcCd(partsMbVO.getMmcCd());
			partsMbHistoryVO.setMscCd(partsMbVO.getMscCd());
			partsMbHistoryVO.setMakerId(partsMbVO.getMakerId());
			partsMbHistoryVO.setPort(partsMbVO.getPort());
			partsMbHistoryVO.setScal(partsMbVO.getScal());
			partsMbHistoryVO.setBios(partsMbVO.getBios());
			partsMbHistoryVO.setCpuSocCd(partsMbVO.getCpuSocCd());
			partsMbHistoryVO.setVrmRange(partsMbVO.getVrmRange());
			partsMbHistoryVO.setMemSocCd(partsMbVO.getMemSocCd());
			partsMbHistoryVO.setScsCd(partsMbVO.getScsCd());
			partsMbHistoryVO.setFf(partsMbVO.getFf());
			partsMbHistoryVO.setPl(partsMbVO.getPl());
			partsMbHistoryVO.setSata(partsMbVO.getSata());
			partsMbHistoryVO.setPartsImage(partsMbVO.getPartsImage());
			partsMbHistoryVO.setMultiBulk(partsMbVO.getMultiBulk());
			partsMbHistoryVO.setWifi(partsMbVO.getWifi());
			partsMbHistoryVO.setMc(partsMbVO.getMc());
			partsMbHistoryVO.setLimVrm(partsMbVO.getLimVrm());
			
			result += partsDAO.insertPartsMbHistoryVO(partsMbHistoryVO);
		}
		return result;
	}
	
	@Override
	public PartsMbHistoryVO getPartsMbHistoryVOByIdAndHistorySeq(PartsMbHistoryVO partsMbHistoryVO) {
		PartsMbHistoryVO resultVO = null;
		PartsMbHistoryVO searchVO = new PartsMbHistoryVO();
		
		searchVO.setId(partsMbHistoryVO.getId());
		searchVO.setHistorySeq(partsMbHistoryVO.getHistorySeq());
		List<PartsMbHistoryVO> resultList = partsDAO.getMbHistoryAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	/*--------------------------------------------------
	 - RAM
	*--------------------------------------------------*/
	@Override
	public Integer ramRegistLogic(PartsRamVO partsRamVO) {
		int result = 0;
		partsRamVO.setId(partsDAO.getPartsRamVOMaxId());
		result = partsDAO.insertPartsRamVO(partsRamVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsRamHistoryVO partsRamHistoryVO = new PartsRamHistoryVO();
			partsRamHistoryVO.setId(partsRamVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsRamHistoryVOMaxHistorySeq(partsRamVO.getId());
			partsRamHistoryVO.setHistorySeq(maxHistorySeq);
			partsRamHistoryVO.setPartsName(partsRamVO.getPartsName());
			partsRamHistoryVO.setPartsPrice(partsRamVO.getPartsPrice());
			partsRamHistoryVO.setRledCd(partsRamVO.getRledCd());
			partsRamHistoryVO.setRmcCd(partsRamVO.getRmcCd());
			partsRamHistoryVO.setRscCd(partsRamVO.getRscCd());
			partsRamHistoryVO.setCl(partsRamVO.getCl());
			partsRamHistoryVO.setLatency(partsRamVO.getLatency());
			partsRamHistoryVO.setPrCd(partsRamVO.getPrCd());
			partsRamHistoryVO.setMemSocCd(partsRamVO.getMemSocCd());
			partsRamHistoryVO.setDdr4MaxRange(partsRamVO.getDdr4MaxRange());
			partsRamHistoryVO.setDdr5MaxRange(partsRamVO.getDdr5MaxRange());
			partsRamHistoryVO.setPartsImage(partsRamVO.getPartsImage());
			partsRamHistoryVO.setMultiBulk(partsRamVO.getMultiBulk());
			partsRamHistoryVO.setVolume(partsRamVO.getVolume());
			partsRamHistoryVO.setSd(partsRamVO.getSd());

			result += partsDAO.insertPartsRamHistoryVO(partsRamHistoryVO);
		}
		return result;
	}
	
	@Override
	public List<PartsRamVO> getRamAllList() {
		PartsRamVO searchVO = new PartsRamVO();
		searchVO.setId(null);
		return partsDAO.getRamAllList(searchVO);
	}
	
	@Override
	public PartsRamVO getPartsRamVOById(String id) {
		PartsRamVO resultVO = null;
		PartsRamVO searchVO = new PartsRamVO();
		
		searchVO.setId(id);
		List<PartsRamVO> resultList = partsDAO.getRamAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer ramUpdateLogic(PartsRamVO partsRamVO) {
		int result = 0;
		result = partsDAO.updatePartsRamVO(partsRamVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsRamHistoryVO partsRamHistoryVO = new PartsRamHistoryVO();
			partsRamHistoryVO.setId(partsRamVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsRamHistoryVOMaxHistorySeq(partsRamVO.getId());
			partsRamHistoryVO.setHistorySeq(maxHistorySeq);
			partsRamHistoryVO.setPartsName(partsRamVO.getPartsName());
			partsRamHistoryVO.setPartsPrice(partsRamVO.getPartsPrice());
			partsRamHistoryVO.setRledCd(partsRamVO.getRledCd());
			partsRamHistoryVO.setRmcCd(partsRamVO.getRmcCd());
			partsRamHistoryVO.setRscCd(partsRamVO.getRscCd());
			partsRamHistoryVO.setCl(partsRamVO.getCl());
			partsRamHistoryVO.setLatency(partsRamVO.getLatency());
			partsRamHistoryVO.setPrCd(partsRamVO.getPrCd());
			partsRamHistoryVO.setMemSocCd(partsRamVO.getMemSocCd());
			partsRamHistoryVO.setDdr4MaxRange(partsRamVO.getDdr4MaxRange());
			partsRamHistoryVO.setDdr5MaxRange(partsRamVO.getDdr5MaxRange());
			partsRamHistoryVO.setPartsImage(partsRamVO.getPartsImage());
			partsRamHistoryVO.setMultiBulk(partsRamVO.getMultiBulk());
			partsRamHistoryVO.setVolume(partsRamVO.getVolume());
			partsRamHistoryVO.setSd(partsRamVO.getSd());

			result += partsDAO.insertPartsRamHistoryVO(partsRamHistoryVO);
		}
		return result;
	}
	
	@Override
	public PartsRamHistoryVO getPartsRamHistoryVOByIdAndHistorySeq(PartsRamHistoryVO partsRamHistoryVO) {
		PartsRamHistoryVO resultVO = null;
		PartsRamHistoryVO searchVO = new PartsRamHistoryVO();
		
		searchVO.setId(partsRamHistoryVO.getId());
		searchVO.setHistorySeq(partsRamHistoryVO.getHistorySeq());
		List<PartsRamHistoryVO> resultList = partsDAO.getRamHistoryAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	/*--------------------------------------------------
	 - PSU
	*--------------------------------------------------*/
	@Override
	public Integer psuRegistLogic(PartsPsuVO partsPsuVO) {
		int result = 0;
		partsPsuVO.setId(partsDAO.getPartsPsuVOMaxId());
		result = partsDAO.insertPartsPsuVO(partsPsuVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsPsuHistoryVO partsPsuHistoryVO = new PartsPsuHistoryVO();
			partsPsuHistoryVO.setId(partsPsuVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsPsuHistoryVOMaxHistorySeq(partsPsuVO.getId());
			partsPsuHistoryVO.setHistorySeq(maxHistorySeq);
			partsPsuHistoryVO.setPartsName(partsPsuVO.getPartsName());
			partsPsuHistoryVO.setPartsPrice(partsPsuVO.getPartsPrice());
			partsPsuHistoryVO.setPmcCd(partsPsuVO.getPmcCd());
			partsPsuHistoryVO.setPscCd(partsPsuVO.getPscCd());
			partsPsuHistoryVO.setStd(partsPsuVO.getStd());
			partsPsuHistoryVO.setMakerId(partsPsuVO.getMakerId());
			partsPsuHistoryVO.setPfm(partsPsuVO.getPfm());
			partsPsuHistoryVO.setSft(partsPsuVO.getSft());
			partsPsuHistoryVO.setTdp(partsPsuVO.getTdp());
			partsPsuHistoryVO.setPl(partsPsuVO.getPl());
			partsPsuHistoryVO.setGpl(partsPsuVO.getGpl());
			partsPsuHistoryVO.setTwelvePin(partsPsuVO.getTwelvePin());
			partsPsuHistoryVO.setPartsImage(partsPsuVO.getPartsImage());
			partsPsuHistoryVO.setMultiBulk(partsPsuVO.getMultiBulk());

			result += partsDAO.insertPartsPsuHistoryVO(partsPsuHistoryVO);
		}
		return result;
	}
	
	@Override
	public List<PartsPsuVO> getPsuAllList() {
		PartsPsuVO searchVO = new PartsPsuVO();
		searchVO.setId(null);
		return partsDAO.getPsuAllList(searchVO);
	}
	
	@Override
	public PartsPsuVO getPartsPsuVOById(String id) {
		PartsPsuVO resultVO = null;
		PartsPsuVO searchVO = new PartsPsuVO();
		
		searchVO.setId(id);
		List<PartsPsuVO> resultList = partsDAO.getPsuAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer psuUpdateLogic(PartsPsuVO partsPsuVO) {
		int result = 0;
		result = partsDAO.updatePartsPsuVO(partsPsuVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsPsuHistoryVO partsPsuHistoryVO = new PartsPsuHistoryVO();
			partsPsuHistoryVO.setId(partsPsuVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsPsuHistoryVOMaxHistorySeq(partsPsuVO.getId());
			partsPsuHistoryVO.setHistorySeq(maxHistorySeq);
			partsPsuHistoryVO.setPartsName(partsPsuVO.getPartsName());
			partsPsuHistoryVO.setPartsPrice(partsPsuVO.getPartsPrice());
			partsPsuHistoryVO.setPmcCd(partsPsuVO.getPmcCd());
			partsPsuHistoryVO.setPscCd(partsPsuVO.getPscCd());
			partsPsuHistoryVO.setStd(partsPsuVO.getStd());
			partsPsuHistoryVO.setMakerId(partsPsuVO.getMakerId());
			partsPsuHistoryVO.setPfm(partsPsuVO.getPfm());
			partsPsuHistoryVO.setSft(partsPsuVO.getSft());
			partsPsuHistoryVO.setTdp(partsPsuVO.getTdp());
			partsPsuHistoryVO.setPl(partsPsuVO.getPl());
			partsPsuHistoryVO.setGpl(partsPsuVO.getGpl());
			partsPsuHistoryVO.setTwelvePin(partsPsuVO.getTwelvePin());
			partsPsuHistoryVO.setPartsImage(partsPsuVO.getPartsImage());
			partsPsuHistoryVO.setMultiBulk(partsPsuVO.getMultiBulk());

			result += partsDAO.insertPartsPsuHistoryVO(partsPsuHistoryVO);
		}
		return result;
	}
	
	/*--------------------------------------------------
	 - CASE
	*--------------------------------------------------*/
	@Override
	public Integer caseRegistLogic(PartsCaseVO partsCaseVO) {
		int result = 0;
		partsCaseVO.setId(partsDAO.getPartsCaseVOMaxId());
		result = partsDAO.insertPartsCaseVO(partsCaseVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsCaseHistoryVO partsCaseHistoryVO = new PartsCaseHistoryVO();
			partsCaseHistoryVO.setId(partsCaseVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsCaseHistoryVOMaxHistorySeq(partsCaseVO.getId());
			partsCaseHistoryVO.setHistorySeq(maxHistorySeq);
			partsCaseHistoryVO.setPartsName(partsCaseVO.getPartsName());
			partsCaseHistoryVO.setPartsPrice(partsCaseVO.getPartsPrice());
			partsCaseHistoryVO.setCledCd(partsCaseVO.getCledCd());
			partsCaseHistoryVO.setCmCd(partsCaseVO.getCmCd());
			partsCaseHistoryVO.setCmcCd(partsCaseVO.getCmcCd());
			partsCaseHistoryVO.setCscCd(partsCaseVO.getCscCd());
			partsCaseHistoryVO.setMakerId(partsCaseVO.getMakerId());
			partsCaseHistoryVO.setAdap(partsCaseVO.getAdap());
			partsCaseHistoryVO.setCool(partsCaseVO.getCool());
			partsCaseHistoryVO.setEnd(partsCaseVO.getEnd());
			partsCaseHistoryVO.setConv(partsCaseVO.getConv());
			partsCaseHistoryVO.setFf(partsCaseVO.getFf());
			partsCaseHistoryVO.setIw(partsCaseVO.getIw());
			partsCaseHistoryVO.setIl(partsCaseVO.getIl());
			partsCaseHistoryVO.setIh(partsCaseVO.getIh());
			partsCaseHistoryVO.setIt(partsCaseVO.getIt());
			partsCaseHistoryVO.setFh(partsCaseVO.getFh());
			partsCaseHistoryVO.setFt(partsCaseVO.getFt());
			partsCaseHistoryVO.setStrTwoDotFive(partsCaseVO.getStrTwoDotFive());
			partsCaseHistoryVO.setStrThreeDotFive(partsCaseVO.getStrThreeDotFive());
			partsCaseHistoryVO.setPartsImage(partsCaseVO.getPartsImage());
			partsCaseHistoryVO.setMultiBulk(partsCaseVO.getMultiBulk());

			result += partsDAO.insertPartsCaseHistoryVO(partsCaseHistoryVO);
		}
		return result;
	}
	
	@Override
	public List<PartsCaseVO> getCaseAllList() {
		PartsCaseVO searchVO = new PartsCaseVO();
		searchVO.setId(null);
		return partsDAO.getCaseAllList(searchVO);
	}
	
	@Override
	public PartsCaseVO getPartsCaseVOById(String id) {
		PartsCaseVO resultVO = null;
		PartsCaseVO searchVO = new PartsCaseVO();
		
		searchVO.setId(id);
		List<PartsCaseVO> resultList = partsDAO.getCaseAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer caseUpdateLogic(PartsCaseVO partsCaseVO) {
		int result = 0;
		result = partsDAO.updatePartsCaseVO(partsCaseVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsCaseHistoryVO partsCaseHistoryVO = new PartsCaseHistoryVO();
			partsCaseHistoryVO.setId(partsCaseVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsCaseHistoryVOMaxHistorySeq(partsCaseVO.getId());
			partsCaseHistoryVO.setHistorySeq(maxHistorySeq);
			partsCaseHistoryVO.setPartsName(partsCaseVO.getPartsName());
			partsCaseHistoryVO.setPartsPrice(partsCaseVO.getPartsPrice());
			partsCaseHistoryVO.setCledCd(partsCaseVO.getCledCd());
			partsCaseHistoryVO.setCmCd(partsCaseVO.getCmCd());
			partsCaseHistoryVO.setCmcCd(partsCaseVO.getCmcCd());
			partsCaseHistoryVO.setCscCd(partsCaseVO.getCscCd());
			partsCaseHistoryVO.setMakerId(partsCaseVO.getMakerId());
			partsCaseHistoryVO.setAdap(partsCaseVO.getAdap());
			partsCaseHistoryVO.setCool(partsCaseVO.getCool());
			partsCaseHistoryVO.setEnd(partsCaseVO.getEnd());
			partsCaseHistoryVO.setConv(partsCaseVO.getConv());
			partsCaseHistoryVO.setFf(partsCaseVO.getFf());
			partsCaseHistoryVO.setIw(partsCaseVO.getIw());
			partsCaseHistoryVO.setIl(partsCaseVO.getIl());
			partsCaseHistoryVO.setIh(partsCaseVO.getIh());
			partsCaseHistoryVO.setIt(partsCaseVO.getIt());
			partsCaseHistoryVO.setFh(partsCaseVO.getFh());
			partsCaseHistoryVO.setFt(partsCaseVO.getFt());
			partsCaseHistoryVO.setStrTwoDotFive(partsCaseVO.getStrTwoDotFive());
			partsCaseHistoryVO.setStrThreeDotFive(partsCaseVO.getStrThreeDotFive());
			partsCaseHistoryVO.setPartsImage(partsCaseVO.getPartsImage());
			partsCaseHistoryVO.setMultiBulk(partsCaseVO.getMultiBulk());

			result += partsDAO.insertPartsCaseHistoryVO(partsCaseHistoryVO);
		}
		return result;
	}
	
	/*--------------------------------------------------
	 - COOLER
	*--------------------------------------------------*/
	@Override
	public Integer coolerRegistLogic(PartsCoolerVO partsCoolerVO) {
		int result = 0;
		partsCoolerVO.setId(partsDAO.getPartsCoolerVOMaxId());
		result = partsDAO.insertPartsCoolerVO(partsCoolerVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsCoolerHistoryVO partsCoolerHistoryVO = new PartsCoolerHistoryVO();
			partsCoolerHistoryVO.setId(partsCoolerVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsCoolerHistoryVOMaxHistorySeq(partsCoolerVO.getId());
			partsCoolerHistoryVO.setHistorySeq(maxHistorySeq);
			partsCoolerHistoryVO.setPartsName(partsCoolerVO.getPartsName());
			partsCoolerHistoryVO.setPartsPrice(partsCoolerVO.getPartsPrice());
			partsCoolerHistoryVO.setClledCd(partsCoolerVO.getClledCd());
			partsCoolerHistoryVO.setClmcCd(partsCoolerVO.getClmcCd());
			partsCoolerHistoryVO.setClscCd(partsCoolerVO.getClscCd());
			partsCoolerHistoryVO.setFormulaCd(partsCoolerVO.getFormulaCd());
			partsCoolerHistoryVO.setSta(partsCoolerVO.getSta());
			partsCoolerHistoryVO.setWcas(partsCoolerVO.getWcas());
			partsCoolerHistoryVO.setAcas(partsCoolerVO.getAcas());
			partsCoolerHistoryVO.setNoi(partsCoolerVO.getNoi());
			partsCoolerHistoryVO.setCnv(partsCoolerVO.getCnv());
			partsCoolerHistoryVO.setThermal(partsCoolerVO.getThermal());
			partsCoolerHistoryVO.setIw(partsCoolerVO.getIw());
			partsCoolerHistoryVO.setIh(partsCoolerVO.getIh());
			partsCoolerHistoryVO.setIt(partsCoolerVO.getIt());
			partsCoolerHistoryVO.setPartsImage(partsCoolerVO.getPartsImage());
			partsCoolerHistoryVO.setMultiBulk(partsCoolerVO.getMultiBulk());

			result += partsDAO.insertPartsCoolerHistoryVO(partsCoolerHistoryVO);
		}
		return result;
	}
	
	@Override
	public List<PartsCoolerVO> getCoolerAllList() {
		PartsCoolerVO searchVO = new PartsCoolerVO();
		searchVO.setId(null);
		return partsDAO.getCoolerAllList(searchVO);
	}
	
	@Override
	public PartsCoolerVO getPartsCoolerVOById(String id) {
		PartsCoolerVO resultVO = null;
		PartsCoolerVO searchVO = new PartsCoolerVO();
		
		searchVO.setId(id);
		List<PartsCoolerVO> resultList = partsDAO.getCoolerAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer coolerUpdateLogic(PartsCoolerVO partsCoolerVO) {
		int result = 0;
		result = partsDAO.updatePartsCoolerVO(partsCoolerVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsCoolerHistoryVO partsCoolerHistoryVO = new PartsCoolerHistoryVO();
			partsCoolerHistoryVO.setId(partsCoolerVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsCoolerHistoryVOMaxHistorySeq(partsCoolerVO.getId());
			partsCoolerHistoryVO.setHistorySeq(maxHistorySeq);
			partsCoolerHistoryVO.setPartsName(partsCoolerVO.getPartsName());
			partsCoolerHistoryVO.setPartsPrice(partsCoolerVO.getPartsPrice());
			partsCoolerHistoryVO.setClledCd(partsCoolerVO.getClledCd());
			partsCoolerHistoryVO.setClmcCd(partsCoolerVO.getClmcCd());
			partsCoolerHistoryVO.setClscCd(partsCoolerVO.getClscCd());
			partsCoolerHistoryVO.setFormulaCd(partsCoolerVO.getFormulaCd());
			partsCoolerHistoryVO.setSta(partsCoolerVO.getSta());
			partsCoolerHistoryVO.setWcas(partsCoolerVO.getWcas());
			partsCoolerHistoryVO.setAcas(partsCoolerVO.getAcas());
			partsCoolerHistoryVO.setNoi(partsCoolerVO.getNoi());
			partsCoolerHistoryVO.setCnv(partsCoolerVO.getCnv());
			partsCoolerHistoryVO.setThermal(partsCoolerVO.getThermal());
			partsCoolerHistoryVO.setIw(partsCoolerVO.getIw());
			partsCoolerHistoryVO.setIh(partsCoolerVO.getIh());
			partsCoolerHistoryVO.setIt(partsCoolerVO.getIt());
			partsCoolerHistoryVO.setPartsImage(partsCoolerVO.getPartsImage());
			partsCoolerHistoryVO.setMultiBulk(partsCoolerVO.getMultiBulk());

			result += partsDAO.insertPartsCoolerHistoryVO(partsCoolerHistoryVO);
		}
		return result;
	}
	
	/*--------------------------------------------------
	 - HDD
	*--------------------------------------------------*/
	@Override
	public Integer hddRegistLogic(PartsHddVO partsHddVO) {
		int result = 0;
		partsHddVO.setId(partsDAO.getPartsHddVOMaxId());
		result = partsDAO.insertPartsHddVO(partsHddVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsHddHistoryVO partsHddHistoryVO = new PartsHddHistoryVO();
			partsHddHistoryVO.setId(partsHddVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsHddHistoryVOMaxHistorySeq(partsHddVO.getId());
			partsHddHistoryVO.setHistorySeq(maxHistorySeq);
			partsHddHistoryVO.setPartsName(partsHddVO.getPartsName());
			partsHddHistoryVO.setPartsPrice(partsHddVO.getPartsPrice());
			partsHddHistoryVO.setSpd(partsHddVO.getSpd());
			partsHddHistoryVO.setFea(partsHddVO.getFea());
			partsHddHistoryVO.setRel(partsHddVO.getRel());
			partsHddHistoryVO.setNoice(partsHddVO.getNoice());
			partsHddHistoryVO.setMttf(partsHddVO.getMttf());
			partsHddHistoryVO.setGur(partsHddVO.getGur());
			partsHddHistoryVO.setStrThreeDotFive(partsHddVO.getStrThreeDotFive());
			partsHddHistoryVO.setSata(partsHddVO.getSata());
			partsHddHistoryVO.setPartsImage(partsHddVO.getPartsImage());
			partsHddHistoryVO.setMultiBulk(partsHddVO.getMultiBulk());
			partsHddHistoryVO.setVolume(partsHddVO.getVolume());
			
			result += partsDAO.insertPartsHddHistoryVO(partsHddHistoryVO);
		}
		return result;
	}
	
	@Override
	public List<PartsHddVO> getHddAllList() {
		PartsHddVO searchVO = new PartsHddVO();
		searchVO.setId(null);
		return partsDAO.getHddAllList(searchVO);
	}
	
	@Override
	public PartsHddVO getPartsHddVOById(String id) {
		PartsHddVO resultVO = null;
		PartsHddVO searchVO = new PartsHddVO();
		
		searchVO.setId(id);
		List<PartsHddVO> resultList = partsDAO.getHddAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer hddUpdateLogic(PartsHddVO partsHddVO) {
		int result = 0;
		result = partsDAO.updatePartsHddVO(partsHddVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsHddHistoryVO partsHddHistoryVO = new PartsHddHistoryVO();
			partsHddHistoryVO.setId(partsHddVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsHddHistoryVOMaxHistorySeq(partsHddVO.getId());
			partsHddHistoryVO.setHistorySeq(maxHistorySeq);
			partsHddHistoryVO.setPartsName(partsHddVO.getPartsName());
			partsHddHistoryVO.setPartsPrice(partsHddVO.getPartsPrice());
			partsHddHistoryVO.setSpd(partsHddVO.getSpd());
			partsHddHistoryVO.setFea(partsHddVO.getFea());
			partsHddHistoryVO.setRel(partsHddVO.getRel());
			partsHddHistoryVO.setNoice(partsHddVO.getNoice());
			partsHddHistoryVO.setMttf(partsHddVO.getMttf());
			partsHddHistoryVO.setGur(partsHddVO.getGur());
			partsHddHistoryVO.setStrThreeDotFive(partsHddVO.getStrThreeDotFive());
			partsHddHistoryVO.setSata(partsHddVO.getSata());
			partsHddHistoryVO.setPartsImage(partsHddVO.getPartsImage());
			partsHddHistoryVO.setMultiBulk(partsHddVO.getMultiBulk());
			partsHddHistoryVO.setVolume(partsHddVO.getVolume());
			
			result += partsDAO.insertPartsHddHistoryVO(partsHddHistoryVO);
		}
		return result;
	}
	
	/*--------------------------------------------------
	 - SSD
	*--------------------------------------------------*/
	@Override
	public Integer ssdRegistLogic(PartsSsdVO partsSsdVO) {
		int result = 0;
		partsSsdVO.setId(partsDAO.getPartsSsdVOMaxId());
		result = partsDAO.insertPartsSsdVO(partsSsdVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsSsdHistoryVO partsSsdHistoryVO = new PartsSsdHistoryVO();
			partsSsdHistoryVO.setId(partsSsdVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsSsdHistoryVOMaxHistorySeq(partsSsdVO.getId());
			partsSsdHistoryVO.setHistorySeq(maxHistorySeq);
			partsSsdHistoryVO.setPartsName(partsSsdVO.getPartsName());
			partsSsdHistoryVO.setPartsPrice(partsSsdVO.getPartsPrice());
			partsSsdHistoryVO.setBasic(partsSsdVO.getBasic());
			partsSsdHistoryVO.setFnc(partsSsdVO.getFnc());
			partsSsdHistoryVO.setCmf(partsSsdVO.getCmf());
			partsSsdHistoryVO.setWar(partsSsdVO.getWar());
			partsSsdHistoryVO.setThr(partsSsdVO.getThr());
			partsSsdHistoryVO.setRlb(partsSsdVO.getRlb());
			partsSsdHistoryVO.setStrTwoDotFive(partsSsdVO.getStrTwoDotFive());
			partsSsdHistoryVO.setScsCd(partsSsdVO.getScsCd());
			partsSsdHistoryVO.setSata(partsSsdVO.getSata());
			partsSsdHistoryVO.setPartsImage(partsSsdVO.getPartsImage());
			partsSsdHistoryVO.setMultiBulk(partsSsdVO.getMultiBulk());
			partsSsdHistoryVO.setVolume(partsSsdVO.getVolume());

			result += partsDAO.insertPartsSsdHistoryVO(partsSsdHistoryVO);
		}
		return result;
	}
	
	@Override
	public List<PartsSsdVO> getSsdAllList() {
		PartsSsdVO searchVO = new PartsSsdVO();
		searchVO.setId(null);
		return partsDAO.getSsdAllList(searchVO);
	}
	
	@Override
	public PartsSsdVO getPartsSsdVOById(String id) {
		PartsSsdVO resultVO = null;
		PartsSsdVO searchVO = new PartsSsdVO();
		
		searchVO.setId(id);
		List<PartsSsdVO> resultList = partsDAO.getSsdAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer ssdUpdateLogic(PartsSsdVO partsSsdVO) {
		int result = 0;
		result = partsDAO.updatePartsSsdVO(partsSsdVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsSsdHistoryVO partsSsdHistoryVO = new PartsSsdHistoryVO();
			partsSsdHistoryVO.setId(partsSsdVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsSsdHistoryVOMaxHistorySeq(partsSsdVO.getId());
			partsSsdHistoryVO.setHistorySeq(maxHistorySeq);
			partsSsdHistoryVO.setPartsName(partsSsdVO.getPartsName());
			partsSsdHistoryVO.setPartsPrice(partsSsdVO.getPartsPrice());
			partsSsdHistoryVO.setBasic(partsSsdVO.getBasic());
			partsSsdHistoryVO.setFnc(partsSsdVO.getFnc());
			partsSsdHistoryVO.setCmf(partsSsdVO.getCmf());
			partsSsdHistoryVO.setWar(partsSsdVO.getWar());
			partsSsdHistoryVO.setThr(partsSsdVO.getThr());
			partsSsdHistoryVO.setRlb(partsSsdVO.getRlb());
			partsSsdHistoryVO.setStrTwoDotFive(partsSsdVO.getStrTwoDotFive());
			partsSsdHistoryVO.setScsCd(partsSsdVO.getScsCd());
			partsSsdHistoryVO.setSata(partsSsdVO.getSata());
			partsSsdHistoryVO.setPartsImage(partsSsdVO.getPartsImage());
			partsSsdHistoryVO.setMultiBulk(partsSsdVO.getMultiBulk());
			partsSsdHistoryVO.setVolume(partsSsdVO.getVolume());

			result += partsDAO.insertPartsSsdHistoryVO(partsSsdHistoryVO);
		}
		return result;
	}
	
	/*--------------------------------------------------
	 - SF
	*--------------------------------------------------*/
	@Override
	public Integer sfRegistLogic(PartsSfVO partsSfVO) {
		int result = 0;
		partsSfVO.setId(partsDAO.getPartsSfVOMaxId());
		result = partsDAO.insertPartsSfVO(partsSfVO);
		
		// 최초 등록 시 이력 등록
		if(1 == result) {
			PartsSfHistoryVO partsSfHistoryVO = new PartsSfHistoryVO();
			partsSfHistoryVO.setId(partsSfVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsSfHistoryVOMaxHistorySeq(partsSfVO.getId());
			partsSfHistoryVO.setHistorySeq(maxHistorySeq);
			partsSfHistoryVO.setPartsName(partsSfVO.getPartsName());
			partsSfHistoryVO.setPartsPrice(partsSfVO.getPartsPrice());
			partsSfHistoryVO.setFledCd(partsSfVO.getFledCd());
			partsSfHistoryVO.setFmcCd(partsSfVO.getFmcCd());
			partsSfHistoryVO.setFscCd(partsSfVO.getFscCd());
			partsSfHistoryVO.setFnoi(partsSfVO.getFnoi());
			partsSfHistoryVO.setFfm(partsSfVO.getFfm());
			partsSfHistoryVO.setFh(partsSfVO.getFh());
			partsSfHistoryVO.setFt(partsSfVO.getFt());
			partsSfHistoryVO.setPartsImage(partsSfVO.getPartsImage());
			partsSfHistoryVO.setMultiBulk(partsSfVO.getMultiBulk());

			result += partsDAO.insertPartsSfHistoryVO(partsSfHistoryVO);
		}
		return result;
	}
	
	@Override
	public List<PartsSfVO> getSfAllList() {
		PartsSfVO searchVO = new PartsSfVO();
		searchVO.setId(null);
		return partsDAO.getSfAllList(searchVO);
	}
	
	@Override
	public PartsSfVO getPartsSfVOById(String id) {
		PartsSfVO resultVO = null;
		PartsSfVO searchVO = new PartsSfVO();
		
		searchVO.setId(id);
		List<PartsSfVO> resultList = partsDAO.getSfAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer sfUpdateLogic(PartsSfVO partsSfVO) {
		int result = 0;
		result = partsDAO.updatePartsSfVO(partsSfVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsSfHistoryVO partsSfHistoryVO = new PartsSfHistoryVO();
			partsSfHistoryVO.setId(partsSfVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsSfHistoryVOMaxHistorySeq(partsSfVO.getId());
			partsSfHistoryVO.setHistorySeq(maxHistorySeq);
			partsSfHistoryVO.setPartsName(partsSfVO.getPartsName());
			partsSfHistoryVO.setPartsPrice(partsSfVO.getPartsPrice());
			partsSfHistoryVO.setFledCd(partsSfVO.getFledCd());
			partsSfHistoryVO.setFmcCd(partsSfVO.getFmcCd());
			partsSfHistoryVO.setFscCd(partsSfVO.getFscCd());
			partsSfHistoryVO.setFnoi(partsSfVO.getFnoi());
			partsSfHistoryVO.setFfm(partsSfVO.getFfm());
			partsSfHistoryVO.setFh(partsSfVO.getFh());
			partsSfHistoryVO.setFt(partsSfVO.getFt());
			partsSfHistoryVO.setPartsImage(partsSfVO.getPartsImage());
			partsSfHistoryVO.setMultiBulk(partsSfVO.getMultiBulk());

			result += partsDAO.insertPartsSfHistoryVO(partsSfHistoryVO);
		}
		return result;
	}
	
	/*--------------------------------------------------
	 - MAKER
	*--------------------------------------------------*/
	@Override
	public Integer makerRegistLogic(PartsMakerVO partsMakerVO) {
		int result = 0;
		partsMakerVO.setId(partsDAO.getPartsMakerVOMaxId());
		result = partsDAO.insertPartsMakerVO(partsMakerVO);
		
		// 최초 insert 시 이력 등록
		if(1 == result) {
			PartsMakerHistoryVO partsMakerHistoryVO = new PartsMakerHistoryVO();
			partsMakerHistoryVO.setId(partsMakerVO.getId());
			partsMakerHistoryVO.setHistorySeq(1);
			partsMakerHistoryVO.setMakerName(partsMakerVO.getMakerName());
			partsMakerHistoryVO.setAsScore(partsMakerVO.getAsScore());
			result += partsDAO.insertPartsMakerHistoryVO(partsMakerHistoryVO);
		}
		
		return result;
	}
	
	@Override
	public List<PartsMakerVO> getMakerAllList() {
		PartsMakerVO searchVO = new PartsMakerVO();
		searchVO.setId(null);
		return partsDAO.getMakerAllList(searchVO);
	}
	
	@Override
	public PartsMakerVO getPartsMakerVOById(String id) {
		PartsMakerVO resultVO = null;
		PartsMakerVO searchVO = new PartsMakerVO();
		
		searchVO.setId(id);
		List<PartsMakerVO> resultList = partsDAO.getMakerAllList(searchVO);
		
		if(resultList.size() != 0) {
			resultVO = resultList.get(0);
		}
		
		return resultVO;
	}
	
	@Override
	public Integer makerUpdateLogic(PartsMakerVO partsMakerVO) {
		int result = 0;
		result = partsDAO.updatePartsMakerVO(partsMakerVO);
		
		// update 시 이력 등록
		if(1 == result) {
			PartsMakerHistoryVO partsMakerHistoryVO = new PartsMakerHistoryVO();
			partsMakerHistoryVO.setId(partsMakerVO.getId());
			
			int maxHistorySeq = partsDAO.getPartsMakerHistoryVOMaxHistorySeq(partsMakerVO.getId());
			partsMakerHistoryVO.setHistorySeq(maxHistorySeq);
			partsMakerHistoryVO.setMakerName(partsMakerVO.getMakerName());
			partsMakerHistoryVO.setAsScore(partsMakerVO.getAsScore());
			result += partsDAO.insertPartsMakerHistoryVO(partsMakerHistoryVO);
		}
		return result;
	}
}
