<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 견적저장소</title>
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
	$(function(){
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
				<h1 class="d-flex justify-content-center mb-2">견적 저장소</h1>
				<h5 class="d-flex justify-content-center mb-5">※ 저장은 총 50개까지 가능합니다.</h5>
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col" class="col-1 border-end">#</th>
							<th scope="col" class="col-9 border-end">견적 내용</th>
							<th scope="col" class="col-2">선택</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row" class="border-end pt-4">
								1
								<br>
								<div class="version mt-2 border-top pt-2">ver.01</div>
							</th>
							<td class="border-end">내용ㅇ용ㅇ오옹</td>
							<td class="d-flex flex-column gap-2">
								<button class="btn btn-outline-primary">
									견적 산출하기
								</button>
								<button class="btn btn-outline-danger">
									삭제
								</button>
							</td>
						</tr>
						<tr>
							<th scope="row" class="border-end pt-4">
								2
								<br>
								<div class="version mt-2 border-top pt-2">ver.02</div>
							</th>
							<td class="border-end">내용ㅇ용ㅇ오옹2222222222</td>
							<td class="d-flex flex-column gap-2">
								<button class="btn btn-outline-primary">
									견적 산출하기
								</button>
								<button class="btn btn-outline-danger">
									삭제
								</button>
							</td>
						</tr>
						<tr>
							<th scope="row" class="border-end pt-4">
								3
								<br>
								<div class="version mt-2 border-top pt-2">ver.01</div>
							</th>
							<td class="border-end">내용ㅇ용ㅇ오옹333333333333333333333</td>
							<td class="d-flex flex-column gap-2">
								<button class="btn btn-outline-primary">
									견적 산출하기
								</button>
								<button class="btn btn-outline-danger">
									삭제
								</button>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- <div class="row source border-top border-bottom p-2">
					<div class="col-1 border-end d-flex align-items-center justify-content-center">
						1
					</div>
					<div class="col-9 border-end">
						<div class="my-auto">
							견적 내용(url parameter / login ver.)
						</div>
					</div>
					<div class="col-2 d-flex flex-column gap-2">
						<button class="btn btn-primary">
							견적 산출하기
						</button>
						<button class="btn btn-danger">
							삭제
						</button>
					</div>
				</div> -->
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
