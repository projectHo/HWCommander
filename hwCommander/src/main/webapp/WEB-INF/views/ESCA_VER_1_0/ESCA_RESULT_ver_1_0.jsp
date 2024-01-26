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
<link rel="stylesheet" href="/resources/css/escaResult.css">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

<!-- 08.23 캡쳐 스크립트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>

<script>
	$(function() {
		if (productMaster == ""){
			$("#resultErrorModal").modal("show");
			return false;
		}
		const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();
		// 부품 이름 입력 & 총 가격 계산
		enterPartsText();
		insertRams();
		boxHeadInput();
		answersModal();

		answersMatches();
	})
	function answersMatches(){
		const urlString = location.href;
		var matches = urlString.match(/answer\d+%3C(.*?)%3E/g);
		console.log(matches);
		let values = [];

		for(let i = 0; i < 20; i++){
			if(i != 2 && i != 7 && i != 1){
				let a = matches[i].match(/answer\d{1,2}/);
				let b = matches[i].match(/%3C(.*?)%3E/);
				b = b[1].split("%2C");
				if(b[0] != "null" && b[1] != "null"){
					b.unshift(a[0]);
					values.push(b);
				}
			}else if (i == 1 || i == 2){
				let a = matches[i].match(/answer\d{1,2}/);
				let b = matches[i].match(/%3C(.*?)%3E/)[1];
				let c = b.split("%3A");
				let d = [a[0]];
				c.forEach(function(part) {
					d = d.concat(part.split("%2C"));
				})
				values.push(d);
			}
		}
		console.log(values);
		for(let i = values.length-1 ; i >= 0 ; i--){
			console.log(i);
			if(values[i][0] == "answer0"){
				if(values[i][2] == "0"){
					$(".answer1-p").after('<small><p class="mb-0 pb-1">┖ OS : 프리도스(+0원)</p></small>');
				}else if(values[i][2] == "1"){
					$(".answer1-p").after('<small><p class="mb-0 pb-1">┖ OS : COEM(+150,000원)</p></small>');
				}else if(values[i][2] == "2"){
					$(".answer1-p").after('<small><p class="mb-0 pb-1">┖ OS : Fpp(+180,000원)</p></small>');
				}
			}
			if(values[i][0] == "answer1"){
				$(".answer2-p").after('<small><p class="mb-0 pb-1">┖ 예산 : ' + values[i][2].replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</p></small>");
			}
			if(values[i][0] == "answer2"){
				let answer3a;
				for(let j = values[i].length-2; j >= 1; j-=2){
					if(values[i][j] == "PR000001"){
						answer3a = "Apex Legend";
					}
					if(values[i][j] == "PR000002"){
						answer3a = "Valorant";
					}
					if(values[i][j] == "PR000029"){
						answer3a = "PUBG";
					}
					if(values[i][j] == "PR000032"){
						answer3a = "[FPS 기타]";
					}
					if(values[i][j] == "PR000003"){
						answer3a = "League of Legends";
					}
					if(values[i][j] == "PR000004"){
						answer3a = "Dota 2";
					}
					if(values[i][j] == "PR000005"){
						answer3a = "Heros of the Storm";
					}
					if(values[i][j] == "PR000033"){
						answer3a = "[AOS 기타]";
					}
					if(values[i][j] == "PR000006"){
						answer3a = "Lost Ark";
					}
					if(values[i][j] == "PR000007"){
						answer3a = "Diablo IV";
					}
					if(values[i][j] == "PR000008"){
						answer3a = "Dungeon and Fighter";
					}
					if(values[i][j] == "PR000009"){
						answer3a = "FIFA Online 4";
					}
					if(values[i][j] == "PR000010"){
						answer3a = "Starcraft Remastered";
					}
					if(values[i][j] == "PR000011"){
						answer3a = "Warcraft III Reforged";
					}
					if(values[i][j] == "PR000012"){
						answer3a = "Forza Horizon 5";
					}
					if(values[i][j] == "PR000013"){
						answer3a = "Assetto Corsa";
					}
					if(values[i][j] == "PR000014"){
						answer3a = "Grand Theft Auto V";
					}
					if(values[i][j] == "PR000015"){
						answer3a = "Illustrator";
					}
					if(values[i][j] == "PR000016"){
						answer3a = "PhotoShop";
					}
					if(values[i][j] == "PR000030"){
						answer3a = "CAD";
					}
					if(values[i][j] == "PR000017"){
						answer3a = "Cinema 4D";
					}
					if(values[i][j] == "PR000018"){
						answer3a = "Blender";
					}
					if(values[i][j] == "PR000019"){
						answer3a = "3DS MAX";
					}
					if(values[i][j] == "PR000020"){
						answer3a = "Web Publicing";
					}
					if(values[i][j] == "PR000021"){
						answer3a = "Embedded";
					}
					if(values[i][j] == "PR000022"){
						answer3a = "VSC";
					}
					if(values[i][j] == "PR000023"){
						answer3a = "Premiere Pro";
					}
					if(values[i][j] == "PR000024"){
						answer3a = "DaVinci Resolve";
					}
					if(values[i][j] == "PR000025"){
						answer3a = "PowerDirector";
					}
					if(values[i][j] == "PR000031"){
						answer3a = "After Effect";
					}
					if(values[i][j] == "PR000026"){
						answer3a = "Excel";
					}
					if(values[i][j] == "PR000027"){
						answer3a = "CAPS CCTV";
					}
					if(values[i][j] == "PR000028"){
						answer3a = "SAP ERP";
					}
					$(".answer3-p").after('<small><p class="mb-0 pb-1">┖ 이름 :  ' + answer3a + " / 비중 : " + Math.round(values[i][j+1]) + "%</p></small>");
				}
			}
			if(values[i][0] == "answer3"){
				$(".answer4-p").after('<small><p class="mb-0 pb-1">┖ 발열 : ' + values[i][2] + "점 / 소재 : " + values[i][4] + "점 / AS : " + values[i][6] + "점 / 소음 : " + values[i][8] + "점 / 안정성 : " + values[i][10] + "점 / QC : " + values[i][12] + "점</p></small>");
			}
			if(values[i][0] == "answer4"){
				let answer4;
				if(values[i][2] == "0"){
					answer4 = "필요";
				}else if(values[i][2] == "1"){
					answer4 = "불필요";
				}
				$(".answer5-p").after('<small><p class="mb-0 pb-1">┖ 무선 : ' + answer4 + '</p></small>');
			}
			if(values[i][0] == "answer5"){
				let answer5;
				if(values[i][2] == "0"){
					answer5 = "Intel";
				}else if(values[i][2] == "1"){
					answer5 = "Amd";
				}else {
					answer5 = "상관없음";
				}
				$(".answer6-p").after('<small><p class="mb-0 pb-1">┖ CPU : ' + answer5 + '</p></small>');
			}
			if(values[i][0] == "answer6"){
				let answer6;
				if(values[i][2] == "0"){
					answer6 = "필요";
				}else if(values[i][2] == "1"){
					answer6 = "불필요";
				}else {
					answer6 = "상관없음";
				}
				$(".answer7-p").after('<small><p class="mb-0 pb-1">┖ 내장그래픽 : ' + answer6 + '</p></small>');
			}
			if(values[i][0] == "answer7"){
				let answer7;
				if(values[i][2] == "0"){
					answer7 = "필요";
				}else if(values[i][2] == "1"){
					answer7 = "불필요";
				}else {
					answer7 = "상관없음";
				}
				$(".answer8-p").after('<small><p class="mb-0 pb-1">┖ 수냉쿨러 : ' + answer7 + '</p></small>');
			}
			if(values[i][0] == "answer8"){
				let answer8;
				if(values[i][2] == "0"){
					answer8 = "DDR4";
				}else if(values[i][2] == "1"){
					answer8 = "DDR5";
				}else {
					answer8 = "상관없음";
				}
				$(".answer9-p").after('<small><p class="mb-0 pb-1">┖ 램버전 : ' + answer8 + '</p></small>');
			}
			if(values[i][0] == "answer10"){
				let answer10;
				if(values[i][2] == "0"){
					answer10 = "벌크";
				}else if(values[i][2] == "1"){
					answer10 = "멀티팩";
				}else if(values[i][2] == "2") {
					answer10 = "둘다 좋음";
				}else {
					answer10 = "둘다 싫음";
				}
				$(".answer11-p").after('<small><p class="mb-0 pb-1">┖ 벌크&멀티팩 : ' + answer10 + '</p></small>');
			}
			if(values[i][0] == "answer11"){
				let answer11;
				if(values[i][2] == "0"){
					answer11 = "예산에 맞게";
				}else if(values[i][2] == "1"){
					answer11 = "256GB";
				}else if(values[i][2] == "2") {
					answer11 = "512GB";
				}else if(values[i][2] == "3"){
					answer11 = "1024GB";
				}else {
					answer11 = "2048GB";
				}
				$(".answer12-p").after('<small><p class="mb-0 pb-1">┖ SSD : ' + answer11 + '</p></small>');
			}
		}
	}
	function loginCheck() {
		var check = false;
		if("${loginUser}" == "") {
			alert("로그인 후 이용해주세요.");
			location.href = "/user/login.do";
		}else {
			check = true;
		}
		return check;
	}
	let productMaster = "${productMaster}";
	let mbInfo = "${productMbDetailInfo}";
	let productDet = "${productDetail}";
	let partsRam = "${partsRam}";
	let partsRam2 = "${productRamDetailInfo}";
	let loginUser = "${loginUser}";
	
	// 마스터 리스트화
	const productMasterDetail = productMaster.substring(1, productMaster.length - 1);
	const productMasterSplit = productMasterDetail.split('PartsproductMasterHistoryVO(');
	
	const productMasterResult = {};
	let productMasterIdVal = "";
	let productMasterIndex = 0;
	productMasterSplit.forEach(item => {
	const keyValuePairs = item.split(', ');
	const detail = {};
	keyValuePairs.forEach(pair => {
		const [key, value] = pair.split('=');
		detail[key] = value;
	});
	
	if (!productMasterResult[productMasterIndex]) {
		productMasterResult[productMasterIndex] = [];
	}
	productMasterResult[productMasterIndex].push(detail);	
	productMasterIndex++;
	});
		
		
	// 추천된 마더보드 리스트화
	const mbDetail = mbInfo.substring(1, mbInfo.length - 1);
	const mbSplit = mbDetail.split('PartsMbHistoryVO(');
	
	const mbResult = {};
	let mbIdVal = "";
	let mbIndex = 0;
	mbSplit.forEach(item => {
	const keyValuePairs = item.split(', ');
	const detail = {};
	keyValuePairs.forEach(pair => {
		const [key, value] = pair.split('=');
		detail[key] = value;
	});
	
	if (!mbResult[mbIndex]) {
		mbResult[mbIndex] = [];
	}
	mbResult[mbIndex].push(detail);	
	mbIndex++;
	});

	// 추천된 부품 디테일 리스트화
	const productDetail = productDet.substring(1, productDet.length - 1);
	const productSplit = productDetail.split('ProductDetailVO(');
	
	const productResult = {};
	let productIdVal = "";
	let productIndex = 0;
	productSplit.forEach(item => {
	const keyValuePairs = item.split(', ');
	const detail = {};
	keyValuePairs.forEach(pair => {
		const [key, value] = pair.split('=');
		detail[key] = value;
	});
	
	if (!productResult[productIndex]) {
		productResult[productIndex] = [];
	}
	productResult[productIndex].push(detail);	
	productIndex++;
	});

	// 전체 램 리스트화
	const ramDetail = partsRam.substring(1, partsRam.length - 1);
	const ramSplit = ramDetail.split('PartsRamVO(');

	const ramResult = {};
	var ramIdVal = "";
	let ramIndex = 0;
	ramSplit.forEach(item => {
	const keyValuePairs = item.split(', ');
	const detail = {};
	keyValuePairs.forEach(pair => {
		const [key, value] = pair.split('=');
		detail[key] = value;
	});
	if (!ramResult[ramIndex]) {
		ramResult[ramIndex] = [];
	}
	ramResult[ramIndex].push(detail);
	ramIndex++;
	});

	function enterPartsText () {
		$(".gpu-text").html(productResult[1][0].partsName);
		$(".cpu-text").html(productResult[2][0].partsName);
		$(".mb-text").html(productResult[3][0].partsName);
		$(".cooler-text").html(productResult[4][0].partsName);
		$(".case-text").html(productResult[5][0].partsName);
		$(".psu-text").html(productResult[6][0].partsName);
		$(".ram-text").html(productResult[7][0].partsName);
		$(".ssd-text").html(productResult[8][0].partsName);
		$(".price-text").html("${productMaster.productPriceStr}");
	}
	
	function clickReturnBtn () {
		if(loginCheck()){
			location.href = "/ESCA/ESCASelect.do";
		}
		sessionStorage.clear();
	}
	let orderQtys;
	let boxQtys;
	function clickOrderBtn() {
		// 09.06 오류 상태 추가 및 램 변경시 업데이트 로직 추가 필요
		if(sessionStorage.getItem("pay") == "y"){
			if(loginCheck()){
				location.href = "/order/sheet.do?accessRoute=direct&productIds="+"${productMaster.id}"+"&orderQtys="+orderQtys+"&boxQtys="+boxQtys;
			}
		}else {
			alert("과거 견적 기준으로는 구매하실 수 없습니다!");
		}
	}
	function clickSinglOrderBtn(el){
		if(sessionStorage.getItem("pay") == "y"){
			if(loginCheck()){
				location.href = "/order/sheet.do?accessRoute=direct&productIds="+"${productMaster.id}"+"&orderQtys=1"+"&boxQtys="+$(el).attr("box");
			}
		}else {
			alert("과거 견적 기준으로는 구매하실 수 없습니다!");
		}
	}
	const numberCheck = /^[0-9]+$/;
	function orderCount(el){
		if($(el).val().length>=1 && !numberCheck.test($(el).val())){
			alert("숫자만 입력해주세요");
			$(el).val("");
			return false;
		}
		if(Number($(el).val()) >= Number("${productMaster.productQty}")){
			$("#orderCount").val("${productMaster.productQty}");
		}
		orderQtys = $(el).val();
	}
	function orderBoxCount(el){
		if($(el).val().length>=1 && !numberCheck.test($(el).val())){
			alert("숫자만 입력해주세요");
			$(el).val("");
			return false;
		}
		if(Number($(el).val()) > $("#orderCount").val()){
			$(el).val($("#orderCount").val());
		}
		boxQtys = $(el).val();
	}
	function clickSaveBtn(){
		$("#modal-description").modal("show");
	}

	let differencePrices = [];
	let ramRufIndex = 1;
	let basedRam = productResult[6][0].partsPrice;
	for (let i = 1; i<Object.keys(ramResult).length; i++){
		if(ramResult[i][0].partsPrice !== "0" && ramResult[i][0].partsPrice !== "9999999"){
			let defferenceRam = ramResult[i][0].partsPrice;
			let calcPrices = Number(defferenceRam) - Number(basedRam);
			differencePrices.push(calcPrices);
		}
	}
	function insertRams(){
		for(let i = 1; i<Object.keys(ramResult).length; i++){
			if(ramResult[i][0].partsPrice !== "0" && ramResult[i][0].partsPrice !== "9999999" && mbResult[0][0].memSocCd === ramResult[i][0].memSocCd){
				let li = $("<li></li>");
				let button = $("<button></button>").addClass("dropdown-item").attr("cd",i).attr("nb",ramRufIndex).attr("type","button").attr("onclick","javascript:clickChangeRam(this)").html(ramResult[i][0].partsName + "(" + differencePrices[ramRufIndex-1] + ")");
				li.append(button);
				$(".dropdown-menu.ram").append(li);
				ramRufIndex++;
			}
		}
	}

	function clickChangeRam(e){
		if($(e).attr("cd") === "0"){
			enterPartsText();
		}else {
			const ramCd = $(e).attr("cd");
			const ramI = $(e).attr("nb");
			$(".ram-text").html(ramResult[ramCd][0].partsName);
			$(".price-text").html(((Number("${productMaster.productPrice}") + differencePrices[ramI-1]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원"));
		}
	}
	// 캡쳐 기능
	function clickCaptureBtn(){
		html2canvas(document.querySelector("#capture-container")).then(canvas => {
			$(".change-ram-btn").css("display","none");
			saveAs(canvas.toDataURL('image/png'),"HWC-Capture.png");
			$(".change-ram-btn").css("display","inline-block");
		});
	};
	function saveAs(uri, filename) { 
		var link = document.createElement('a'); 
		if (typeof link.download === 'string') { 
			link.href = uri; 
			link.download = filename; 
			document.body.appendChild(link); 
			link.click(); 
			document.body.removeChild(link); 
		} else { 
			window.open(uri); 
		} 
	}
	function modalButtons(el){
		if($(el).hasClass("btn-secondary")){
			location.href = "/";
			sessionStorage.clear();
		}else {
			sessionStorage.clear();
			location.href = "/ESCA/ESCASelect.do";
		}
	}
	
	function boxHeadInput(){
		$("#id-input").val("ID : " + "${loginUser.id}");
		const currentDate = new Date();
		const year = currentDate.getFullYear();
		const month = String(currentDate.getMonth() + 1).padStart(2, "0");
		const day = String(currentDate.getDate()).padStart(2, "0");
		const hours = currentDate.getHours();
		const minutes = currentDate.getMinutes();
		const seconds = currentDate.getSeconds();
		const formattedDate = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;

		if(sessionStorage.getItem("targetData") == ""){
			$("#date-input").val("Date : " + formattedDate);
		}else if(sessionStorage.getItem("pay") == "y"){
			$("#date-input").val("Date : " + formattedDate);
		}else {
			$("#date-input").val("Date : " + sessionStorage.getItem("targetData"));
		}

		const urlString = location.href;
		const matchedId = urlString.match(/userId%2C([^%]+)/);
		if(matchedId == null){
			const matchedId = urlString.match(/userId%2C([^%]+)/);
		}else {
			const recommenderName = matchedId[1];
			if("${loginUser.id}" != recommenderName){
				$("#recommender-input").parent().css("display","block");
				$("#recommender-input").val("추천인 ID : "+ recommenderName).css("display","block");
			}
		}
	}
	function descriptionInput(el){
		if($(el).val().length > 20){
			alert("20자 이내로 입력해주세요!");
			$(el).val("");
		}
	}
	function goSaveBtn(){
		if("${userEscasStorageVOList.size()}" == 50){
			if(confirm("저장된 견적이 50개 이상입니다. 가장 오래된 견적을 삭제 후 저장하시겠습니까?")){
				$.ajax({
				type: "post",
				url: "/user/escaStorageMaxRegistLogic.do",
				data: {
					userId : "${loginUser.id}",
					escasStorageDescription: $("#modal-description").find("input").val(),
					escasUrlParameter: "${escasUrlParameter}",
					escasLogicVersion: "${escasLogicVersion}"
				},
				dataType: "json",
				success: function() {
					alert("성공적으로 저장되었습니다.");
					if(loginCheck()){
						location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
					}
				},
				error: function() {
					alert("저장에 실패했습니다.");
				}
			})	
			}else {
				return false;
			}
		}else {
			$.ajax({
				type: "post",
				url: "/user/escaStorageRegistLogic.do",
				data: {
					userId : "${loginUser.id}",
					escasStorageDescription: $("#modal-description").find("input").val(),
					escasUrlParameter: "${escasUrlParameter}",
					escasLogicVersion: "${escasLogicVersion}"
				},
				dataType: "json",
				success: function() {
					alert("성공적으로 저장되었습니다.");
					if(loginCheck()){
						location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
					}
				},
				error: function() {
					alert("저장에 실패했습니다.");
				}
			})
		}
	}
	function answersModal(){
		if(sessionStorage.getItem("data-0") == "0"){
			$("#answerCheck .modal-body").append("<p>질문 1 : 프리도스(+0원)</p>");
		}else if(sessionStorage.getItem("data-0") == "1"){
			$("#answerCheck .modal-body").append("<p>질문 1 : COEM(+150,000원)</p>");
		}else if(sessionStorage.getItem("data-0") == "2"){
			$("#answerCheck .modal-body").append("<p>질문 1 : Fpp(+180,000원)</p>");
		}
		let answer2 = Number(sessionStorage.getItem("data-1"))*10000;
		answer2 = answer2.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$("#answerCheck .modal-body").append("<p>질문 2 : " + answer2 + "원</p>");

		const answer3 = JSON.parse(sessionStorage.getItem("data-2"));
		let answer3a;
		$("#answerCheck .modal-body").append("<p>질문 3 : 사용 목적 ⤵️</p>");
		if(answer3.length > 1){
			for(let i = 0; i < answer3.length ; i++){
				if(answer3[i][0] == "PR000001"){
					$("#answerCheck .modal-body").append("<p>이름 = Apex Legend" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Apex Legend";
				}
				if(answer3[i][0] == "PR000002"){
					$("#answerCheck .modal-body").append("<p>이름 = Valorant" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Valorant";
				}
				if(answer3[i][0] == "PR000029"){
					$("#answerCheck .modal-body").append("<p>이름 = PUBG" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "PUBG";
				}
				if(answer3[i][0] == "PR000032"){
					$("#answerCheck .modal-body").append("<p>이름 = [FPS 기타]" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "[FPS 기타]";
				}
				if(answer3[i][0] == "PR000003"){
					$("#answerCheck .modal-body").append("<p>이름 = League of Legends" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "League of Legends";
				}
				if(answer3[i][0] == "PR000004"){
					$("#answerCheck .modal-body").append("<p>이름 = Dota 2" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Dota 2";
				}
				if(answer3[i][0] == "PR000005"){
					$("#answerCheck .modal-body").append("<p>이름 = Heros of the Storm" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Heros of the Storm";
				}
				if(answer3[i][0] == "PR000033"){
					$("#answerCheck .modal-body").append("<p>이름 = [AOS 기타]" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "[AOS 기타]";
				}
				if(answer3[i][0] == "PR000006"){
					$("#answerCheck .modal-body").append("<p>이름 = Lost Ark" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Lost Ark";
				}
				if(answer3[i][0] == "PR000007"){
					$("#answerCheck .modal-body").append("<p>이름 = Diablo IV" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Diablo IV";
				}
				if(answer3[i][0] == "PR000008"){
					$("#answerCheck .modal-body").append("<p>이름 = Dungeon and Fighter" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Dungeon and Fighter";
				}
				if(answer3[i][0] == "PR000009"){
					$("#answerCheck .modal-body").append("<p>이름 = FIFA Online 4" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "FIFA Online 4";
				}
				if(answer3[i][0] == "PR000010"){
					$("#answerCheck .modal-body").append("<p>이름 = Starcraft Remastered" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Starcraft Remastered";
				}
				if(answer3[i][0] == "PR000011"){
					$("#answerCheck .modal-body").append("<p>이름 = Warcraft III Reforged" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Warcraft III Reforged";
				}
				if(answer3[i][0] == "PR000012"){
					$("#answerCheck .modal-body").append("<p>이름 = Forza Horizon 5" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Forza Horizon 5";
				}
				if(answer3[i][0] == "PR000013"){
					$("#answerCheck .modal-body").append("<p>이름 = Assetto Corsa" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Assetto Corsa";
				}
				if(answer3[i][0] == "PR000014"){
					$("#answerCheck .modal-body").append("<p>이름 = Grand Theft Auto V" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Grand Theft Auto V";
				}
				if(answer3[i][0] == "PR000015"){
					$("#answerCheck .modal-body").append("<p>이름 = Illustrator" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Illustrator";
				}
				if(answer3[i][0] == "PR000016"){
					$("#answerCheck .modal-body").append("<p>이름 = PhotoShop" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "PhotoShop";
				}
				if(answer3[i][0] == "PR000030"){
					$("#answerCheck .modal-body").append("<p>이름 = CAD" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "CAD";
				}
				if(answer3[i][0] == "PR000017"){
					$("#answerCheck .modal-body").append("<p>이름 = Cinema 4D" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Cinema 4D";
				}
				if(answer3[i][0] == "PR000018"){
					$("#answerCheck .modal-body").append("<p>이름 = Blender" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Blender";
				}
				if(answer3[i][0] == "PR000019"){
					$("#answerCheck .modal-body").append("<p>이름 = 3DS MAX" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "3DS MAX";
				}
				if(answer3[i][0] == "PR000020"){
					$("#answerCheck .modal-body").append("<p>이름 = Web Publicing" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Web Publicing";
				}
				if(answer3[i][0] == "PR000021"){
					$("#answerCheck .modal-body").append("<p>이름 = Embedded" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Embedded";
				}
				if(answer3[i][0] == "PR000022"){
					$("#answerCheck .modal-body").append("<p>이름 = VSC" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "VSC";
				}
				if(answer3[i][0] == "PR000023"){
					$("#answerCheck .modal-body").append("<p>이름 = Premiere Pro" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Premiere Pro";
				}
				if(answer3[i][0] == "PR000024"){
					$("#answerCheck .modal-body").append("<p>이름 = DaVinci Resolve" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "DaVinci Resolve";
				}
				if(answer3[i][0] == "PR000025"){
					$("#answerCheck .modal-body").append("<p>이름 = PowerDirector" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "PowerDirector";
				}
				if(answer3[i][0] == "PR000031"){
					$("#answerCheck .modal-body").append("<p>이름 = After Effect" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "After Effect";
				}
				if(answer3[i][0] == "PR000026"){
					$("#answerCheck .modal-body").append("<p>이름 = Excel" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "Excel";
				}
				if(answer3[i][0] == "PR000027"){
					$("#answerCheck .modal-body").append("<p>이름 = CAPS CCTV" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "CAPS CCTV";
				}
				if(answer3[i][0] == "PR000028"){
					$("#answerCheck .modal-body").append("<p>이름 = SAP ERP" + " / 비중 = " + answer3[i][1] + "</p>");
					answer3a = "SAP ERP";
				}
			}
		}else {
			if(answer3[0][0] == "PR000001"){
					answer3a = "Apex Legend";
				}
				if(answer3[0][0] == "PR000002"){
					answer3a = "Valorant";
				}
				if(answer3[0][0] == "PR000029"){
					answer3a = "PUBG";
				}
				if(answer3[0][0] == "PR000032"){
					answer3a = "[FPS 기타]";
				}
				if(answer3[0][0] == "PR000003"){
					answer3a = "League of Legends";
				}
				if(answer3[0][0] == "PR000004"){
					answer3a = "Dota 2";
				}
				if(answer3[0][0] == "PR000005"){
					answer3a = "Heros of the Storm";
				}
				if(answer3[0][0] == "PR000033"){
					answer3a = "[AOS 기타]";
				}
				if(answer3[0][0] == "PR000006"){
					answer3a = "Lost Ark";
				}
				if(answer3[0][0] == "PR000007"){
					answer3a = "Diablo IV";
				}
				if(answer3[0][0] == "PR000008"){
					answer3a = "Dungeon and Fighter";
				}
				if(answer3[0][0] == "PR000009"){
					answer3a = "FIFA Online 4";
				}
				if(answer3[0][0] == "PR000010"){
					answer3a = "Starcraft Remastered";
				}
				if(answer3[0][0] == "PR000011"){
					answer3a = "Warcraft III Reforged";
				}
				if(answer3[0][0] == "PR000012"){
					answer3a = "Forza Horizon 5";
				}
				if(answer3[0][0] == "PR000013"){
					answer3a = "Assetto Corsa";
				}
				if(answer3[0][0] == "PR000014"){
					answer3a = "Grand Theft Auto V";
				}
				if(answer3[0][0] == "PR000015"){
					answer3a = "Illustrator";
				}
				if(answer3[0][0] == "PR000016"){
					answer3a = "PhotoShop";
				}
				if(answer3[0][0] == "PR000030"){
					answer3a = "CAD";
				}
				if(answer3[0][0] == "PR000017"){
					answer3a = "Cinema 4D";
				}
				if(answer3[0][0] == "PR000018"){
					answer3a = "Blender";
				}
				if(answer3[0][0] == "PR000019"){
					answer3a = "3DS MAX";
				}
				if(answer3[0][0] == "PR000020"){
					answer3a = "Web Publicing";
				}
				if(answer3[0][0] == "PR000021"){
					answer3a = "Embedded";
				}
				if(answer3[0][0] == "PR000022"){
					answer3a = "VSC";
				}
				if(answer3[0][0] == "PR000023"){
					answer3a = "Premiere Pro";
				}
				if(answer3[0][0] == "PR000024"){
					answer3a = "DaVinci Resolve";
				}
				if(answer3[0][0] == "PR000025"){
					answer3a = "PowerDirector";
				}
				if(answer3[0][0] == "PR000031"){
					answer3a = "After Effect";
				}
				if(answer3[0][0] == "PR000026"){
					answer3a = "Excel";
				}
				if(answer3[0][0] == "PR000027"){
					answer3a = "CAPS CCTV";
				}
				if(answer3[0][0] == "PR000028"){
					answer3a = "SAP ERP";
				}
			$("#answerCheck .modal-body").append("<p>이름 = " + answer3a + " / 비중 = " + answer3[0][1] + "</p>");
		}
		if(sessionStorage.getItem("data-3")){
			let answer4 = JSON.parse(sessionStorage.getItem("data-3"));
			$("#answerCheck .modal-body").append("<p>질문 4 : 발열(" + answer4[0]  + "), 소재(" + answer4[1] + "), AS(" + answer4[2] + "), 소음(" + answer4[3] + "), 안정성(" + answer4[4] + "), QC(" + answer4[5] + "</p>");
		}
		if(sessionStorage.getItem("data-4")){
			if(sessionStorage.getItem("data-4") == 0) {
				$("#answerCheck .modal-body").append("<p>질문 5(블루투스) : 필요합니다</p>");
			}else if(sessionStorage.getItem("data-4") == 1){
				$("#answerCheck .modal-body").append("<p>질문 5(블루투스) : 필요없습니다</p>");
			}
		}

		if(sessionStorage.getItem("data-5")){
			if(sessionStorage.getItem("data-5") == 0) {
				$("#answerCheck .modal-body").append("<p>질문 6(CPU) : Intel</p>");
			}else if(sessionStorage.getItem("data-5") == 1){
				$("#answerCheck .modal-body").append("<p>질문 6(CPU) : AMD</p>");
			}else if(sessionStorage.getItem("data-5") == 2){
				$("#answerCheck .modal-body").append("<p>질문 6(CPU) : 상관없음</p>");
			}
		}

		if(sessionStorage.getItem("data-6")){
			if(sessionStorage.getItem("data-6") == 0) {
				$("#answerCheck .modal-body").append("<p>질문 7(내장그래픽) : 필요합니다</p>");
			}else if(sessionStorage.getItem("data-6") == 1){
				$("#answerCheck .modal-body").append("<p>질문 7(내장그래픽) : 필요없습니다</p>");
			}else if(sessionStorage.getItem("data-6") == 2){
				$("#answerCheck .modal-body").append("<p>질문 7(내장그래픽) : 상관없음</p>");
			}
		}

		if(sessionStorage.getItem("data-7")){
			if(sessionStorage.getItem("data-7") == 0) {
				$("#answerCheck .modal-body").append("<p>질문 8(수냉쿨러) : 선호</p>");
			}else if(sessionStorage.getItem("data-7") == 1){
				$("#answerCheck .modal-body").append("<p>질문 8(수냉쿨러) : 비선호</p>");
			}else if(sessionStorage.getItem("data-7") == 2){
				$("#answerCheck .modal-body").append("<p>질문 8(수냉쿨러) : 상관없음</p>");
			}
		}

		if(sessionStorage.getItem("data-9")){
			if(sessionStorage.getItem("data-9") == 0) {
				$("#answerCheck .modal-body").append("<p>질문 10(램) : DDR4</p>");
			}else if(sessionStorage.getItem("data-9") == 1){
				$("#answerCheck .modal-body").append("<p>질문 10(램) : DDR5</p>");
			}else if(sessionStorage.getItem("data-9") == 2){
				$("#answerCheck .modal-body").append("<p>질문 10(램) : 상관없음</p>");
			}
		}

		if(sessionStorage.getItem("data-10")){
			if(sessionStorage.getItem("data-10") == 0) {
				$("#answerCheck .modal-body").append("<p>질문 11 : 벌크</p>");
			}else if(sessionStorage.getItem("data-10") == 1){
				$("#answerCheck .modal-body").append("<p>질문 11 : 멀티팩</p>");
			}else if(sessionStorage.getItem("data-10") == 2){
				$("#answerCheck .modal-body").append("<p>질문 11 : 둘다 좋음</p>");
			}else if(sessionStorage.getItem("data-10") == 3){
				$("#answerCheck .modal-body").append("<p>질문 11 : 둘다 싫음</p>");
			}
		}

		if(sessionStorage.getItem("data-11")){
			if(sessionStorage.getItem("data-11") == 0) {
				$("#answerCheck .modal-body").append("<p>질문 12(SSD) : 예산에 맞게</p>");
			}else if(sessionStorage.getItem("data-11") == 1){
				$("#answerCheck .modal-body").append("<p>질문 12(SSD) : 256GB</p>");
			}else if(sessionStorage.getItem("data-11") == 2){
				$("#answerCheck .modal-body").append("<p>질문 12(SSD) : 512GB</p>");
			}else if(sessionStorage.getItem("data-11") == 3){
				$("#answerCheck .modal-body").append("<p>질문 12(SSD) : 1024GB</p>");
			}else if(sessionStorage.getItem("data-11") == 4){
				$("#answerCheck .modal-body").append("<p>질문 12(SSD) : 2048GB</p>");
			}
		}
	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="modal fade" id="resultErrorModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
			<div class="modal-header">
			  <h1 class="modal-title fs-5">견적산출 오류!</h1>
			</div>
			<div class="modal-body">
			  견적 산출 중 오류가 발생했습니다...!!<br>조건을 바꿔서 다시하시거나 이벤트몰을 이용해주세요!
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-secondary" onclick="javascript:modalButtons(this)">홈페이지</button>
			  <button type="button" class="btn btn-primary" onclick="javascript:modalButtons(this)">다시하기</button>
			</div>
		  </div>
		</div>
	  </div>
	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="justify-content-start escaResult-empty-space"></div>
			<!-- 작업영역 -->
			<div id="capturedImage"></div>
			<div class="estimateCalc_background container" id="capture-container">
				<div class="row justify-content-center">
					<div class="row w-100">
						<div class="col-md-2">
							<div class="input-group mb-3 w-100">
								<input type="text" class="form-control pb-0 ps-3" id="id-input"aria-label="Text input with checkbox" value="ID : error" style="background-color: #fff;" disabled>
							</div>
						</div>
						<div class="col"></div>
						<div class="col-md-2">
							<div class="input-group w-100 result-inputs" style="display: none;">
								<input type="text" class="form-control pb-0 ps-3 w-100" id="recommender-input" value="추천인 : 오류" style="background-color: #fff;" disabled>
							</div>
						</div>
						<div class="col-md-3">
							<div class="input-group w-100 result-inputs">
								<input type="text" class="form-control pb-0 ps-3" id="date-input"aria-label="Text input with checkbox" value="Date : 0000-00-00" style="background-color: #fff;" disabled>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="card mb-3">
							<div class="row g-0">
							  <div class="col-md-4 pt-3 ps-2">
								<img src="${productMaster.productImage}" class="img-fluid rounded-start" alt="...">
								<p class="p-2">제품 견본 이미지는 케이스의 외관을 보여드리기 위함입니다. 내장제품의 형태가 상이하니 케이스의 형태만 확인하여 선택 부탁드립니다.</p>
							  </div>
							  <div class="col-md-8">
								<div class="card-body">
									<div class="row">
										<div class="col-md">
											<h4 class="card-title position-relative result-index">제품 상세 정보</h4>
										</div>
										<div class="col-md d-md-flex gap-2 justify-content-end">
											<!-- <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#answerCheck">질문 확인</button> -->
											<div class="dropdown">
												<!-- data-bs-toggle="dropdown" -->
												<button class="btn btn-secondary dropdown-toggle change-ram-btn" type="button" aria-expanded="false" onclick="javascript:alert('준비중입니다')">
													Ram 변경하기
												</button>
												<ul class="dropdown-menu ram">
													<li><button class="dropdown-item" cd="0" type="button" onclick="clickChangeRam(this)">추천 램으로 돌아가기</button></li>
												</ul>
											</div>
											<div class="dropdown">
												<button class="btn btn-secondary dropdown-toggle change-case-btn" type="button" aria-expanded="false" onclick="javascript:alert('준비중입니다')">
													케이스 변경하기
												</button>
												<ul class="dropdown-menu">
													<li></li>
												</ul>
											</div>
										</div>
									</div>
									<div class="container mb-3 position-relative result-index">
										<p class="card-text mb-0 fw-bold answer2-p">가격 : <span class="fw-normal price-text">오류</span></p>
										<p class="card-text mb-0 fw-bold answer6-p answer7-p">CPU : <span class="fw-normal cpu-text">오류</span></p>
										<p class="card-text mb-0 fw-bold answer8-p">Cooler : <span class="fw-normal cooler-text">오류</span></p>
										<p class="card-text mb-0 fw-bold answer5-p">MB : <span class="fw-normal mb-text">오류</span></p>
										<p class="card-text mb-0 fw-bold answer9-p">RAM : <span class="fw-normal ram-text">오류</span></p>
										<p class="card-text mb-0 fw-bold">GPU : <span class="fw-normal gpu-text">오류</span></p>
										<p class="card-text mb-0 fw-bold">SSD : <span class="fw-normal ssd-text">오류</span></p>
										<p class="card-text mb-0 fw-bold">CASE : <span class="fw-normal case-text">오류</span></p>
										<p class="card-text mb-0 fw-bold">PSU : <span class="fw-normal psu-text">오류</span></p>
										<p class="card-text mb-0 fw-bold answer1-p">OS : <span class="fw-normal">${productMaster.windowsName}</span></p>
										<p class="card-text mb-0 fw-bold answer3-p">사용 용도</p>
										<p class="card-text mb-0 fw-bold answer4-p answer11-p">기타 질문들</p>
									</div>
									<!-- <h4 class="card-title">제품 설명</h4>
									<div class="container mb-3">
										<p class="card-text fw-bold">제품설명블라블라</p>
									</div> -->
									<h4 class="card-title position-relative result-index">배송 정보</h4>
									<div class="container mb-3 position-relative result-index">
										<p class="card-text mb-0 fw-bold pb-1">배송기간 : <span class="fw-normal delivery-period">영업일 기준 1~2일</span></p>
										<p class="card-text mb-0 fw-bold pb-1">택배사 : <span class="fw-normal delivery-period">우체국택배</span></p>
										<p class="card-text mb-0 fw-bold"><small class="text-muted">도서산간 지역의 경우 배송이 제한되거나 추가요금이 발생할 수 있습니다.</small></p>
										<p class="card-text"><small class="text-muted">AS 기준은 각 부품의 유통사 규정에 따르며 해당 쇼핑몰에서 1년간 무상 AS를 지원해드립니다.</small></p>
									</div>
								</div>
							  </div>
							</div>
						  </div>
					</div>
				</div>
				<div class="row">
					<div class="col-md result-buttom-btns result-ret-btn">
						<button type="button" class="form-control" onclick="javascript:clickReturnBtn()">다시하기</button>
					</div>
					<div class="col-md-3 result-buttom-btns"></div>
					<div class="col-md result-buttom-btns">
						<c:if test="${productMaster.productQty > 1}">
							<button type="button" class="form-control btn btn-primary" data-bs-toggle="modal" data-bs-target="#orderCheck">주문하기</button>
						</c:if>
						<c:if test="${productMaster.productQty == 1}">
							<button type="button" class="form-control btn btn-primary" data-bs-toggle="modal" data-bs-target="#orderBoxCheck">주문하기</button>
						</c:if>
					</div>
					<div class="col-md result-buttom-btns">
						<button type="button" class="form-control" onclick="javascript:clickCaptureBtn()">캡쳐하기</button>
					</div>
					<div class="col-md result-buttom-btns">
						<button type="button" class="form-control" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="질문에 대한 답변들을 저장합니다. 추후 견적 산출시 현재 견적과 다를 수 있으니 참고 부탁드립니다!!" onclick="javascript:clickSaveBtn()">질문저장</button>
					</div>
				</div>
	 		</div>
			<div class="modal fade" data-bs-backdrop="static" id="modal-description" tabindex="-1" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5">질문 저장하기</h1>
						</div>
						<div class="modal-body">
							<h3 class="text-center">견적의 이름을 입력해주세요!</h3>
							<input type="text" class="form-control" placeholder="최대 20자" oninput="javascript:descriptionInput(this)">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" onclick="javascript:goSaveBtn()">저장</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end escaResult-empty-space"></div>
		</div>
		<!-- 주문 수량 모달 -->
		<div class="modal fade" id="orderCheck" tabindex="-1" data-bs-keyboard="false" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">주문 수량확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="d-flex gap-2">
							<div class="w-50">
								<div class="form-floating">
									<input type="text" class="form-control" id="orderCount" autocomplete="off" oninput="javascript:orderCount(this)">
									<label for="orderCount">주문 수량(최대 ${productMaster.productQty}개)</label>
								</div>
							</div>
							<div class="w-50">
								<div class="form-floating">
									<input type="text" class="form-control" id="orderBoxCount" autocomplete="off" oninput="javascript:orderBoxCount(this)">
									<label for="orderBoxCount">박스 추가수량(개당 5,000원)</label>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" onclick="javascript:clickOrderBtn()">주문하기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 재고 1개 인 경우 박스추가 모달 -->
		<div class="modal fade" id="orderBoxCheck" tabindex="-1" data-bs-keyboard="false" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">사용된 제품 박스 추가</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						사용된 제품들의 박스를 추가할까요?(5,000원)
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" box="0" onclick="javascript:clickSingleOrderBtn(this)">아니요</button>
						<button type="button" class="btn btn-primary" box="1" onclick="javascript:clickSingleOrderBtn(this)">네</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 질문답변 확인용 모달 -->
		<div class="modal fade" id="answerCheck" tabindex="-1" data-bs-keyboard="true" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h1 class="modal-title fs-5">질문 답변확인</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 2022.11.16 디자인이미지 추가 -->
		<div class="mt-5 mx-5" style="height: 15%!important;">
			<img class="img-fluid float-end" src="/resources/img/layer-34-1200x107.png" alt="">
		</div>
		<div class="mt-2 mx-5" style="height: 15%!important;">
			<img class="img-fluid" src="/resources/img/layer-26.png" alt="">
		</div>
	</div>
	<input type="hidden" name="${userEscasStorageVOList.size()}" class="storage-size">
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
