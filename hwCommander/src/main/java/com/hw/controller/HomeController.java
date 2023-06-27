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
import org.springframework.web.bind.annotation.SessionAttribute;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hw.model.ProcessResourceMasterVO;
import com.hw.model.ProcessResourceTypeCodeInfoVO;
import com.hw.model.UserInfoVO;
import com.hw.service.ProcessResourceService;
import com.hw.service.ProductService;


@Controller
public class HomeController {
	
	private static final Logger LOGGER = LogManager.getLogger(HomeController.class);
	
	@Autowired
    private ProductService productService;
	
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
	
	@RequestMapping(value = "/estimateCalculationOne.do", method = RequestMethod.GET)
	public String goEstimateCalculationOne(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationOne");
	}
	
	@RequestMapping(value = "/estimateCalculationTwo.do", method = RequestMethod.GET)
	public String goEstimateCalculationTwo(HttpServletRequest request, Model model) {
		
		List<ProcessResourceMasterVO> processResourceMasterVOList = new ArrayList<>();
		
		ProcessResourceMasterVO processResourceMasterVO = new ProcessResourceMasterVO();
		processResourceMasterVO.setId("PR000001");
		processResourceMasterVO.setProcessLgCd("01");
		processResourceMasterVO.setProcessTypeExclusiveCd("PRTEC01");
		processResourceMasterVO.setProcessName("PlayerUnknown's Battlegrounds");
		
		processResourceMasterVOList.add(processResourceMasterVO);
		
		ProcessResourceMasterVO processResourceMasterVO2 = new ProcessResourceMasterVO();
		processResourceMasterVO2.setId("PR000002");
		processResourceMasterVO2.setProcessLgCd("01");
		processResourceMasterVO2.setProcessTypeExclusiveCd("PRTEC01");
		processResourceMasterVO2.setProcessName("Apex Legend");
		
		processResourceMasterVOList.add(processResourceMasterVO2);
		
		ProcessResourceMasterVO processResourceMasterVO3 = new ProcessResourceMasterVO();
		processResourceMasterVO3.setId("PR000003");
		processResourceMasterVO3.setProcessLgCd("01");
		processResourceMasterVO3.setProcessTypeExclusiveCd("PRTEC01");
		processResourceMasterVO3.setProcessName("Valorant");
		
		processResourceMasterVOList.add(processResourceMasterVO3);
		
		ProcessResourceMasterVO processResourceMasterVO4 = new ProcessResourceMasterVO();
		processResourceMasterVO4.setId("PR000004");
		processResourceMasterVO4.setProcessLgCd("01");
		processResourceMasterVO4.setProcessTypeExclusiveCd("PRTEC01");
		processResourceMasterVO4.setProcessName("FPS 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO4);
		
		ProcessResourceMasterVO processResourceMasterVO5 = new ProcessResourceMasterVO();
		processResourceMasterVO5.setId("PR000005");
		processResourceMasterVO5.setProcessLgCd("01");
		processResourceMasterVO5.setProcessTypeExclusiveCd("PRTEC02");
		processResourceMasterVO5.setProcessName("League of Legends");
		
		processResourceMasterVOList.add(processResourceMasterVO5);
		
		ProcessResourceMasterVO processResourceMasterVO6 = new ProcessResourceMasterVO();
		processResourceMasterVO6.setId("PR000006");
		processResourceMasterVO6.setProcessLgCd("01");
		processResourceMasterVO6.setProcessTypeExclusiveCd("PRTEC02");
		processResourceMasterVO6.setProcessName("Dota 2");
		
		processResourceMasterVOList.add(processResourceMasterVO6);
		
		ProcessResourceMasterVO processResourceMasterVO7 = new ProcessResourceMasterVO();
		processResourceMasterVO7.setId("PR000007");
		processResourceMasterVO7.setProcessLgCd("01");
		processResourceMasterVO7.setProcessTypeExclusiveCd("PRTEC02");
		processResourceMasterVO7.setProcessName("Heros of the Storm");
		
		processResourceMasterVOList.add(processResourceMasterVO7);
		
		ProcessResourceMasterVO processResourceMasterVO8 = new ProcessResourceMasterVO();
		processResourceMasterVO8.setId("PR000008");
		processResourceMasterVO8.setProcessLgCd("01");
		processResourceMasterVO8.setProcessTypeExclusiveCd("PRTEC02");
		processResourceMasterVO8.setProcessName("AOS 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO8);
		
		ProcessResourceMasterVO processResourceMasterVO9 = new ProcessResourceMasterVO();
		processResourceMasterVO9.setId("PR000009");
		processResourceMasterVO9.setProcessLgCd("01");
		processResourceMasterVO9.setProcessTypeExclusiveCd("PRTEC03");
		processResourceMasterVO9.setProcessName("Lost Ark");
		
		processResourceMasterVOList.add(processResourceMasterVO9);
		
		ProcessResourceMasterVO processResourceMasterVO10 = new ProcessResourceMasterVO();
		processResourceMasterVO10.setId("PR000010");
		processResourceMasterVO10.setProcessLgCd("01");
		processResourceMasterVO10.setProcessTypeExclusiveCd("PRTEC03");
		processResourceMasterVO10.setProcessName("디아블로");
		
		processResourceMasterVOList.add(processResourceMasterVO10);
		
		ProcessResourceMasterVO processResourceMasterVO11 = new ProcessResourceMasterVO();
		processResourceMasterVO11.setId("PR000011");
		processResourceMasterVO11.setProcessLgCd("01");
		processResourceMasterVO11.setProcessTypeExclusiveCd("PRTEC03");
		processResourceMasterVO11.setProcessName("던파");
		
		processResourceMasterVOList.add(processResourceMasterVO11);
		
		ProcessResourceMasterVO processResourceMasterVO12 = new ProcessResourceMasterVO();
		processResourceMasterVO12.setId("PR000012");
		processResourceMasterVO12.setProcessLgCd("01");
		processResourceMasterVO12.setProcessTypeExclusiveCd("PRTEC03");
		processResourceMasterVO12.setProcessName("RPG 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO12);
		
		ProcessResourceMasterVO processResourceMasterVO13 = new ProcessResourceMasterVO();
		processResourceMasterVO13.setId("PR000013");
		processResourceMasterVO13.setProcessLgCd("01");
		processResourceMasterVO13.setProcessTypeExclusiveCd("PRTEC04");
		processResourceMasterVO13.setProcessName("피파");
		
		processResourceMasterVOList.add(processResourceMasterVO13);
		
		ProcessResourceMasterVO processResourceMasterVO14 = new ProcessResourceMasterVO();
		processResourceMasterVO14.setId("PR000014");
		processResourceMasterVO14.setProcessLgCd("01");
		processResourceMasterVO14.setProcessTypeExclusiveCd("PRTEC04");
		processResourceMasterVO14.setProcessName("스타");
		
		processResourceMasterVOList.add(processResourceMasterVO14);
		
		ProcessResourceMasterVO processResourceMasterVO15 = new ProcessResourceMasterVO();
		processResourceMasterVO15.setId("PR000015");
		processResourceMasterVO15.setProcessLgCd("01");
		processResourceMasterVO15.setProcessTypeExclusiveCd("PRTEC04");
		processResourceMasterVO15.setProcessName("워크");
		
		processResourceMasterVOList.add(processResourceMasterVO15);
		
		ProcessResourceMasterVO processResourceMasterVO16 = new ProcessResourceMasterVO();
		processResourceMasterVO16.setId("PR000016");
		processResourceMasterVO16.setProcessLgCd("01");
		processResourceMasterVO16.setProcessTypeExclusiveCd("PRTEC04");
		processResourceMasterVO16.setProcessName("RTS 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO16);
		
		ProcessResourceMasterVO processResourceMasterVO17 = new ProcessResourceMasterVO();
		processResourceMasterVO17.setId("PR000017");
		processResourceMasterVO17.setProcessLgCd("01");
		processResourceMasterVO17.setProcessTypeExclusiveCd("PRTEC05");
		processResourceMasterVO17.setProcessName("레이싱1");
		
		processResourceMasterVOList.add(processResourceMasterVO17);
		
		
		ProcessResourceMasterVO processResourceMasterVO18 = new ProcessResourceMasterVO();
		processResourceMasterVO18.setId("PR000018");
		processResourceMasterVO18.setProcessLgCd("01");
		processResourceMasterVO18.setProcessTypeExclusiveCd("PRTEC05");
		processResourceMasterVO18.setProcessName("레이싱2");
		
		processResourceMasterVOList.add(processResourceMasterVO18);
		
		
		ProcessResourceMasterVO processResourceMasterVO19 = new ProcessResourceMasterVO();
		processResourceMasterVO19.setId("PR000019");
		processResourceMasterVO19.setProcessLgCd("01");
		processResourceMasterVO19.setProcessTypeExclusiveCd("PRTEC05");
		processResourceMasterVO19.setProcessName("레이싱3");
		
		processResourceMasterVOList.add(processResourceMasterVO19);
		
		
		ProcessResourceMasterVO processResourceMasterVO20 = new ProcessResourceMasterVO();
		processResourceMasterVO20.setId("PR000020");
		processResourceMasterVO20.setProcessLgCd("01");
		processResourceMasterVO20.setProcessTypeExclusiveCd("PRTEC05");
		processResourceMasterVO20.setProcessName("레이싱 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO20);
		
		
		
		ProcessResourceMasterVO processResourceMasterVO21 = new ProcessResourceMasterVO();
		processResourceMasterVO21.setId("PR000021");
		processResourceMasterVO21.setProcessLgCd("02");
		processResourceMasterVO21.setProcessTypeExclusiveCd("PRTEC06");
		processResourceMasterVO21.setProcessName("2d그래픽1");
		
		processResourceMasterVOList.add(processResourceMasterVO21);
		
		ProcessResourceMasterVO processResourceMasterVO22 = new ProcessResourceMasterVO();
		processResourceMasterVO22.setId("PR000022");
		processResourceMasterVO22.setProcessLgCd("02");
		processResourceMasterVO22.setProcessTypeExclusiveCd("PRTEC06");
		processResourceMasterVO22.setProcessName("2d그래픽2");
		
		processResourceMasterVOList.add(processResourceMasterVO22);
		
		
		ProcessResourceMasterVO processResourceMasterVO23 = new ProcessResourceMasterVO();
		processResourceMasterVO23.setId("PR000023");
		processResourceMasterVO23.setProcessLgCd("02");
		processResourceMasterVO23.setProcessTypeExclusiveCd("PRTEC06");
		processResourceMasterVO23.setProcessName("2d그래픽3");
		
		processResourceMasterVOList.add(processResourceMasterVO23);
		
		ProcessResourceMasterVO processResourceMasterVO24 = new ProcessResourceMasterVO();
		processResourceMasterVO24.setId("PR000024");
		processResourceMasterVO24.setProcessLgCd("02");
		processResourceMasterVO24.setProcessTypeExclusiveCd("PRTEC06");
		processResourceMasterVO24.setProcessName("2d그래픽 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO24);
		
		ProcessResourceMasterVO processResourceMasterVO25 = new ProcessResourceMasterVO();
		processResourceMasterVO25.setId("PR000025");
		processResourceMasterVO25.setProcessLgCd("02");
		processResourceMasterVO25.setProcessTypeExclusiveCd("PRTEC07");
		processResourceMasterVO25.setProcessName("3d그래픽1");
		
		processResourceMasterVOList.add(processResourceMasterVO25);
		
		ProcessResourceMasterVO processResourceMasterVO26 = new ProcessResourceMasterVO();
		processResourceMasterVO26.setId("PR000026");
		processResourceMasterVO26.setProcessLgCd("02");
		processResourceMasterVO26.setProcessTypeExclusiveCd("PRTEC07");
		processResourceMasterVO26.setProcessName("3d그래픽2");
		
		processResourceMasterVOList.add(processResourceMasterVO26);
		
		ProcessResourceMasterVO processResourceMasterVO27 = new ProcessResourceMasterVO();
		processResourceMasterVO27.setId("PR000027");
		processResourceMasterVO27.setProcessLgCd("02");
		processResourceMasterVO27.setProcessTypeExclusiveCd("PRTEC07");
		processResourceMasterVO27.setProcessName("3d그래픽3");
		
		processResourceMasterVOList.add(processResourceMasterVO27);
		
		ProcessResourceMasterVO processResourceMasterVO28 = new ProcessResourceMasterVO();
		processResourceMasterVO28.setId("PR000028");
		processResourceMasterVO28.setProcessLgCd("02");
		processResourceMasterVO28.setProcessTypeExclusiveCd("PRTEC07");
		processResourceMasterVO28.setProcessName("3d그래픽 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO28);
		
		ProcessResourceMasterVO processResourceMasterVO29 = new ProcessResourceMasterVO();
		processResourceMasterVO29.setId("PR000029");
		processResourceMasterVO29.setProcessLgCd("02");
		processResourceMasterVO29.setProcessTypeExclusiveCd("PRTEC08");
		processResourceMasterVO29.setProcessName("코딩1");
		
		processResourceMasterVOList.add(processResourceMasterVO29);
		
		
		ProcessResourceMasterVO processResourceMasterVO30 = new ProcessResourceMasterVO();
		processResourceMasterVO30.setId("PR000030");
		processResourceMasterVO30.setProcessLgCd("02");
		processResourceMasterVO30.setProcessTypeExclusiveCd("PRTEC08");
		processResourceMasterVO30.setProcessName("코딩2");
		
		processResourceMasterVOList.add(processResourceMasterVO30);
		
		
		ProcessResourceMasterVO processResourceMasterVO31 = new ProcessResourceMasterVO();
		processResourceMasterVO31.setId("PR000031");
		processResourceMasterVO31.setProcessLgCd("02");
		processResourceMasterVO31.setProcessTypeExclusiveCd("PRTEC08");
		processResourceMasterVO31.setProcessName("코딩3");
		
		processResourceMasterVOList.add(processResourceMasterVO31);
		
		
		ProcessResourceMasterVO processResourceMasterVO32 = new ProcessResourceMasterVO();
		processResourceMasterVO32.setId("PR000032");
		processResourceMasterVO32.setProcessLgCd("02");
		processResourceMasterVO32.setProcessTypeExclusiveCd("PRTEC08");
		processResourceMasterVO32.setProcessName("코딩기타");
		
		processResourceMasterVOList.add(processResourceMasterVO32);
		
		ProcessResourceMasterVO processResourceMasterVO33 = new ProcessResourceMasterVO();
		processResourceMasterVO33.setId("PR000033");
		processResourceMasterVO33.setProcessLgCd("02");
		processResourceMasterVO33.setProcessTypeExclusiveCd("PRTEC09");
		processResourceMasterVO33.setProcessName("영상편집1");
		
		processResourceMasterVOList.add(processResourceMasterVO33);
		
		
		ProcessResourceMasterVO processResourceMasterVO34 = new ProcessResourceMasterVO();
		processResourceMasterVO34.setId("PR000034");
		processResourceMasterVO34.setProcessLgCd("02");
		processResourceMasterVO34.setProcessTypeExclusiveCd("PRTEC09");
		processResourceMasterVO34.setProcessName("영상편집2");
		
		processResourceMasterVOList.add(processResourceMasterVO34);
		
		
		ProcessResourceMasterVO processResourceMasterVO35 = new ProcessResourceMasterVO();
		processResourceMasterVO35.setId("PR000035");
		processResourceMasterVO35.setProcessLgCd("02");
		processResourceMasterVO35.setProcessTypeExclusiveCd("PRTEC09");
		processResourceMasterVO35.setProcessName("영상편집3");
		
		processResourceMasterVOList.add(processResourceMasterVO35);
		
		
		ProcessResourceMasterVO processResourceMasterVO36 = new ProcessResourceMasterVO();
		processResourceMasterVO36.setId("PR000036");
		processResourceMasterVO36.setProcessLgCd("02");
		processResourceMasterVO36.setProcessTypeExclusiveCd("PRTEC09");
		processResourceMasterVO36.setProcessName("영상편집 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO36);
		
		ProcessResourceMasterVO processResourceMasterVO37 = new ProcessResourceMasterVO();
		processResourceMasterVO37.setId("PR000037");
		processResourceMasterVO37.setProcessLgCd("02");
		processResourceMasterVO37.setProcessTypeExclusiveCd("PRTEC10");
		processResourceMasterVO37.setProcessName("문서작업1");
		
		processResourceMasterVOList.add(processResourceMasterVO37);
		
		
		ProcessResourceMasterVO processResourceMasterVO38 = new ProcessResourceMasterVO();
		processResourceMasterVO38.setId("PR000038");
		processResourceMasterVO38.setProcessLgCd("02");
		processResourceMasterVO38.setProcessTypeExclusiveCd("PRTEC10");
		processResourceMasterVO38.setProcessName("문서작업2");
		
		processResourceMasterVOList.add(processResourceMasterVO38);
		
		
		ProcessResourceMasterVO processResourceMasterVO39 = new ProcessResourceMasterVO();
		processResourceMasterVO39.setId("PR000039");
		processResourceMasterVO39.setProcessLgCd("02");
		processResourceMasterVO39.setProcessTypeExclusiveCd("PRTEC10");
		processResourceMasterVO39.setProcessName("문서작업3");
		
		processResourceMasterVOList.add(processResourceMasterVO39);
		
		
		ProcessResourceMasterVO processResourceMasterVO40 = new ProcessResourceMasterVO();
		processResourceMasterVO40.setId("PR000040");
		processResourceMasterVO40.setProcessLgCd("02");
		processResourceMasterVO40.setProcessTypeExclusiveCd("PRTEC10");
		processResourceMasterVO40.setProcessName("문서작업 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO40);
		
		
		ProcessResourceMasterVO processResourceMasterVO41 = new ProcessResourceMasterVO();
		processResourceMasterVO41.setId("PR000041");
		processResourceMasterVO41.setProcessLgCd("03");
		processResourceMasterVO41.setProcessTypeExclusiveCd("PRTEC10");
		processResourceMasterVO41.setProcessName("문서작업 기타");
		
		processResourceMasterVOList.add(processResourceMasterVO41);
		
		ObjectMapper mapper = new ObjectMapper();
		String tempJson = "";
		try {
			tempJson = mapper.writeValueAsString(processResourceMasterVOList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		String tempInfoJson = "";
		try {
			tempInfoJson = mapper.writeValueAsString(processResourceTypeCodeInfoVOList);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("processResourceMasterVOList", tempJson);
		
		List<ProcessResourceTypeCodeInfoVO> processResourceTypeCodeInfoVOList = processResourceService.getProcessResourceTypeCodeInfoAllList();
		model.addAttribute("processResourceTypeCodeInfoVOList", processResourceTypeCodeInfoVOList);
		
		
		
		return userLoginCheck(request, model, "estimateCalculationTwo");
	}
	
	@RequestMapping(value = "/estimateCalculationThree.do", method = RequestMethod.GET)
	public String goEstimateCalculationThree(HttpServletRequest request, Model model) {
		return userLoginCheck(request, model, "estimateCalculationThree");
	}
	
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
