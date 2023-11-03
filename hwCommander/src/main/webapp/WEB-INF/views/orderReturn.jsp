<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.inicis.std.util.ParseUtil"%>
<%@ page import="com.inicis.std.util.SignatureUtil"%>
<%@ page import="com.inicis.std.util.HttpUtil"%>
<%@ page import="java.util.*"%>
<% 

	Map<String, String> resultMap = new HashMap<String, String>();

	try{

		//#############################
		// 인증결과 파라미터 일괄 수신
		//#############################
		request.setCharacterEncoding("UTF-8");

		Map<String,String> paramMap = new Hashtable<String,String>();

		Enumeration elems = request.getParameterNames();

		String temp = "";

		while(elems.hasMoreElements())
		{
			temp = (String) elems.nextElement();
			paramMap.put(temp, request.getParameter(temp));
		}
		
		System.out.println("paramMap : "+ paramMap.toString());
		
		
		if("0000".equals(paramMap.get("resultCode"))){

			System.out.println("####인증성공/승인요청####");

			//############################################
			// 1.전문 필드 값 설정(***가맹점 개발수정***)
			//############################################
			
			String mid 		= paramMap.get("mid");
			String timestamp= SignatureUtil.getTimestamp();
			String charset 	= "UTF-8";
			String format 	= "JSON";
			String authToken= paramMap.get("authToken");
			String authUrl	= paramMap.get("authUrl");
			String netCancel= paramMap.get("netCancelUrl");	
			String merchantData = paramMap.get("merchantData");
			
			//#####################
			// 2.signature 생성
			//#####################
			Map<String, String> signParam = new HashMap<String, String>();

			signParam.put("authToken",	authToken);		// 필수
			signParam.put("timestamp",	timestamp);		// 필수

			// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
			String signature = SignatureUtil.makeSignature(signParam);


			//#####################
			// 3.API 요청 전문 생성
			//#####################
			Map<String, String> authMap = new Hashtable<String, String>();

			authMap.put("mid"			,mid);			// 필수
			authMap.put("authToken"		,authToken);	// 필수
			authMap.put("signature"		,signature);	// 필수
			authMap.put("timestamp"		,timestamp);	// 필수
			authMap.put("charset"		,charset);		// default=UTF-8
			authMap.put("format"		,format);	    // default=XML


			HttpUtil httpUtil = new HttpUtil();

			try{
				//#####################
				// 4.API 통신 시작
				//#####################

				String authResultString = "";

				authResultString = httpUtil.processHTTP(authMap, authUrl);
				
				//############################################################
				//5.API 통신결과 처리(***가맹점 개발수정***)
				//############################################################
				
				String test = authResultString.replace(",", "&").replace(":", "=").replace("\"", "").replace(" ","").replace("\n", "").replace("}", "").replace("{", "");
				
							
				resultMap = ParseUtil.parseStringToMap(test); //문자열을 MAP형식으로 파싱
				
				System.out.println("@@@@@@@@@@ resultMap : "+ resultMap.get("resultCode"));
				
				// 주문상태 02로 변경처리해야함 update. 이력도 쌓아야함 insert.
				System.out.println("@@@@@@@@@@ 주문번호 : "+ resultMap.get("MOID"));
				
				
				
				
			  // 수신결과를 파싱후 resultCode가 "0000"이면 승인성공 이외 실패

			  //throw new Exception("강제 Exception");
			} catch (Exception ex) {

				//####################################
				// 실패시 처리(***가맹점 개발수정***)
				//####################################

				//---- db 저장 실패시 등 예외처리----//
				System.out.println(ex);

				//#####################
				// 망취소 API
				//#####################
				String netcancelResultString = httpUtil.processHTTP(authMap, netCancel);	// 망취소 요청 API url(고정, 임의 세팅 금지)

				out.println("## 망취소 API 결과 ##");

				// 취소 결과 확인
				out.println("<p>"+netcancelResultString.replaceAll("<", "&lt;").replaceAll(">", "&gt;")+"</p>");
			}

		}else{
			
			resultMap.put("resultCode", paramMap.get("resultCode"));
			resultMap.put("resultMsg", paramMap.get("resultMsg"));
		}

	}catch(Exception e){

		System.out.println(e);
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>현우의 컴퓨터 공방 - 결제완료</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<!-- 이니시스 js -->
<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<script type="text/javascript">
$(function() {
	
	if("0000" == $("#resultCode").val()) {
		
		var ajaxData = {
				id : $("#moid").val()
		};
			
	    $.ajax({
	        type: "post",
	        url: "/order/inicisPayComplete.do",
	        data: ajaxData,
	        dataType: 'json',
	        success: function (data) {
	        	
	        	console.log(data);
	        	
	        	if(data == 2) {
	        		alert("주문이 완료되었습니다.\n감사합니다.");
	        		location.href = "/";
	        	}else {
	        		alert("결제 후 주문상태변경에 오류가 발생했습니다.\n 관리자에게 문의하세요.");
	        	}
	        }
	    });
	}

});

</script>
</head>
    <body class="wrap">
		<form name="" id="result" method="post" class="mt-5">
			<input type="hidden" id="resultCode" value="<%=resultMap.get("resultCode")%>">
			<input type="hidden" id="moid" value="<%=resultMap.get("MOID")%>">
		</form>
    </body>
</html>
