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

<script>
	//견적산출 데이터처리부(송신)
	function sendAllData(){
		let answer1 = new Map();let answer2 = new Map();let answer3 = new Map();let answer4 = new Map();let answer5 = new Map();let answer6 = new Map();let answer7 = new Map();let answer8 = new Map();let answer9 = new Map();let answer10 = new Map();let answer11 = new Map();let answer12 = new Map();let answer13 = new Map();let answer14 = new Map();let answer15 = new Map();let answer16 = new Map();let answer17 = new Map();let answer18 = new Map();let answer19 = new Map();let answer20 = new Map();
		
		answer1.set(sessionStorage.getItem("data-1") + "0000", "");
		let twoDatas = JSON.parse(sessionStorage.getItem("data-2"));
		for(let i = 0 ; i < twoDatas.length; i++){
			answer2.set(twoDatas[i][0],twoDatas[i][1])
		}
		if(sessionStorage.getItem("data-3") !== ""){
			let threeDatas = JSON.parse(sessionStorage.getItem("data-3"));
			answer3.set("Fever", threeDatas[0]);
			answer3.set("Meterial", threeDatas[1]);
			answer3.set("AS", threeDatas[2]);
			answer3.set("Noise", threeDatas[3]);
			answer3.set("Stability", threeDatas[4]);
			answer3.set("QC", threeDatas[5]);
		}else {
			answer3.set("Fever", "");
			answer3.set("Meterial", "");
			answer3.set("AS", "");
			answer3.set("Noise", "");
			answer3.set("Stability", "");
			answer3.set("QC", "");
		}
		
		for(let i = 4; i <=20 ; i++){
			if(i === 8 && sessionStorage.getItem("data-" + i) !== ""){
				let eightDatas = JSON.parse(sessionStorage.getItem("data-8"));
				answer8.set("main-color", eightDatas[0]);
				answer8.set("sub-color", eightDatas[1]);
			}else if (i === 8 && sessionStorage.getItem("data-" + i) === ""){
				answer8.set("main-color", "");
				answer8.set("sub-color", "");
			}else if(sessionStorage.getItem("data-" + i) !== ""){
				var answerName = "answer" + i;
				var answer = eval(answerName);
				answer.set(sessionStorage.getItem("data-" + i));
			}else if (sessionStorage.getItem("data-" + i) === ""){
				var answerName = "answer" + i;
				var answer = eval(answerName);
				answer.set("");
			}
		}
		

		var urlParams = "";

		for (var i = 1; i <= 20; i++) {
			var mapName = "answer" + i;
			var map = eval(mapName);

			for (var [key, value] of map) {
				if(value === "" || !value){
					value = "null";
				}
				urlParams += mapName + ":" + key + "=" + value;
				urlParams += "|";
			}
		}
		var baseUrl = "/estimateCalculationResult.do";
		var fullUrl = baseUrl + "?" + urlParams;
		location.href = baseUrl + "?resultString=" + encodeURIComponent(urlParams);
	}
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
			$(".donut-fill").html("11");
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
	function clickAnswerBtn(el){
		const aa = $(el).html();
		console.log(aa);
		if( aa !== "예산에 맞게"){
			sessionStorage.setItem("data-11", aa);
		}else {
			sessionStorage.setItem("data-11", "0");
		}
	}
	function returnPageBtn(){
		sessionStorage.setItem("data-11","");
		location.href = "estimateCalculationTen.do";
	}
	function clickEstimateBtn(el){
		if($("#answer-a").prop("checked") === false && $("#answer-b").prop("checked") === false && $("#answer-c").prop("checked") === false && $("#answer-d").prop("checked") === false && $("#answer-e").prop("checked") === false){
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
			sendAllData();
		}
	}
	function clickNextBtn(el){
		// if($("#answer-a").prop("checked") === false && $("#answer-b").prop("checked") === false && $("#answer-c").prop("checked") === false && $("#answer-d").prop("checked") === false && $("#answer-e").prop("checked") === false){
		// 	alert("선택은 필수에요!");
		// 	$(el).addClass("is-invalid");
		// 	setTimeout(() => {
		// 		$(el).removeClass("is-invalid");
		// 	}, 2000);
		// }else {
		// 	$(el).addClass("is-valid");
		// 	setTimeout(() => {
		// 		$(el).removeClass("is-valid");
		// 	}, 2000);
		// 	window.location.href = "estimateCalculationEleven.do";
		// }
		alert("드디어 마지막 질문이네요!! 견적보기를 눌러주세요!!");
	}
	$(function () {
	// donut
	animateDonutGauge();
	$(".donut-fill").css("left","calc(50% - 20px)");
	// typing question text
	let index = 0;
	function typeText() {
		const text = "C드라이브(SSD)의 용량을 선택해주세요!";
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
});
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
								 <div class="donut-fill"">10</div>
							</div>
						</div>
						<div class="col-8 d-flex p-2">
							<input id="typingInput" class="form-control text-center" type="text" readonly aria-label="예산 편성" disabled />
						</div>
					    <div class="col-2 d-flex flex-column-reverse">
							<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="저장장치의 용량을 골라주세요!" style="cursor:pointer">
						</div>
					</div>
					<div class="row pb-5">
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-a">
							<label class="btn btn-outline-secondary w-75" for="answer-a" onclick="javascript:clickAnswerBtn(this)">예산에 맞게</label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-b">
							<label class="btn btn-outline-secondary w-75" for="answer-b" onclick="javascript:clickAnswerBtn(this)">256GB</label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-c">
							<label class="btn btn-outline-secondary w-75" for="answer-c" onclick="javascript:clickAnswerBtn(this)">512GB</label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-d">
							<label class="btn btn-outline-secondary w-75" for="answer-d" onclick="javascript:clickAnswerBtn(this)">1024GB(1TB)</label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-e">
							<label class="btn btn-outline-secondary w-75" for="answer-e" onclick="javascript:clickAnswerBtn(this)">2048GB(2TB)</label>
						</div>
					</div>
					<div class="row mb-4">
						<div class="col-4">
							<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:returnPageBtn()">이전 질문</button>
						</div>
						<div class="col-4">
							<button type="button" class="form-control margin-center" onclick="javascript:clickEstimateBtn(this)">견적 보기</button>
						</div>
						<div class="col-4">
							<button type="button" class="form-control margin-left-auto w-50" onclick="javascript:clickNextBtn(this)">다음 질문</button>
						</div>
					</div>
			 	</div>
	 		</div>
			
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 15%!important;"></div>
		
		
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
