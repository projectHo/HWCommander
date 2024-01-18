package com.hw.controller;


import java.net.URI;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.Mac;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.json.JSONException;
import org.json.JSONObject;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hw.model.OrderMasterVO;
import com.hw.model.RefundInfoVO;
import com.hw.model.UserEscasStorageVO;
import com.hw.model.UserInfoVO;
import com.hw.service.OrderService;
import com.hw.service.UserService;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLDecoder;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


@Controller
@RequestMapping(value="/user")
public class UserController {
	
	private static final Logger LOGGER = LogManager.getLogger(UserController.class);
	
	@Autowired
    private UserService userService;
	
	@Autowired
    private OrderService orderService;
	
	/*--------------------------------------------------
	 - 회원가입 및 로그인
	*--------------------------------------------------*/
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String goLogin(Model model) {
		return "login";
	}

	@RequestMapping(value = "/loginLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public UserInfoVO loginLogic(HttpServletRequest request, UserInfoVO userInfoVO) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO resultVO = userService.getUserInfoByIdAndPw(userInfoVO);
		if(resultVO.getMailConfirm().equals("Y")) {
			httpSession.setAttribute("loginUser", resultVO);
		}else {
			httpSession.removeAttribute("loginUser"); 
			httpSession.invalidate(); // 세션 전체 제거, 무효화 
		}
		System.out.println("===========================");
		System.out.println("===========================");
		System.out.println("id : "+userInfoVO.getId());
		System.out.println("pw : "+userInfoVO.getPw());
		System.out.println("===========================");
		System.out.println("===========================");
		
		return resultVO;
	}
	
	@RequestMapping(value = "/signUp.do", method = RequestMethod.GET)
	public String goSignUp(Model model, HttpServletRequest request) {
		HashMap<String, String> niceMap = niceHpNumberAuthentication();
		request.setAttribute("enc_data", niceMap.get("enc_data"));
		request.setAttribute("integrity_value", niceMap.get("integrity_value"));
		request.setAttribute("token_version_id", niceMap.get("token_version_id"));
		
		HttpSession httpSession = request.getSession();
		httpSession.removeAttribute("iv");
		httpSession.removeAttribute("key");
		httpSession.setAttribute("iv", niceMap.get("iv"));
		httpSession.setAttribute("key", niceMap.get("key"));
		
		return "signUp";
	}
	
	@RequestMapping(value = "/idDupliChk.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer idDupliChk(String id) {
		return userService.getIdDupliChkCount(id);
	}
	
	@RequestMapping(value = "/signUpLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer signUpLogic(UserInfoVO userInfoVO) {
		return userService.signUpLogic(userInfoVO);
	}
	
	@RequestMapping(value = "/mailConfirmLogic.do", method = RequestMethod.GET)
	public String mailConfirmLogic(UserInfoVO userInfoVO, Model model) {
		int result = userService.mailConfirmLogic(userInfoVO);
		model.addAttribute("result", result);
		return "mailConfirmPage";
	}
	
	// 아직 사용안함 인증메일 key값 재발급할때 쓸것.
	@RequestMapping(value = "/updateMailKey.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer updateMailKey(UserInfoVO userInfoVO) {
		return userService.updateMailKey(userInfoVO);
	}
	
	@RequestMapping(value = "/logoutLogic.do", method = RequestMethod.GET)
	public String logoutLogic(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession(false);
		if(httpSession != null) {
			httpSession.removeAttribute("loginUser"); 
			httpSession.invalidate(); 
		}
		model.addAttribute("loginUser", null);
		return "redirect:/";
	}
	
	/*--------------------------------------------------
	 - 회원탈퇴로직
	*--------------------------------------------------*/
	@RequestMapping(value = "/tempDeleteAccountLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer tempDeleteAccountLogic(UserInfoVO userInfoVO) {
		return userService.tempDeleteAccountLogic(userInfoVO);
	}
	
	/*--------------------------------------------------
	 - 회원정보수정페이지
	*--------------------------------------------------*/
	@RequestMapping(value = "/infoUpdate.do", method = RequestMethod.GET)
	public String goInfoUpdate(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		model.addAttribute("loginUser", user);
		
		return userLoginCheck(request, model, "userInfoUpdate");
	}
	@RequestMapping(value = "/userMailInfoUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer userMailInfoUpdateLogic(UserInfoVO userInfoVO) {
		return userService.userMailInfoUpdateLogic(userInfoVO);
	}
	
