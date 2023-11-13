<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 반품몰 상세</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/resources/css/banpumMallDetail.css">
<script>

	let aa = "${banpumMaster}";
    $(function() {

    });
    
function goTermsOfService() {
	location.href = "/termsOfService.do";
}
    
function goCart() {
	alert("준비중");
}

function goDirectOrder() {
	if(loginCheck()) {
		location.href = "/order/sheet.do?accessRoute=banpum&productIds="+"${banpumMaster.id}&orderQtys="+ $("#orderQtys").val() +"&boxQtys=" + $("#boxQtys").val();
	}
}

function loginCheck() {
	var check = false;
	if("${loginUser}" == "") {
		alert("로그인 후 이용해주세요.");
		location.href = "/user/login.do";
	}else {
		check = true;
	}
	return check;
}
function onOrder(){
	if("${banpumMaster.banpumQty}" > 1){
		$("#banpumQModal").modal("show");
	}else if("${banpumMaster.banpumQty}" == 1){
		$("#banpumSModal").modal("show");
	}
}
function goSingleOrder(el){
	if(loginCheck()) {
		location.href = "/order/sheet.do?accessRoute=banpum&productIds="+"${banpumMaster.id}&orderQtys=1"+"&boxQtys="+$(el).attr("box");
	}
}
const numberCheck = /^[0-9]+$/;	
function orderQtysCheck(el){
	if($(el).val().length>=1){
		if(!numberCheck.test($(el).val())){
			alert("숫자만 입력해주세요!");
			$(el).val("").focus();
		}else if($(el).val() > Number("${banpumMaster.banpumQty}")){
			$(el).val("${banpumMaster.banpumQty}");
			$(el).next("p").addClass("show");
			setTimeout(() => {
				$(el).next("p").removeClass("show");
			}, 2000);
		}
	}
}
let orderQtys = $("#orderQtys").val();
function boxQtysCheck(el){
	orderQtys = $("#orderQtys").val();
	if($(el).val().length>=1){
		if(!numberCheck.test($(el).val())){
			alert("숫자만 입력해주세요!");
			$(el).val("").focus();
		}else if($(el).val() > Number(orderQtys)){
			$(el).val(orderQtys);
			$(el).next("p").html("주문수량이 " + orderQtys + "개 입니다").addClass("show");
			setTimeout(() => {
				$(el).next("p").removeClass("show");
			}, 2000);
		}
	}
}
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			
			<!-- 본문영역 -->
			<div style="width: 70%!important;">
				<div class="w-100 row align-items-center mt-4 mb-4">
					<div class="card mb-4 pt-5 pb-3 estimateCalc_background">
						<div class="card-body">				
							<div class="container">
							  <div class="row">
							    <div class="col-5" id="images">
							    <!-- 임시 몰루이미지
							      <img class="img-fluid rounded mx-auto d-block" src="/resources/img/tempImage_600x600.png">
							     -->  
									<div id="banpumMallDetailIndicators" class="carousel carousel-dark slide" data-bs-ride="true">
										<div class="carousel-indicators">
											<button type="button" data-bs-target="#banpumMallDetailIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
											<c:forEach var="i" begin="2" end="15">
												<c:set var="key" value="banpumImage${i}" />
												<c:if test="${not empty banpumMaster[key]}">
													<button type="button" data-bs-target="#banpumMallDetailIndicators" data-bs-slide-to="${i-1}" aria-label="Slide ${i}"></button>
												</c:if>
											</c:forEach>
										</div>
										<div class="carousel-inner">
											<div class="carousel-item active">
												<img src="${banpumMaster.banpumImage1}" class="d-block w-100 h-100" alt="...">
											</div>
											<c:forEach var="i" begin="2" end="15">
												<c:set var="key" value="banpumImage${i}" />
												<c:if test="${not empty banpumMaster[key]}">
													<div class="carousel-item">
														<img src="${banpumMaster[key]}" class="d-block w-100 h-100" alt="...">
													</div>
												</c:if>
											</c:forEach>
										</div>
										<button class="carousel-control-prev" type="button" data-bs-target="#banpumMallDetailIndicators" data-bs-slide="prev">
											<span class="carousel-control-prev-icon" aria-hidden="true"></span>
											<span class="visually-hidden">Previous</span>
										</button>
										<button class="carousel-control-next" type="button" data-bs-target="#banpumMallDetailIndicators" data-bs-slide="next">
											<span class="carousel-control-next-icon" aria-hidden="true"></span>
											<span class="visually-hidden">Next</span>
										</button>
									</div>
							    </div>
							    <div class="col-7">
							    	<p class="h1 mb-4">${banpumMaster.banpumName}</p>
							    	<p class="h3 mb-4">가격 : ${banpumMaster.banpumPriceStr}</p>
							    	<p class="h3">상세 정보</p>
									<p class="h5 mb-4">${banpumMaster.banpumDescriptionStr}</p>
							    	<p class="h4">배송 기간 : 영업일 기준 약 2일 소요</p>
							    	<p class="h4">택배사 : 우체국 택배</p>
							    	<p class="h4 mb-3">배송비 : 무료</p>
							    	<p class="h6">도서산간 지역의 경우 배송이 제한되거나 추가요금이 발생할 수 있습니다.</p>
							    	<p class="h6">﻿AS 기준은 각 부품의 유통사 규정에 따르며 해당 쇼핑몰에서 1년간 무상 AS를 지원해드립니다.</p>
							    </div>
							  </div>
							  <div class="row">
							    <div class="col-5">
							    	<!-- <p class="h3 mt-3 mb-3">제품 상세 정보</p>
									<p class="h3 mb-5">${banpumMaster.banpumDescriptionStr}</p> -->
							    </div>
							    <div class="col-7">
							    </div>
							  </div>
							  
							  <!-- 버튼부 -->
							  <div class="row">
							    <div class="col-5">
							    </div>
							    <div class="col-7 mb-3">
									<div class="d-grid gap-2 d-md-flex justify-content-md-end">
										<button class="btn btn-primary btn-lg me-md-2" type="button" onclick="javascript:goTermsOfService()">이용약관</button>
										<!-- <button class="btn btn-primary btn-lg me-md-2" type="button" onclick="javascript:goCart()">장바구니</button> -->
										<button class="btn btn-primary btn-lg" type="button" onclick="javascript:onOrder()">주문하기</button>
									</div>
							    </div>
							  </div>
							  
							  <!-- 수량 박스체크 모달 -->
							  <div class="modal fade" id="banpumQModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
								  <div class="modal-content">
									<div class="modal-header">
										<h2>주문 수량을 입력해주세요</h2>
									  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="row p-2">
											<div class="col">
												제품 수량
												<input type="text" class="form-control" id="orderQtys" placeholder="최대 ${banpumMaster.banpumQty}개" oninput="javascript:orderQtysCheck(this)">
												<p class="text-danger fade mt-2 mb-0">재고가 ${banpumMaster.banpumQty}개 입니다</p>
											</div>
											<div class="col">
												사용된 제품 박스
												<input type="number" class="form-control" id="boxQtys" placeholder="주문 수량 이하로 입력해주세요" oninput="javascript:boxQtysCheck(this)">
												<p class="text-danger fade mt-2 mb-0"></p>
											</div>
										</div>
									</div>
									<div class="modal-footer">
									  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
									  <button type="button" class="btn btn-primary" onclick="javascript:goDirectOrder()">주문하기</button>
									</div>
								  </div>
								</div>
							  </div>
							  <!-- 재고 1개 주문시 박스추가여부 모달 -->
							  <div class="modal fade" id="banpumSModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
								  <div class="modal-content">
									<div class="modal-header">
										<h2>주문하기</h2>
									  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div class="row p-2">
											사용된 제품들의 박스를 추가할까요?(5,000원)
										</div>
									</div>
									<div class="modal-footer">
									  <button type="button" class="btn btn-secondary" box="0" onclick="javascript:goSingleOrder(this)">아니요</button>
									  <button type="button" class="btn btn-primary" box="1" onclick="javascript:goSingleOrder(this)">네</button>
									</div>
								  </div>
								</div>
							  </div>
							</div>
						</div>
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
