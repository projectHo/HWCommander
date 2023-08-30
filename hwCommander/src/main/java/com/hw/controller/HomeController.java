package com.hw.controller;

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
import org.springframework.web.bind.annotation.SessionAttribute;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hw.model.EstimateCalculationResultPrivateDetailVO;
import com.hw.model.EstimateCalculationResultPrivateMasterVO;
import com.hw.model.PartsMbHistoryVO;
import com.hw.model.PartsRamHistoryVO;
import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;
import com.hw.model.UserInfoVO;
import com.hw.service.ProcessResourceService;
import com.hw.service.ProductService;
//08.17 test
import com.hw.service.PartsService;
// end


@Controller
public class HomeController {
	
	private static final Logger LOGGER = LogManager.getLogger(HomeController.class);
	
	@Autowired
    private ProductService productService;
	
//	08.17 test
	@Autowired
	private PartsService partsService;
// end

	@Autowired
    private ProcessResourceService processResourceService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(@SessionAttribute(name = "loginUser", required = false)UserInfoVO userInfoVO, Model model) {
		
		model.addAttribute("loginUser", userInfoVO);
		
		return "main";
	}
	
	@RequestMapping(value = "/aboutUs.do", method = RequestMethod.GET)
	public String goAboutUs(Model model) {
		return "aboutUs";
	}
	
	@RequestMapping(value = "/termsOfService.do", method = RequestMethod.GET)
	public String goTermsOfService(Model model) {
		return "termsOfService";
	}
	
	@RequestMapping(value = "/personalInformationProcessingPolicy.do", method = RequestMethod.GET)
	public String goPersonalInformationProcessingPolicy(Model model) {
		return "personalInformationProcessingPolicy";
	}
	
	@RequestMapping(value = "/eventMall.do", method = RequestMethod.GET)
	public String goEventMall(Model model) {
		model.addAttribute("eventMallList", productService.getEventMallList());
		return "eventMall";
	}
	
	@RequestMapping(value = "/eventMallDetail.do", method = RequestMethod.GET)
	public String goEventMallDetail(Model model, @RequestParam(value = "productId", required = true) String productId, @SessionAttribute(name = "loginUser", required = false)UserInfoVO userInfoVO) {
		model.addAttribute("loginUser", userInfoVO);
		model.addAttribute("productMaster", productService.getProductMasterById(productId));
		model.addAttribute("productDetail", productService.getProductDetailById(productId));
		return "eventMallDetail";
	}
	
