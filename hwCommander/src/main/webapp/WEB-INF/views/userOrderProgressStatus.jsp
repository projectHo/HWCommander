<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 주문진핸현황</title>
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
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<!-- 작업영역 -->
			<div class="estimateCalc_background pt-5 pb-5" style="width: 70% !important">
				<div class="mb-3 ps-5 ms-5">
					<span class="user-name fs-2">12</span>
					<b class="fs-2">님의 진행현황</b>
					<p>※ 상태가 배송단계로 넘어갔을 경우 배송지 변경은 불가능합니다!! ※</p>
					<span>주문 제품 명 : </span>
					<b>122</b>
				</div>
				<div class="d-flex align-items-center">
					<div class="progress" style="height: 8px; width: 8%;">
						<div class="progress-bar bg-info" role="progressbar" aria-label="Success example" style="width: 100%; border: 1px solid gray;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="border: 1px solid gray;"></div>
					</div>
					<div class="box text-center d-flex align-items-center justify-content-center" style="font-size: 12px; width: 12%; height: 60px; background-color: #5CACEE;border-radius: 12px; box-shadow: 2px 2px 2px 2px gray; z-index: 99;">
						<span class="fw-bold text-white">청약철회 및<br>소프트웨어<br>조항 동의 완료</span>
					</div>
					<div class="progress" style="height: 8px; width: 4%;">
						<div class="progress-bar bg-success" role="progressbar" aria-label="Success example" style="width: 100%; border: 1px solid gray;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="border: 1px solid gray;"></div>
					</div>
					<div class="box text-center d-flex align-items-center justify-content-center" style="width: 12%; height: 60px; background-color: #5CACEE;border-radius: 12px; box-shadow: 2px 2px 2px 2px gray; z-index: 99;">
						<span class="fw-bold text-white">결제 완료</span>
					</div>
					<div class="progress" style="height: 8px; width: 4%;">
						<div class="progress-bar bg-info" role="progressbar" aria-label="Success example" style="width: 100%; border: 1px solid gray;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="border: 1px solid gray;"></div>
					</div>
					<div class="box text-center d-flex align-items-center justify-content-center" style="width: 12%; height: 60px; background-color: #5CACEE;border-radius: 12px; box-shadow: 2px 2px 2px 2px gray; z-index: 99;">
						<span class="fw-bold text-white">제품 공수 중</span>
					</div>
					<div class="progress" style="height: 8px; width: 4%;">
						<div class="progress-bar bg-danger" role="progressbar" aria-label="Success example" style="width: 100%; border: 1px solid gray;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="border: 1px solid gray;"></div>
					</div>
					<div class="box text-center d-flex align-items-center justify-content-center" style="width: 12%; height: 60px; background-color: #5CACEE;border-radius: 12px; box-shadow: 2px 2px 2px 2px gray; z-index: 99;">
						<span class="fw-bold text-white">조립 중</span>
					</div>
					<div class="progress" style="height: 8px; width: 4%;">
						<div class="progress-bar bg-info" role="progressbar" aria-label="Success example" style="width: 100%; border: 1px solid gray;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="border: 1px solid gray;"></div>
					</div>
					<div class="box text-center d-flex align-items-center justify-content-center" style="width: 12%; height: 60px; background-color: #5CACEE;border-radius: 12px; box-shadow: 2px 2px 2px 2px gray; z-index: 99;">
						<span class="fw-bold text-white">시스템 구성 중</span>
					</div>
					<div class="progress" style="height: 8px; width: 4%;">
						<div class="progress-bar bg-success" role="progressbar" aria-label="Success example" style="width: 100%; border: 1px solid gray;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="border: 1px solid gray;"></div>
					</div>
					<div class="box text-center d-flex align-items-center justify-content-center" style="width: 12%; height: 60px; background-color: #5CACEE;border-radius: 12px; box-shadow: 2px 2px 2px 2px gray; z-index: 99;">
						<span class="fw-bold text-white">출고</span>
					</div>
					<div class="progress" style="height: 8px; width: 4%;">
						<div class="progress-bar bg-danger" role="progressbar" aria-label="Success example" style="width: 100%; border: 1px solid gray;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="border: 1px solid gray;"></div>
					</div>
					<div class="box text-center d-flex align-items-center justify-content-center" style="width: 12%; height: 60px; background-color: #5CACEE;border-radius: 12px; box-shadow: 2px 2px 2px 2px gray; z-index: 99;">
						<span class="fw-bold text-white">지역배송 출발</span>
					</div>
					<div class="progress" style="height: 8px; width: 4%;">
						<div class="progress-bar bg-info" role="progressbar" aria-label="Success example" style="width: 100%; border: 1px solid gray;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="border: 1px solid gray;"></div>
					</div>
					<div class="box text-center d-flex align-items-center justify-content-center" style="width: 12%; height: 60px; background-color: #5CACEE;border-radius: 12px; box-shadow: 2px 2px 2px 2px gray; z-index: 99;">
						<span class="fw-bold text-white">도착</span>
					</div>
					<div class="progress" style="height: 8px; width: 8%;">
						<div class="progress-bar bg-success" role="progressbar" aria-label="Success example" style="width: 100%; border: 1px solid gray;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" style="border: 1px solid gray;"></div>
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
