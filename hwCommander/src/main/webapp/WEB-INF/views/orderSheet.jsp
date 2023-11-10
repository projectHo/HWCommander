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
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/users.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<!-- 09.06 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>

<!-- 23.07.08 다음 카카오 주소 api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 이니시스js -->
<!--테스트 JS-->

<!-- 
<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
 -->

<!--운영 JS -->
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
	let a = "${productMasterVO}"
    $(function() {
		// bootstrap 툴팁
		const tooltipTriggerList = $('[data-bs-toggle="tooltip"]');
		const tooltipList = tooltipTriggerList.map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();

    	$('#productListInfoTable').DataTable({ 
    	    bAutoWidth: false,
    	    columnDefs: [
    	    { width: "20%", targets : 0 },
    	    { width: "50%", targets: 1 },
    	    { width: "20%", targets: 2 }
    	    ],
    		// 표시 건수기능 숨기기
    		lengthChange: false,
    		// 검색 기능 숨기기
    		searching: false,
    		// 정렬 기능 숨기기
    		ordering: false,
    		// 정보 표시 숨기기
    		info: false,
    		// 페이징 기능 숨기기
    		paging: false
    	 });
    	
    	//orderer set
    	$("#ordererName").val("${loginUser.name}");
    	$("#ordererHpNumber").val("${loginUser.hpNumber}");
    	$("#ordererMail").val("${loginUser.mail}");
    	
    	//recipient set
    	$("#recipientName").val("${loginUser.name}");
    	$("#recipientHpNumber").val("${loginUser.hpNumber}");
    	
    	$("#recipientZipcode").val("${loginUser.zipcode}");
    	$("#recipientJibunAddr").val("${loginUser.jibunAddr}");
    	$("#recipientRoadAddr").val("${loginUser.roadAddr}");
    	$("#recipientDetailAddr").val("${loginUser.detailAddr}");
    	
        // 주소찾기
        $('#btn_addr_search').on("click", function () {
        	findDaumAddr();
        });
		// 08.26 상품들 아래 테두리
		for(let i = 1 ; i <= $(".order-items").length; i++){
			if(i === $(".order-items").length){
				$(".order-items").eq(i-1).children("td").addClass("border-bottom-0");
			}
		}
    });
    
