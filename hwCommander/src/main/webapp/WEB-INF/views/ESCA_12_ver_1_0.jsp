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
			$(".donut-fill").html("12");
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
	let answers=[];
	if(sessionStorage.getItem("data-12")){
		let datas = JSON.parse(sessionStorage.getItem("data-12"));
		for(let i = 0 ; i < datas.length ; i++){
			answers.push(datas[i]);
		}
	}
	function clickAnswerBtn(el){
		if($(el).children().html() !== "상관없음"){
			if(sessionStorage.getItem("data-12") === "5"){
				answers = [];
			}
			$("#answer-f").prop("checked",false);
			if($(el).siblings().prop("checked") === false){
				if($(el).children().html() === "아크릴"){
					if(!answers.includes("0")){
						answers.push("0");
					}
				}else if ($(el).children().html() === "강화유리"){
					if(!answers.includes("1")){
						answers.push("1");
					}
				}else if($(el).children().html() === "알루미늄"){
					if(!answers.includes("2")){
						answers.push("2");
					}
				}else if($(el).children().html() === "통철판"){
					if(!answers.includes("3")){
						answers.push("3");
					}
				}else if($(el).children().html() === "창문형 유리"){
					if(!answers.includes("4")){
						answers.push("4");
					}
				}
			}else if($(el).siblings().prop("checked") === true){
				var index = answers.indexOf($(el).attr("data-value"));
				if(index !== -1){
					answers.splice(index,1);
				}
			}
			sessionStorage.setItem("data-12",JSON.stringify(answers));
		}else {
			if($(el).siblings().prop("checked") === false){
				answers = [];
				answers.push("5");
				$("#answer-a").prop("checked",false);
				$("#answer-b").prop("checked",false);
				$("#answer-c").prop("checked",false);
				$("#answer-d").prop("checked",false);
				$("#answer-e").prop("checked",false);
				sessionStorage.setItem("data-12",JSON.stringify(answers));
				answers = [];
			}
		}
	}
	
	function clickReturnBtn(){
		sessionStorage.setItem("data-12","null");
		location.href = "ESCA_11_ver_1_0.do";
	}
	function clickEstimateBtn(el){
		if($("#answer-a").prop("checked") === false && $("#answer-b").prop("checked") === false && $("#answer-c").prop("checked") === false && $("#answer-d").prop("checked") === false && $("#answer-e").prop("checked") === false && $("#answer-f").prop("checked") === false){
			alert("선택은 필수에요!");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
		}else {
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			$(el).css("display","none");
			$(".loading-prog").css("display","block");
			sendAllData();
		}
	}
	function clickNextBtn(el){
		if($("#answer-a").prop("checked") === false && $("#answer-b").prop("checked") === false && $("#answer-c").prop("checked") === false && $("#answer-d").prop("checked") === false && $("#answer-e").prop("checked") === false && $("#answer-f").prop("checked") === false){
			alert("선택은 필수에요!");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
		}else {
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			window.location.href = "ESCA_13_ver_1_0.do";
		}
	}
	$(function(){
		// donut
		$(".donut-fill").css("left","calc(50% - 22px)");
		animateDonutGauge();
		// typing question text
		let index = 0;
		function typeText() {
			const text = "원하시는 본체 옆판의 소재를 선택해주세요!(다중선택 가능)";
			if (index < text.length) {
			$("#typingInput").val(function(i, val) {
				return val + text.charAt(index);
			});
			index++;
			setTimeout(typeText, 50);
			}
		}
		typeText();
		// bootstrap tooltip
		const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();
		// 견적산출 데이터처리부(수신)
		if(sessionStorage.getItem("data-12")){
			const storedData = JSON.parse(sessionStorage.getItem("data-12"));
			for(let i =0; i<storedData.length; i++){
				if (storedData[i] === "0"){
					$("#answer-a").prop("checked",true);
				}else if (storedData[i] === "1"){
					$("#answer-b").prop("checked",true);
				}else if (storedData[i] === "2"){
					$("#answer-c").prop("checked",true);
				}else if (storedData[i] === "3"){
					$("#answer-d").prop("checked",true);
				}else if (storedData[i] === "4"){
					$("#answer-e").prop("checked",true);
				}else if(storedData[i] === "5"){
					$("#answer-f").prop("checked",true);
				}
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
								 <div class="donut-fill"">11</div>
							</div>
						</div>
						<div class="col-8 d-flex p-2">
							<input id="typingInput" class="form-control text-center pt-2 fs-5" type="text" readonly aria-label="예산 편성" disabled />
						</div>
					    <div class="col-2 d-flex flex-column-reverse">
							<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="본체 옆판의 소재를 선택해주세요!(선택사항입니다)" style="cursor:pointer">
						</div>
					</div>
					<div class="row pb-5">
						<div class="col d-flex justify-content-center">
							<input type="checkbox" class="btn-check" name="btnCheck" id="answer-a">
							<label class="btn btn-outline-secondary w-75" for="answer-a" data-value="0" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">아크릴</p></label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="checkbox" class="btn-check" name="btnCheck" id="answer-b">
							<label class="btn btn-outline-secondary w-75" for="answer-b" data-value="1" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">강화유리</p></label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="checkbox" class="btn-check" name="btnCheck" id="answer-c">
							<label class="btn btn-outline-secondary w-75" for="answer-c" data-value="2" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">알루미늄</p></label>
						</div>
					</div>
					<div class="row pb-5">
						<div class="col d-flex justify-content-center">
							<input type="checkbox" class="btn-check" name="btnCheck" id="answer-d">
							<label class="btn btn-outline-secondary w-75" for="answer-d" data-value="3" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">통철판</p></label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="checkbox" class="btn-check" name="btnCheck" id="answer-e">
							<label class="btn btn-outline-secondary w-75" for="answer-e" data-value="4" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">창문형 유리</p></label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="checkbox" class="btn-check" name="btnCheck" id="answer-f">
							<label class="btn btn-outline-secondary w-75" for="answer-f" data-value="5" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">상관없음</p></label>
						</div>
					</div>
					<div class="row mb-4">
						<div class="col-4">
							<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:clickReturnBtn()"><p class="pt-2 m-0">이전 질문</p></button>
						</div>
						<div class="col-4">
							<button type="button" class="form-control margin-center" onclick="javascript:clickEstimateBtn(this)"><p class="pt-2 m-0">견적 보기</p></button>
							<button class="btn btn-primary margin-center loading-prog w-100" type="button" disabled style="display: none;">
								<span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
								Loading...
							</button>
						</div>
						<div class="col-4">
							<button type="button" class="form-control margin-left-auto w-50" onclick="javascript:clickNextBtn(this)"><p class="pt-2 m-0">다음 질문</p></button>
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