	/*--------------------------------------------------
	 - 회원정보수정로직
	*--------------------------------------------------*/
	@RequestMapping(value = "/userInfoUpdateLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer userInfoUpdateLogic(UserInfoVO userInfoVO) {
		return userService.userInfoUpdateLogic(userInfoVO);
	}
	
	/*--------------------------------------------------
	 - 주문내역
	*--------------------------------------------------*/
	@RequestMapping(value = "/orderList.do", method = RequestMethod.GET)
	public String goOrderList(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		List<OrderMasterVO> orderMasterVOList = orderService.getOrderMasterListByOrdererUserId(user.getId());
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVOList", orderMasterVOList);
		
		return userLoginCheck(request, model, "userOrderList");
	}
	
	@RequestMapping(value = "/orderListDetail.do", method = RequestMethod.GET)
	public String goOrderListDetail(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVO", orderService.getOrderMasterById(id));
		model.addAttribute("orderDetailVOList", orderService.getOrderDetailListById(id));
		
		return userLoginCheck(request, model, "userOrderListDetail");
	}
	
	@RequestMapping(value = "/orderVideoRequestToAdminLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderVideoRequestToAdminLogic(String id) {
		OrderMasterVO orderMasterVO = new OrderMasterVO();
		orderMasterVO.setId(id);
		orderMasterVO.setVideoRequestCd("02");
		return orderService.updateVideoRequestCd(orderMasterVO);
	}
	
	@RequestMapping(value = "/orderUpdateRecipientHpNumber2Logic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderUpdateRecipientHpNumber2Logic(OrderMasterVO orderMasterVO) {
		return orderService.updateRecipientHpNumber2(orderMasterVO);
	}
	
	@RequestMapping(value = "/orderUpdateAddrsLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderUpdateAddrsLogic(OrderMasterVO orderMasterVO) {
		return orderService.updateAddrs(orderMasterVO);
	}
	
	@RequestMapping(value = "/orderUpdateOrderRequest.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderUpdateOrderRequest(OrderMasterVO orderMasterVO) {
		return orderService.updateOrderRequest(orderMasterVO);
	}
	
	@RequestMapping(value = "/orderUpdateDeliveryRequest.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer orderUpdateDeliveryRequest(OrderMasterVO orderMasterVO) {
		return orderService.updateDeliveryRequest(orderMasterVO);
	}
	
	/*--------------------------------------------------
	 - 주문진행현황
	*--------------------------------------------------*/
	@RequestMapping(value = "/orderProgressStatus.do", method = RequestMethod.GET)
	public String goOrderProgressStatus(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVO", orderService.getOrderMasterById(id));
		model.addAttribute("orderDetailVOList", orderService.getOrderDetailListById(id));
		
		return userLoginCheck(request, model, "userOrderProgressStatus");
	}
	
	/*--------------------------------------------------
	 - 영수증페이지
	*--------------------------------------------------*/
	@RequestMapping(value = "/userReceipt.do", method = RequestMethod.GET)
	public String goUserReceipt(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		model.addAttribute("loginUser", user);
		model.addAttribute("orderMasterVO", orderService.getOrderMasterById(id));
		model.addAttribute("orderDetailVOList", orderService.getOrderDetailListById(id));
		
		return userLoginCheck(request, model, "userReceipt");
	}

	/*--------------------------------------------------
	 - 마이페이지
	*--------------------------------------------------*/
	@RequestMapping(value = "/myPage.do", method = RequestMethod.GET)
	public String goMyPage(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		if( null != user ){
			List<OrderMasterVO> orderMasterVOList = orderService.getOrderMasterListByOrdererUserId(user.getId());
			List<RefundInfoVO> refundInfoVOList = orderService.getRefundInfoByUserId(user.getId());
			
			model.addAttribute("loginUser", user);
			model.addAttribute("orderMasterVOList", orderMasterVOList);
			model.addAttribute("refundInfoVOList", refundInfoVOList);

			return userLoginCheck(request, model, "myPage");
		}else {
			return userLoginCheck(request, model, "myPage");
		}
	}
	
