<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 견적산출</title>
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

<!-- 09.08 date picker js css 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.min.css" integrity="sha512-aQb0/doxDGrw/OC7drNaJQkIKFu6eSWnVMAwPN64p6sZKeJ4QCDYL42Rumw2ZtL8DB9f66q4CnLIUnAw28dEbg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.standalone.min.css" integrity="sha512-t+00JqxGbnKSfg/4We7ulJjd3fGJWsleNNBSXRk9/3417ojFqSmkBfAJ/3+zpTFfGNZyKxPVGwWvaRuGdtpEEA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script>
	$(function(){
		$("#select-modal").modal("show");
		$(".modal-footer").css("display","none");
	})

	function modalNew(){
		location.href = "/ESCA/ESCA_00_ver_1_0.do";
	}
	function modalPrev(){
		$(".modal-footer").css("display","block");
		$('#datepicker-input').datepicker({
			language: 'ko', // 한국어 번역 설정
			format: 'yyyy-mm-dd', // 날짜 형식 (년-월-일)
			startDate: '2023-03-01', // 시작 날짜 설정
			endDate: new Date(), // 현재 날짜까지만 선택 가능하도록 설정
			autoclose: true, // 선택 후 자동으로 닫히도록 설정
		});
	}
	function modalReturn(){
		location.href = "/";
	}
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	<div class="modal fade" id="select-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
			<div class="modal-header justify-content-center">
			  <h1 class="modal-title fs-5 pt-2">저희 홈페이지에서 견적산출을 해본 적 있으신가요?</h1>
			</div>
			<div class="modal-body pt-0">
				<div class="row mb-2 mt-2 border-bottom align-items-center">
					<div class="col-md-3 text-center"><button type="button" class="btn btn-primary pb-0" onclick="javascript:modalNew()">새로하기</button></div>
					<div class="col-md-9">처음 이용하시거나 과거 견적산출이 필요 없으신 경우 새로 진행합니다.</div>
				</div>
				<div class="row mb-2 border-bottom align-items-center">
					<div class="col-md-3 text-center"><button type="button" class="btn btn-primary pb-0" onclick="javascript:modalPrev()">과거기준</button></div>
					<div class="col-md-9">견적산출을 했던 날짜를 선택합니다. 날짜 기준으로 다시 견적산출을 진행합니다.</div>
				</div>
				<div class="row align-items-center">
					<div class="col-md-3 text-center"><button type="button" class="btn btn-primary pb-0" onclick="javascript:modalReturn()">돌아가기</button></div>
					<div class="col-md-9 pt-2">홈페이지로 이동합니다</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="form-group">
					<label for="datepicker-input">날짜 선택:</label>
					<input type="text" id="datepicker-input" class="form-control">
				</div>
			</div>
		  </div>
		</div>
	  </div>
	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<!-- 작업영역 -->
			<div class="estimateCalc_background p-5" style="width: 70% !important">
				<div class="container">
					
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
