<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 진행현황</title>
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
	$(function(){

	})
	function isValidEmail() {
		const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
		return emailRegex.test($(".e-mail-input").val());
	}
	function modalOpen(){
		if(isValidEmail()){
			$('#check-email').modal({ backdrop: 'static', keyboard: false }); 
			$("#check-email").modal('show');
			$("#check-email-modal-body").html($(".e-mail-input").val());
		}else {
			alert("이메일을 확인해주세요!");
			$(".e-mail-input").focus();
		}
	}
	function modalCancleBtn(){
		$(".e-mail-input").focus();
	}
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
				<!-- 클라우드 연동 전 -->
				<div class="container">
					<h2 class="mb-3">제품 상태 개봉 영상</h2>
					<div class="explane-box">
						<p>입력하신 이메일로 제품 개봉 영상을 보내드립니다!</p>
					</div>
					<div class="input-group w-50">
						<span class="input-group-text bg-white pe-1">
							<svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M4 7L10.94 11.3375C11.5885 11.7428 12.4115 11.7428 13.06 11.3375L20 7M5 18H19C20.1046 18 21 17.1046 21 16V8C21 6.89543 20.1046 6 19 6H5C3.89543 6 3 6.89543 3 8V16C3 17.1046 3.89543 18 5 18Z" stroke="#000000" stroke-width="0.624" stroke-linecap="round" stroke-linejoin="round"></path> </g></svg>
						</span>
						<input type="email" class="e-mail-input form-control border-start-0 pb-0" placeholder="e-mail을 입력해주세요">
						<button type="button" class="btn btn-secondary pb-0" id="enter-email" onclick="javascript:modalOpen()">메일입력</button>
					</div>
				</div>
				<!-- 클라우드 연동 후 -->
				
	 		</div>
			<!-- 이메일 확인 모달 -->
			<div class="modal fade" id="check-email" tabindex="-1" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
				  <div class="modal-content">
					<div class="modal-header">
					  <h1 class="modal-title fs-5">주소를 확인해주세요!</h1>
					  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
					  <p>입력된 E-mail</p>
					  <p id="check-email-modal-body"></p>
					</div>
					<div class="modal-footer">
					  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="javascript:modalCancleBtn()">수정</button>
					  <button type="button" class="btn btn-primary" id="modal-btn-check">저장</button>
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
