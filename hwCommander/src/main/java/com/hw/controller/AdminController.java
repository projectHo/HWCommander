package com.hw.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hw.model.PartsGpuVO;
import com.hw.service.AdminService;
import com.hw.service.PartsService;

@Controller
@RequestMapping(value="/admin")
public class AdminController {
	
	private static final Logger LOGGER = LogManager.getLogger(AdminController.class);
	
	@Autowired
    private AdminService adminService;
	
	@Autowired
    private PartsService partsService;
	
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
		return "cpuManagement";
	}
	
	@RequestMapping(value = "/mbManagement.do", method = RequestMethod.GET)
	public String goMbManagement(Model model) {
		return "mbManagement";
	}
	
	@RequestMapping(value = "/ramManagement.do", method = RequestMethod.GET)
	public String goRamManagement(Model model) {
		return "ramManagement";
	}
	
	@RequestMapping(value = "/psuManagement.do", method = RequestMethod.GET)
	public String goPsuManagement(Model model) {
		return "psuManagement";
	}

	@RequestMapping(value = "/caseManagement.do", method = RequestMethod.GET)
	public String goCaseManagement(Model model) {
		return "caseManagement";
	}
	
	@RequestMapping(value = "/coolerManagement.do", method = RequestMethod.GET)
	public String goCoolerManagement(Model model) {
		return "coolerManagement";
	}
	
	@RequestMapping(value = "/hddManagement.do", method = RequestMethod.GET)
	public String goHddManagement(Model model) {
		return "hddManagement";
	}
	
	@RequestMapping(value = "/ssdManagement.do", method = RequestMethod.GET)
	public String goSsdManagement(Model model) {
		return "ssdManagement";
	}
	
	@RequestMapping(value = "/sfManagement.do", method = RequestMethod.GET)
	public String goSfManagement(Model model) {
		return "sfManagement";
	}
}
