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
		let answer0 = new Map();
		answer0.set("OS",sessionStorage.getItem("data-0"));
		let answer1 = new Map();
		answer1.set("Price",Number(sessionStorage.getItem("data-1")) * 10000);
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
			answer3.set("Fever", "null");
			answer3.set("Meterial", "null");
			answer3.set("AS", "null");
			answer3.set("Noise", "null");
			answer3.set("Stability", "null");
			answer3.set("QC", "null");
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
			answer8.set("main-color", "null");
			answer8.set("sub-color", "null");
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
		answer14.set("Fan",sessionStorage.getItem("data-14"));
		let answer15 = new Map();
		answer15.set("LED",sessionStorage.getItem("data-15"));
		let answer16 = new Map();let answer17 = new Map();let answer18 = new Map();let answer19 = new Map();
		
		
		for(let i = 16; i <=19 ; i++){
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

		for (var i = 1; i <= 19; i++) {
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
					}else if(key !== "" && value === ""){
						value = "null";
					}
					
					urlParams += mapName + "<" + key + "," + value + ">";
					
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
		urlParams += "etc<userId," + userInfoObject.id + "> |etc<targetDate,null>" + "answer0<" + Array.from(answer0.keys()) + "," + Array.from(answer0.values()) + ">";
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
			$(".donut-fill").html("13");
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
	function clickAnswerBtn(el){
		if($(el).html().includes("필요없음")){
			$(".count-container").css("display","none");
			var val = [];
			val.push("5");
			val.push("");
			sessionStorage.setItem("data-13",JSON.stringify(val))
		}else{
			$(".count-container").css("display","flex");
			$(".count-hdd").focus();
			if($(".count-hdd").val() !== ""){
				var val = [];
				if($(el).html().includes("1TB")){
					val.push("0");
					val.push($(".count-hdd").val());
					sessionStorage.setItem("data-13",JSON.stringify(val));
				}else if($(el).html().includes("2TB")){
					val.push("1");
					val.push($(".count-hdd").val());
					sessionStorage.setItem("data-13",JSON.stringify(val));
				}else if($(el).html().includes("4TB")){
					val.push("2");
					val.push($(".count-hdd").val());
					sessionStorage.setItem("data-13",JSON.stringify(val));
				}else if($(el).html().includes("6TB")){
					val.push("3");
					val.push($(".count-hdd").val());
					sessionStorage.setItem("data-13",JSON.stringify(val));
				}else if($(el).html().includes("8TB")){
					val.push("4");
					val.push($(".count-hdd").val());
					sessionStorage.setItem("data-13",JSON.stringify(val));
				}
			}
		}
	}
	
	function clickReturnBtn(){
		sessionStorage.setItem("data-13","null");
		location.href = "estimateCalculationTwelve.do";
	}
	function clickEstimateBtn(el){
		if($("#answer-a").prop("checked") === false && $("#answer-b").prop("checked") === false && $("#answer-c").prop("checked") === false && $("#answer-d").prop("checked") === false && $("#answer-e").prop("checked") === false && $("#answer-f").prop("checked") === false){
			alert("선택은 필수에요!");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
		}else if($(".count-container").css("display") === "flex" && $(".count-hdd").val() === ""){
			alert("개수를 입력해주세요!");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
			$(".count-hdd").focus();
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
		}else if($(".count-container").css("display") === "flex" && $(".count-hdd").val() === ""){
			alert("개수를 입력해주세요!");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
			$(".count-hdd").focus();
		}else {
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			window.location.href = "estimateCalculationFourteen.do";
		}
	}
	function inputHdd(){
		if(isNaN($(".count-hdd").val())){
			alert("숫자만 입력해주세요!!");
			$(".count-hdd").val("").focus();
		}else {
			let value = [];
			if($("#answer-a").prop("checked") === true){
				value.push("0");
				value.push($(".count-hdd").val());
				sessionStorage.setItem("data-13",JSON.stringify(value))
			}else if($("#answer-b").prop("checked") === true){
				value.push("1");
				value.push($(".count-hdd").val());
				sessionStorage.setItem("data-13",JSON.stringify(value))
			}else if($("#answer-c").prop("checked") === true){
				value.push("2");
				value.push($(".count-hdd").val());
				sessionStorage.setItem("data-13",JSON.stringify(value))
			}else if($("#answer-d").prop("checked") === true){
				value.push("3");
				value.push($(".count-hdd").val());
				sessionStorage.setItem("data-13",JSON.stringify(value))
			}else if($("#answer-e").prop("checked") === true){
				value.push("4");
				value.push($(".count-hdd").val());
				sessionStorage.setItem("data-13",JSON.stringify(value))
			}
		}
	}
	$(function(){
		// donut
		$(".donut-fill").css("left","calc(50% - 22px)");
		animateDonutGauge();
		// typing question text
		let index = 0;
		function typeText() {
			const text = "HDD를 선택해주세요!";
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
		if(sessionStorage.getItem("data-13")){
			const storedData = JSON.parse(sessionStorage.getItem("data-13"));
			for(let i =0; i<storedData.length; i++){
				if (storedData[i] === "0)"){
					$("#answer-a").prop("checked",true);
				}else if (storedData[i] === "1)"){
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
				if(storedData[0] !== "5"){
					$(".count-container").css("display","flex");
					$(".count-hdd").val(storedData[1]);
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
								 <div class="donut-fill"">12</div>
							</div>
						</div>
						<div class="col-8 d-flex p-2">
							<input id="typingInput" class="form-control text-center pt-2 fs-5" type="text" readonly aria-label="예산 편성" disabled />
						</div>
					    <div class="col-2 d-flex flex-column-reverse">
							<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="추가 저장장치를 골라주세요!" style="cursor:pointer">
						</div>
					</div>
					<div class="row pb-5">
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-a">
							<label class="btn btn-outline-secondary w-75" for="answer-a" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">1024GB(1TB)</p></label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-b">
							<label class="btn btn-outline-secondary w-75" for="answer-b" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">2048GB(2TB)</p></label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-c">
							<label class="btn btn-outline-secondary w-75" for="answer-c" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">4096GB(4TB)</p></label>
						</div>
					</div>
					<div class="row pb-5">
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-d">
							<label class="btn btn-outline-secondary w-75" for="answer-d" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">6144GB(6TB)</p></label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-e">
							<label class="btn btn-outline-secondary w-75" for="answer-e" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">8192GB(8TB)</p></label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-f">
							<label class="btn btn-outline-secondary w-75" for="answer-f" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">필요없음</p></label>
						</div>
					</div>
					<div class="row pb-5 w-25 mx-auto count-container" style="display: none;">
						<div class="input-group">
							<input type="text" min="0" class="form-control count-hdd text-end" aria-label="hdd`s count(only number)" placeholder="ex)1 or 2 ..." oninput="javascript:inputHdd()">
							<span class="input-group-text">개</span>
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
