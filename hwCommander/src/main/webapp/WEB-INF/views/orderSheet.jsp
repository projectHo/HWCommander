<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inicis.std.util.SignatureUtil"%>
<%@page import="java.util.*"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - OrderSheet</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<link rel="stylesheet" href="/resources/css/ver_02/orderSheet.css">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<!-- 23.07.08 다음 카카오 주소 api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 이니시스js -->
<!--테스트 JS-->

<!-- 
<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
 -->

<!--운영 JS // PC -->
<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<%

/* 
	String mid					= "INIpayTest";		                    // 상점아이디					
	String signKey			    = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS";	// 웹 결제 signkey
	 */
	 
	 String mid					= "hwmander66";		                    // 상점아이디					
	String signKey			    = "dTh3MWdEYUJ6ZFhSbEZ1dnNjbzJYZz09";	// 웹 결제 signkey
		
	String mKey = SignatureUtil.hash(signKey, "SHA-256");

	String timestamp			= SignatureUtil.getTimestamp();			// util에 의해서 자동생성
	//String oid			= "TESTORD0000001";	// 가맹점 주문번호(가맹점에서 직접 설정)
	String oid			= String.valueOf(request.getAttribute("orderId"));	// 가맹점 주문번호(가맹점에서 직접 설정)
	
	
	String price				= String.valueOf(request.getAttribute("totOrderPrice")); // 상품가격(특수기호 제외, 가맹점에서 직접 설정)
	
	Map<String, String> signParam = new HashMap<String, String>();

	signParam.put("oid", oid);
	signParam.put("price", price);
	signParam.put("timestamp", timestamp);

	String signature = SignatureUtil.makeSignature(signParam);
	
%>