	@RequestMapping(value = "/idAndPwCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public Boolean idAndPwCheck(HttpServletRequest request, UserInfoVO userInfoVO) {
		boolean loginCheck = false;
		
		UserInfoVO resultVO = userService.getUserInfoByIdAndPw(userInfoVO);
		
		if(null != resultVO.getId()) {
			loginCheck = true;
		}
		
		return loginCheck;
	}
	@RequestMapping(value = "/orderStateM.do", method = RequestMethod.GET)
	public String goOrderStateM(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		if( null != user ){
			List<OrderMasterVO> orderMasterVOList = orderService.getOrderMasterListByOrdererUserId(user.getId());
			
			model.addAttribute("loginUser", user);
			model.addAttribute("orderMasterVOList", orderMasterVOList);

			return userLoginCheck(request, model, "userOrderStateM");
		}else {
			return userLoginCheck(request, model, "userOrderStateM");
		}
	}
	@RequestMapping(value = "/refundStateM.do", method = RequestMethod.GET)
	public String goRefundStateM(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		if( null != user ){
			List<RefundInfoVO> refundInfoVOList = orderService.getRefundInfoByUserId(user.getId());
			List<OrderMasterVO> orderMasterVOList = orderService.getOrderMasterListByOrdererUserId(user.getId());
			
			model.addAttribute("loginUser", user);
			
			model.addAttribute("orderMasterVOList", orderMasterVOList);
			model.addAttribute("refundInfoVOList", refundInfoVOList);


			return userLoginCheck(request, model, "userRefundStateM");
		}else {
			return userLoginCheck(request, model, "userRefundStateM");
		}
	}
	@RequestMapping(value = "/infoM.do", method = RequestMethod.GET)
	public String goInfoM(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		if( null != user ){
			List<OrderMasterVO> orderMasterVOList = orderService.getOrderMasterListByOrdererUserId(user.getId());
			
			model.addAttribute("loginUser", user);
			model.addAttribute("orderMasterVOList", orderMasterVOList);

			return userLoginCheck(request, model, "userInfoM");
		}else {
			return userLoginCheck(request, model, "userInfoM");
		}
	}
	@RequestMapping(value = "/seccessionM.do", method = RequestMethod.GET)
	public String goSeccessionM(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		if( null != user ){

			model.addAttribute("loginUser", user);

			return userLoginCheck(request, model, "userSeccessionM");
		}else {
			return userLoginCheck(request, model, "userSeccessionM");
		}
	}
//	23.11.05 refund_info 로직이 구현완료됨으로써 기존 order_master에 orderStateCd 직접변경 하던 로직 폐기 
//	@RequestMapping(value = "/orderRefundRequestToAdminLogic.do", method = RequestMethod.POST)
//	@ResponseBody
//	public Integer orderRefundRequestToAdminLogic(String id) {
//		OrderMasterVO orderMasterVO = new OrderMasterVO();
//		orderMasterVO.setId(id);
//		orderMasterVO.setOrderStateCd("09");
//		return orderService.updateOrderStateCd(orderMasterVO);
//	}
	
	@RequestMapping(value = "/refundInfoRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer refundInfoRegistLogic(
			@RequestParam(value = "refundInfoVO", required = true) String refundInfoVOString
			, @RequestParam(value = "orderStateCd", required = true) String orderStateCd) throws JsonMappingException, JsonProcessingException {
		
		RefundInfoVO refundInfoVO = new RefundInfoVO();
		ObjectMapper objectMapper = new ObjectMapper();
		
		refundInfoVO = objectMapper.readValue(refundInfoVOString, RefundInfoVO.class);
		
		return orderService.refundInfoRegistLogic(refundInfoVO, orderStateCd);
	}
	
	/*--------------------------------------------------
	 - 환불내역
	*--------------------------------------------------*/
	@RequestMapping(value = "/refundInfoList.do", method = RequestMethod.GET)
	public String goRefundInfoList(HttpServletRequest request, Model model) {
		
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		List<RefundInfoVO> refundInfoVOList = orderService.getRefundInfoByUserId(user.getId());
		
		model.addAttribute("loginUser", user);
		model.addAttribute("refundInfoVOList", refundInfoVOList);
		
		return userLoginCheck(request, model, "userRefundInfoList");
	}
	
