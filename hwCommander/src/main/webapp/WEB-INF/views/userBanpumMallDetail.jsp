<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 반품몰 상세</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap & jquery -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<link rel="stylesheet" href="/resources/css/ver_02/banpummallDetail.css">

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<script>
    $(function() {
    });
    
	function boxQtyCheckBox(){
		if($("#boxCheck").prop("checked") == true){
			$("#itemBoxQty").attr("value",1);
		}else if($("#boxCheck").prop("checked") == false){
			$("#itemBoxQty").attr("value",0);
		}
	}

	function goOrderSheet(){
		if(loginCheck()) {
			location.href = "/order/sheet.do?accessRoute=banpum&productIds=" + $("#itemId").val() + "&orderQtys=" + $("#itemQty").val() + "&boxQtys=" + $("#itemBoxQty").val();
		}
	}
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="w-100" style="background-color: #0F0F14;">
		<div class="container px-5 py-5">
			<div class="d-flex flex-column gap-5">
				<div class="d-flex justify-content-center align-items-center">
					<h2 class="fw-bold text-light">제품 상세</h2>
				</div>
				<div class="d-flex gap-5">
					<div class="w-50">
						<div class="banpummall-detail-item-box w-100 h-100">
							<div id="banpumMallDetailIndicators" class="carousel carousel-light slide" data-bs-ride="true" style="min-height: 500px;">
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
					</div>
					<div class="w-50 d-flex flex-column text-start text-light gap-2">
						<h3 class="fw-bold">${banpumMaster.banpumName}</h3>
						<h2 class="fw-bold">${banpumMaster.banpumPriceStr}</h2>
						<h6>택배배송* 영업일 기준 약 2일 소요 | 배송비 무료 [우체국 택배]</h6>
						<h5 class="mt-2 fw-semibold">상세정보</h5>
						<div class="d-flex flex-column">
							<h6 class="m-0">${banpumMaster.banpumDescriptionStr}</h6>
						</div>
						<div class="w-100 border-top my-2" style="border-color: #404040!important;"></div>

						<c:if test="${banpumMaster.banpumQty != 1}">
							<div class="d-flex flex-column gap-2">
								<h5 class="fw-semibold m-0 d-flex align-items-center">상품 수량&nbsp;<div class="fs-6">| 최대 <span>${banpumMaster.banpumQty}</span>개</div></h5>
								<div class="d-flex border border-1 mb-2" style="border-radius: 4px; border-color: #D3D3D3; height: 44px; min-width: 166px; max-width: 200px;">
									<div class="w-25 d-flex justify-content-center align-items-center btn" style="border-right: 1px solid #D3D3D3; border-radius: 0;">
										<svg width="17" height="3" viewBox="0 0 17 3" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd" d="M16.5 1.25C16.5 1.94036 15.9404 2.5 15.25 2.5L1.25 2.5C0.559644 2.5 -6.23395e-08 1.94036 -4.01598e-08 1.25C-1.79802e-08 0.559643 0.559644 -9.47993e-07 1.25 -9.06937e-07L15.25 -7.43391e-08C15.9404 -3.32827e-08 16.5 0.559644 16.5 1.25Z" fill="#D3D3D3"/>
										</svg>
									</div>
									<div class="w-50 d-flex justify-content-center align-items-center">
										<div class="w-100 d-flex justify-content-center align-items-center h-100">
											<input type="text" value="0" class="text-center form-control border-0 mx-1 bg-transparent text-white">
										</div>
									</div>
									<div class="w-25 d-flex justify-content-center align-items-center" style="background-color: #D3D3D3; cursor: pointer;">
										<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd" d="M10.25 2C10.25 1.30964 9.69036 0.75 9 0.75C8.30964 0.75 7.75 1.30964 7.75 2V7.41675H2C1.30964 7.41675 0.75 7.97639 0.75 8.66675C0.75 9.3571 1.30964 9.91675 2 9.91675H7.75V16C7.75 16.6904 8.30964 17.25 9 17.25C9.69036 17.25 10.25 16.6904 10.25 16V9.91675H16C16.6904 9.91675 17.25 9.3571 17.25 8.66675C17.25 7.97639 16.6904 7.41675 16 7.41675H10.25V2Z" fill="#0F0F14"/>
										</svg>
									</div>
								</div>
								<h5 class="fw-semibold m-0 d-flex align-items-center">박스 추가&nbsp;<div class="fs-6">| 최대 수량은 상품 수량을 넘을 수 없습니다</div></h5>
								<div class="d-flex border border-1" style="border-radius: 4px; border-color: #D3D3D3; height: 44px; min-width: 166px; max-width: 200px;">
									<div class="w-25 d-flex justify-content-center align-items-center btn" style="border-right: 1px solid #D3D3D3; border-radius: 0;">
										<svg width="17" height="3" viewBox="0 0 17 3" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd" d="M16.5 1.25C16.5 1.94036 15.9404 2.5 15.25 2.5L1.25 2.5C0.559644 2.5 -6.23395e-08 1.94036 -4.01598e-08 1.25C-1.79802e-08 0.559643 0.559644 -9.47993e-07 1.25 -9.06937e-07L15.25 -7.43391e-08C15.9404 -3.32827e-08 16.5 0.559644 16.5 1.25Z" fill="#D3D3D3"/>
										</svg>
									</div>
									<div class="w-50 d-flex justify-content-center align-items-center">
										<div class="w-100 d-flex justify-content-center align-items-center h-100">
											<input type="text" value="0" class="text-center form-control border-0 mx-1 bg-transparent text-white">
										</div>
									</div>
									<div class="w-25 d-flex justify-content-center align-items-center" style="background-color: #D3D3D3; cursor: pointer;">
										<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd" d="M10.25 2C10.25 1.30964 9.69036 0.75 9 0.75C8.30964 0.75 7.75 1.30964 7.75 2V7.41675H2C1.30964 7.41675 0.75 7.97639 0.75 8.66675C0.75 9.3571 1.30964 9.91675 2 9.91675H7.75V16C7.75 16.6904 8.30964 17.25 9 17.25C9.69036 17.25 10.25 16.6904 10.25 16V9.91675H16C16.6904 9.91675 17.25 9.3571 17.25 8.66675C17.25 7.97639 16.6904 7.41675 16 7.41675H10.25V2Z" fill="#0F0F14"/>
										</svg>
									</div>
								</div>
							</div>
							<div class="w-100 border-top my-2" style="border-color: #404040!important;"></div>
						</c:if>
						<c:if test="${banpumMaster.banpumQty == 1}">
							<div class="d-flex align-items-center gap-2">
								<input type="checkbox" id="boxCheck" class="form-check-input bg-dark m-0" onclick="javacript:boxQtyCheckBox()">
								<label for="boxCheck"><h6 class="m-0 d-flex align-items-center">사용된 제품 박스 추가(+5,000원)</h6></label>
							</div>
							<div class="w-100 border-top my-2" style="border-color: #404040!important;"></div>
						</c:if>

						<div class="d-flex flex-column">
							<h6>배송 주의사항*</h6>
							<div class="m-0" style="font-size: 12px;">도서산간 지역의 경우 배송이 제한되거나 추가요금이 발생할 수 있습니다.</div>
							<div class="m-0" style="font-size: 12px;">AS 기준은 각 부품의 유통사 규정에 따르며 해당 쇼핑몰에서 1년간 무상 AS를 지원해드립니다.</div>
						</div>
					</div>
				</div>
				<c:if test="${banpumMaster.banpumQty != 1}">
					<div class="d-flex justify-content-center align-items-center mb-5 gap-4">
						<button type="button" class="btn btn-secondary btn-lg fw-bold px-5" onclick="javascript:window.history.back()">뒤로가기</button>
						<button type="button" class="btn btn-primary btn-lg fw-bold px-5" onclick="javascript:goOrderSheet()">주문하기</button>
					</div>
				</c:if>
				<c:if test="${banpumMaster.banpumQty == 1}">
					<div class="d-flex justify-content-center align-items-center mb-5 gap-4">
						<button type="button" class="btn btn-secondary btn-lg fw-bold px-5" onclick="javascript:window.history.back()">뒤로가기</button>
						<button type="button" class="btn btn-primary btn-lg fw-bold px-5" onclick="javascript:goOrderSheet()">주문하기</button>
					</div>
				</c:if>

				<input type="hidden" id="itemId" name="itemId" value="${banpumMaster.id}">
				<input type="hidden" id="itemQty" name="itemQty" value="${banpumMaster.banpumQty}">
				<input type="hidden" id="itemBoxQty" name="itemBoxQty" value="0">
			</div>
		</div>
	</div>

	<%@ include file="./common/footer.jsp" %>
	
</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>