<script>
    $(function() {
		
    });

	let paymentMethod;

	function startPay() {
		if(!validationCheck()) {
			return false;
		}
		if($(".order-sheet-radios#card").prop("checked") != true && $(".order-sheet-radios#account-transfer").prop("checked") != true){
			alert("결제 방법을 선택해주세요!");
			$(".order-sheet-radios").focus();
			return false;
		}

		if(true){
			var orderRegistFormArray = [];
			
			// $('#productListInfoTable tr').each(function (index) {
			// 	if(0 != index) {
			// 		// orderDetail Set
			// 		var item = {
			// 			id : $(this).find('input[name=id]').val(),
			// 			productId : $(this).find('input[name=productId]').val(),
			// 			productPrice : $(this).find('input[name=productPrice]').val(),
			// 			productOrderQty : "${orderQtys}",
			// 			boxQty : "${boxQtys}",
			// 			boxTotPrice : "${boxTotPrice}"
			// 		};
			// 		orderRegistFormArray.push(item);
			// 	}
			// });
			
			// if(2 < $('#productListInfoTable tr').length) {
			// 	orderName += "외 "+($('#productListInfoTable tr').length-1)+"건";
			// }
			$('#product-boxs').each(function (index) {
				// orderDetail Set
				var item = {
					id : $(this).find('input[name=id]').val(),
					productId : $(this).find('input[name=productId]').val(),
					productPrice : $(this).find('input[name=productPrice]').val(),
					productOrderQty : "${orderQtys}",
					boxQty : "${boxQtys}",
					boxTotPrice : "${boxTotPrice}"
				};
				orderRegistFormArray.push(item);
			});
			
			var orderMasterVO = {
				id : $('input[name=oid]').val(),
				orderName : "${orderName}",
				totOrderPrice : $("#inicis_price").val(),
				orderStateCd : "01",
				ordererUserId : "${loginUser.id}",
				ordererName : $("#ordererName").val(),
				ordererHpNumber : $("#ordererHpNumber").val(),
				ordererMail : $("#ordererMail").val(),
				recipientName : $("#recipientName").val(),
				recipientHpNumber : $("#recipientHpNumber").val(),
				recipientHpNumber2 : $("#recipientHpNumber2").val(),
				recipientJibunAddr : $("#recipientJibunAddr").val(),
				recipientRoadAddr : $("#recipientRoadAddr").val(),
				recipientDetailAddr : $("#recipientDetailAddr").val(),
				recipientZipcode : $("#recipientZipcode").val(),
				orderRequest : $("#orderRequest").val(),
				deliveryRequest : $("#deliveryRequest").val(),
				paymentMethod : paymentMethod,
				videoRequestCd : "01"
			};
			
			var ajaxData = {
					orderMasterVO : JSON.stringify(orderMasterVO),
					orderDetailVOList : JSON.stringify(orderRegistFormArray)
			};
			
			if(paymentMethod == "card"){
				$.ajax({
					type: "post",
					url: "/order/orderRegistLogic.do",
					data: ajaxData,
					dataType: 'json',
					success: function (data) {				
						if(data == 2) {
							// ajax success 시 결제모듈 호출
							$("#inicis_goodname").val("${orderName}");
							$("#inicis_buyername").val($("#ordererName").val());
							$("#inicis_buyertel").val($("#ordererHpNumber").val());
							$("#inicis_buyeremail").val($("#ordererMail").val());
							
							INIStdPay.pay('inicisSendForm');
						}else {
							alert("주문서 작성에 오류가 발생했습니다.\n 관리자에게 문의하세요.");
						}
					}
				});
			}else if(paymentMethod == "account-transfer"){
				console.log(ajaxData.orderDetailVOList);
				$.ajax({
					type: "post",
					url: "/order/orderRegistLogic.do",
					data: ajaxData,
					dataType: 'json',
					success: function (data) {
						
						if(data == 2) {
							alert("계좌로 입금해주시면 주문이 완료됩니다. \n계좌번호 : 645-910900-07207 하나은행 이해창(현우의 컴퓨터 공방) \n계좌번호는 주문내역에서 확인 가능합니다!");
							location.href = "/user/myPage.do";
						}else {
							alert("주문서 작성에 오류가 발생했습니다.\n 관리자에게 문의하세요.");
						}
					}
				});
			}
		}
	}

	function selectPayment(el){
		paymentMethod = $(el).attr("id");
		console.log(paymentMethod);
	}
	function findDaumAddr() {
		new daum.Postcode({
			oncomplete: function(data) {
				
				$("#recipientZoneCode").val(data.zonecode);
				$("#recipientJibunAddr").val(data.jibunAddress);
				$("#recipientRoadAddr").val(data.roadAddress);
				$("#recipientDetailAddr").val("");
			}
		}).open();
	}

	function validationCheck() {
		const numberCheck = /^[0-9]+$/;
		
		if($('#ordererName').val().trim() == "" || $('#ordererName').val().trim() == null) {
			alert("주문자 이름을 입력하세요.");
			$('#ordererName').focus();
			return false;
		}
		
		if($('#ordererHpNumber').val() == "" || $('#ordererHpNumber').val() == null) {
			alert("주문자 휴대폰번호를 입력하세요.");
			$('#ordererHpNumber').focus();
			return false;
		}
		
		if (!numberCheck.test($('#ordererHpNumber').val())) {
			alert("주문자 휴대폰번호는 숫자만 입력 가능합니다.");
			$('#ordererHpNumber').focus();
			return false;
		}
		
		if(11 != $('#ordererHpNumber').val().length && 10 != $('#ordererHpNumber').val().length) {
			alert("주문자 휴대폰번호는 11자리 또는 10자리여야 합니다.");
			$('#ordererHpNumber').focus();
			return false;
		}
		
		if($('#ordererMail').val().trim() == "" || $('#ordererMail').val().trim() == null) {
			alert("주문자 이메일을 입력하세요.");
			$('#ordererMail').focus();
			return false;
		}
		
		const mailCheckRegExp = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");

		if (!mailCheckRegExp.test($('#ordererMail').val())) {
			alert("올바른 주문자 이메일을 입력하세요.");
			$('#ordererMail').focus();
			return false;
		}
		
		if($('#recipientName').val().trim() == "" || $('#recipientName').val().trim() == null) {
			alert("수령인을 입력하세요.");
			$('#recipientName').focus();
			return false;
		}
		
		if($('#recipientHpNumber').val() == "" || $('#recipientHpNumber').val() == null) {
			alert("수령인 휴대폰번호를 입력하세요.");
			$('#recipientHpNumber').focus();
			return false;
		}
		
		if (!numberCheck.test($('#recipientHpNumber').val())) {
			alert("수령인 휴대폰번호는 숫자만 입력 가능합니다.");
			$('#recipientHpNumber').focus();
			return false;
		}
		
		if(11 != $('#recipientHpNumber').val().length && 10 != $('#recipientHpNumber').val().length) {
			alert("수령인 휴대폰번호는 11자리 또는 10자리여야 합니다.");
			$('#recipientHpNumber').focus();
			return false;
		}
		
		if($('#recipientHpNumber2').val() != "" && $('#recipientHpNumber2').val() != null) {
			if (!numberCheck.test($('#recipientHpNumber2').val())) {
				alert("수령인 추가 휴대폰번호는 숫자만 입력 가능합니다.");
				$('#recipientHpNumber2').focus();
				return false;
			}
			
			if(11 != $('#recipientHpNumber2').val().length && 10 != $('#recipientHpNumber2').val().length) {
				alert("수령인 추가 휴대폰번호는 11자리 또는 10자리여야 합니다.");
				$('#recipientHpNumber2').focus();
				return false;
			}
		}
		
		if($('#recipientZonecode').val().trim() == "" || $('#recipientZonecode').val().trim() == null) {
			alert("주소를 입력하세요.");
			$('#btn_addr_search').focus();
			return false;
		}
		
		if($('#recipientJibunAddr').val().trim() == "" || $('#recipientJibunAddr').val().trim() == null) {
			alert("주소를 입력하세요.");
			$('#btn_addr_search').focus();
			return false;
		}
		
		if($('#recipientRoadAddr').val().trim() == "" || $('#recipientRoadAddr').val().trim() == null) {
			alert("주소를 입력하세요.");
			$('#btn_addr_search').focus();
			return false;
		}
		
		if($('#recipientDetailAddr').val().trim() == "" || $('#recipientDetailAddr').val().trim() == null) {
			alert("상세주소를 입력하세요.");
			$('#recipientDetailAddr').focus();
			return false;
		}
		
		return true;
	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	<div class="order-sheet-container w-100 py-5">
		<div class="container mb-5">
			<form id="order_sheet_form">
				<div class="d-flex flex-column align-items-center justify-content-center gap-4">
					<h2 class="fw-bold text-white m-0">주문서</h2>
					<div class="d-flex gap-4 w-100">
						<div class="d-flex flex-column gap-4 w-75">
							<div class="order-sheet-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 fw-bold">주문 상품</h4>
								<div class="d-flex align-items-center gap-5">
									<div class="img-box" id="product-boxs" style="width: 200px; height: 200px; cursor: pointer; background-color: transparent; border-radius: 14px;">
										<input type="hidden" name="id" value="<%=oid%>">
										<c:if test="${accessRoute == 'direct'}">
											<input type="hidden" name="productId" value="${productMasterVO.id}">
											<input type="hidden" name="productPrice" value="${productMasterVO.productPrice}">
											<input type="hidden" name="productName" value="${productMasterVO.productName}">
										</c:if>
										<c:if test="${accessRoute == 'banpum'}">
											<input type="hidden" name="productId" value="${banpumMasterVO.id}">
											<input type="hidden" name="productPrice" value="${banpumMasterVO.banpumPrice}">
										</c:if>
										<c:if test="${accessRoute == 'banpum'}">
											<c:if test="${banpumMasterVO.banpumImage1 != ''}">
												<div id="banpumMallOrderIndicators" class="carousel carousel-light slide" data-bs-ride="true" style="object-fit:contain;">
													<div class="carousel-indicators">
														<button type="button" data-bs-target="#banpumMallOrderIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
														<c:forEach var="i" begin="2" end="15">
															<c:set var="key" value="banpumImage${i}" />
															<c:if test="${not empty  banpumMasterVO[key]}">
																<button type="button" data-bs-target="#banpumMallOrderIndicators" data-bs-slide-to="${i-1}" aria-label="Slide ${i}"></button>
															</c:if>
														</c:forEach>
													</div>
													<div class="carousel-inner">
														<div class="carousel-item active">
															<img src="${banpumMasterVO.banpumImage1}" class="d-block w-100 h-100" alt="...">
														</div>
														<c:forEach var="i" begin="2" end="15">
															<c:set var="key" value="banpumImage${i}" />
															<c:if test="${not empty banpumMasterVO[key]}">
																<div class="carousel-item">
																	<img src="${banpumMasterVO[key]}" class="d-block w-100 h-100" alt="...">
																</div>
															</c:if>
														</c:forEach>
													</div>
													<button class="carousel-control-prev" type="button" data-bs-target="#banpumMallOrderIndicators" data-bs-slide="prev">
														<span class="carousel-control-prev-icon" aria-hidden="true"></span>
														<span class="visually-hidden">Previous</span>
													</button>
													<button class="carousel-control-next" type="button" data-bs-target="#banpumMallOrderIndicators" data-bs-slide="next">
														<span class="carousel-control-next-icon" aria-hidden="true"></span>
														<span class="visually-hidden">Next</span>
													</button>
												</div>
											</c:if>
											<c:if test="${banpumMasterVO.banpumImage1 == ''}">
												<div class="d-flex flex-column gap-3 justify-content-center align-items-center h-100 my-auto">
													<svg fill="#000000" width="100px" height="100px" viewBox="-3.2 -3.2 38.40 38.40" id="icon" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.192"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#CCCCCC" stroke-width="1.7280000000000002"><defs><style>.cls-1{fill:none;}</style></defs><title>no-image</title><path d="M30,3.4141,28.5859,2,2,28.5859,3.4141,30l2-2H26a2.0027,2.0027,0,0,0,2-2V5.4141ZM26,26H7.4141l7.7929-7.793,2.3788,2.3787a2,2,0,0,0,2.8284,0L22,19l4,3.9973Zm0-5.8318-2.5858-2.5859a2,2,0,0,0-2.8284,0L19,19.1682l-2.377-2.3771L26,7.4141Z"></path><path d="M6,22V19l5-4.9966,1.3733,1.3733,1.4159-1.416-1.375-1.375a2,2,0,0,0-2.8284,0L6,16.1716V6H22V4H6A2.002,2.002,0,0,0,4,6V22Z"></path><rect id="_Transparent_Rectangle_" data-name="<Transparent Rectangle>" class="cls-1" width="32" height="32"></rect></g><g id="SVGRepo_iconCarrier"><defs><style>.cls-1{fill:none;}</style></defs><title>no-image</title><path d="M30,3.4141,28.5859,2,2,28.5859,3.4141,30l2-2H26a2.0027,2.0027,0,0,0,2-2V5.4141ZM26,26H7.4141l7.7929-7.793,2.3788,2.3787a2,2,0,0,0,2.8284,0L22,19l4,3.9973Zm0-5.8318-2.5858-2.5859a2,2,0,0,0-2.8284,0L19,19.1682l-2.377-2.3771L26,7.4141Z"></path><path d="M6,22V19l5-4.9966,1.3733,1.3733,1.4159-1.416-1.375-1.375a2,2,0,0,0-2.8284,0L6,16.1716V6H22V4H6A2.002,2.002,0,0,0,4,6V22Z"></path><rect id="_Transparent_Rectangle_" data-name="<Transparent Rectangle>" class="cls-1" width="32" height="32"></rect></g></svg>
													<p class="fw-bold text-light">등록된 이미지가 없습니다</p>
												</div>
											</c:if>
										</c:if>
										<c:if test="${accessRoute == 'direct'}">
											<c:if test="${productMasterVO.productImage != ''}">
												<img class="img-fluid rounded d-block" src="${productMasterVO.productImage}" alt="" style="cursor:pointer; width:100%; height:280px; object-fit:contain;">
											</c:if>
											<c:if test="${productMasterVO.productImage == ''}">
												<div class="d-flex flex-column gap-3 justify-content-center align-items-center h-100 my-auto">
													<svg fill="#000000" width="100px" height="100px" viewBox="-3.2 -3.2 38.40 38.40" id="icon" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.192"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#CCCCCC" stroke-width="1.7280000000000002"><defs><style>.cls-1{fill:none;}</style></defs><title>no-image</title><path d="M30,3.4141,28.5859,2,2,28.5859,3.4141,30l2-2H26a2.0027,2.0027,0,0,0,2-2V5.4141ZM26,26H7.4141l7.7929-7.793,2.3788,2.3787a2,2,0,0,0,2.8284,0L22,19l4,3.9973Zm0-5.8318-2.5858-2.5859a2,2,0,0,0-2.8284,0L19,19.1682l-2.377-2.3771L26,7.4141Z"></path><path d="M6,22V19l5-4.9966,1.3733,1.3733,1.4159-1.416-1.375-1.375a2,2,0,0,0-2.8284,0L6,16.1716V6H22V4H6A2.002,2.002,0,0,0,4,6V22Z"></path><rect id="_Transparent_Rectangle_" data-name="<Transparent Rectangle>" class="cls-1" width="32" height="32"></rect></g><g id="SVGRepo_iconCarrier"><defs><style>.cls-1{fill:none;}</style></defs><title>no-image</title><path d="M30,3.4141,28.5859,2,2,28.5859,3.4141,30l2-2H26a2.0027,2.0027,0,0,0,2-2V5.4141ZM26,26H7.4141l7.7929-7.793,2.3788,2.3787a2,2,0,0,0,2.8284,0L22,19l4,3.9973Zm0-5.8318-2.5858-2.5859a2,2,0,0,0-2.8284,0L19,19.1682l-2.377-2.3771L26,7.4141Z"></path><path d="M6,22V19l5-4.9966,1.3733,1.3733,1.4159-1.416-1.375-1.375a2,2,0,0,0-2.8284,0L6,16.1716V6H22V4H6A2.002,2.002,0,0,0,4,6V22Z"></path><rect id="_Transparent_Rectangle_" data-name="<Transparent Rectangle>" class="cls-1" width="32" height="32"></rect></g></svg>
													<p class="fw-bold text-light">등록된 이미지가 없습니다</p>
												</div>
											</c:if>
										</c:if>
									</div>
									<c:if test="${accessRoute == 'banpum'}">
										<div class="d-flex flex-column py-2 gap-2 h-100">
											<h4 class="fw-bold text-white">${banpumMasterVO.banpumName}</h4>
											<h6 class="fw-semibold text-white m-0">부품 상세</h6>
											<h6 class="fw-semibold text-white m-0">${banpumMasterVO.banpumDescriptionStr}</h6>
											<h6 class="fw-semibold text-white m-0">본품 : ${orderQtys}개 | ${banpumMasterVO.banpumPriceStr}</h6>
											<h6 class="fw-semibold text-white">옵션 : 박스 추가 ${boxQtys}개 | ${boxTotPriceStr}원</h6>
										</div>
									</c:if>
									<c:if test="${accessRoute == 'direct'}">
										<div class="d-flex flex-column py-2 gap-2 h-100">
											<h4 class="fw-bold text-white">${productMasterVO.productName}</h4>
											<h6 class="fw-semibold text-white m-0">부품 상세</h6>
											<c:choose>
												<c:when test="${productMasterVO.windowsName == 'COEM'}">
													<h6 class="fw-semibold text-white m-0">윈도우 : 메인보드 귀속형(${productMasterVO.windowsName})</h6>
												</c:when>
												<c:when test="${productMasterVO.windowsName == 'FPP'}">
													<h6 class="fw-semibold text-white m-0">윈도우 : 구매형(${productMasterVO.windowsName})</h6>
												</c:when>
												<c:otherwise>
													<h6 class="fw-semibold text-white m-0">윈도우 : 미포함</h6>
												</c:otherwise>
											</c:choose>
											<h6 class="fw-semibold text-white m-0">메인보드 : ${productDetailVOList[2].partsName}</h6>
											<h6 class="fw-semibold text-white m-0">파워 : ${productDetailVOList[5].partsName}</h6>
											<h6 class="fw-semibold text-white m-0">CPU : ${productDetailVOList[1].partsName}</h6>
											<h6 class="fw-semibold text-white m-0">그래픽카드 : ${productDetailVOList[0].partsName}</h6>
											<h6 class="fw-semibold text-white m-0">램 : ${productDetailVOList[6].partsName}</h6>
											<h6 class="fw-semibold text-white m-0">저장장치 : (${productDetailVOList[7].partsTypeCdNm}) ${productDetailVOList[7].partsName}</h6>
											<h6 class="fw-semibold text-white m-0">케이스 : ${productDetailVOList[4].partsName}</h6>
											<h6 class="fw-semibold text-white m-0">쿨러 : ${productDetailVOList[3].partsName}</h6>
											<h6 class="fw-semibold text-white m-0">본품 : ${orderQtys}개 | ${productMasterVO.productPriceStr}</h6>
											<h6 class="fw-semibold text-white">옵션 : 박스 추가 ${boxQtys}개 | ${boxTotPriceStr}원</h6>
										</div>
									</c:if>
								</div>
							</div>
							<div class="order-sheet-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 mb-3 fw-bold">주문자 정보</h4>

								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">주문자 이름</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" placeholder="주문자 이름" id="ordererName" value="${loginUser.name}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">주문자 휴대폰 번호</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" placeholder="주문자 휴대폰 번호" id="ordererHpNumber" value="${loginUser.hpNumber}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">주문자 이메일</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" placeholder="주문자 이메일" id="ordererMail" value="${loginUser.mail}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3 d-none">
									<h6 class="fw-bold">추천인</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary w-75" placeholder="추천인">
											<button type="button" class="btn btn-secondary btn-lg h-100 flex-grow-1">확인</button>
										</div>
									</div>
								</div>
							</div>
							<div class="order-sheet-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 mb-3 fw-bold">배송지 정보</h4>

								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">수령인 이름</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" placeholder="수령인 이름" id="recipientName" value="${loginUser.name}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">수령인 휴대폰 번호</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" placeholder="수령인 핸드폰 번호" id="recipientHpNumber" value="${loginUser.hpNumber}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">추가 휴대폰 번호</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" placeholder="추가 핸드폰 번호" id="recipientHpNumber2">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">우편번호</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary w-75" id="recipientZonecode" placeholder="" disabled value="${loginUser.zipcode}">
											<button type="button" class="btn btn-secondary btn-lg h-100 flex-grow-1" onclick="javascript:findDaumAddr()">검색</button>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">지번주소</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" id="recipientJibunAddr" placeholder="" disabled value="${loginUser.jibunAddr}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">도로명주소</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" id="recipientRoadAddr" placeholder="" disabled value="${loginUser.roadAddr}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">상세주소</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" id="recipientDetailAddr" placeholder="상세 주소">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">주문 요청사항</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" placeholder="주문 요청사항" id="orderRequest" value="${loginUser.detailAddr}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">배송 요청사항</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-sheet-inputs text-white form-control p-3 border-secondary" placeholder="배송 요청사항" id="deliveryRequest">
										</div>
									</div>
								</div>
							</div>
							<div class="order-sheet-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 mb-3 fw-bold">결제수단</h4>

								<div class="d-flex justify-content-between align-items-center gap-3 w-100">
									<h6 class="fw-bold flex-grow-1">결제수단</h6>
									<div class="d-flex gap-5 align-items-center justify-content-start w-75">
										<div class="form-check">
											<input class="form-check-input order-sheet-radios" type="radio" name="payment" id="card" onclick="javascript:selectPayment(this)">
											<label class="form-check-label" for="card">
											  카드
											</label>
										</div>
										<div class="form-check">
											<input class="form-check-input order-sheet-radios" type="radio" name="payment" id="account-transfer" onclick="javascript:selectPayment(this)">
											<label class="form-check-label" for="account-transfer">
											  계좌이체
											</label>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="d-flex flex-column gap-2 order-sheet-boxs text-white flex-grow-1 p-4" style="height: fit-content; position: sticky; top: 2rem;">
							<h4 class="m-0 fw-bold text-white">총 가격</h4>

							<div class="order-sheet-divider my-3"></div>
							<c:if test="${accessRoute == 'banpum'}">
								<h6 class="text-white">본품 : ${banpumMasterVO.banpumPriceStr}</h6>
								<h6 class="text-white">박스 추가 : ${boxQtys}개, 총 ${boxTotPriceStr}원</h6>
							</c:if>
							
							<c:if test="${accessRoute == 'direct'}">
								<h6 class="text-white">본품 : ${productMasterVO.productPriceStr}</h6>
								<h6 class="text-white">박스 추가 : ${boxQtys}개, 총 ${boxTotPriceStr}원</h6>
							</c:if>
							<h6 class="text-white">배송비 : 무료</h6>
							<div class="order-sheet-divider my-3"></div>

							<h4 class="m-0 fw-bold text-white">${totOrderPriceStr}원</h4>

							<button type="button" class="mt-4 w-100 btn btn-lg btn-primary" onclick="javascript:startPay()">결제하기</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	
	<form class="d-none" id="inicisSendForm" method="post">
		<input type="hidden" name="version" value="1.0">
		<input type="hidden" name="gopaymethod" value="Card">
		<input type="hidden" name="mid" value="<%=mid%>">
		<input type="hidden" name="oid" value="<%=oid%>">
		<input type="hidden" id="inicis_price" name="price" value="<%=price%>">
		<input type="hidden" name="timestamp" value="<%=timestamp%>">
		<input type="hidden" name="signature" value="<%=signature%>">
		<input type="hidden" name="mKey" value="<%=mKey%>">
		<input type="hidden" name="currency" value="WON">
		<input type="hidden" id="inicis_goodname" name="goodname">
		<input type="hidden" id="inicis_buyername" name="buyername">
		<input type="hidden" id="inicis_buyertel" name="buyertel">
		<input type="hidden" id="inicis_buyeremail" name="buyeremail">
		<input type="hidden" name="quotabase" value="1:2:3:4:5:6:7:8:9:10:11:12">
			
		<!-- todo wonho 로컬테스트 -->
		<%-- 
		<input type="hidden" name="returnUrl" value="https://localhost:8080/order/inicisPayReturn.do">
		<input type="hidden" name="closeUrl" value="https://localhost:8080/order/inicisPayClose.do?id=<%=oid%>">
		--%> 
		<!-- todo wonho 운영 -->
		
		<input type="hidden" name="returnUrl" value="https://hwcommander.com/order/inicisPayReturn.do">
		<input type="hidden" name="closeUrl" value="https://hwcommander.com/order/inicisPayClose.do?id=<%=oid%>">
		
	</form>
	<form class="d-none" id="inicisSendFormM" method="post" name="mobileweb" action="https://mobile.inicis.com/smart/payment/" target="_self">
		<input type="hidden" name="P_INI_PAYMENT" value="Card">
		<input type="hidden" name="P_MID" value="<%=mid%>">
		<input type="hidden" name="P_OID" value="<%=oid%>">
		<input type="hidden" id="inicis_price" name="P_AMT" value="<%=price%>">
		<!-- <input type="hidden" name="signature" value="<%=signature%>">
		<input type="hidden" name="mKey" value="<%=mKey%>">
		<input type="hidden" name="currency" value="WON"> -->
		<input type="hidden" id="inicis_goodname" name="P_GOODS">
		<input type="hidden" id="inicis_buyername" name="P_UNAME">
		<input type="hidden" id="inicis_buyertel" name="buyertel">
		<input type="hidden" id="inicis_buyeremail" name="buyeremail">
		<input type="hidden" name="P_QUOTABASE" value="1:2:3:4:5:6:7:8:9:10:11:12">
			
		<!-- todo wonho 로컬테스트 -->
		
		<input type="hidden" name="P_NEXT_URL" value="https://localhost:8080/order/inicisPayReturnM.do">
		<input type="hidden" name="closeUrl" value="https://localhost:8080/order/inicisPayClose.do?id=<%=oid%>">
		
		<!-- todo wonho 운영 -->
		<%--
		<input type="hidden" name="P_NEXT_URL" value="https://hwcommander.com/order/inicisPayReturnM.do">
		<input type="hidden" name="closeUrl" value="https://hwcommander.com/order/inicisPayClose.do?id=<%=oid%>">
		--%>
	</form>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>