	/*--------------------------------------------------
	 - 환불정보
	*--------------------------------------------------*/
	@RequestMapping(value = "/refundInfo.do", method = RequestMethod.GET)
	public String goRefundInfo(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		RefundInfoVO refundInfoVO = orderService.getRefundInfoById(id);
		OrderMasterVO orderMasterVO = orderService.getOrderMasterById(refundInfoVO.getOrderId());
		
		model.addAttribute("loginUser", user);
		model.addAttribute("refundInfoVO", refundInfoVO);
		model.addAttribute("orderMasterVO", orderMasterVO);
		
		return userLoginCheck(request, model, "userRefundInfo");
	}
	
	@RequestMapping(value = "/refundDeleteLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer refundDeleteLogic(
			@RequestParam(value = "id", required = true) String id
			, @RequestParam(value = "orderId", required = true) String orderId) {
		return orderService.refundInfoDeleteLogic(id, orderId);
	}
	
	@RequestMapping(value = "/updateRefundReasonCdAndUserWrite.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer updateRefundReasonCdAndUserWrite(RefundInfoVO refundInfoVO) {
		return orderService.updateRefundReasonCdAndUserWrite(refundInfoVO);
	}
	
	@RequestMapping(value = "/updateRefundPartialAgreeCd.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer updateRefundPartialAgreeCd(RefundInfoVO refundInfoVO) {
		return orderService.updateRefundPartialAgreeCd(refundInfoVO);
	}

	/*--------------------------------------------------
	 - 견적 저장소
	*--------------------------------------------------*/
	@RequestMapping(value = "/estimateStorage.do", method = RequestMethod.GET)
	public String goEstimateStorage(HttpServletRequest request
			, Model model
			, @RequestParam(value = "id", required = true) String id) {
		
		HttpSession httpSession = request.getSession();
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		// 23.10.30 user_escas_storage 조회리스트 추가
		List<UserEscasStorageVO> userEscasStorageVOList = userService.getUserEscasStorageVOByUserId(id);
		model.addAttribute("userEscasStorageVOList", userEscasStorageVOList);

		model.addAttribute("loginUser", user);

		return userLoginCheck(request, model, "estimateStorage");
	}
	
	// 23.10.30 user_escas_storage insert를 위함
	@RequestMapping(value = "/escaStorageRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer escaStorageRegistLogic(UserEscasStorageVO userEscasStorageVO) {
		return userService.userEscasStorageRegistLogic(userEscasStorageVO);
	}
	
	// 23.10.30 user_escas_storage 50개(max) 넘었을 때 밀어내기 등록을 위함
	@RequestMapping(value = "/escaStorageMaxRegistLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer escaStorageMaxRegistLogic(UserEscasStorageVO userEscasStorageVO) {
		return userService.userEscasStorageMaxRegistLogic(userEscasStorageVO);
	}
	
	// 23.10.30 user_escas_storage delete를 위함
	@RequestMapping(value = "/escaStorageDeleteLogic.do", method = RequestMethod.POST)
	@ResponseBody
	public Integer escaStorageDeleteLogic(UserEscasStorageVO userEscasStorageVO) {
		return userService.userEscasStorageDeleteLogic(userEscasStorageVO);
	}
	
	/*--------------------------------------------------
	 - private method
	*--------------------------------------------------*/
	private String userLoginCheck(HttpServletRequest request, Model model, String url) {
		HttpSession httpSession = request.getSession();
		
		UserInfoVO user = (UserInfoVO) httpSession.getAttribute("loginUser");
		
		if(null == user) {
			model.addAttribute("msg", "로그인 후에 이용 가능합니다.");
			model.addAttribute("url", "/user/login.do");
			return "redirect";
		}else {
			return url;
		}
	}
	
