package com.hw.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import com.hw.model.UserInfoVO;
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
	public String goAdminPageMain(HttpServletRequest request, Model model) {
		return adminLoginCheck(request, model, "adminPageMain");
	}
	
	/*--------------------------------------------------
	 - GPU
	*--------------------------------------------------*/
	@RequestMapping(value = "/gpuManagement.do", method = RequestMethod.GET)
	public String goGpuManagement(HttpServletRequest request, Model model) {
		model.addAttribute("gpuList", partsService.getGpuAllList());
		return adminLoginCheck(request, model, "gpuManagement");
	}
	
	@RequestMapping(value = "/gpuRegist.do", method = RequestMethod.GET)
	public String goGpuRegist(HttpServletRequest request, Model model) {
		model.addAttribute("gled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("gmc_cd", adminService.getComnCdDetailList("PRT001"));
		model.addAttribute("gsc_cd", adminService.getComnCdDetailList("PRT002"));
		model.addAttribute("gpuas_cd", adminService.getComnCdDetailList("PRT003"));
		return adminLoginCheck(request, model, "gpuRegist");
	}
	
	@RequestMapping(value = "/gpuRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer gpuRegistLogic(PartsGpuVO partsGpuVO) {
		return partsService.gpuRegistLogic(partsGpuVO);
	}
	
	@RequestMapping(value = "/gpuUpdate.do", method = RequestMethod.GET)
	public String goGpuUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("gled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("gmc_cd", adminService.getComnCdDetailList("PRT001"));
		model.addAttribute("gsc_cd", adminService.getComnCdDetailList("PRT002"));
		model.addAttribute("gpuas_cd", adminService.getComnCdDetailList("PRT003"));
		
		model.addAttribute("selectData", partsService.getPartsGpuVOById(partsId));
		return adminLoginCheck(request, model, "gpuUpdate");
	}
	
	@RequestMapping(value = "/gpuUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer gpuUpdateLogic(PartsGpuVO partsGpuVO) {
		return partsService.gpuUpdateLogic(partsGpuVO);
	}
	
	
	/*--------------------------------------------------
	 - CPU
	*--------------------------------------------------*/
	@RequestMapping(value = "/cpuManagement.do", method = RequestMethod.GET)
	public String goCpuManagement(HttpServletRequest request, Model model) {
		model.addAttribute("cpuList", partsService.getCpuAllList());
		return adminLoginCheck(request, model, "cpuManagement");
	}
	
	@RequestMapping(value = "/cpuRegist.do", method = RequestMethod.GET)
	public String goCpuRegist(HttpServletRequest request, Model model) {
		model.addAttribute("maker_cd", adminService.getComnCdDetailList("PRT009"));
		model.addAttribute("cpu_soc_cd", adminService.getComnCdDetailList("PRT007"));
		return adminLoginCheck(request, model, "cpuRegist");
	}
	
	@RequestMapping(value = "/cpuRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer cpuRegistLogic(PartsCpuVO partsCpuVO) {
		return partsService.cpuRegistLogic(partsCpuVO);
	}
	
	@RequestMapping(value = "/cpuUpdate.do", method = RequestMethod.GET)
	public String goCpuUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("maker_cd", adminService.getComnCdDetailList("PRT009"));
		model.addAttribute("cpu_soc_cd", adminService.getComnCdDetailList("PRT007"));
		
		model.addAttribute("selectData", partsService.getPartsCpuVOById(partsId));
		return adminLoginCheck(request, model, "cpuUpdate");
	}
	
	@RequestMapping(value = "/cpuUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer cpuUpdateLogic(PartsCpuVO partsCpuVO) {
		return partsService.cpuUpdateLogic(partsCpuVO);
	}
	
	/*--------------------------------------------------
	 - MB
	*--------------------------------------------------*/	
	@RequestMapping(value = "/mbManagement.do", method = RequestMethod.GET)
	public String goMbManagement(HttpServletRequest request, Model model) {
		model.addAttribute("mbList", partsService.getMbAllList());
		return adminLoginCheck(request, model, "mbManagement");
	}
	
	@RequestMapping(value = "/mbRegist.do", method = RequestMethod.GET)
	public String goMbRegist(HttpServletRequest request, Model model) {
		model.addAttribute("mled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("mmc_cd", adminService.getComnCdDetailList("PRT004"));
		model.addAttribute("msc_cd", adminService.getComnCdDetailList("PRT005"));
		model.addAttribute("mbas_cd", adminService.getComnCdDetailList("PRT006"));
		model.addAttribute("cpu_soc_cd", adminService.getComnCdDetailList("PRT007"));
		model.addAttribute("mem_soc_cd", adminService.getComnCdDetailList("PRT024"));
		model.addAttribute("scs_cd", adminService.getComnCdDetailList("PRT008"));
		return adminLoginCheck(request, model, "mbRegist");
	}
	
	@RequestMapping(value = "/mbRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer mbRegistLogic(PartsMbVO partsMbVO) {
		return partsService.mbRegistLogic(partsMbVO);
	}
	
	@RequestMapping(value = "/mbUpdate.do", method = RequestMethod.GET)
	public String goMbUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("mled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("mmc_cd", adminService.getComnCdDetailList("PRT004"));
		model.addAttribute("msc_cd", adminService.getComnCdDetailList("PRT005"));
		model.addAttribute("mbas_cd", adminService.getComnCdDetailList("PRT006"));
		model.addAttribute("cpu_soc_cd", adminService.getComnCdDetailList("PRT007"));
		model.addAttribute("mem_soc_cd", adminService.getComnCdDetailList("PRT024"));
		model.addAttribute("scs_cd", adminService.getComnCdDetailList("PRT008"));
		
		model.addAttribute("selectData", partsService.getPartsMbVOById(partsId));
		return adminLoginCheck(request, model, "mbUpdate");
	}
	
	@RequestMapping(value = "/mbUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer mbUpdateLogic(PartsMbVO partsMbVO) {
		return partsService.mbUpdateLogic(partsMbVO);
	}
	
	/*--------------------------------------------------
	 - RAM
	*--------------------------------------------------*/
	@RequestMapping(value = "/ramManagement.do", method = RequestMethod.GET)
	public String goRamManagement(HttpServletRequest request, Model model) {
		model.addAttribute("ramList", partsService.getRamAllList());
		return adminLoginCheck(request, model, "ramManagement");
	}
	
	@RequestMapping(value = "/ramRegist.do", method = RequestMethod.GET)
	public String goRamRegist(HttpServletRequest request, Model model) {
		model.addAttribute("rled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("rmc_cd", adminService.getComnCdDetailList("PRT010"));
		model.addAttribute("rsc_cd", adminService.getComnCdDetailList("PRT011"));
		model.addAttribute("pr_cd", adminService.getComnCdDetailList("PRT012"));
		model.addAttribute("mem_soc_cd", adminService.getComnCdDetailList("PRT024"));
		return adminLoginCheck(request, model, "ramRegist");
	}
	
	@RequestMapping(value = "/ramRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer ramRegistLogic(PartsRamVO partsRamVO) {
		return partsService.ramRegistLogic(partsRamVO);
	}
	
	@RequestMapping(value = "/ramUpdate.do", method = RequestMethod.GET)
	public String goRamUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("rled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("rmc_cd", adminService.getComnCdDetailList("PRT010"));
		model.addAttribute("rsc_cd", adminService.getComnCdDetailList("PRT011"));
		model.addAttribute("pr_cd", adminService.getComnCdDetailList("PRT012"));
		model.addAttribute("mem_soc_cd", adminService.getComnCdDetailList("PRT024"));
		
		model.addAttribute("selectData", partsService.getPartsRamVOById(partsId));
		return adminLoginCheck(request, model, "ramUpdate");
	}
	
	@RequestMapping(value = "/ramUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer ramUpdateLogic(PartsRamVO partsRamVO) {
		return partsService.ramUpdateLogic(partsRamVO);
	}
	
	/*--------------------------------------------------
	 - PSU
	*--------------------------------------------------*/
	@RequestMapping(value = "/psuManagement.do", method = RequestMethod.GET)
	public String goPsuManagement(HttpServletRequest request, Model model) {
		model.addAttribute("psuList", partsService.getPsuAllList());
		return adminLoginCheck(request, model, "psuManagement");
	}
	
	@RequestMapping(value = "/psuRegist.do", method = RequestMethod.GET)
	public String goPsuRegist(HttpServletRequest request, Model model) {
		model.addAttribute("pmc_cd", adminService.getComnCdDetailList("PRT013"));
		model.addAttribute("psc_cd", adminService.getComnCdDetailList("PRT014"));
		return adminLoginCheck(request, model, "psuRegist");
	}
	
	@RequestMapping(value = "/psuRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer psuRegistLogic(PartsPsuVO partsPsuVO) {
		return partsService.psuRegistLogic(partsPsuVO);
	}
	
	@RequestMapping(value = "/psuUpdate.do", method = RequestMethod.GET)
	public String goPsuUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("pmc_cd", adminService.getComnCdDetailList("PRT013"));
		model.addAttribute("psc_cd", adminService.getComnCdDetailList("PRT014"));
		
		model.addAttribute("selectData", partsService.getPartsPsuVOById(partsId));
		return adminLoginCheck(request, model, "psuUpdate");
	}
	
	@RequestMapping(value = "/psuUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer psuUpdateLogic(PartsPsuVO partsPsuVO) {
		return partsService.psuUpdateLogic(partsPsuVO);
	}

	/*--------------------------------------------------
	 - CASE
	*--------------------------------------------------*/
	@RequestMapping(value = "/caseManagement.do", method = RequestMethod.GET)
	public String goCaseManagement(HttpServletRequest request, Model model) {
		model.addAttribute("caseList", partsService.getCaseAllList());
		return adminLoginCheck(request, model, "caseManagement");
	}
	
	@RequestMapping(value = "/caseRegist.do", method = RequestMethod.GET)
	public String goCaseRegist(HttpServletRequest request, Model model) {
		model.addAttribute("cled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("cm_cd", adminService.getComnCdDetailList("PRT023"));
		model.addAttribute("cmc_cd", adminService.getComnCdDetailList("PRT015"));
		model.addAttribute("csc_cd", adminService.getComnCdDetailList("PRT016"));
		model.addAttribute("caseas_cd", adminService.getComnCdDetailList("PRT017"));
		return adminLoginCheck(request, model, "caseRegist");
	}
	
	@RequestMapping(value = "/caseRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer caseRegistLogic(PartsCaseVO partsCaseVO) {
		return partsService.caseRegistLogic(partsCaseVO);
	}
	
	@RequestMapping(value = "/caseUpdate.do", method = RequestMethod.GET)
	public String goCaseUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("cled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("cm_cd", adminService.getComnCdDetailList("PRT023"));
		model.addAttribute("cmc_cd", adminService.getComnCdDetailList("PRT015"));
		model.addAttribute("csc_cd", adminService.getComnCdDetailList("PRT016"));
		model.addAttribute("caseas_cd", adminService.getComnCdDetailList("PRT017"));
		
		model.addAttribute("selectData", partsService.getPartsCaseVOById(partsId));
		return adminLoginCheck(request, model, "caseUpdate");
	}
	
	@RequestMapping(value = "/caseUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer caseUpdateLogic(PartsCaseVO partsCaseVO) {
		return partsService.caseUpdateLogic(partsCaseVO);
	}
	
	/*--------------------------------------------------
	 - COOLER
	*--------------------------------------------------*/
	@RequestMapping(value = "/coolerManagement.do", method = RequestMethod.GET)
	public String goCoolerManagement(HttpServletRequest request, Model model) {
		model.addAttribute("coolerList", partsService.getCoolerAllList());
		return adminLoginCheck(request, model, "coolerManagement");
	}
	
	@RequestMapping(value = "/coolerRegist.do", method = RequestMethod.GET)
	public String goCoolerRegist(HttpServletRequest request, Model model) {
		model.addAttribute("clled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("clmc_cd", adminService.getComnCdDetailList("PRT018"));
		model.addAttribute("clsc_cd", adminService.getComnCdDetailList("PRT019"));
		model.addAttribute("formula_cd", adminService.getComnCdDetailList("PRT020"));
		return adminLoginCheck(request, model, "coolerRegist");
	}
	
	@RequestMapping(value = "/coolerRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer coolerRegistLogic(PartsCoolerVO partsCoolerVO) {
		return partsService.coolerRegistLogic(partsCoolerVO);
	}
	
	@RequestMapping(value = "/coolerUpdate.do", method = RequestMethod.GET)
	public String goCoolerUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("clled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("clmc_cd", adminService.getComnCdDetailList("PRT018"));
		model.addAttribute("clsc_cd", adminService.getComnCdDetailList("PRT019"));
		model.addAttribute("formula_cd", adminService.getComnCdDetailList("PRT020"));
		
		model.addAttribute("selectData", partsService.getPartsCoolerVOById(partsId));
		return adminLoginCheck(request, model, "coolerUpdate");
	}
	
	@RequestMapping(value = "/coolerUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer coolerUpdateLogic(PartsCoolerVO partsCoolerVO) {
		return partsService.coolerUpdateLogic(partsCoolerVO);
	}
	
	/*--------------------------------------------------
	 - HDD
	*--------------------------------------------------*/
	@RequestMapping(value = "/hddManagement.do", method = RequestMethod.GET)
	public String goHddManagement(HttpServletRequest request, Model model) {
		model.addAttribute("hddList", partsService.getHddAllList());
		return adminLoginCheck(request, model, "hddManagement");
	}
	
	@RequestMapping(value = "/hddRegist.do", method = RequestMethod.GET)
	public String goHddRegist(HttpServletRequest request, Model model) {
		return adminLoginCheck(request, model, "hddRegist");
	}
	
	@RequestMapping(value = "/hddRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer hddRegistLogic(PartsHddVO partsHddVO) {
		return partsService.hddRegistLogic(partsHddVO);
	}
	
	@RequestMapping(value = "/hddUpdate.do", method = RequestMethod.GET)
	public String goHddUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("selectData", partsService.getPartsHddVOById(partsId));
		return adminLoginCheck(request, model, "hddUpdate");
	}
	
	@RequestMapping(value = "/hddUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer hddUpdateLogic(PartsHddVO partsHddVO) {
		return partsService.hddUpdateLogic(partsHddVO);
	}
	
	/*--------------------------------------------------
	 - SSD
	*--------------------------------------------------*/
	@RequestMapping(value = "/ssdManagement.do", method = RequestMethod.GET)
	public String goSsdManagement(HttpServletRequest request, Model model) {
		model.addAttribute("ssdList", partsService.getSsdAllList());
		return adminLoginCheck(request, model, "ssdManagement");
	}
	
	@RequestMapping(value = "/ssdRegist.do", method = RequestMethod.GET)
	public String goSsdRegist(HttpServletRequest request, Model model) {
		model.addAttribute("scs_cd", adminService.getComnCdDetailList("PRT008"));
		return adminLoginCheck(request, model, "ssdRegist");
	}
	
	@RequestMapping(value = "/ssdRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer ssdRegistLogic(PartsSsdVO partsSsdVO) {
		return partsService.ssdRegistLogic(partsSsdVO);
	}
	
	@RequestMapping(value = "/ssdUpdate.do", method = RequestMethod.GET)
	public String goSsdUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("scs_cd", adminService.getComnCdDetailList("PRT008"));
		
		model.addAttribute("selectData", partsService.getPartsSsdVOById(partsId));
		return adminLoginCheck(request, model, "ssdUpdate");
	}
	
	@RequestMapping(value = "/ssdUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer ssdUpdateLogic(PartsSsdVO partsSsdVO) {
		return partsService.ssdUpdateLogic(partsSsdVO);
	}
	
	
	/*--------------------------------------------------
	 - SF
	*--------------------------------------------------*/
	@RequestMapping(value = "/sfManagement.do", method = RequestMethod.GET)
	public String goSfManagement(HttpServletRequest request, Model model) {
		model.addAttribute("sfList", partsService.getSfAllList());
		return adminLoginCheck(request, model, "sfManagement");
	}
	
	@RequestMapping(value = "/sfRegist.do", method = RequestMethod.GET)
	public String goSfRegist(HttpServletRequest request, Model model) {
		model.addAttribute("fled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("fmc_cd", adminService.getComnCdDetailList("PRT021"));
		model.addAttribute("fsc_cd", adminService.getComnCdDetailList("PRT022"));
		return adminLoginCheck(request, model, "sfRegist");
	}
	
	@RequestMapping(value = "/sfRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer sfRegistLogic(PartsSfVO partsSfVO) {
		return partsService.sfRegistLogic(partsSfVO);
	}
	
	@RequestMapping(value = "/sfUpdate.do", method = RequestMethod.GET)
	public String goSfUpdate(HttpServletRequest request, Model model, @RequestParam(value = "partsId", required = true) String partsId) {
		model.addAttribute("fled_cd", adminService.getComnCdDetailList("COM002"));
		model.addAttribute("fmc_cd", adminService.getComnCdDetailList("PRT021"));
		model.addAttribute("fsc_cd", adminService.getComnCdDetailList("PRT022"));
		
		model.addAttribute("selectData", partsService.getPartsSfVOById(partsId));
		return adminLoginCheck(request, model, "sfUpdate");
	}
	
	@RequestMapping(value = "/sfUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer sfUpdateLogic(PartsSfVO partsSfVO) {
		return partsService.sfUpdateLogic(partsSfVO);
	}
	
	
	/*--------------------------------------------------
	 - PRODUCT
	*--------------------------------------------------*/
	@RequestMapping(value = "/productManagement.do", method = RequestMethod.GET)
	public String goProductManagement(HttpServletRequest request, Model model) {
		model.addAttribute("productList", productService.getProductMasterAllList());
		return adminLoginCheck(request, model, "productManagement");
	}
	
	@RequestMapping(value = "/productRegist.do", method = RequestMethod.GET)
	public String goProductRegist(HttpServletRequest request, Model model) {
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
		return adminLoginCheck(request, model, "productRegist");
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
	
	@RequestMapping(value = "/productUpdate.do", method = RequestMethod.GET)
	public String goProductUpdate(HttpServletRequest request, Model model, @RequestParam(value = "productId", required = true) String productId) {
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
		
		model.addAttribute("selectMasterData", productService.getProductMasterById(productId));
		
		List<ProductDetailVO> productDetailVOList = productService.getProductDetailById(productId);
		
		ObjectMapper mapper = new ObjectMapper();
		String productDetailVOListJson = "";
		try {
			productDetailVOListJson = mapper.writeValueAsString(productDetailVOList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("selectDetailDataJson", productDetailVOListJson);
		
		return adminLoginCheck(request, model, "productUpdate");
	}
	
	@RequestMapping(value = "/productUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer productUpdateLogic(
			@RequestParam(value = "productMasterVO", required = true) String productMasterVOString
			, @RequestParam(value = "productDetailVOList", required = true) String productDetailVOListString) throws JsonMappingException, JsonProcessingException {
		
		ProductMasterVO productMasterVO = new ProductMasterVO();
		List<ProductDetailVO> productDetailVOList = new ArrayList<>();
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		productMasterVO = objectMapper.readValue(productMasterVOString, ProductMasterVO.class);
		productDetailVOList = objectMapper.readValue(productDetailVOListString, new TypeReference<List<ProductDetailVO>>() {});
		
		return productService.productUpdateLogic(productMasterVO, productDetailVOList);
	}

	private String adminLoginCheck(HttpServletRequest request, Model model, String url) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		if(null == user || user.getUserTypeCd().equals("02")) {
			model.addAttribute("msg", "관리자로그인 후에 접근가능합니다.");
			model.addAttribute("url", "/");
			return "redirect";
		}else {
			return url;
		}
	}
	
}
