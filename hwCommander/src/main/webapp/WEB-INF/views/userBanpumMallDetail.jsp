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

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

<!-- 10.25 swiper 추가 & 단독 css 추가 -->
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<link rel="stylesheet" href="/resources/css/banpumMallDetail.css">
<script>
    $(function() {
		var swiper = new Swiper(".mySwiper", {
			grabCursor: true,
			pagination: {
				el: ".swiper-pagination",
				dynamicBullets: true,
			},
		});
    });
    
function goTermsOfService() {
	location.href = "/termsOfService.do";
}
    
function goCart() {
	alert("준비중");
}

function goDirectOrder() {
	if(loginCheck()) {
		location.href = "/order/sheet.do?accessRoute=direct&banpumMallIds="+"${banpumMaster.id}";
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
								  <div class="swiper mySwiper">
									<div class="swiper-wrapper">
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage1}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage2}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage3}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage4}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage5}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage6}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage7}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage8}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage9}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage10}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage11}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage12}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage13}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage14}" alt="">
										</div>
										<div class="swiper-slide">
											<img src="${banpumMaster.banpumImage15}" alt="">
										</div>
									</div>
									<div class="swiper-pagination"></div>
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
										<button class="btn btn-primary btn-lg me-md-2" type="button" onclick="javascript:goCart()">장바구니</button>
										<button class="btn btn-primary btn-lg" type="button" onclick="javascript:goDirectOrder()">주문하기</button>
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