	/*--------------------------------------------------
	 - NICE API 응답 URL
	*--------------------------------------------------*/
	@RequestMapping(value = "/niceHpNumberAuthenticationResult.do", method = RequestMethod.GET)
	public String niceHpNumberAuthenticationResult(
			HttpServletRequest request
			, Model model
			, @RequestParam(value = "token_version_id", required = true) String token_version_id
			, @RequestParam(value = "enc_data", required = true) String enc_data
			, @RequestParam(value = "integrity_value", required = true) String integrity_value
			) {
		
		HttpSession httpSession = request.getSession();
		
		String key = (String) httpSession.getAttribute("key");
		String iv = (String) httpSession.getAttribute("iv");
		
		SecretKey secureKey = new SecretKeySpec(key.getBytes(), "AES");
		byte[] result = null;
		
		try {
			Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
			c.init(Cipher.DECRYPT_MODE, secureKey, new IvParameterSpec(iv.getBytes()));
			byte[] decoedBytes = Base64.getDecoder().decode(enc_data.getBytes());
			result = c.doFinal(decoedBytes);
		} catch (NoSuchAlgorithmException | NoSuchPaddingException | InvalidKeyException | InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String resData =   new String(result);
		JSONObject jsonObject = new JSONObject(resData);
		
		String decodeResultName = "";
		
		try {
			decodeResultName = URLDecoder.decode((String) jsonObject.get("utf8_name"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		model.addAttribute("resultcode", jsonObject.get("resultcode"));
//		model.addAttribute("name", jsonObject.get("name"));
		model.addAttribute("name", decodeResultName);
		model.addAttribute("gender", jsonObject.get("gender"));
		model.addAttribute("mobileno", jsonObject.get("mobileno"));
		model.addAttribute("birthdate", jsonObject.get("birthdate"));
		model.addAttribute("di", jsonObject.get("di"));
		
		return "niceHpNumberAuthenticationResult";
	}
	
	/*--------------------------------------------------
	 - NICE API 호출
	*--------------------------------------------------*/
	private HashMap<String, String> niceHpNumberAuthentication() {
		HashMap<String, String> resultMap = new HashMap<>();
		String accessToken = "";
		String cryptoToken = "";
		String clientId = "250a3e1c-4c5c-4637-8725-e8a69e76a23c";
		String clientSecret = "295e72732ccb9749c64d0674b3107aa4";
		String clientIdAndSecret = clientId+":"+clientSecret;
		String cryptoTokenProductCode = "2101979031";
		URI accessTokenUrl = URI.create("https://svc.niceapi.co.kr:22001/digital/niceid/oauth/oauth/token");
		URI cryptoTokenUrl = URI.create("https://svc.niceapi.co.kr:22001/digital/niceid/api/v1.0/common/crypto/token");
		Encoder encoder = Base64.getEncoder();
		
		/*--------------------------------------------------
		 - 접근토큰발급 처리부
		*--------------------------------------------------*/
		RestTemplate accessTokenRestTemplate = new RestTemplate();
		HttpHeaders accessTokenHeaders = new HttpHeaders();
		accessTokenHeaders.add("Accept", "*/*");
		accessTokenHeaders.add("Content-Type", "application/x-www-form-urlencoded");
		accessTokenHeaders.add("Authorization", "Basic "+new String(encoder.encode(clientIdAndSecret.getBytes())));
		
		MultiValueMap<String, String> accessTokenParams = new LinkedMultiValueMap<>();
		accessTokenParams.add("grant_type", "client_credentials");
		accessTokenParams.add("scope", "default");
		
		HttpEntity<MultiValueMap<String, String>> accessTokenRequestEntity = new HttpEntity<>(accessTokenParams, accessTokenHeaders);
		
		ResponseEntity<String> accessTokenResponse = accessTokenRestTemplate.exchange(accessTokenUrl, HttpMethod.POST, accessTokenRequestEntity, String.class);
		
		JSONObject jsonObject = new JSONObject(accessTokenResponse.getBody());
		JSONObject accessTokenDataHeader = jsonObject.getJSONObject("dataHeader");
		JSONObject accessTokenDataBody = jsonObject.getJSONObject("dataBody");
		
		// nice api 결과코드
		String GW_RSLT_CD = (String) accessTokenDataHeader.get("GW_RSLT_CD");
		
//		1200	오류 없음 (정상)	No Error
//		1300	request body가 비었습니다.	Request Body is Null
//		1400	잘못된 요청	bad Request
//		1401	인증 필요	authorized required
//		1402	권한없음	unAuthorized
//		1403	서비스 사용 중지됨	service Disabled
//		1404	서비스를 찾을 수 없음	Service Not Found
//		1500	서버 내부 오류	Internal Server Error
//		1501	보호된 서비스에서 엑세스가 거부되었습니다.	Access Denied by Protected Service
//		1502	보호된 서비스에서 응답이 잘못되었습니다.	Bad Response from Protected Service
//		1503	일시적으로 사용할 수 없는 서비스	Service Temporarily Unavailable
//		1700	엑세스가 허용되지 않습니다. - Client ID	Access Not Allowed - Client ID
//		1701	엑세스가 허용되지 않습니다. - Service URI	Access Not Allowed - Service URI
//		1702	엑세스가 허용되지 않습니다. - Client ID + Client IP	Access Not Allowed - Client ID + Client IP
//		1703	엑세스가 허용되지 않습니다. - Client ID + Service URI	Access Not Allowed - Client ID + Service URI
//		1705	엑세스가 허용되지 않습니다. - Client ID + Black List Client IP	Access is not allowed - Client ID + Black List Client IP
//		1706	액세스가 허용되지 않습니다 - Client ID + Product Code	Access is not allowed - Client ID + Product Code
//		1707	액세스가 허용되지 않습니다 - Product Code + Service URI	Access is not allowed - Product Code + Service URI
//		1711	거래제한된 요일입니다.	Transaction Restriction week
//		1712	거래제한된 시간입니다.	Transaction Restriction time
//		1713	거래제한된 요일/시간입니다.	Transaction Restriction week/time
//		1714	거래제한된 일자입니다.	Transaction Restriction date
//		1715	거래제한된 일자/시간입니다.	Transaction Restriction date/time
//		1716	공휴일 거래가 제한된 서비스입니다.	Transaction Restriction holiday
//		1717	SQL인젝션, XSS방어	Sql Injection Error
//		1800	잘못된 토큰	Invalid Token
//		1801	잘못된 클라이언트 정보	INVALID_TOKEN
//		1900	초과된 연결 횟수	Exceeded Connections
//		1901	초과 된 토큰 조회 실패	Exceeded getToken failed count
//		1902	초과된 토큰 체크 실패	Exceeded checkToken failed count
//		1903	초과된 접속자 수 	Exceeded User Connections
//		1904	전송 크기 초과	Exceeded Content Length
//		1905	접속량이 너무 많음	Over Connections
//		1906	상품이용 한도 초과	Exceeded Product Use Limit
//		1907	API 이용 주기 초과	Exceeded API Use Time Limit
//		1908	상품 이용 주기 초과	Exceeded Product Use Time Limit

		if("1200".equals(GW_RSLT_CD)) {
			// dataBody.get("expires_in") 값으로 유효기간 지났으면 폐기 후 재발급하는 코드 필요한데
			// 유효기간이 50년이라고 하니까 생략함.
			accessToken = (String) accessTokenDataBody.get("access_token");
			
			/*--------------------------------------------------
			 - 암호화토큰발급 처리부
			*--------------------------------------------------*/
			RestTemplate cryptoTokenRestTemplate = new RestTemplate();
			HttpHeaders cryptoTokenHeaders = new HttpHeaders();
			Date currentDate = new Date();
			long current_timestamp = currentDate.getTime()/1000;
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss", new Locale("KOREAN", "KOREA"));
			String req_dtim = formatter.format(currentDate);
			String accessTokenAndCurrentTimestampAndClientId = accessToken+":"+current_timestamp+":"+clientId;
			
			cryptoTokenHeaders.add("Accept", "*/*");
			cryptoTokenHeaders.add("Content-Type", "application/json");
			cryptoTokenHeaders.add("Authorization", "bearer "+new String(encoder.encode(accessTokenAndCurrentTimestampAndClientId.getBytes())));
			cryptoTokenHeaders.add("ProductID", cryptoTokenProductCode);
			cryptoTokenHeaders.add("CNTY_CD", "ko");
			
			JSONObject jsonReq = new JSONObject();
			jsonReq.put("req_dtim", req_dtim);
			String req_no = "";
			for (int i = 0; i < 10; i++) {
				req_no += Math.floor(Math.random() * 10);
			}
			jsonReq.put("req_no", req_no);
			jsonReq.put("enc_mode", "1");
			
			// json 안에 json을 또 담는 개 병신짓을 왜 해야함?? 씨발 지들이 그렇게 받도록 만들었으면 알려라도주던가 개미친새끼들이
			// 앵무새새끼마냥 매크로답변 ㅈㄴ보내면서 json형태로 보내주셔야합니다 이지랄 ㅆㅂ json으로 보냈는데 오류답변온다고 몇번말함
			// 애미터진 개 씨발 나이스 앰창새끼들
			JSONObject jsonReq2 = new JSONObject();
			jsonReq2.put("dataBody", jsonReq);
	        
			HttpEntity<String> entity = new HttpEntity<>(jsonReq2.toString(), cryptoTokenHeaders);
			ResponseEntity<String> cryptoTokenResponse = cryptoTokenRestTemplate.exchange(cryptoTokenUrl, HttpMethod.POST, entity, String.class);
			
			JSONObject jsonObject2 = new JSONObject(cryptoTokenResponse.getBody());
			JSONObject cryptoTokenDataHeader = jsonObject2.getJSONObject("dataHeader");
			JSONObject cryptoTokenDataBody = jsonObject2.getJSONObject("dataBody");
			
			String GW_RSLT_CD2 = (String) cryptoTokenDataHeader.get("GW_RSLT_CD");
			
			if("1200".equals(GW_RSLT_CD2)) {
				
				/*--------------------------------------------------
				 - 대칭키 생성
				*--------------------------------------------------*/
				cryptoToken = (String) cryptoTokenDataBody.get("token_val");
				
				String value = req_dtim.trim() + req_no.trim() + cryptoToken.trim();
				MessageDigest md = null;
				try {
					md = MessageDigest.getInstance("SHA-256");
				} catch (NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				md.update(value.getBytes());
				byte[] arrHashValue = md.digest();
				
				String resultVal = new String(encoder.encode(arrHashValue));
				
				String key = resultVal.substring(0, 16);
				String iv = resultVal.substring(resultVal.length()-16, resultVal.length());
				String hmac_key = resultVal.substring(0, 32);
				
				/*--------------------------------------------------
				 - 요청데이터 암호화
				*--------------------------------------------------*/
				String site_code = (String) cryptoTokenDataBody.get("site_code");
				
				JSONObject reqDataJson = new JSONObject();
				reqDataJson.put("requestno", req_no);
//				reqDataJson.put("returnurl", "http://localhost:8080/user/niceHpNumberAuthenticationResult.do");
				reqDataJson.put("returnurl", "http://hwcommander.com/user/niceHpNumberAuthenticationResult.do");
				reqDataJson.put("sitecode", site_code);
				reqDataJson.put("methodtype", "get");
				reqDataJson.put("authtype", "M"); // 휴대폰인증 고정
//				reqDataJson.put("receivedata", "testtt");
				
				SecretKey secureKey = new SecretKeySpec(key.getBytes(), "AES");
				byte[] encrypted = null;
				try {
					Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
					c.init(Cipher.ENCRYPT_MODE, secureKey, new IvParameterSpec(iv.getBytes()));
					encrypted = c.doFinal(reqDataJson.toString().getBytes());
				} catch (NoSuchAlgorithmException | NoSuchPaddingException | InvalidKeyException | InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				String enc_data = new String(encoder.encode(encrypted));
				resultMap.put("enc_data", enc_data);
				
				byte[] hmacSha256 = hmac256(hmac_key.getBytes(), enc_data.getBytes());	
				String integrity_value = Base64.getEncoder().encodeToString(hmacSha256);	
				
				resultMap.put("integrity_value", integrity_value);
				resultMap.put("token_version_id", (String) cryptoTokenDataBody.get("token_version_id"));
				resultMap.put("iv", iv);
				resultMap.put("key", key);
			}
		}
		
		return resultMap;
	}
	
	private static byte[] hmac256(byte[] secretKey, byte[] message){
	      byte[] hmac256 = null;
	      try{
	            Mac mac = Mac.getInstance("HmacSHA256");
	            SecretKeySpec sks = new SecretKeySpec(secretKey, "HmacSHA256");
	            mac.init(sks);
	            hmac256 = mac.doFinal(message);
	            return hmac256;
	      } catch(Exception e){
	            throw new RuntimeException("Failed to generate HMACSHA256 encrypt");
	      }
	}

	
}
