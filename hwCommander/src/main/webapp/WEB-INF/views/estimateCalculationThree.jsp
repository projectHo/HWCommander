<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<head>
<title>현우의 컴퓨터 공방 - 견적산출</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css">

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-dragdata"></script>
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
			urlParams += "|";
		}
		var Pattern = /\((.*?)\)/;
		var userInfoMatch = Pattern.exec("${loginUser}");
		var userInfoValues = userInfoMatch[1];

		var userInfoArray = userInfoValues.split(", ");
		var userInfoObject = {};
		for (var i = 0; i < userInfoArray.length; i++) {
			var keyValue = userInfoArray[i].split("=");
			var key = keyValue[0];
			var value = keyValue[1];
			userInfoObject[key] = value;
		}
		urlParams += "etc<userId," + userInfoObject.id + "> |etc<targetDate,null>";
		var baseUrl = "/estimateCalculationResult.do";
		var fullUrl = baseUrl + "?" + urlParams;
		location.href = baseUrl + "?resultString=" + encodeURIComponent(urlParams);
	}
	function clickReturnBtn() {
		sessionStorage.setItem("data-3","");
		window.location.href = "estimateCalculationTwo.do";
	}
	function clickEstimateBtn(el){
		let value = [];
		$(el).addClass("is-valid");
		setTimeout(()=>{
			$(el).removeClass("is-valid");
		}, 3000);
		for(let i = 0 ; i<$(".hex-input").length; i++){
			let storageValue = [$(".hex-input")[i].value];
			value.push(storageValue);
		}
		sessionStorage.setItem("data-3",JSON.stringify(value))
		sendAllData();
	}
	function clickNextBtn(el){
		let value = [];
		$(el).addClass("is-valid");
		setTimeout(()=>{
			$(el).removeClass("is-valid");
		}, 3000);
		for(let i = 0 ; i<$(".hex-input").length; i++){
			let storageValue = [$(".hex-input")[i].value];
			value.push(storageValue);
		}
		sessionStorage.setItem("data-3",JSON.stringify(value))
		window.location.href = "estimateCalculationFour.do";
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
			$(".donut-fill").html("3");
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
		const text = " 예산을 세분화하여 편성 해주세요";
		if (index < text.length) {
		$("#typingInput").val(function(i, val) {
			return val + text.charAt(index);
		});
		index++;
		setTimeout(typeText, 50);
		}
	}
	typeText();
	
	var myChart ;
	// hex chart.js
	function createChart(){
		var minDataValue = 0; 

		var ctx = $('#myChart')[0].getContext('2d');
		var gradient = ctx.createLinearGradient(0, 0, 0, 300);
		gradient.addColorStop(0, 'rgba(153, 50, 204, 0.9)'); 
		gradient.addColorStop(1, 'rgba(37, 180, 220, 0.9)'); 

		myChart = new Chart(ctx, {
			type: 'radar',
			data: {
				labels: ['발열', '소재', 'AS', '소음', '안정성', 'QC'],
				datasets: [{
				label: '',
				data: [1, 1, 1, 1, 1, 1],
				backgroundColor: gradient,
				}]
			},
			options: {
				maintainAspectRatio: false,
				responsive: false,
				scales: {
				r: {
					display: false,
					min: minDataValue,
					max: 2,
					ticks: {
					// display: false,
					stepSize: 0.01
					}
				}
				},
				plugins: {
					legend: {
						display: false
					},
					dragData: {
						round: 2,
						showTooltip: true,
						onDragStart: function (event, datasetIndex, index, value) {
						if (value < minDataValue) {
							return false;
						}
						},
						onDrag: function (event, datasetIndex, index, value) {
							const hexInputs = $(".hex-input");
							
							hexInputs[index].value = parseFloat(myChart.data.datasets[datasetIndex].data[index]).toFixed(2);
							hexagonType();
						if (value < minDataValue) {
							myChart.data.datasets[datasetIndex].data[index] = minDataValue;
							myChart.update();
						}
						}
					}
				},
				animation: {
					duration: 500,
					easing: 'easeOutQuart'
				},

				afterDraw: function(chart) {
					var ctx = chart.ctx;
					var scale = chart.scales.r;
					
					if (scale.max === 2) {
						ctx.save();
						ctx.beginPath();
						ctx.strokeStyle = '#000000';
						ctx.lineWidth = 2;
						ctx.setLineDash([5, 5]);
						ctx.moveTo(scale.xCenter, scale.yCenter);
						ctx.lineTo(scale.xCenter + scale.radius, scale.yCenter);
						ctx.stroke();
						ctx.restore();
					}
				}
			}
		});
	}
	
	function hexagonType(){
		const hexInputs = $(".hex-input");

		for(let i = 0 ; i<hexInputs.length; i++){
			const inputValue = parseFloat(hexInputs[i].value);
			if(hexInputs[i].value < 0 || hexInputs[i].value>2){
				alert("0이상 2미만으로 입력해주세요!");
				hexInputs[i].value = "1.00";
				myChart.data.datasets[i].data[i] = 1.00;
			}
			myChart.data.datasets[0].data[i] = inputValue;
		}
		myChart.update();
		$("#hex-val-total").val(parseFloat((Number($("#hex-val-01").val())+Number($("#hex-val-02").val())+Number($("#hex-val-03").val())+Number($("#hex-val-04").val())+Number($("#hex-val-05").val())+Number($("#hex-val-06").val()))/(6)).toFixed(2));
	}
	let prevTotalVal = 1;
	function totalValue(){
		
		let count = 6;
		const hexInputs = $(".hex-input");
		
		const totalVal = Number(parseFloat($("#hex-val-total").val()).toFixed(2));
		const allInputs = (Number($("#hex-val-01").val())+Number($("#hex-val-02").val())+Number($("#hex-val-03").val())+Number($("#hex-val-04").val())+Number($("#hex-val-05").val())+Number($("#hex-val-06").val()))/6;

		if($("#hex-val-total").val() ==="0"){
			for(let i = 0 ; i<hexInputs.length; i++){
				hexInputs[i].value = "0.00"
				myChart.data.datasets[0].data[i] = "0";
			}
		}else if($("#hex-val-total").val() ==="2"){
			for(let i = 0 ; i<hexInputs.length; i++){
				hexInputs[i].value = "2.00"
				myChart.data.datasets[0].data[i] = "2";
			}
		}else {
			if(totalVal<allInputs){
				for(let i = 0 ; i<hexInputs.length; i++){
					if(hexInputs[i].value === "0"){
						count--;
					}
				}
				
				for(let i = 0 ; i<hexInputs.length; i++){
					let inputVal = hexInputs[i].value;
					if(Number(inputVal) > 0){
						let inputVal = Number(hexInputs[i].value) - Number(parseFloat(Math.abs(prevTotalVal - totalVal)).toFixed(2))
						hexInputs[i].value = String(parseFloat(inputVal).toFixed(2));
						myChart.data.datasets[0].data[i] = inputVal;
						if(Number(inputVal) < 0){
							hexInputs[i].value = "0.00";
							
						}else if(Number(inputVal)>2){
							hexInputs[i].value = "2.00";
						}
					}
				}
			}else if(totalVal>allInputs){
				for(let i = 0 ; i<hexInputs.length; i++){
					if(hexInputs[i].value === "2"){
						count--;
					}
				}
				for(let i = 0 ; i<hexInputs.length; i++){
					let inputVal = hexInputs[i].value;
					if(Number(inputVal) < 2){
						let inputVal = Number(hexInputs[i].value)+Number(parseFloat(Math.abs(prevTotalVal - totalVal)).toFixed(2))
						hexInputs[i].value = String(parseFloat(inputVal).toFixed(2));
						myChart.data.datasets[0].data[i] = inputVal;
						if(Number(inputVal) < 0){
							hexInputs[i].value = "0.00";
						}else if(Number(inputVal)>2){
							hexInputs[i].value = "2.00"
						}
					}
				}
			
			}
			prevTotalVal = totalVal;
		}
		myChart.update();
	}
	// explane-area
	function mouseEnter(elem){
		const elemHtml = $(elem).html();
		if(elemHtml === "발열"){
			$("#explane-area").html("발열 : 제품을 낮은 온도로 유지해줄 발열제어능력을 의미합니다.\n\n0일 때 온전한 성능을 발휘할 수 있는 최소한의 쿨러만 설치되며, 2일 때 예산을 초과편성하지 않는 선에서의 최고의 쿨링성능을 제공합니다.")
		}else if(elemHtml ==="소재"){
			$("#explane-area").html("소재 : 하드웨어적 제품 가치를 의미합니다.\n\n강판의 종류, 두께, 강도, 열전도율, 베어링 방식, 방열판 구조, 쿨링솔루션 등을 의미합니다.\n\n0일 때 소재를 전혀 고려하지 않고 호환성만 검토하며\n\n2일 때 하드웨어적으로 완성에 가까운 제품을 선정하게 됩니다.")
		}else if(elemHtml === "소음"){
			$("#explane-area").html("소음 : 제품의 상세설명 상 표기 데시벨을 점수화하여 기록된 자료입니다.\n\nBeta버전으로, 실측 테스트가 진행되지 않아 알고리즘 연산식에서 배제됩니다.\n\n수치 변동에 따라 제품 선정 변경점이 존재하지 않습니다.")
		}else if(elemHtml === "QC"){
			$("#explane-area").html("QC : 제품의 결함율을 나타냅니다.\n\n단순한 출고 결함율만이 아닌 최근 해당 제품 혹은 제품의 제조사, 제품군의 라인업/칩셋 등의 이슈를 다룹니다.\n\n0일 때 당장의 리콜/판매금지 제품을 제외하곤 모든 가능성을 열어두며, 2일 때 이름값을 다소 지불하더라도 입증된 메이저 제품군만을 취급합니다.")
		}else if(elemHtml === "안정성"){
			$("#explane-area").html("안정성 : 제품의 성능을 온전하게 유지하고 수명을 올려줄 모든 수단을 의미합니다.\n\n0일 때 가격대비 퍼포먼스 표기 성능이 가장 높은 제품을 선택하고, 2일 때 제품의 체급을 낮춰서라도 프리미엄 라인업을 선정합니다.")
		}else if(elemHtml === "AS"){
			$("#explane-area").html("AS : 제품들의 사후처리 가능성을 나타냅니다.\n\n수리규정, 유통사 평판 등이 이에 해당합니다.\n0일 때 AS를 전혀 감안하지 않으며, 2일 때 AS의 가격가치를 제품 성능보다도 우선시합니다.")
		}else {
			$("#explane-area").html("가성비 : (깡통 독3사) 최소한의 기준치를 충족한 제품군들 중 성능만을 위해 예산을 소요합니다.\n가격대 성능비가 가장 좋지만 체급에 비해 종합 안정성이 떨어집니다.\n\n메인스트림 : (필수옵션 소나타)해당 예산대의 평균적인 제품군을 선정합니다. 예산 내의 이상적인 견적을 받을 수 있습니다.\n\n프리미엄 : (풀옵 경차)예산에 비해 과한 제품 종합 안정성을 보장합니다.\n각 라인업별 최고의 제품들만 선별하여 활용하겠지만, 성능은 돈값을 못한다는 이야기를 듣기 쉽습니다.");
		}
	}
	
	function clickReset() {
		const hexInputs = $(".hex-input");
		for(let i = 0 ; i<hexInputs.length; i++){
			hexInputs[i].value = "1.00";
		}
		hexagonType();
	}
	
	$(function () {
		createChart();
		// 견적산출 데이터처리부(수신)
		if(sessionStorage.getItem("data-3")){
			const storedValues =JSON.parse(sessionStorage.getItem("data-3"));
			
			const ranges = $(".hex-input");
			for(let i = 0 ; i<ranges.length ; i++){
				ranges[i].value = storedValues[i];
			}
			hexagonType()
		}

		const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();
		// donut
		animateDonutGauge();
		// modal esc delete
		$('#use-collector').off('keydown.dismiss.bs.modal');
		// reset btn function control
		$(".reset-svg").mouseover(()=>{
			$(".reset-svg").addClass("mouse-in");
			setTimeout(() => {
				$(".reset-svg").removeClass("mouse-in");
			}, 2000);
		})
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
			<div class="estimateCalc_background p-2 pt-5 pb-5" style="width: 70%!important;">
				<div class="w-75 container">
					<div class="row mt-4 pb-4">
						<div class="col-2 text-center">
							<div class="donut-container margin-center">
								 <div class="donut-fill">2</div>
							</div>
						</div>
						<div class="col-8 d-flex p-2">
							<input id="typingInput" class="form-control text-center" type="text" readonly aria-label="예산 편성" disabled />
						</div>
					    <div class="col-2 d-flex flex-column-reverse">
							<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="이 페이지부터는 선택 사항입니다!" style="cursor:pointer">
						</div>
		   
					</div>
					<form class="needs-validation" action="estimateCalculationResult.do" novalidate>
						<div class="row pb-2">
							<div class="col-6">
								<div class="row">
									<div class="hex-container mb-5">
										<div class="hex m-4 d-flex justify-content-center">
											<!-- <svg xmlns="http://www.w3.org/2000/svg" width="400" height="360" class="bi bi-hexagon mt-4" viewBox="0 0 16 16">
												<defs>
													<linearGradient id="gradient" x1="0%" y1="0%" x2="0%" y2="100%">
													<stop offset="0%" style="stop-color: #C635ED;" />
													<stop offset="100%" style="stop-color: #955CE7;" />
													</linearGradient>
												</defs>
												<path d="M14 4.577v6.846L8 15l-6-3.577V4.577L8 1l6 3.577zM8.5.134a1 1 0 0 0-1 0l-6 3.577a1 1 0 0 0-.5.866v6.846a1 1 0 0 0 .5.866l6 3.577a1 1 0 0 0 1 0l6-3.577a1 1 0 0 0 .5-.866V4.577a1 1 0 0 0-.5-.866L8.5.134z" fill="url(#gradient)" stroke-width="0.5"  />
											</svg> -->
											<svg fill="url(#gradient)" class="mt-4" width="90%" height="90%" viewBox="0 0 250 250" id="Flat" xmlns="http://www.w3.org/2000/svg">
												<defs>
												  <linearGradient id="gradient" x1="0%" y1="0%" x2="0%" y2="100%">
													<stop offset="0%" style="stop-color: #C635ED;" />
													<stop offset="100%" style="stop-color: #955CE7;" />
												  </linearGradient>
												</defs>
												<g id="SVGRepo_bgCarrier" stroke-width="0"></g>
												<g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
												<g id="SVGRepo_iconCarrier">
												  <path d="M128,234.80127a12.00322,12.00322,0,0,1-5.90466-1.54395l-84-47.47827A12.01881,12.01881,0,0,1,32,175.33228V80.66772A12.019,12.019,0,0,1,38.09521,70.221l84.00013-47.47827a12.06282,12.06282,0,0,1,11.80932,0l84,47.47827A12.01881,12.01881,0,0,1,224,80.66772v94.66456a12.019,12.019,0,0,1-6.09521,10.44677l-84.00013,47.47827A12.00322,12.00322,0,0,1,128,234.80127Zm0-205.60889a4.00152,4.00152,0,0,0-1.96814.51465l-84,47.47827A4.00672,4.00672,0,0,0,40,80.66772v94.66456a4.00658,4.00658,0,0,0,2.032,3.48242L126.03186,226.293a4.0215,4.0215,0,0,0,3.93628,0l84-47.47827A4.00672,4.00672,0,0,0,216,175.33228V80.66772a4.00658,4.00658,0,0,0-2.032-3.48242L129.96814,29.707A4.00152,4.00152,0,0,0,128,29.19238Z"></path>
												</g>
											</svg>
											<div class="lines w-100">
												<div class="line l-one w-100"><svg width="93%" height="93%" viewBox="0 0 24.00 24.00" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#bdbdbd" transform="rotate(0)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Line_Xl"> <path id="Vector" d="M12 21V3" stroke="#a3a3a3" stroke-width="0.21600000000000003" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg></div>
												<div class="line l-two w-100" style="rotate: -74deg;"><svg width="93%" height="93%" viewBox="0 0 24.00 24.00" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#bdbdbd" transform="rotate(-45)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Line_Xl"> <path id="Vector" d="M12 21V3" stroke="#a3a3a3" stroke-width="0.21600000000000003" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg></div>
												<div class="line l-three w-100" style="rotate: 74deg;"><svg width="93%" height="93%" viewBox="0 0 24.00 24.00" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#bdbdbd" transform="rotate(45)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <g id="Interface / Line_Xl"> <path id="Vector" d="M12 21V3" stroke="#a3a3a3" stroke-width="0.21600000000000003" stroke-linecap="round" stroke-linejoin="round"></path> </g> </g></svg></div>
											</div>
											<canvas id="myChart"></canvas>
											<div class="hex-text first-hex-text w-100 d-flex justify-content-center">
												<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">발열</div>
											</div>
											<div class="hex-text second-hex-text w-100 d-flex justify-content-between p-3">
												<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">QC</div>
												<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">소재</div>
											</div>
											<div class="hex-text third-hex-text w-100 d-flex justify-content-between ps-3">
												<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">안정성</div>
												<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">AS</div>
											</div>
											<div class="hex-text fourth-hex-text w-100 d-flex justify-content-center">
												<div class="fs-4" onmouseenter="javascript:mouseEnter(this)">소음</div>
											</div>
											<svg onclick="javascript:clickReset()" class="reset-svg" fill="#000000" width="40px" height="40px" viewBox="-652.8 -652.8 3225.60 3225.60" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="65.28" transform="matrix(-1, 0, 0, -1, 0, 0)rotate(0)"><g id="SVGRepo_bgCarrier" stroke-width="0" transform="translate(0,0), scale(1)"><path transform="translate(-652.8, -652.8), scale(201.6)" fill="url(#gradient)" d="M9.166.33a2.25 2.25 0 00-2.332 0l-5.25 3.182A2.25 2.25 0 00.5 5.436v5.128a2.25 2.25 0 001.084 1.924l5.25 3.182a2.25 2.25 0 002.332 0l5.25-3.182a2.25 2.25 0 001.084-1.924V5.436a2.25 2.25 0 00-1.084-1.924L9.166.33z" strokewidth="0"></path></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#25b4dc " stroke-width="280.32"> <path d="M960 0v213.333c411.627 0 746.667 334.934 746.667 746.667S1371.627 1706.667 960 1706.667 213.333 1371.733 213.333 960c0-197.013 78.4-382.507 213.334-520.747v254.08H640V106.667H53.333V320h191.04C88.64 494.08 0 720.96 0 960c0 529.28 430.613 960 960 960s960-430.72 960-960S1489.387 0 960 0" fill-rule="evenodd"></path> </g><g id="SVGRepo_iconCarrier"> <path d="M960 0v213.333c411.627 0 746.667 334.934 746.667 746.667S1371.627 1706.667 960 1706.667 213.333 1371.733 213.333 960c0-197.013 78.4-382.507 213.334-520.747v254.08H640V106.667H53.333V320h191.04C88.64 494.08 0 720.96 0 960c0 529.28 430.613 960 960 960s960-430.72 960-960S1489.387 0 960 0" fill-rule="evenodd"></path> </g></svg>
										</div>
									</div>
								</div>
								<div class="row w-100 justify-content-center m-4 mt-5" style="padding-right: 2.1rem;">
									<input type="range" class="form-range w-50" min="0" max="2" step="0.01" id="hex-val-total" oninput="javascript:totalValue()">
									<label for="hex-val-total" class="form-label text-center ms-2" onmouseenter="javascript:mouseEnter(this)">가성비 <- 메인스트림 -> 프리미엄</label>
								</div>
							</div>
							<div class="col-6" id="hex-label">
								<div class="m-4">
									<div class="row">
										<div class="mb-3">
											<label for="explane-area" class="form-label">단어에 마우스를 올리면 이곳에 설명이 나옵니다!</label>
											<textarea class="form-control" id="explane-area" rows="15" disabled></textarea>
										</div>
									</div>
									<div class="row hex-input-type">
										<div class="col-6">
											<label for="hexFever" class="form-label w-100">
												<div class="input-group input-group-lg">
													<span class="input-group-text w-50 justify-content-center" id="hex-form-01" onmouseenter="javascript:mouseEnter(this)">발열</span>
													<input type="number" class="form-control text-center hex-input" aria-label="발열" aria-describedby="hex-form-01" id="hex-val-01" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
												</div>
											</label>
										</div>
										<div class="col-6">
											<label for="hexMaterial" class="form-label w-100">
												<div class="input-group input-group-lg">
													<span class="input-group-text w-50 justify-content-center" id="hex-form-02" onmouseenter="javascript:mouseEnter(this)">소재</span>
													<input type="number" class="form-control text-center hex-input" aria-label="소재" aria-describedby="hex-form-02" id="hex-val-02" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
												</div>
											</label>
										</div>
									</div>
									<div class="row">
										<div class="col-6">
											<label for="hexAs" class="form-label w-100">
												<div class="input-group input-group-lg">
													<span class="input-group-text w-50 justify-content-center" id="hex-form-03" onmouseenter="javascript:mouseEnter(this)">AS</span>
													<input type="number" class="form-control text-center hex-input" aria-label="AS" aria-describedby="hex-form-03" id="hex-val-03" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
												</div>
											</label>
										</div>
										<div class="col-6">
											<label for="hexNoise" class="form-label w-100">
												<div class="input-group input-group-lg">
													<span class="input-group-text w-50 justify-content-center" id="hex-form-04" onmouseenter="javascript:mouseEnter(this)">소음</span>
													<input type="number" class="form-control text-center hex-input" aria-label="소음" aria-describedby="hex-form-04" id="hex-val-04" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
												</div>
											</label>
										</div>
									</div>
									<div class="row">
										<div class="col-6">
											<label for="hexStability" class="form-label w-100">
												<div class="input-group input-group-lg">
													<span class="input-group-text w-50 justify-content-center" id="hex-form-05" onmouseenter="javascript:mouseEnter(this)">안정성</span>
													<input type="number" class="form-control text-center hex-input" aria-label="안정성" aria-describedby="hex-form-05" id="hex-val-05" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
												</div>
											</label>
										</div>
										<div class="col-6">
											<label for="hexQc" class="form-label w-100">
												<div class="input-group input-group-lg">
													<span class="input-group-text w-50 justify-content-center" id="hex-form-06" onmouseenter="javascript:mouseEnter(this)">QC</span>
													<input type="number" class="form-control text-center hex-input" aria-label="QC" aria-describedby="hex-form-06" id="hex-val-06" min="0.00" max="2.00" value="1.00" oninput="javascript:hexagonType()">
												</div>
											</label>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row mb-4">
							<div class="col">
								<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:clickReturnBtn()">이전 질문</button>
							</div>
							<div class="col">
								<button type="button" class="form-control calc-two-final margin-center" onclick="javascript:clickEstimateBtn(this)">견적 보기</button>
							</div>
							<div class="col">
								<button type="button" class="form-control w-50 margin-left-auto" onclick="javascript:clickNextBtn(this)">다음 질문</button>
							</div>
						</div>
					</form>
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