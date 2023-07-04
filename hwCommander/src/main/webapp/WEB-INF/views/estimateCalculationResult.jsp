<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 견적산출 결과</title>
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

<script>
	function clickReturnBtn () {
		window.location.href = "estimateCalculationOne.do";
		sessionStorage.clear();
	}
	function clickOrderBtn() {
		alert("미구현");
	}
	function clickCaptureBtn(){
		alert("미구현");
	}
	function clickSaveBtn(){
		alert("미구현");
	}
	function clickChangeRam(e){
		const ramHtml = $(e).html();
		$(".ram-text").html(ramHtml);
		$(".change-ram-btn").html(ramHtml);
	}
	$(function() {
		const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();

		
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
				<div class="row">
					<div class="row w-25">
						<div class="input-group mb-3 w-50">
							<input type="text" class="form-control" aria-label="Text input with checkbox" value="ID : example" style="background-color: #fff;" disabled>
						</div>
					</div>
					<div class="row">
						<div class="card mb-3">
							<div class="row g-0">
							  <div class="col-md-4 pt-3 ps-2">
								<img src="..." class="img-fluid rounded-start" style="box-shadow: 1px 1px gray;"alt="...">
							  </div>
							  <div class="col-md-8">
								<div class="card-body">
									<h2 class="card-title mb-3 fw-bold">컴퓨터 이름</h2>
									<h4 class="card-title">제품 상세 정보</h4>
									<div class="container mb-3">
										<p class="card-text mb-0 fw-bold">가격 : <span class="fw-normal price-text">111</span></p>
										<p class="card-text mb-0 fw-bold">CPU : <span class="fw-normal cpu-text">111</span></p>
										<p class="card-text mb-0 fw-bold">Cooler : <span class="fw-normal cooler-text">111</span></p>
										<p class="card-text mb-0 fw-bold">MB : <span class="fw-normal mb-text">111</span></p>
										<p class="card-text mb-0 fw-bold">GPU : <span class="fw-normal gpu-text">111</span></p>
										<p class="card-text mb-0 fw-bold">SSD : <span class="fw-normal ssd-text">111</span></p>
										<p class="card-text mb-0 fw-bold">CASE : <span class="fw-normal case-text">111</span></p>
										<p class="card-text mb-0 fw-bold">PSU : <span class="fw-normal psu-text">111</span></p>
										<div class="row">
											<div class="col">
												<p class="card-text mb-0 fw-bold">RAM : <span class="fw-normal ram-text">기본 종류</span></p>
											</div>
											<div class="col">
												<div class="dropdown">
													<button class="btn btn-secondary dropdown-toggle change-ram-btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
														Ram 바꾸기
													</button>
													<ul class="dropdown-menu">
													<li><button class="dropdown-item" type="button" onclick="javascript:clickChangeRam(this)">램종류1</button></li>
													<li><button class="dropdown-item" type="button" onclick="javascript:clickChangeRam(this)">램종류2</button></li>
													<li><button class="dropdown-item" type="button" onclick="javascript:clickChangeRam(this)">램종류3</button></li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									<h4 class="card-title">제품 설명</h4>
									<div class="container mb-3">
										<p class="card-text fw-bold">제품설명블라블라</p>
									</div>
									<h4 class="card-title">배송 정보</h4>
									<div class="container mb-3">
										<p class="card-text mb-0 fw-bold">배송기간 : <span class="fw-normal delivery-period">1달</span></p>
										<p class="card-text mb-0 fw-bold">택배사 : <span class="fw-normal delivery-period">로젠통운</span></p>
										<p class="card-text mb-0 fw-bold">배송비 : <span class="fw-normal delivery-period">30,000원</span></p>
										<p class="card-text mb-0 fw-bold"><small class="text-muted">도서산간 지역의 경우 배송이 제한되거나 추가요금이 발생할 수 있습니다.</small></p>
										<p class="card-text"><small class="text-muted">AS 기준은 각 부품의 유통사 규정에 따르며 해당 쇼핑몰에서 1년간 무상 AS를 지원해드립니다.</small></p>
									</div>
								</div>
							  </div>
							</div>
						  </div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<button type="button" class="form-control" onclick="javascript:clickReturnBtn()">다시하기</button>
					</div>
					<div class="col-3"></div>
					<div class="col">
						<button type="button" class="form-control" onclick="javascript:clickOrderBtn()">주문하기</button>
					</div>
					<div class="col">
						<button type="button" class="form-control" onclick="javascript:clickCaptureBtn()">캡쳐하기</button>
					</div>
					<div class="col">
						<button type="submit" class="form-control" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="질문에 대한 답변들을 저장합니다. 추후 견적 산출시 현재 견적과 다를 수 있으니 참고 부탁드립니다!!" onclick="javascript:clickSaveBtn()">질문저장</button>
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
