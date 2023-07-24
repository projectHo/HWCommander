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
		let index1 = 0;
		let index2 = 0;
		let index3 = 0;
		let answer1 = new Map();
		answer1.set("Price",sessionStorage.getItem("data-1") + "0000");
		let answer2 = new Map();
		let answer2s = "";
		let twoDatas = JSON.parse(sessionStorage.getItem("data-2"));
		for(let i = 0 ; i < twoDatas.length; i++){
			answer2.set(twoDatas[i][0],twoDatas[i][1])
		}
		for(var [key,value] of answer2){
			let totalKey = answer2.size;
			answer2s += key + "," + value;
			index1++;
			if (index1 !== totalKey) {
				answer2s += ":";
			}
		}
		let answer3 = new Map();
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
		let answer3s = "";
		for(var [key,value] of answer3){
			let totalKey = answer3.size;
			answer3s += key + "," + value;
			index2++;
			if (index2 !== totalKey) {
				answer3s += ":";
			}
		}
		let answer4 = new Map();
		answer4.set("Wireless",sessionStorage.getItem("data-4"));
		let answer5 = new Map();
		answer5.set("CPU",sessionStorage.getItem("data-5"));
		let answer6 = new Map();
		answer6.set("GPU",sessionStorage.getItem("data-6"));
		let answer7 = new Map();
		answer7.set("Aio",sessionStorage.getItem("data-7"));
		let answer8 = new Map();
		if(sessionStorage.getItem("data-8") !== ""){
			let eightDatas = JSON.parse(sessionStorage.getItem("data-8"));
			answer8.set("main-color", eightDatas[0]);
			answer8.set("sub-color", eightDatas[1]);
		}else if (sessionStorage.getItem("data-8") === ""){
			answer8.set("main-color", "");
			answer8.set("sub-color", "");
		}
		let answer8s = "";
		for(var [key,value] of answer8){
			let totalKey = answer8.size;
			answer8s += key + "," + value;
			index3++;
			if (index3 !== totalKey) {
				answer8s += ":";
			}
		}
		let answer9 = new Map();
		answer9.set("RAM",sessionStorage.getItem("data-9"));
		let answer10 = new Map();
		answer10.set("Bulk",sessionStorage.getItem("data-10"));
		let answer11 = new Map();
		answer11.set("Ssd",sessionStorage.getItem("data-11"));
		let answer12 = new Map();
		answer12.set("Metarial",sessionStorage.getItem("data-12"));
		let answer13 = new Map();
		if(sessionStorage.getItem("data-13") !== ""){
			const thirteenDatas = JSON.parse(sessionStorage.getItem("data-13"));
			answer13.set("HDD",thirteenDatas[0] + ":" + thirteenDatas[1]);
		}else {
			answer13.set("HDD","");
		}
		let answer14 = new Map();
		answer14.set("Window",sessionStorage.getItem("data-14"));
		let answer15 = new Map();
		answer15.set("Fan",sessionStorage.getItem("data-15"));
		let answer16 = new Map();
		answer16.set("LED",sessionStorage.getItem("data-16"));
		let answer17 = new Map();let answer18 = new Map();let answer19 = new Map();let answer20 = new Map();
		
		
		for(let i = 17; i <=20 ; i++){
			if(sessionStorage.getItem("data-" + i) !== ""){
				var answerName = "answer" + i;
				var answer = eval(answerName);
				answer.set(sessionStorage.getItem("data-" + i),"");
			}else if (sessionStorage.getItem("data-" + i) === ""){
				var answerName = "answer" + i;
				var answer = eval(answerName);
				answer.set("null","null");
			}
		}
		var urlParams = "";

		for (var i = 1; i <= 20; i++) {
			var mapName = "answer" + i;
			var map = eval(mapName);
			if(i === 2){
				urlParams += mapName + "<" + answer2s + ">";
			}else if(i===3){
				urlParams += mapName + "<" + answer3s + ">";
			}else if (i ===8){
				urlParams += mapName + "<" + answer8s + ">";
			}else {
				for (var [key, value] of map) {
					if(key === "" || !key){
						key = "null";
						value = "null";
						urlParams += mapName + "<" + "null" + ">";
					}else if(key !== "" && value === ""){
						value = "null";
						urlParams += mapName + "<" + key + ">";
					}else if (key !== "" && value !== ""){
						urlParams += mapName + "<" + key + "," + value + ">";
					}
				}
			}
			if(i !== 20){
				urlParams += "|";
			}
		}
		var baseUrl = "/estimateCalculationResult.do";
		var fullUrl = baseUrl + "?" + urlParams;
		location.href = baseUrl + "?resultString=" + encodeURIComponent(urlParams);
	}
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
			$(".donut-fill").html("8");
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
		const text = " 컴퓨터의 테마 색상을 선택해주세요!(메인컬러 택 1, 서브컬러 택 1)";
		if (index < text.length) {
		$("#typingInput").val(function(i, val) {
			return val + text.charAt(index);
		});
		index++;
		setTimeout(typeText, 50);
		}
	}
	function returnPageBtn(){
		sessionStorage.removeItem("data-8");
		window.location.href = "estimateCalculationSeven.do";
	}
	let value = [];
	function clickEstimateBtn(el){
		let conditionMet = false;

		$(".picked-color").each(function() {
			const backgroundColor = $(this).css("background-color");
			
			if (backgroundColor === "rgb(255, 255, 254)") {
				conditionMet = true;
				return true;
			}
		});
		if($(".np-btn").hasClass("active")){
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			sessionStorage.setItem("data-8","np")
			sendAllData()
		} else if(conditionMet){
			alert("메인&서브 색상을 골라주시거나 상관없음을 골라주세요!");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
		}else if($(".save-btn").css("display") === "block"){
			alert("저장 해주세요!")
		}else {
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			// 견적산출 데이터처리부(송신)
			sessionStorage.setItem("data-8",JSON.stringify(value))
			sendAllData()
		}
	}
	function clickNextBtn(el){
		let conditionMet = false;

		$(".picked-color").each(function() {
			const backgroundColor = $(this).css("background-color");
			
			if (backgroundColor === "rgb(255, 255, 254)") {
				conditionMet = true;
				return true;
			}
		});
		if($(".np-btn").hasClass("active")){
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			window.location.href = "estimateCalculationNine.do";
		} else if(conditionMet){
			alert("메인&서브 색상을 골라주시거나 상관없음을 골라주세요!");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
		}else if($(".save-btn").css("display") === "block"){
			alert("저장 해주세요!")
		}else {
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			window.location.href = "estimateCalculationNine.do";
		}
	}

	function clickColorPick(el){
		$(".color-card").css("cursor","default").css("background-color","#fff").css("opacity","1");
		$(".card-text").css("cursor","pointer");
		$(".save-btn").css("display","block");
		const cardText = $(".card-text");
		value = [];
		cardText.off().on("click",function() {
			const pickColor = $(this).children(".color-container").css("background-color");
			$(el).css("background-color",pickColor);
		});
		$(".np-btn").removeClass("active");
	}
	function clickSaveBtn(){
		$(".save-btn").css("display","none");
		$(".color-card").css("cursor","not-allowed").css("background-color","lightgray").css("opacity","0.3");
		$(".card-text").css("cursor","not-allowed");
		for(let i = 0 ; i<$(".picked-color").length; i++){
			let storageColor = [$($(".picked-color")[i]).css("background-color")];
			value.push(storageColor);
			let trimmedValue = value;
			sessionStorage.setItem("data-8",JSON.stringify(value));
		}
	}
	function clickNpBtn(){
		value = [];
		$(".save-btn").css("display","none");
		$(".color-card").css("cursor","not-allowed").css("background-color","lightgray").css("opacity","0.3");
		$(".card-text").css("cursor","not-allowed");
		$(".picked-color").css("background-color", "rgb(255,255,254)");
	}

	function mouseInPicker(){
		$(".color-card").css("opacity","1");
		$(".color-card").css("background-color","#fff");
	}
	function mouseOutPicker(){
		if($(".save-btn").css("display") !== "block"){
			$(".color-card").css("opacity","0.3");
		}
	}
	// 미구현 모달용
	function clickEstimateModalBtn(){
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
			if(i === 8){
				answer8.set("main-color", "null");
				answer8.set("sub-color", "null");
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
	function clickNextModalBtn(){
		window.location.href = "estimateCalculationNine.do";
	}
	$(function () {
		typeText();
		animateDonutGauge();
		// bootstrap tooltip
		const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();

		// 견적산출 데이터처리부(수신)
		if(sessionStorage.getItem("data-8")){
			const data = sessionStorage.getItem("data-8");
			if(data.length>3){
				const data2 = JSON.parse(data);
				for(let i=0; i<data2.length; i++){
					$($(".picked-color")[i]).css("background-color", data2[i]);
				}
			}else{
				$(".np-btn").addClass("active");
			}
		}
		// 미구현 모달
		$(document).ready(function() {
			$('#myModal').modal({ backdrop: 'static', keyboard: false }); 
			$('#myModal').modal('show');
		});
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
								<div class="donut-fill">7</div>
							</div>
						</div>
						<div class="col-8 d-flex p-2">
							<input id="typingInput" class="form-control text-center" type="text" readonly aria-label="예산 편성" disabled />
						</div>
						<div class="col-2 d-flex flex-column-reverse">
							<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="선택사항 입니다~!" style="cursor:pointer">
						</div>
					</div>
					<div class="row container">
						<div class="col-4">
							<div class="row pb-5">
								<div class="col-7 p-0">
									<div class="card" style="width: 100%;">
										<div class="card-body">
											<h3 class="card-title mb-0 text-center">메인 컬러</h3>
										</div>
									</div>
								</div>
								<div class="col-4">
									<div class="card h-100">
										<div class="card-body p-0 color-picker-btn d-flex align-items-center justify-content-center">
											<div class="picked-color" onclick="javascript:clickColorPick(this)" onmouseover="javascript:mouseInPicker()" onmouseout="javascript:mouseOutPicker()">
	
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row pb-5">
								<div class="col-7 p-0">
									<div class="card" style="width: 100%;">
										<div class="card-body">
											<h3 class="card-title mb-0 text-center">서브 컬러</h3>
										</div>
									</div>
								</div>
								<div class="col-4">
									<div class="card h-100">
										<div class="card-body p-0 color-picker-btn d-flex align-items-center justify-content-center">
											<div class="picked-color"  onclick="javascript:clickColorPick(this)" onmouseover="javascript:mouseInPicker()" onmouseout="javascript:mouseOutPicker()">
	
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row pb-5">
								<div class="col-7 p-0">
									<button type="button" class="btn btn-outline-secondary w-100 fs-3 np-btn" data-bs-toggle="button" onclick="javascript:clickNpBtn()">상관 없음</button>
								</div>
								<div class="col"></div>
							</div>
						</div>
						<div class="col-8">
							<div class="card color-card" style="width: 100%;">
								<div class="card-body">
									<div class="row">
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(0,0,0);"></div> Black</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(0,122,192);"></div> Blue</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(112,63,58);"></div> Brown</span></div>
									</div>
									<div class="row">
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(222,182,62);"></div> Gold</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(94,94,94);"></div> Gray</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(199,198,116);"></div> Green</span></div>
									</div>
									<div class="row">
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(212,37,114);"></div> Magenta</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(143,215,212);"></div> Mint</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(239,124,31);"></div> Orange</span></div>
									</div>
									<div class="row">
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(236,180,186);"></div> Pink</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(173,108,200);"></div> Purple</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(252,46,70);"></div> Red</span></div>
									</div>
									<div class="row">
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(220,218,221);"></div> Silver</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(255,255,255);"></div> White</span></div>
										<div class="col-4"><span class="card-text d-flex align-items-center w-75 fs-4"><div class="color-container me-2 mt-1" style="background-color: rgb(255,213,33);"></div> Yellow</span></div>
									</div>
									<div class="row">
										<div class="col-4"><span class="card-text d-flex align-items-center fs-4"><div class="color-container me-2 mt-1"></div> 상관없음</span></div>
										<div class="col-4"></div>
										<div class="col-4">
											<button type="button" class="btn btn-primary ms-5 save-btn" style="display: none;" onclick="javascript:clickSaveBtn()">저장</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mb-4">
						<div class="col">
							<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:returnPageBtn()">이전 질문</button>
						</div>
						<div class="col">
							<button type="button" class="form-control calc-two-final margin-center" onclick="javascript:clickEstimateBtn(this)">견적 보기</button>
						</div>
						<div class="col">
							<button type="button" class="form-control w-50 margin-left-auto" onclick="javascript:clickNextBtn(this)">다음 질문</button>
						</div>
					</div>
				</div>
	 		</div>
			<!-- 미구현 모달 -->
			<div class="modal fade" id="myModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
				  <div class="modal-content">
					<div class="modal-header">
					  <h5 class="modal-title text-center">8번째 질문</h5>
					</div>
					<div class="modal-body text-center">
					  <p>죄송합니다.. 미구현 질문입니다...</p>
					  <p>다음질문으로 넘어가시거나 견적산출을 해주세요!</p>
					  <p>(이전까지의 질문은 모두 저장 되어 있습니다!!)</p>
					</div>
					<div class="modal-footer">
					  <button type="button" class="btn btn-secondary" onclick="javascript:clickEstimateModalBtn()">견적 산출</button>
					  <button type="button" class="btn btn-primary" onclick="javascript:clickNextModalBtn()">다음 질문</button>
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