	/*--------------------------------------------------
	 - 견적산출(ESCA = Estimate Calculation)
	*--------------------------------------------------*/
	@RequestMapping(value = "/ESCASelect.do", method = RequestMethod.GET)
	public String goESCASelect(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCASelect");
	}
	
	
	/*--------------------------------------------------
	 - 견적산출
	*--------------------------------------------------*/
	@RequestMapping(value = "/ESCA_00_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_00_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_00_ver_1_0");
	}

	@RequestMapping(value = "/ESCA_01_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_01_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_01_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_02_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_02_ver_1_0(HttpServletRequest request, Model model) {
		List<ProcessResourceTypeCodeInfoVO> processResourceTypeCodeInfoVOList = processResourceService.getProcessResourceTypeCodeInfoByUseYn("Y");
		List<ProcessResourceMasterVO> processResourceMasterVOList = processResourceService.getProcessResourceMasterAllList();
		
		ObjectMapper mapper = new ObjectMapper();
		String processResourceMasterVOListJSON = "";
		String processResourceTypeCodeInfoVOListJSON = "";
		try {
			processResourceTypeCodeInfoVOListJSON = mapper.writeValueAsString(processResourceTypeCodeInfoVOList);
			processResourceMasterVOListJSON = mapper.writeValueAsString(processResourceMasterVOList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("processResourceMasterVOList", processResourceMasterVOListJSON);
		model.addAttribute("processResourceTypeCodeInfoVOList", processResourceTypeCodeInfoVOListJSON);
		
		return userLoginCheck(request, model, "ESCA_02_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_03_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_03_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_03_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_04_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_04_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_04_ver_1_0");
	}

	@RequestMapping(value = "/ESCA_05_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_05_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_05_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_06_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_06_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_06_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_07_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_07_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_07_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_08_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_08_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_08_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_09_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_09_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_09_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_10_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_10_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_10_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_11_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_11_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_11_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_12_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_12_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_12_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_13_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_13_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_13_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_14_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_14_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_14_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_15_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_15_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_15_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_16_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_16_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_16_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_17_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_17_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_17_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_18_ver_1_0.do", method = RequestMethod.GET)
	public String goEstimateCalculationEighteen(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_18_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_19_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_19_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_19_ver_1_0");
	}
	
	@RequestMapping(value = "/ESCA_20_ver_1_0.do", method = RequestMethod.GET)
	public String goESCA_20_ver_1_0(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "ESCA_20_ver_1_0");
	}
	
	@RequestMapping(value = "/estimateCalculationResult.do", method = RequestMethod.GET)
	public String goEstimateCalculationResult(
			HttpServletRequest request
			, Model model
			, @RequestParam(value = "resultString", required = true) String resultString ) {
		
		// 견적산출 로직 호출
		EstimateCalculationResultPrivateMasterVO estimateCalculationResultPrivateMasterVO 
		= productService.estimateCalculation(resultString);
		
		if(!estimateCalculationResultPrivateMasterVO.getErrChk()) {
			EstimateCalculationResultPrivateDetailVO estimateCalculationResultPrivateDetailVO
			= estimateCalculationResultPrivateMasterVO.getSelectProduct();
			
			String productId = estimateCalculationResultPrivateMasterVO.getCreateProductId();
			
			PartsMbHistoryVO partsMbHistoryVO = new PartsMbHistoryVO();
			partsMbHistoryVO.setId(estimateCalculationResultPrivateDetailVO.getMbId());
			partsMbHistoryVO.setHistorySeq(estimateCalculationResultPrivateDetailVO.getMbHistorySeq());
			
			PartsRamHistoryVO partsRamHistoryVO = new PartsRamHistoryVO();
			partsRamHistoryVO.setId(estimateCalculationResultPrivateDetailVO.getRamId());
			partsRamHistoryVO.setHistorySeq(estimateCalculationResultPrivateDetailVO.getRamHistorySeq());
			
			model.addAttribute("productMaster", productService.getProductMasterById(productId));
			model.addAttribute("productDetail", productService.getProductDetailById(productId));
			
			model.addAttribute("productMbDetailInfo", partsService.getPartsMbHistoryVOByIdAndHistorySeq(partsMbHistoryVO));
			model.addAttribute("productRamDetailInfo", partsService.getPartsRamHistoryVOByIdAndHistorySeq(partsRamHistoryVO));
		}else {
			model.addAttribute("productMaster", null);
			model.addAttribute("productDetail", null);
			
			model.addAttribute("productMbDetailInfo", null);
			model.addAttribute("productRamDetailInfo", null);
		}
		

		
		// 과거견적산출은 아래와 같이 각각 부품id, 부품 history_seq로 조회쿼리 돌려서 정보 얻어오면 됨.
//		EstimateCalculationResultPrivateDetailVO 
//			estimateCalculationResultPrivateDetailVO = productService.estimateCalculation(resultString).getSelectProduct();
//		estimateCalculationResultPrivateDetailVO.getGpuId();
//		estimateCalculationResultPrivateDetailVO.getGpuHistorySeq();
		
		
		// 08.17 test
		model.addAttribute("partsRam", partsService.getRamAllList());
		// end
		return userLoginCheck(request, model, "estimateCalculationResult");
	}
	
	/*--------------------------------------------------
	 - private method
	*--------------------------------------------------*/
	private String userLoginCheck(HttpServletRequest request, Model model, String url) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		if(null == user) {
			model.addAttribute("msg", "로그인 후에 견적산출이 가능합니다.");
			model.addAttribute("url", "/user/login.do");
			return "redirect";
		}else {
			return url;
		}
	}
	
}
