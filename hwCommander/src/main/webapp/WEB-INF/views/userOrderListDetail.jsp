<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 주문내역</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css" />
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

<!-- 23.07.15 다음 카카오 map api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	// 데이터 불러오기
	var Pattern = /\((.*?)\)/;
	var masterInfoMatch = Pattern.exec("${orderMasterVO}");
	var masterInfoValues = masterInfoMatch[1];

	var masterInfoArray = masterInfoValues.split(", ");
	var masterInfoObject = {};
	for (var i = 0; i < masterInfoArray.length; i++) {
		var keyValue = masterInfoArray[i].split("=");
		var key = keyValue[0];
		var value = keyValue[1];
		masterInfoObject[key] = value;
	}
	console.log(masterInfoObject);
	function loadData(){
		$(".order-num").html(masterInfoObject.id);
		$(".order-date").html(masterInfoObject.orderDateStr);
		$(".orderer-name").html(masterInfoObject.ordererName);
		$(".order-state").html(masterInfoObject.orderStateCdNm);
		$(".orderer-hp").html(masterInfoObject.ordererHpNumber.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3"));
		$(".orderer-email").html(masterInfoObject.ordererMail);
		$(".recipient-name").html(masterInfoObject.recipientName);
		$(".recipient-hp").html(masterInfoObject.recipientHpNumber.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3"));
		$(".recipient-next-hp").val(masterInfoObject.recipientHpNumber2.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3"));
		$(".recipient-zip-code").val(masterInfoObject.recipientZipcode);
		$(".recipient-jibun-addr").val(masterInfoObject.recipientJibunAddr);
		$(".recipient-road-addr").val(masterInfoObject.recipientRoadAddr);
		$(".recipient-detail-addr").val(masterInfoObject.recipientDetailAddr);
		$(".order-req").val(masterInfoObject.orderRequest);
		$(".delivery-req").val(masterInfoObject.deliveryRequest);
		$(".waybill").html(masterInfoObject.waybillNumber);
		$(".payment-meth").html(masterInfoObject.paymentMethod);
		$(".tot-order-price").html(masterInfoObject.totOrderPriceStr + "원")
	};
	// 다음 지도
	function findDaumAddr() {
	new daum.Postcode({
        oncomplete: function(data) {
            $(".recipient-zip-code").val(data.zonecode);
            $(".recipient-jibun-addr").val(data.jibunAddress);
            $(".recipient-road-addr").val(data.roadAddress);
            $(".recipient-detail-addr").val("");
        }
    }).open();
}
	// 수정버튼
	function editHpBtn(){
		$.ajax({
			type: "post",
			url: "/user/orderUpdateRecipientHpNumber2Logic.do",
			data: {
				id: $(".order-num").html(),
				recipientHpNumber2: $(".recipient-next-hp").val()
			},
			dataType: "json",
			success: function(response) {
				console.log("데이터 수정 성공!");
				console.log(response);
			},
			error: function(xhr, status, error) {
				console.error("데이터 수정 실패:", error);
			}
		});
	}
	
	function editAddrBtn(){
		findDaumAddr();
	}

	function saveAddrBtn(){
		$.ajax({
			type: "post",
			url: "/user/orderUpdateAddrsLogic.do",
			data: {
				id: $(".order-num").html(),
				recipientJibunAddr: $(".recipient-jibun-addr").val(),
				recipientRoadAddr: $(".recipient-road-addr").val(),
				recipientDetailAddr: $(".recipient-detail-addr").val(),
				recipientZipcode: $(".recipient-zip-code").val()
			},
			dataType: "json",
			success: function(response) {
				console.log("데이터 수정 성공!");
				console.log(response);
			},
			error: function(xhr, status, error) {
				console.error("데이터 수정 실패:", error);
			}
		});
	}
	
	function editOrderReqBtn(){
		$.ajax({
			type: "post",
			url: "/user/orderUpdateOrderRequest.do",
			data: {
				id: $(".order-num").html(),
				orderRequest: $(".order-req").val()
			},
			dataType: "json",
			success: function(response) {
				console.log("데이터 수정 성공!");
				console.log(response);
			},
			error: function(xhr, status, error) {
				console.error("데이터 수정 실패:", error);
			}
		});
	}
	
	function editDeliveryReqBtn(){
		$.ajax({
			type: "post",
			url: "/user/orderUpdateDeliveryRequest.do",
			data: {
				id: $(".order-num").html(),
				deliveryRequest: $(".delivery-req").val()
			},
			dataType: "json",
			success: function(response) {
				console.log("데이터 수정 성공!");
				console.log(response);
			},
			error: function(xhr, status, error) {
				console.error("데이터 수정 실패:", error);
			}
		});
	}
	
	function requestVideoBtn(){
		$.ajax({
			type: "post",
			url: "/user/orderVideoRequestToAdminLogic.do",
			data: {
				id: $(".order-num").html()
			},
			dataType: "json",
			success: function(response) {
				console.log("데이터 수정 성공!");
				console.log(response);
			},
			error: function(xhr, status, error) {
				console.error("데이터 수정 실패:", error);
			}
		});
	}
	function requestRefundBtn(){
		$.ajax({
			type: "post",
			url: "/user/orderRefundRequestToAdminLogic.do",
			data: {
				id: $(".order-num").html()
			},
			dataType: "json",
			success: function(response) {
				console.log("데이터 수정 성공!");
				console.log(response);
			},
			error: function(xhr, status, error) {
				console.error("데이터 수정 실패:", error);
			}
		});
	}

	function checkHp(){
		const numberCheck = /^[0-9]+$/;
		if($('.recipient-next-hp').val().trim() == "" || $('.recipient-next-hp').val().trim() == null) {
			alert("휴대폰번호를 입력하세요.");
			$('.recipient-next-hp').focus();
		}
	
		if (!numberCheck.test($('.recipient-next-hp').val())) {
			alert("휴대폰번호는 숫자만 입력 가능합니다.");
			$('.recipient-next-hp').val("");
			$('.recipient-next-hp').focus();
		}
	}
	$(function(){
		loadData();
		var Pattern = /\((.*?)\)/;
		var userInfoMatch = Pattern.exec("${loginUser}");
		var userInfoValues = userInfoMatch[1];

		var userInfoArray = userInfoValues.split(", ");
		var userInfoObject = {};
		for (var i = 0; i < userInfoArray.length; i++) {
			var keyValue = userInfoArray[i].split("=");
			var key = keyValue[0];
			var value = keyValue[1];
			userInfoObject[key] = value;
		}
		$(".user-name").html(userInfoObject.name);
		if($(".order-state").html() == "출고" || $(".order-state").html() == "배송 출발" || $(".order-state").html() == "배송 완료"){
			$(".btn-s").attr("data-bs-toggle","tooltip").attr("data-bs-placement","right").attr("data-bs-title","배송 단계부터는 수정이 불가능합니다!").css("cursor","not-allowed").attr("onclick","");
		}

		// 부트스트랩 툴팁
		const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
		const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
	})
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<!-- 작업영역 -->
			<div class="estimateCalc_background p-5" style="width: 70% !important">
				<div class="container">
					<div class="buttons mb-3 d-flex justify-content-md-between">
						<h2 class="mb-3">
							<span class="user-name"></span>
							<b>님의 주문 상세내역</b>
						</h2>
						<div class="mt-2">
							<button class="btn btn-outline-success me-md-2" type="button" onclick="javascript:requestVideoBtn()">영상 요청</button>
							<button class="btn btn-outline-danger" type="button" onclick="javascript:requestRefundBtn()">환불 요청</button>
						</div>	
					</div>
					<table class="table table-secondary table-bordered" style="border-collapse: separate;">
						<tbody>
								<tr>
									<th style="width: 20%;" scope="row">주문번호</th>
									<td style="width: 30%;" class="order-num"></td>
									<th style="width: 20%;">주문날짜</th>
									<td style="width: 30%;" class="order-date"></td>
								</tr>
								<tr>
									<th style="width: 20%;" scope="row">주문자</th>
									<td style="width: 30%;" class="orderer-name"></td>
									<th style="width: 20%;">결제상태</th>
									<td style="width: 30%;" class="order-state"></td>
								</tr>
								<tr>
									<th style="width: 20%;" scope="row">연락처</th>
									<td style="width: 30%;" class="orderer-hp"></td>
									<th style="width: 20%;">이메일 주소</th>
									<td style="width: 30%;" class="orderer-email"></td>
								</tr>
						</tbody>
					</table>
					<table class="table table-secondary table-bordered" style="border-collapse: separate;">
						<thead>
							<tr>
								<th scope="col" style="width: 20%;">수령인</th>
								<th scope="col" style="font-weight: 400;" class="recipient-name"></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">연락처</th>
								<td class="recipient-hp"></td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">추가 연락처</th>
								<td>
									<div class="input-group">
										<input maxlength="11" type="text" class="form-control recipient-next-hp" aria-label="Recipient's another hpNumber" aria-describedby="button-addon" oninput="javascript:checkHp()">
										<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon" onclick="javascript:editHpBtn()">저장</button>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">주소</th>
								<td>
									<div class="input-group">
										<input type="text" class="form-control recipient-zip-code" aria-label="Recipient's addr" aria-describedby="button-addon2" readonly="readonly">
										<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon2" onclick="javascript:editAddrBtn()">찾기</button>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">지번주소</th>
								<td>
									<input type="text" class="form-control recipient-jibun-addr" aria-label="Recipient's Ji addr" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">도로명주소</th>
								<td>
									<input type="text" class="form-control recipient-road-addr" aria-label="Recipient's Road addr" readonly="readonly">
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">상세주소</th>
								<td>
									<div class="input-group">
										<input type="text" class="form-control recipient-detail-addr" aria-label="Recipient's Detail addr" aria-describedby="button-addon3">
										<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon3" onclick="javascript:saveAddrBtn()">저장</button>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">주문 시 요청사항</th>
								<td>
									<div class="input-group">
										<input type="text" class="form-control order-req" aria-label="Recipient's order required" aria-describedby="button-addon4">
										<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon4" onclick="javascript:editOrderReqBtn()">저장</button>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">배송 시 요청사항</th>
								<td>
									<div class="input-group">
										<input type="text" class="form-control delivery-req" aria-label="Recipient's delivery required" aria-describedby="button-addon5">
										<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon5" onclick="javascript:editDeliveryReqBtn()">저장</button>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">상태</th>
								<td class="order-state"></td>
							</tr>
							<tr>
								<th scope="row">결제 수단</th>
								<td class="payment-meth"></td>
							</tr>
							<tr>
								<th class="align-middle" scope="row">결제 금액</th>
								<td class="tot-order-price"></td>
							</tr>
						</tbody>
					</table>
					<div class="d-flex align-items-center justify-content-center">
						
					</div>
				</div>
	 		</div>
			
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 15%!important;"></div>
		</div>
		
		<!-- 2022.11.16 디자인이미지 추가 -->
		<div class="mt-5 mx-5" style="height: 15%!important;">
			<img class="img-fluid float-end" src="/resources/img/layer-34-1200x107.png" alt="">
		</div>
		<div class="mt-2 mx-5" style="height: 15%!important;">
			<img class="img-fluid" src="/resources/img/layer-26.png" alt="">
		</div>
	</div>
	
	<%@ include file="./common/footer.jsp" %>
</body>
</html>
