package com.hw.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import com.hw.model.ProductDetailVO;
import com.hw.model.ProductMasterVO;
import com.hw.service.AdminService;
import com.hw.service.PartsService;
import com.hw.service.ProductService;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	private static final Logger LOGGER = LogManager.getLogger(AdminController.class);
	
	@Autowired
    private AdminService adminService;
	
	@Autowired
    private PartsService partsService;
	
	@Autowired
    private ProductService productService;
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String goAdminPageMain(Model model) {
		return "adminPageMain";
	}
	
	@RequestMapping(value = "/gpuManagement.do", method = RequestMethod.GET)
	public String goGpuManagement(Model model) {
		model.addAttribute("gpuList", partsService.getGpuAllList());
		return "gpuManagement";
	}
	
	@RequestMapping(value = "/gpuRegist.do", method = RequestMethod.GET)
	public String goGpuRegist(Model model) {
		model.addAttribute("gled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("gmc_cd", adminService.getComnCdDetailList("PRT001"));
		model.addAttribute("gsc_cd", adminService.getComnCdDetailList("PRT002"));
		model.addAttribute("gpuas_cd", adminService.getComnCdDetailList("PRT003"));
		return "gpuRegist";
	}
	
	@RequestMapping(value = "/gpuRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer gpuRegistLogic(PartsGpuVO partsGpuVO) {
		return partsService.gpuRegistLogic(partsGpuVO);
	}
	
	@RequestMapping(value = "/cpuManagement.do", method = RequestMethod.GET)
	public String goCpuManagement(Model model) {
		model.addAttribute("cpuList", partsService.getCpuAllList());
		return "cpuManagement";
	}
	
	@RequestMapping(value = "/cpuRegist.do", method = RequestMethod.GET)
	public String goCpuRegist(Model model) {
		model.addAttribute("maker_cd", adminService.getComnCdDetailList("PRT009"));
		model.addAttribute("cpu_soc_cd", adminService.getComnCdDetailList("PRT007"));
		return "cpuRegist";
	}
	
	@RequestMapping(value = "/cpuRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer cpuRegistLogic(PartsCpuVO partsCpuVO) {
		return partsService.cpuRegistLogic(partsCpuVO);
	}
	
	@RequestMapping(value = "/mbManagement.do", method = RequestMethod.GET)
	public String goMbManagement(Model model) {
		model.addAttribute("mbList", partsService.getMbAllList());
		return "mbManagement";
	}
	
	@RequestMapping(value = "/mbRegist.do", method = RequestMethod.GET)
	public String goMbRegist(Model model) {
		model.addAttribute("mled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("mmc_cd", adminService.getComnCdDetailList("PRT004"));
		model.addAttribute("msc_cd", adminService.getComnCdDetailList("PRT005"));
		model.addAttribute("mbas_cd", adminService.getComnCdDetailList("PRT006"));
		model.addAttribute("cpu_soc_cd", adminService.getComnCdDetailList("PRT007"));
		model.addAttribute("mem_soc_cd", adminService.getComnCdDetailList("PRT024"));
		model.addAttribute("scs_cd", adminService.getComnCdDetailList("PRT008"));
		return "mbRegist";
	}
	
	@RequestMapping(value = "/mbRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer mbRegistLogic(PartsMbVO partsMbVO) {
		return partsService.mbRegistLogic(partsMbVO);
	}
	
	@RequestMapping(value = "/ramManagement.do", method = RequestMethod.GET)
	public String goRamManagement(Model model) {
		model.addAttribute("ramList", partsService.getRamAllList());
		return "ramManagement";
	}
	
	@RequestMapping(value = "/ramRegist.do", method = RequestMethod.GET)
	public String goRamRegist(Model model) {
		model.addAttribute("rled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("rmc_cd", adminService.getComnCdDetailList("PRT010"));
		model.addAttribute("rsc_cd", adminService.getComnCdDetailList("PRT011"));
		model.addAttribute("pr_cd", adminService.getComnCdDetailList("PRT012"));
		model.addAttribute("mem_soc_cd", adminService.getComnCdDetailList("PRT024"));
		return "ramRegist";
	}
	
	@RequestMapping(value = "/ramRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer ramRegistLogic(PartsRamVO partsRamVO) {
		return partsService.ramRegistLogic(partsRamVO);
	}
	
	@RequestMapping(value = "/psuManagement.do", method = RequestMethod.GET)
	public String goPsuManagement(Model model) {
		model.addAttribute("psuList", partsService.getPsuAllList());
		return "psuManagement";
	}
	
	@RequestMapping(value = "/psuRegist.do", method = RequestMethod.GET)
	public String goPsuRegist(Model model) {
		model.addAttribute("pmc_cd", adminService.getComnCdDetailList("PRT013"));
		model.addAttribute("psc_cd", adminService.getComnCdDetailList("PRT014"));
		return "psuRegist";
	}
	
	@RequestMapping(value = "/psuRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer psuRegistLogic(PartsPsuVO partsPsuVO) {
		return partsService.psuRegistLogic(partsPsuVO);
	}

	@RequestMapping(value = "/caseManagement.do", method = RequestMethod.GET)
	public String goCaseManagement(Model model) {
		model.addAttribute("caseList", partsService.getCaseAllList());
		return "caseManagement";
	}
	
	@RequestMapping(value = "/caseRegist.do", method = RequestMethod.GET)
	public String goCaseRegist(Model model) {
		model.addAttribute("cled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("cm_cd", adminService.getComnCdDetailList("PRT023"));
		model.addAttribute("cmc_cd", adminService.getComnCdDetailList("PRT015"));
		model.addAttribute("csc_cd", adminService.getComnCdDetailList("PRT016"));
		model.addAttribute("caseas_cd", adminService.getComnCdDetailList("PRT017"));
		return "caseRegist";
	}
	
	@RequestMapping(value = "/caseRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer caseRegistLogic(PartsCaseVO partsCaseVO) {
		return partsService.caseRegistLogic(partsCaseVO);
	}
	
	@RequestMapping(value = "/coolerManagement.do", method = RequestMethod.GET)
	public String goCoolerManagement(Model model) {
		model.addAttribute("coolerList", partsService.getCoolerAllList());
		return "coolerManagement";
	}
	
	@RequestMapping(value = "/coolerRegist.do", method = RequestMethod.GET)
	public String goCoolerRegist(Model model) {
		model.addAttribute("clled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("clmc_cd", adminService.getComnCdDetailList("PRT018"));
		model.addAttribute("clsc_cd", adminService.getComnCdDetailList("PRT019"));
		model.addAttribute("formula_cd", adminService.getComnCdDetailList("PRT020"));
		return "coolerRegist";
	}
	
	@RequestMapping(value = "/coolerRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer coolerRegistLogic(PartsCoolerVO partsCoolerVO) {
		return partsService.coolerRegistLogic(partsCoolerVO);
	}
	
	@RequestMapping(value = "/hddManagement.do", method = RequestMethod.GET)
	public String goHddManagement(Model model) {
		model.addAttribute("hddList", partsService.getHddAllList());
		return "hddManagement";
	}
	
	@RequestMapping(value = "/hddRegist.do", method = RequestMethod.GET)
	public String goHddRegist(Model model) {
		return "hddRegist";
	}
	
	@RequestMapping(value = "/hddRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer hddRegistLogic(PartsHddVO partsHddVO) {
		return partsService.hddRegistLogic(partsHddVO);
	}
	
	@RequestMapping(value = "/ssdManagement.do", method = RequestMethod.GET)
	public String goSsdManagement(Model model) {
		model.addAttribute("ssdList", partsService.getSsdAllList());
		return "ssdManagement";
	}
	
	@RequestMapping(value = "/ssdRegist.do", method = RequestMethod.GET)
	public String goSsdRegist(Model model) {
		model.addAttribute("scs_cd", adminService.getComnCdDetailList("PRT008"));
		return "ssdRegist";
	}
	
	@RequestMapping(value = "/ssdRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer ssdRegistLogic(PartsSsdVO partsSsdVO) {
		return partsService.ssdRegistLogic(partsSsdVO);
	}
	
	@RequestMapping(value = "/sfManagement.do", method = RequestMethod.GET)
	public String goSfManagement(Model model) {
		model.addAttribute("sfList", partsService.getSfAllList());
		return "sfManagement";
	}
	
	@RequestMapping(value = "/sfRegist.do", method = RequestMethod.GET)
	public String goSfRegist(Model model) {
		model.addAttribute("fled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("fmc_cd", adminService.getComnCdDetailList("PRT021"));
		model.addAttribute("fsc_cd", adminService.getComnCdDetailList("PRT022"));
		return "sfRegist";
	}
	
	@RequestMapping(value = "/sfRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer sfRegistLogic(PartsSfVO partsSfVO) {
		return partsService.sfRegistLogic(partsSfVO);
	}
	
	@RequestMapping(value = "/productManagement.do", method = RequestMethod.GET)
	public String goProductManagement(Model model) {
		model.addAttribute("productList", productService.getProductMasterAllList());
		return "productManagement";
	}
	
	@RequestMapping(value = "/productRegist.do", method = RequestMethod.GET)
	public String goProductRegist(Model model) {
		model.addAttribute("parts_type_cd", adminService.getComnCdDetailList("COM003"));
		model.addAttribute("gpuList", partsService.getGpuAllList());
		model.addAttribute("cpuList", partsService.getCpuAllList());
		model.addAttribute("mbList", partsService.getMbAllList());
		model.addAttribute("ramList", partsService.getRamAllList());
		model.addAttribute("psuList", partsService.getPsuAllList());
		model.addAttribute("caseList", partsService.getCaseAllList());
		model.addAttribute("coolerList", partsService.getCoolerAllList());
		model.addAttribute("hddList", partsService.getHddAllList());
		model.addAttribute("ssdList", partsService.getSsdAllList());
		model.addAttribute("sfList", partsService.getSfAllList());
		return "productRegist";
	}
	
	@RequestMapping(value = "/productRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer productRegistLogic(
			@RequestParam(value = "productMasterVO", required = true) String productMasterVOString
			, @RequestParam(value = "productDetailVOList", required = true) String productDetailVOListString) throws JsonMappingException, JsonProcessingException {
		
		ProductMasterVO productMasterVO = new ProductMasterVO();
		List<ProductDetailVO> productDetailVOList = new ArrayList<>();
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		productMasterVO = objectMapper.readValue(productMasterVOString, ProductMasterVO.class);
		productDetailVOList = objectMapper.readValue(productDetailVOListString, new TypeReference<List<ProductDetailVO>>() {});
		
		return productService.productRegistLogic(productMasterVO, productDetailVOList);
	}
}