function btnCheckOutClick() {
	if(!validationCheck()) {
		return false;
	}
	if($("#payment-method-card").prop("checked") != true && $("#payment-method-account-transfer").prop("checked") != true){
		alert("결제 방법을 선택해주세요!");
		return false;
	}

	if($("#payment-method-card").prop("checked") == true){
		var orderRegistFormArray = [];
		
		//var totOrderPrice = 0;
		$('#productListInfoTable tr').each(function (index) {
			if(0 != index) {
				// orderDetail Set
				var item = {
					id : $(this).find('input[name=id]').val(),
					productId : $(this).find('input[name=productId]').val(),
					productPrice : $(this).find('input[name=productPrice]').val(),
					//productOrderQty : $(this).find('input[name=productOrderQty]').val()
					productOrderQty : "${orderQtys}",
					boxQty : "${boxQtys}",
					boxTotPrice : "${boxTotPrice}"
				};
				orderRegistFormArray.push(item);
				
				//totOrderPrice set
				//totOrderPrice += parseInt($(this).find('input[name=productPrice]').val());
			}
		});
		
		if(2 < $('#productListInfoTable tr').length) {
			orderName += "외 "+($('#productListInfoTable tr').length-1)+"건";
		}
		
		
		var orderMasterVO = {
			id : $('input[name=oid]').val(),
			orderName : "${orderName}",
			//totOrderPrice : totOrderPrice,
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
			paymentMethod : "Card",
			videoRequestCd : "01"
		};
		
		var ajaxData = {
				orderMasterVO : JSON.stringify(orderMasterVO),
				orderDetailVOList : JSON.stringify(orderRegistFormArray)
		};
			
		$.ajax({
			type: "post",
			url: "/order/orderRegistLogic.do",
			data: ajaxData,
			dataType: 'json',
			success: function (data) {
				
				console.log(data);
				
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
	}else if($("#payment-method-account-transfer").prop("checked") == true) {
		var orderRegistFormArray = [];
		
		$('#productListInfoTable tr').each(function (index) {
			if(0 != index) {
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
			}
		});
		
		if(2 < $('#productListInfoTable tr').length) {
			orderName += "외 "+($('#productListInfoTable tr').length-1)+"건";
		}
		
		
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
			paymentMethod : "account-transfer",
			videoRequestCd : "01"
		};
		
		var ajaxData = {
				orderMasterVO : JSON.stringify(orderMasterVO),
				orderDetailVOList : JSON.stringify(orderRegistFormArray)
		};
			
		$.ajax({
			type: "post",
			url: "/order/orderRegistLogic.do",
			data: ajaxData,
			dataType: 'json',
			success: function (data) {
				
				console.log(data);
				
				if(data == 2) {
					alert("계좌로 입금해주시면 주문이 완료됩니다. \n계좌번호 : 645-910900-07207 하나은행 이해창(현우의 컴퓨터 공방) \n계좌번호는 주문내역에서 확인 가능합니다!");
					location.href = "/user/orderList.do";
				}else {
					alert("주문서 작성에 오류가 발생했습니다.\n 관리자에게 문의하세요.");
				}
			}
		});
	}
}

function findDaumAddr() {
	new daum.Postcode({
        oncomplete: function(data) {
        	console.log(data);
        	
            $("#recipientZipcode").val(data.zonecode);
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
	
	if($('#recipientZipcode').val().trim() == "" || $('#recipientZipcode').val().trim() == null) {
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

// 08.26 추천인 확인 기능 추가
var targetId = null;

function recDupliChk(id) {
	if(id == "") {
		alert("추천인을 입력하세요.");
		return false;
	}
	
	$.ajax({
        type: "post",
        url: "/user/idDupliChk.do",
        data: {
        	"id" : id
        },
        dataType: 'json',
        success: function (data) {
        	if(data == 0) {
				targetId = null;
				alert("아이디가 정확하지 않습니다.");
        		$("#recommander").addClass("is-invalid");
				$("#recommander").next().addClass("border-danger");
        	}else {
        		targetId = id;
        		$("#recommander").removeClass("is-invalid");
				$("#recommander").next().removeClass("border-danger");
        		alert("확인되었습니다.");
        	}
        }
    });
}
</script>
</head>
<body class="order-sheet-body">
	<form id="order_sheet_form">
		<div class="mx-auto container pt-3 pb-3">
			<div class="card mt-4">
				<div class="card-header">
					<div class="d-flex">
						<div class="me-auto d-flex align-items-center">상품 정보</div>
					</div>
				</div>
				<div class="card-body pb-0">
					<table id="productListInfoTable" class="table">
						<thead>
							<tr>
								<th>상품이미지</th>
								<th>상품명</th>
								<th>상품가격</th>
							</tr>
						</thead>
						<tbody>
							<!-- 완본체몰 -->
							<c:if test="${accessRoute == 'direct'}">
								<tr class="order-items">
									<td>
										<input type="hidden" name="id" value="<%=oid%>">
										<input type="hidden" name="productId" value="${productMasterVO.id}">
										<input type="hidden" name="productPrice" value="${productMasterVO.productPrice}">
										<!-- todo wonho 지금은 장바구니쪽 로직이 없으므로 수량 1로 고정함. -->
										<input type="hidden" name="productOrderQty" value="1">
										
										<input type="hidden" name="productName" value="${productMasterVO.productName}">
										
										
										<%-- 임시 몰루이미지 
										<img class="img-fluid rounded mx-auto d-block" src="/resources/img/tempImage_600x600.png">
										--%>
										<img class="img-fluid rounded d-block" src="${productMasterVO.productImage}" alt="" style="cursor:pointer; width:200px; height:200px; object-fit:contain;">
									</td>
									<td class="align-middle pb-0">
										<div class="row pt-2">
											<div class="col fs-4">
												${productMasterVO.productName}
											</div>
										</div>
										<div class="row pt-2">
											<h5 class="col mb-0">
												부품 상세
											</h5>
										</div>
										<div class="row p-2">
											<div class="col" id="product-detail-box">
												<c:choose>
													<c:when test="${productMasterVO.windowsName == 'COEM'}">
														<p class="mb-1">윈도우 : 메인보드 귀속형(${productMasterVO.windowsName})</p>
													</c:when>
													<c:when test="${productMasterVO.windowsName == 'FPP'}">
														<p class="mb-1">윈도우 : 구매형(${productMasterVO.windowsName})</p>
													</c:when>
													<c:otherwise>
														<p class="mb-1">윈도우 : 미포함</p>
													</c:otherwise>
												</c:choose>
												<p class="mb-1">메인보드 : ${productDetailVOList[2].partsName}</p>
												<p class="mb-1">파워 : ${productDetailVOList[5].partsName}</p>
												<p class="mb-1">CPU : ${productDetailVOList[1].partsName}</p>
												<p class="mb-1">그래픽카드 : ${productDetailVOList[0].partsName}</p> 
												<p class="mb-1">램 : ${productDetailVOList[6].partsName}</p>
												<p class="mb-1">저장장치 : (${productDetailVOList[7].partsTypeCdNm}) ${productDetailVOList[7].partsName}</p>
												<p class="mb-1">케이스 : ${productDetailVOList[4].partsName}</p>
												<p class="mb-0">쿨러 : ${productDetailVOList[3].partsName}</p>
											</div>
										</div>
										
									</td>
									<td class="align-middle text-center">
										<div class="p-2">
											<p class="p-2 border-bottom fs-4">주문 내역</p>
											<p class="p-2 border-bottom">상품 가격 : ${orderQtys}개, 개당${productMasterVO.productPriceStr}</p>
											<p class="p-2 border-bottom">박스 추가 : ${boxQtys}개, 총 ${boxTotPriceStr}원</p>
											<h4 class="p-2"> 총 금액 : ${totOrderPriceStr}원</h4>
										</div>
									</td>
								</tr>
							</c:if>
							<c:if test="${accessRoute == 'banpum'}">
								<tr class="order-items">
									<td>
										<input type="hidden" name="id" value="<%=oid%>">
										<input type="hidden" name="productId" value="${banpumMasterVO.id}">
										<input type="hidden" name="productPrice" value="${banpumMasterVO.banpumPrice}">
										<!-- todo wonho 지금은 장바구니쪽 로직이 없으므로 수량 1로 고정함. -->
										<input type="hidden" name="productOrderQty" value="1">
										
										<input type="hidden" name="productName" value="${banpumMasterVO.banpumName}">
										
										
										<%-- 임시 몰루이미지 
										<img class="img-fluid rounded mx-auto d-block" src="/resources/img/tempImage_600x600.png">
										--%>
										<!-- 이미지 추가 방식 변경예정 -->
										<div id="banpumMallOrderIndicators" class="carousel carousel-dark slide" data-bs-ride="true" style="width:280px; height:280px; object-fit:contain;">
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
									</td>
									<td class="align-middle pb-0">
										<div class="row pt-2">
											<div class="col fs-4">
												${banpumMasterVO.banpumName}
											</div>
										</div>
										<div class="row pt-2">
											<h5 class="col mb-0">
												부품 상세
											</h5>
										</div>
										<div class="row p-2">
											<div class="col" id="product-detail-box">
												<p class="mb-1">${banpumMasterVO.banpumDescriptionStr}</p>
											</div>
										</div>
										
									</td>
									<td class="align-middle text-center">
										<div class="p-2">
											<p class="p-2 border-bottom fs-4">주문 내역</p>
											<p class="p-2 border-bottom">상품 가격 : ${orderQtys}개, 개당${banpumMasterVO.banpumPriceStr}</p>
											<p class="p-2 border-bottom">박스 추가 : ${boxQtys}개, 총 ${boxTotPrice}원</p>
											<h4 class="p-2"> 총 금액 : ${totOrderPrice}원</h4>
										</div>
									</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
			<div class="card order-sheet-card-border">
				<div class="card-header">
					<div class="d-flex">
						<div class="me-auto d-flex align-items-center">주문자 정보</div>
					</div>
				</div>
				<div class="card-body">
					<div class="mb-3 row">
						<label for="ordererName" class="col-md-2 col-form-label">주문자 이름</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="ordererName" name="ordererName" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="ordererHpNumber" class="col-md-2 col-form-label">주문자 휴대폰번호</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="ordererHpNumber" name="ordererHpNumber" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="ordererMail" class="col-md-2 col-form-label">주문자 이메일</label>
						<div class="col-md-5">
							<input type="email" class="form-control" id="ordererMail" name="ordererMail" required>
						</div>
					</div>
					<div class="row">
						<label for="recommander" class="col-md-2 col-form-label">추천인</label>
						<div class="col-md-5">
							<div class="input-group">
								<input type="text" class="form-control" id="recommander" name="recommander" required>
								<button type="button" class="btn btn-outline-secondary" maxlength="25" id="btn_rec_dupli_chk" onclick="javascript:recDupliChk($('#recommander').val().trim())">ID확인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">
					<div class="d-flex">
						<div class="me-auto d-flex align-items-center">배송지 정보</div>
					</div>
				</div>
				<div class="card-body pb-0">
					<div class="mb-3 row">
						<label for="recipientName" class="col-md-2 col-form-label">수령인</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="recipientName" name="recipientName" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientName" class="col-md-2 col-form-label">수령인 휴대폰번호</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="recipientHpNumber" name="recipientHpNumber" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientHpNumber2" class="col-md-2 col-form-label">수령인 추가 휴대폰번호</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="recipientHpNumber2" name="recipientHpNumber2" required>
						</div>
					</div>
					<div class="mb-3 row d-md-flex">
						<label for="recipientZipcode" class="col-md-2 col-form-label">우편번호</label>
						<div class="input-group order-custom-input-group col-md-5">
							<input type="text" class="form-control" id=recipientZipcode name="recipientZipcode" readonly="readonly" required>
							<button type="button" class="btn btn-secondary" id="btn_addr_search">주소찾기</button>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientJibunAddr" class="col-md-2 col-form-label">지번주소</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id=recipientJibunAddr name="recipientJibunAddr" readonly="readonly" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientRoadAddr" class="col-md-2 col-form-label">도로명주소</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id=recipientRoadAddr name="recipientRoadAddr" readonly="readonly" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientDetailAddr" class="col-md-2 col-form-label">상세주소</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id=recipientDetailAddr name="recipientDetailAddr" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="orderRequest" class="col-md-2 col-form-label">주문 시 요청사항</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="orderRequest" name="orderRequest" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="deliveryRequest" class="col-md-2 col-form-label">배송 시 요청사항</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="deliveryRequest" name="deliveryRequest" required>
						</div>
					</div>
					<div class="row">
						<label class="col-md-2 col-form-label">결제 방법</label>
						<div class="col-md-5">
							<div class="form-check form-check-inline">
								<input class="form-check-input" name="payment-method" type="radio" id="payment-method-card" value="option1" required>
								<label class="form-check-label pt-1" for="payment-method-card">카드</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" name="payment-method" type="radio" id="payment-method-account-transfer" value="option1" required>
								<label class="form-check-label pt-1" for="payment-method-account-transfer">계좌이체</label>
							</div>
						</div>
						<div class="goni-wrap">
							<p>"난 딴돈의 반만 가져가"</p>
							<svg width="180px" height="145" class="goni-speech" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="저희는 노동치 이상의 수익을 요구하지 않습니다. 결제 수단에 따라 차액을 마진으로 생각하지 않으며, 계좌이체를 결제 수단으로 이용함에 따라 발생하는 카드수수료 차액만큼을 할인가로 적용해드립니다." viewBox="0 0 303 145" fill="none" xmlns="http://www.w3.org/2000/svg"><mask id="path-1-inside-1_118_11" fill="white"><path fill-rule="evenodd" clip-rule="evenodd" d="M10 0C4.47715 0 0 4.47715 0 10V131C0 136.523 4.47715 141 10 141H255.125C255.333 141.019 255.551 141.038 255.778 141.057L295.839 144.538C299.97 144.897 302.035 145.076 302.65 143.883C303.264 142.691 301.919 141.113 299.229 137.958L280 115.401V10C280 4.47715 275.523 0 270 0H10Z"/></mask><path d="M255.125 141L255.214 140.004L255.17 140H255.125V141ZM255.778 141.057L255.865 140.061L255.865 140.061L255.778 141.057ZM295.839 144.538L295.753 145.534L295.753 145.534L295.839 144.538ZM302.65 143.883L301.761 143.425L301.761 143.425L302.65 143.883ZM299.229 137.958L298.468 138.606L298.468 138.606L299.229 137.958ZM280 115.401H279V115.769L279.239 116.05L280 115.401ZM1 10C1 5.02943 5.02944 1 10 1V-1C3.92487 -1 -1 3.92486 -1 10H1ZM1 131V10H-1V131H1ZM10 140C5.02943 140 1 135.971 1 131H-1C-1 137.075 3.92486 142 10 142V140ZM255.125 140H10V142H255.125V140ZM255.865 140.061C255.637 140.041 255.421 140.022 255.214 140.004L255.036 141.996C255.246 142.015 255.465 142.034 255.692 142.054L255.865 140.061ZM295.926 143.541L255.865 140.061L255.692 142.054L295.753 145.534L295.926 143.541ZM301.761 143.425C301.72 143.504 301.573 143.737 300.51 143.794C299.488 143.848 298.024 143.724 295.926 143.541L295.753 145.534C297.785 145.71 299.419 145.855 300.617 145.791C301.772 145.729 302.965 145.455 303.539 144.341L301.761 143.425ZM298.468 138.606C299.835 140.21 300.786 141.329 301.335 142.193C301.905 143.092 301.801 143.347 301.761 143.425L303.539 144.341C304.113 143.228 303.643 142.097 303.023 141.121C302.38 140.109 301.314 138.861 299.99 137.309L298.468 138.606ZM279.239 116.05L298.468 138.606L299.99 137.309L280.761 114.752L279.239 116.05ZM279 10V115.401H281V10H279ZM270 1C274.971 1 279 5.02944 279 10H281C281 3.92487 276.075 -1 270 -1V1ZM10 1H270V-1H10V1Z" fill="black" mask="url(#path-1-inside-1_118_11)"/></svg>
							<img class="goni-img" src="/resources/img/goni.png" alt="">
						</div>
					</div>
					<div class="d-grid p-3">
						<a class="btn btn-secondary btn-block" id="btn_check_out" onclick="javascript:btnCheckOutClick()">결제하기</a>
					</div>
				</div>
			</div>
		</div>
	</form>
	
	
<form id="inicisSendForm" method="post">
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

		
	<!-- todo wonho 로컬테스트 -->
	<%-- 
	<input type="hidden" name="returnUrl" value="https://localhost:8080/order/inicisPayReturn.do">
	<input type="hidden" name="closeUrl" value="https://localhost:8080/order/inicisPayClose.do?id=<%=oid%>">
	 --%>
	<!-- todo wonho 운영 -->
	<input type="hidden" name="returnUrl" value="https://hwcommander.com/order/inicisPayReturn.do">
	<input type="hidden" name="closeUrl" value="https://hwcommander.com/order/inicisPayClose.do?id=<%=oid%>">
</form>

</body>
</html>
