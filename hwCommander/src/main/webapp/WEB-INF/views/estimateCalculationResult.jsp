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
	function clickOrderBtn() {
		alert("미구현");
	}
	function clickCaptureBtn(){
		alert("미구현");
	}
	function clickSaveBtn(){
		alert("미구현");
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
			<div class="estimateCalc_background" style="width: 70% !important">
				<div class="row p-5">
					<div class="row w-25">
						<div class="input-group mb-3 w-50">
							<input type="text" class="form-control" aria-label="Text input with checkbox" value="ID : example" style="background-color: #fff;" disabled>
						</div>
					</div>
					<div class="row" style="height: 800px;"></div>
				</div>
				<div class="row pb-5 pe-5">
					<div class="col-4"></div>
					<div class="col">
						<button type="button" class="form-control" onclick="javascript:clickOrderBtn()">주문하기</button>
					</div>
					<div class="col">
						<button type="button" class="form-control" onclick="javascript:clickOrderBtn()">주문하기</button>
					</div>
					<div class="col">
						<button type="button" class="form-control" onclick="javascript:clickCaptureBtn()">캡쳐하기</button>
					</div>
					<div class="col">
						<button type="submit" class="form-control" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="질문에 대한 답변들을 저장합니다. 추후 견적 산출시 현재 견적과 다를 수 있으니 참고 부탁드립니다!!" onclick="javascript:clickSaveBtn()">질문저장</button>
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
