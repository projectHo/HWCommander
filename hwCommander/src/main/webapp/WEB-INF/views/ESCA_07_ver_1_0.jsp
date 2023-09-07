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

<!-- 08.31 url 파라메터 함수 js파일 분리 -->
<script src="/resources/js/escaSendData.js"></script>
<script>
	const loginUser = "${loginUser}";
	
	// donut
	let progress = 0;
	function animateDonutGauge() {
		$(".donut-container").css(
			"background",
			"conic-gradient(#df22ee 0% " + progress + "%, #f2f2f2 100% 0%)"
		);
		if (progress < 100) {
			progress += 5;
			setTimeout(animateDonutGauge, 20);
		} else {
			$(".donut-fill").html("7");
			goToZero();
		}
	};
	function goToZero() {
		$(".donut-container").css(
			"background",
			"conic-gradient(#df22ee 0% " + progress + "%, #f2f2f2 100% 0%)"
		);
		progress -= 3;
		if (progress > 0) {
			setTimeout(goToZero, 20);
		}
	};
	// typing question text
	let index = 0;
	function typeText() {
		const text = " 수냉쿨러를 선호하시나요?";
		if (index < text.length) {
		$("#typingInput").val(function(i, val) {
			return val + text.charAt(index);
		});
		index++;
		setTimeout(typeText, 50);
		}
	}

	function clickAnswerBtn(el){
		if($(el).html() === "좋아요!"){
			sessionStorage.setItem("data-7",0);
		}else if($(el).html() === "싫어요!"){
			sessionStorage.setItem("data-7",1);
		}else {
			sessionStorage.setItem("data-7",2);
		}
	}
	function clickReturnBtn(){
		sessionStorage.setItem("data-7","null");
		window.location.href = "ESCA_06_ver_1_0.do";
	}
	function clickEstimateBtn(el){
		if($("#answer-a").prop("checked") === true || $("#answer-b").prop("checked") === true || $("#answer-c").prop("checked") === true){
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			$(el).css('display',"none");
			$(".loading-prog").css("display","block");
			sendAllData();
		}else {
			$(el).addClass("is-invalid");
			alert("둘중에 하나 선택해주세요!")
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
		}
	}
	function clickNextBtn(el){
		if($("#answer-a").prop("checked") === false && $("#answer-b").prop("checked")===false && $("#answer-c").prop("checked") === false){
			$(el).addClass("is-invalid");
			alert("둘중에 하나 선택해주세요!")
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
		}else {
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			window.location.href = "ESCA_08_ver_1_0.do";
		}
	}
	$(function () {
	typeText();
	animateDonutGauge();
	// bootstrap tooltip
	const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
		return new bootstrap.Tooltip($(this)[0]);
	}).get();
	// 견적산출 데이터처리부(수신)
	if(sessionStorage.getItem("data-7")){
		if(sessionStorage.getItem("data-7") === "0"){
			$("#answer-a").prop("checked",true);
		}else if (sessionStorage.getItem("data-7") === "1"){
			$("#answer-b").prop("checked",true);
		}else if (sessionStorage.getItem("data-7") === "2"){
			$("#answer-c").prop("checked",true);
		}
	}
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
				<div class="w-75 container">
					<div class="row mt-4 pb-5">
						<div class="col-2 text-center">
							<div class="donut-container margin-center">
								 <div class="donut-fill">6</div>
							</div>
						</div>
						<div class="col-8 d-flex p-2">
							<input id="typingInput" class="form-control text-center pt-2 fs-5" type="text" readonly aria-label="예산 편성" disabled />
						</div>
					    <div class="col-2 d-flex flex-column-reverse">
							<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="선택사항 입니다~!" style="cursor:pointer">
						</div>
					</div>
					<div class="row pb-5">
						<div class="col-4 d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-a">
							<label class="btn btn-outline-secondary w-75" for="answer-a" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">좋아요!</p></label>
						</div>
						<div class="col-4 d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-b">
							<label class="btn btn-outline-secondary w-75" for="answer-b" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">싫어요!</p></label>
						</div>
						<div class="col-4 d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-c">
							<label class="btn btn-outline-secondary w-75" for="answer-c" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">상관없어요!</p></label>
						</div>
					</div>
					<div class="row mb-4">
						<div class="col">
							<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:clickReturnBtn()"><p class="pt-2 m-0">이전 질문</p></button>
						</div>
						<div class="col">
							<button type="button" class="form-control calc-two-final margin-center" onclick="javascript:clickEstimateBtn(this)"><p class="pt-2 m-0">견적 보기</p></button>
							<button class="btn btn-primary margin-center loading-prog w-100" type="button" disabled style="display: none;">
								<span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
								Loading...
							</button>
						</div>
						<div class="col">
							<button type="button" class="form-control w-50 margin-left-auto" onclick="javascript:clickNextBtn(this)"><p class="pt-2 m-0">다음 질문</p></button>
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
