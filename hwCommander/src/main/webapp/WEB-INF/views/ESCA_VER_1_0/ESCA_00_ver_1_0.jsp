<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.File" %>
<html>
<head>
<title>HWCommander - 견적산출</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<link rel="stylesheet" href="/resources/css/ver_02/escaBase.css">
<link rel="stylesheet" href="/resources/css/ver_02/esca_00.css">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<!-- 질문 4번 js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-dragdata"></script>

<!-- 견적산출 js -->

<script src="/resources/js/escaSendData.js"></script>
<script>
	$(function() {

	})
	const loginUser = "${loginUser}";
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
	function questionBtns(el){
		if(loginCheck()){
			if($(el).hasClass("active")){
				return false;
			}
			$(".esca-left-side button").removeClass("btn-lg p-3 active").addClass("border-0 ms-2 btn-outline-secondary");
			$(el).removeClass("btn-outline-secondary border-0 ms-2").addClass("p-3 btn-lg active");

			let question = $(el).attr("question");
			const values = ["09","13","14","15","16","17","18","19","20"];
			if(!values.indexOf(question) === -1){
				return false;
			}
			
			$(".question-box-item").hide();
			for(let i = 0; i < $(".question-box-item").length ; i++){
				if($(".question-box-item").eq(i).attr("question") == question){
					$(".question-box-item").eq(i).toggle();
				}
			}
			
			$(".esca-prev-btn").attr("question",(Number(question) - 1).toString().padStart(2,'0'));
			$(".esca-next-btn").attr("question",(Number(question) + 1).toString().padStart(2,'0'));
			if($(".esca-prev-btn").attr("question") == "00"){
				$(".esca-prev-btn").attr("disabled",true);
			}else {
				$(".esca-prev-btn").attr("disabled",false);
			}

			if($(".esca-next-btn").attr("question") == "13"){
				$(".esca-next-btn").attr("disabled",true);
			}else {
				$(".esca-next-btn").attr("disabled",false);
			}

			if(question == "01"){
				$(".q-badge").removeClass("text-primary border-primary").addClass("text-secondary border-secondary");
				$(".q-badge").eq(0).removeClass("text-secondary border-secondary").addClass("text-primary border-primary");
			}else if(question == "02"){
				$(".q-badge").removeClass("text-primary border-primary").addClass("text-secondary border-secondary");
				$(".q-badge").eq(1).removeClass("text-secondary border-secondary").addClass("text-primary border-primary");
			}else if(question == "03"){
				$(".q-badge").removeClass("text-primary border-primary").addClass("text-secondary border-secondary");
				$(".q-badge").eq(2).addClass("text-primary border-primary").removeClass("text-secondary border-secondary");
			}else {
				$(".q-badge").removeClass("text-primary border-primary").addClass("text-secondary border-secondary");
			}
		}
	}

	function moveQuestion(num){
		if(loginCheck()){
			let questionNum = num;
			if(questionNum == "08"){
				$(".esca-next-btn").attr("question","10");
				$(".esca-prev-btn").attr("question","07");
			}else if(questionNum == "10"){
				$(".esca-next-btn").attr("question","11");
				$(".esca-prev-btn").attr("question","08");
			}else {
				$(".esca-prev-btn").attr("question",(Number(questionNum) - 1).toString().padStart(2,'0'));
				$(".esca-next-btn").attr("question",(Number(questionNum) + 1).toString().padStart(2,'0'));
			}
			$(".esca-left-side button").each(function(){
				if($(this).attr("question") == questionNum){
					$(this).removeClass("btn-outline-secondary border-0 ms-2").addClass("p-3 btn-lg active");
				}else{
					$(this).removeClass("btn-lg p-3 active").addClass("border-0 ms-2 btn-outline-secondary");
				}
			})
	
			$(".question-box-item").hide();
			for(let i = 0; i < $(".question-box-item").length ; i++){
				if($(".question-box-item").eq(i).attr("question") == questionNum){
					$(".question-box-item").eq(i).toggle();
				}
			}

			if($(".esca-prev-btn").attr("question") == "00"){
				$(".esca-prev-btn").attr("disabled",true);
			}else {
				$(".esca-prev-btn").attr("disabled",false);
			}

			if($(".esca-next-btn").attr("question") == "13"){
				$(".esca-next-btn").attr("disabled",true);
			}else {
				$(".esca-next-btn").attr("disabled",false);
			}

			
			if(questionNum == "01"){
				$(".q-badge").removeClass("text-primary border-primary").addClass("text-secondary border-secondary");
				$(".q-badge").eq(0).removeClass("text-secondary border-secondary").addClass("text-primary border-primary");
			}else if(questionNum == "02"){
				$(".q-badge").removeClass("text-primary border-primary").addClass("text-secondary border-secondary");
				$(".q-badge").eq(1).removeClass("text-secondary border-secondary").addClass("text-primary border-primary");
			}else if(questionNum == "03"){
				$(".q-badge").removeClass("text-primary border-primary").addClass("text-secondary border-secondary");
				$(".q-badge").eq(2).removeClass("text-secondary border-secondary").addClass("text-primary border-primary");
			}else {
				$(".q-badge").removeClass("text-primary border-primary").addClass("text-secondary border-secondary");
			}
		}
	}
	function prevBtn(el){
		moveQuestion($(el).attr("question"));
	}
	function nextBtn(el){
		moveQuestion($(el).attr("question"));
	}
	function estimateBtn(el){
		if($(".esca-left-side button").eq(0).attr("bool") == "0"){
			return false;
		}

		if($(".esca-left-side button").eq(1).attr("bool") == "0"){
			return false;
		}
		if($(".esca-left-side button").eq(2).attr("bool") == "0"){
			return false;
		}

		$(el).attr("disabled",false);
		sendAllData();
	}
	function checkBools(){
		if($(".esca-left-side button").eq(0).attr("bool") == "0" || !$(".esca-left-side button").eq(0).attr("bool")){
			return false;
		}else if($(".esca-left-side button").eq(1).attr("bool") == "0" || !$(".esca-left-side button").eq(1).attr("bool")){
			return false;
		}else if($(".esca-left-side button").eq(2).attr("bool") == "0" || !$(".esca-left-side button").eq(2).attr("bool")){
			return false;
		}else {
			$(".esca-btn").attr("disabled",false);
		}

	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	
	<div class="esca-container py-5 w-100">
		<div class="container mb-5">
			<div class="esca-box">
				<h1 class="fw-bold text-white text-center esca-head-text pb-5 mb-0">견적산출</h1>
				<div class="d-flex">
					<div class="d-flex flex-column gap-2 p-4 w-25 esca-left-side">
						<h3 class="fw-bold text-white">질문 목록</h3>
						<button type="button" class="btn position-relative btn-lg text-start p-3 px-4 fw-bold active d-flex justify-content-between align-items-center" question="01" onclick="javascript:questionBtns(this)"><span>질문 01</span><span class="text-primary border-primary border-1 border fs-6 px-4 rounded-pill q-badge">필수</span></button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2 d-flex justify-content-between align-items-center" question="02" onclick="javascript:questionBtns(this)"><span>질문 02</span><span class="text-secondary border-secondary border-1 border fs-6 px-4 rounded-pill q-badge">필수</span></button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2 d-flex justify-content-between align-items-center" question="03" onclick="javascript:questionBtns(this)"><span>질문 03</span><span class="text-secondary border-secondary border-1 border fs-6 px-4 rounded-pill q-badge">필수</span></button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2 d-flex justify-content-between align-items-center" question="04" onclick="javascript:questionBtns(this)"><span>질문 04</span><span class="text-secondary border-secondary border-1 border fs-6 px-4 rounded-pill q-badge">권장</span></button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="05" onclick="javascript:questionBtns(this)">질문 05</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="06" onclick="javascript:questionBtns(this)">질문 06</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="07" onclick="javascript:questionBtns(this)">질문 07</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="08" onclick="javascript:questionBtns(this)">질문 08</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="09" onclick="javascript:questionBtns(this)" disabled>질문 09(준비중)</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="10" onclick="javascript:questionBtns(this)">질문 10</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="11" onclick="javascript:questionBtns(this)">질문 11</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="12" onclick="javascript:questionBtns(this)">질문 12</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="13" onclick="javascript:questionBtns(this)" disabled>질문 13(준비중)</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="14" onclick="javascript:questionBtns(this)" disabled>질문 14(준비중)</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="15" onclick="javascript:questionBtns(this)" disabled>질문 15(준비중)</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="16" onclick="javascript:questionBtns(this)" disabled>질문 16(준비중)</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="17" onclick="javascript:questionBtns(this)" disabled>질문 17(준비중)</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="18" onclick="javascript:questionBtns(this)" disabled>질문 18(준비중)</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="19" onclick="javascript:questionBtns(this)" disabled>질문 19(준비중)</button>
						<button type="button" class="btn position-relative btn-outline-secondary border-0 text-start fw-bold px-4 ms-2" question="20" onclick="javascript:questionBtns(this)" disabled>질문 20(준비중)</button>
					</div>

					<div class="d-flex flex-column gap-3 p-4 px-5 flex-grow-1 w-75 question-boxs">
						<!-- 질문1 시작 -->

						<script>
							function q1ButtonToggle(el){
								if(!$(el).hasClass("active")){
									$(".q1-buttons").each(function(){
										if($(this).hasClass("active")){
											$(this).button("toggle");
										}
									})
									$(".descriptionForButtons").hide();
									$(el).button("toggle");
									$(el).next(".descriptionForButtons").show();
									$(".esca-left-side button").eq(0).addClass("done");
									sessionStorage.setItem("data-0",$(el).attr("button-cd"));
									$(".esca-left-side button").eq(0).attr("bool","1");
								}else {
									$(".esca-left-side button").eq(0).removeClass("done");
									$(el).button("toggle");
									$(el).next(".descriptionForButtons").hide();
									sessionStorage.setItem("data-0","");
									$(".esca-left-side button").eq(0).attr("bool","0");
								}
								checkBools();
							}
						</script>

						<div class="question-box-item w-100 flex-grow-1" question="01">
							
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">OS(윈도우) 라이센스가 필요하신가요?</h3>
								<h5 class="text-white fw-bold">버튼 클릭 시 상세 설명을 보실 수 있습니다.</h5>
							</div>
							
							<div class="d-flex gap-4 mb-3 w-75 position-relative">
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center position-relative flex-1 check q1-buttons" button-cd="0" onclick="javascript:q1ButtonToggle(this)">
									<span class="text-white fw-semibold">프리도스</span>
									<span class="text-white fw-semibold">(0원)</span>
								</button>
								<div class="position-absolute descriptionForButtons" id="descriptionForButton1" style="display: none;">
									<div class="d-flex flex-column gap-3 p-4 position-relative">
										<span class="text-white fw-bold">프리도스(OS 미설치)</span>
										<span class="text-white fw-semibold mb-3">구매 후 바로 사용하실 수 없고 윈도우를 직접 설치하셔야 합니다. 최적화가 되어있지 않고, 드라이버가 담긴 USB를 제공합니다</span>
										<span class="text-secondary fw-bold">*최적화란?</span>
										<span class="text-secondary fw-semibold">윈도우 최적화, 드라이버 업데이트, 바이오스 설정 및 업데이트, 각 업데이트 내용은 이슈 없는 버전으로 리빌딩합니다.</span>
									</div>
								</div>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center position-relative flex-1 check q1-buttons" button-cd="1" onclick="javascript:q1ButtonToggle(this)">
									<span class="text-white fw-semibold">COEM</span>
									<span class="text-white fw-semibold">(150,000원)</span>
								</button>
								<div class="position-absolute descriptionForButtons" id="descriptionForButton2" style="display: none;">
									<div class="d-flex flex-column gap-3 p-4 position-relative">
										<span class="text-white fw-bold">COEM(메인보드 귀속형)</span>
										<span class="text-white fw-semibold mb-3">최적화 작업을 무상 진행합니다. 윈도우는 해당 PC를 폐기하거나 메인보드의 수명이 다하거나 당사 귀책 외의 사항으로 교체 시 라이선스를 재구매하셔야 합니다</span>
										<span class="text-secondary fw-bold">*최적화란?</span>
										<span class="text-secondary fw-semibold">윈도우 최적화, 드라이버 업데이트, 바이오스 설정 및 업데이트, 각 업데이트 내용은 이슈 없는 버전으로 리빌딩합니다.</span>
									</div>
								</div>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center position-relative flex-1 check q1-buttons" button-cd="2" onclick="javascript:q1ButtonToggle(this)">
									<span class="text-white fw-semibold">FPP</span>
									<span class="text-white fw-semibold">(180,000원)</span>
								</button>
								<div class="position-absolute descriptionForButtons" id="descriptionForButton3" style="display: none;">
									<div class="d-flex flex-column gap-3 p-4 position-relative">
										<span class="text-white fw-bold">Fpp(라이센스 구매형)</span>
										<span class="text-white fw-semibold mb-3">최적화 작업을 무상 진행합니다. 윈도우는 해당 PC를 폐기하거나 교체 할 경우 라이센스를 유지하고 다른 PC로 이전 가능합니다</span>
										<span class="text-secondary fw-bold">*최적화란?</span>
										<span class="text-secondary fw-semibold">윈도우 최적화, 드라이버 업데이트, 바이오스 설정 및 업데이트, 각 업데이트 내용은 이슈 없는 버전으로 리빌딩합니다.</span>
									</div>
								</div>
							</div>
						</div>
						<!-- 질문1 끝 -->

						<!-- 질문2 시작 -->
						<script>
							function q2Input(el){
								if (!$(el).val()){
									$(".esca-left-side button").eq(1).attr("bool","0");
									$(".esca-left-side button").eq(1).removeClass("done");
								}else if($(el).val() < 0){
									alert("0원 이상으로 입력해주세요");
									$(el).val("").focus();
									$(".esca-left-side button").eq(1).attr("bool","0");
									$(".esca-left-side button").eq(1).removeClass("done");
								}else if($(el).val() > 500){
									alert("500만원 이하로 입력해주세요!");
									$(el).val("").focus();
									$(".esca-left-side button").eq(1).attr("bool","0");
									$(".esca-left-side button").eq(1).removeClass("done");
								}else if (!/^[0-9]+$/.test($(el).val())){
									alert("숫자만 입력해주세요!!");
									$(el).val("").focus();
									$(".esca-left-side button").eq(1).attr("bool","0");
									$(".esca-left-side button").eq(1).removeClass("done");
								}else {
									// $(".q2-badge").html("Price : " + $("#can-pay-val").val()).attr("bool","1");
									sessionStorage.setItem("data-1", $(el).val());
									$(".esca-left-side button").eq(1).attr("bool","1");
									$(".esca-left-side button").eq(1).addClass("done");
								}
								checkBools();
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1" question="02" style="display: none;">
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">본체에 투자하실 최대 한도는 얼마인가요? (최대 500만원)</h3>
								<h5 class="text-white fw-bold">한도에 맞는 최적의 부품을 선별하겠습니다(300만원 입력 예시 : 300)</h5>
							</div>

							<input type="text" class="qestion-box-item-input form-control w-25 px-3 text-end" placeholder="ex) 300만원 => 300" oninput="javascript:q2Input(this)">
						</div>
						<!-- 질문2 끝 -->

						<!-- 질문3 시작 -->
						<script>
							$(function(){
								const btnList = JSON.parse(`${processResourceTypeCodeInfoVOList}`);
								const modalList = JSON.parse(`${processResourceMasterVOList}`);
								for(let i = 0 ; i < btnList.length ; i++){
									if(btnList[i].processLgCd == "01"){
										const games = $("<button type='button' data-bs-toggle='modal' data-bs-target='#q3-modal' cd='games' class='btn btn-secondary w-100 text-light fw-semibold btn-lg border-1 border fs-6' onclick='javascript:qestionThreeBtns(this)'></button>").html(btnList[i].processTypeExclusiveCdNm).attr("id",btnList[i].processTypeExclusiveCd).attr("item-cdnm",btnList[i].processTypeExclusiveCdNm);
										$(".q3-game").append(games);
									}else if(btnList[i].processLgCd == "02"){
										const works = $("<button cd='works'></button>").attr("type","button").attr("data-bs-toggle","modal").attr("data-bs-target","#q3-modal").addClass("btn btn-secondary w-100 text-light fw-semibold btn-lg border-1 border fs-6").html(btnList[i].processTypeExclusiveCdNm).attr("id",btnList[i].processTypeExclusiveCd).attr("onclick","javascript:qestionThreeBtns(this)").attr("item-cdnm",btnList[i].processTypeExclusiveCdNm);
										$(".q3-work").append(works);
									}
								}
							})
							const btnList = JSON.parse(`${processResourceTypeCodeInfoVOList}`);
							const modalList = JSON.parse(`${processResourceMasterVOList}`);

							
							function qestionThreeBtns(el){
								$(".q3-modal-title").html($(el).html()).attr("id",$(el).attr("id"));
								const q3ModalBody = $("#q3-modal-body");

								let thisGanreCd = $(el).attr("id");

								for(let i = 0 ; i< modalList.length ; i++){
									if(modalList[i].processTypeExclusiveCd == thisGanreCd){
										let a = $('<div class="form-check" onclick="javascript:q3ModalItems(this)"></div>').attr("cd",modalList[i].id).attr("group-name",$(el).attr("id")).attr("item-ganre",$(el).attr("cd")).attr("name",modalList[i].processName).attr("item-cdnm",$(el).attr("item-cdnm"));
										let b = $('<input class="form-check-input" type="checkbox" value="">').attr("id",modalList[i].id);
										let c = $('<label class="form-check-label"></label>').attr("for",modalList[i].id).html(modalList[i].processName);
										a.append(b);
										a.append(c);
										q3ModalBody.append(a);
									}
								}
							}
							function q3ModalCloseBtn(){
								setTimeout(() => {
									$("#q3-modal-body").children().remove();
									$("#q3-modal-search").val("");
								}, 200);
								q3CheckedList = [];
								let q3Bool = true;
								$(".q3-select-inputs").each(function(){
									if ($(this).val() == null || $(this).val() === '') {
										q3Bool = false;
										$(".q3-q-box").removeClass("done").attr("bool","0");
										$(".esca-left-side button").eq(2).attr("bool","0");
										$(".esca-left-side button").eq(2).removeClass("done");
										return false;
									}else {
										$(".q3-q-box").addClass("done").attr("bool","1");
										$(".esca-left-side button").eq(2).attr("bool","1");
										$(".esca-left-side button").eq(2).addClass("done");
									}
								})
								checkBools();
							}
							let q3SaveList = [];
							let q3CheckedList = [];
							function q3ModalItems(el){
								let ganre = $(el).attr("item-ganre");
								let itemGroup = $(el).attr("group-name");
								let itemCd = $(el).attr("cd");
								let itemName = $(el).attr("name");
								let itemCdNm = $(el).attr("item-cdnm");
								let a = [ganre, itemGroup, itemCd,itemName,itemCdNm];
								if($(el).children("input").prop("checked") == false){
									$(el).children("input").prop("checked",true);
									if(!q3CheckedList.some(existingArr => JSON.stringify(existingArr) === JSON.stringify(a))){
										q3CheckedList.push(a);
									}
								}else {
									$(el).children("input").prop("checked",false);
									q3CheckedList = q3CheckedList.filter(item => JSON.stringify(item) !== JSON.stringify(a));
								}
							}

							function q3ModalSaveBtn(){
								
								q3CheckedList.forEach(item => {
									if (!q3SaveList.some(existingCd => existingCd === item[2])) {
										let ganres;
										
										if(item[0] == 'games'){
											ganres = "게임";
										}else if(item[0] == 'works'){
											ganres = "작업";
										}
										
										let itemCdNm = item[4];
										
										let a = $('<div class="q3-select-item py-2 px-4 d-flex justify-content-between align-items-center"></div>');
										let b = $('<span class="fw-bold text-white w-25"></span>').html(ganres + " > " + itemCdNm);
										let c = $('<span class="fw-bold text-white w-25 text-nowrap"></span>').html(item[3]);
										let d = $('<div class="d-flex align-items-center gap-5"></div>');

										let e = $('<div class="d-flex align-items-center gap-3"></div>');
										let e1 = $('<span class="text-secondary text-nowrap">사용 비중 : </span>');
										let e2 = $('<input type="text" class="form-control border-0 q3-select-inputs" placeholder="1~100" oninput="javascript:q3SelectedInput(this)">').attr("session1",item[2]).attr("session3",item[1]);

										let f = $('<svg class="q3-select-close" width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" onclick="javascript:q3DeleteItemSvg(this)"><path fill-rule="evenodd" clip-rule="evenodd" d="M3.46967 3.46967C3.76256 3.17678 4.23744 3.17678 4.53033 3.46967L20.5303 19.4697C20.8232 19.7626 20.8232 20.2374 20.5303 20.5303C20.2374 20.8232 19.7626 20.8232 19.4697 20.5303L3.46967 4.53033C3.17678 4.23744 3.17678 3.76256 3.46967 3.46967Z" fill="white"/><path fill-rule="evenodd" clip-rule="evenodd" d="M20.5303 3.46967C20.2374 3.17678 19.7626 3.17678 19.4697 3.46967L3.46967 19.4697C3.17678 19.7626 3.17678 20.2374 3.46967 20.5303C3.76256 20.8232 4.23744 20.8232 4.53033 20.5303L20.5303 4.53033C20.8232 4.23744 20.8232 3.76256 20.5303 3.46967Z" fill="white"/></svg>');
										

										a.append(b);
										a.append(c);
										a.append(d);

										d.append(e);
										d.append(f);

										e.append(e1);
										e.append(e2);
										$(".q3-select-items").append(a);
										q3SaveList.push(item[2]);
									}
								})
								q3ItemBoxCheckState();
								q3ModalCloseBtn();
							}
							function q3ItemBoxCheckState(){
								if($(".q3-select-items").children().length > 0){
									$(".q3-select-items-box").show();
								}else {
									$(".q3-select-items-box").hide();
									$(".q3-q-box").removeClass("done");
									$(".esca-left-side button").eq(2).attr("bool","0");
									$(".esca-left-side button").eq(2).removeClass("done");
								}
								checkBools();
							}
							function q3DeleteItemSvg(el){
								$(el).parent().parent().remove();
								q3ItemBoxCheckState();
								let q3Bool = true;
								$(".q3-select-inputs").each(function(){
									if ($(this).val() == null || $(this).val() === '') {
										q3Bool = false;
										$(".q3-q-box").removeClass("done");
										$(".esca-left-side button").eq(2).attr("bool","0");
										$(".esca-left-side button").eq(2).removeClass("done");
										return false;
									}else {
										$(".q3-q-box").addClass("done");
										$(".esca-left-side button").eq(2).attr("bool","1");
										$(".esca-left-side button").eq(2).addClass("done");
									}
								})
								checkBools();
							}
							function q3SelectedInput(){
								let q3InputAllVal = 0;
								let q3Values = [];
								$(".q3-select-inputs").each(function(){
									q3InputAllVal += Number($(this).val());
								})
								let q3Bool = true;
								$(".q3-select-inputs").each(function(){
									if ($(this).val() == null || $(this).val() === '') {
										q3Bool = false;
										$(".q3-q-box").removeClass("done");
										$(".esca-left-side button").eq(2).attr("bool","0");
										$(".esca-left-side button").eq(2).removeClass("done");
										return false;
									}else {
										$(".q3-q-box").addClass("done").attr("bool","1");
										$(".esca-left-side button").eq(2).attr("bool","1");
										$(".esca-left-side button").eq(2).addClass("done");
									}
									checkBools();
								})
								for(let i = 0; i < $(".q3-select-inputs").length; i++){
									let a = $(".q3-select-inputs").eq(i).attr("session1");
									let b = (100 * $(".q3-select-inputs").eq(i).val()/q3InputAllVal);
									let c = $(".q3-select-inputs").eq(i).attr("session3");
									console.log(b);
									let q3Value = [];
									q3Value.push(a);
									q3Value.push(b);
									q3Value.push(c);
									q3Values.push(q3Value);
									
								}
								
								sessionStorage.setItem("data-2",JSON.stringify(q3Values));
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1 q3-q-box" question="03" style="display: none;">
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">주 사용 목적을 선택해주세요 ( 다중선택 가능 )</h3>
							</div>

							<div class="w-75 d-flex flex-column gap-2">
								<div class="d-flex justify-content-between align-items-center gap-4">
									<div class="btn text-light active py-4 flex-1 q-3-taps fs-4 fw-bold">게임</div>
									<div class="btn text-light active py-4 flex-1 q-3-taps fs-4 fw-bold">작업</div>
									<div class="btn text-light active py-4 flex-1 q-3-taps fs-4 fw-bold">서핑</div>
								</div>

								<div class="d-flex justify-content-between align-items-center gap-4 q-3-s">
									<span class="flex-1 text-white text-center">|</span>
									<span class="flex-1 text-white text-center">|</span>
									<span class="flex-1 text-white text-center">|</span>
								</div>

								<div class="d-flex justify-content-between align-items-start gap-4">
									<div class="d-flex flex-column gap-3 w-100 q3-game">
									</div>
									<div class="d-flex flex-column gap-3 w-100 q3-work">
									</div>
									<div class="d-flex flex-column gap-3 w-100">
										<button type="button" class="btn btn-secondary w-100 text-light fw-semibold btn-lg border-1 border fs-6" disabled>서핑</button>
										<span class="text-danger fs-6 fw-semibold text-center">*점검중입니다*</span>
									</div>
								</div>
							</div>
							<div class="q3-select-items-box" style="display: none;">
								<div class="d-flex flex-column gap-3 q3-select-items mt-3 mb-2 p-3">
								</div>
							</div>
						</div>
						<div class="modal fade" id="q3-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
							<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
								<div class="modal-content">
									<div class="modal-header p-4 pb-0 border-0">
										<div class="d-flex flex-column gap-4 justify-content-between w-100">
											<div class="d-flex justify-content-between align-items-center">
												<h1 class="modal-title fw-bold fs-5 q3-modal-title"></h1>
												<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="javascript:q3ModalCloseBtn()"></button>
											</div>
											<input type="text" class="form-control" id="q3-modal-search" placeholder="검색어를 입력해주세요" oninput="javascript:searchLabel()">
										</div>
									</div>
									<div class="modal-body p-4">
										<div class="d-flex flex-column q3-modal-body-group gap-2" id="q3-modal-body">
										</div>
									</div>
									<div class="modal-footer p-4 pt-0 border-0">
										<div class="d-flex justify-content-between align-items-center gap-3 w-100">
											<button type="button" class="btn btn-light border-1 border w-50 py-2" data-bs-dismiss="modal" onclick="javascript:q3ModalCloseBtn()">닫기</button>
											<button type="button" class="btn btn-dark w-50 py-2" data-bs-dismiss="modal" onclick="javascript:q3ModalSaveBtn()">저장</button>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 질문3 끝 -->

						<!-- 질문4 시작 -->
						<script>
							$(function() {
								createChart();
							})
							let radarChart;
							function createChart(){
								const ctx = document.getElementById('radarChart').getContext('2d');
								const data = {
									labels: ['발열', '소재', 'AS', '소음', '안정', 'QC'],
									datasets: [{
									label: "",
										data: [1, 1, 1, 1, 1, 1],
										fill: true,
										backgroundColor: "#0C5FFF",
										pointBackgroundColor: '#0C5FFF',
										pointBorderColor: '#0C5FFF',
										pointHoverBackgroundColor: '#0C5FFF',
										pointHoverBorderColor: '#FFF',
										pointRadius: 6, // 꼭짓점 원형의 크기
										pointHoverRadius: 8 // 드래그 시 꼭짓점 원형의 크기
									}]
								};
	
								const options = {
									responsive: true,
									plugins: {
										legend: {
											display: false
										},
										tooltip: {
											enabled: true
										},
										dragData: {
											round: 2,
											showTooltip: true,
											dragX: false,
											onDrag: function(e, datasetIndex, index, value) {
												const hexInputs = $(".hex-input");
												hexInputs[index].value = parseFloat(radarChart.data.datasets[datasetIndex].data[index]).toFixed(2);
												if (value < 0) value = 0;
												if (value > 2) value = 2;
											},
											onDragEnd: function(e, datasetIndex, index, value) {
												const hexInputs = $(".hex-input");
												hexInputs[index].value = parseFloat(radarChart.data.datasets[datasetIndex].data[index]).toFixed(2);
												if (value < 0) value = 0;
												if (value > 2) value = 2;
	
												for(let i = 0 ; i<hexInputs.length; i++){
													const inputValue = parseFloat(hexInputs[i].value);
													if(hexInputs[i].value < 0 || hexInputs[i].value>2){
														alert("0이상 2미만으로 입력해주세요!");
														setTimeout(() => {
															hexInputs[i].value = "1.00";
															radarChart.data.datasets[0].data[i] = 1;
															radarChart.update();
														}, 1);
														radarChart.data.datasets[0].data[i] = inputValue;
													}else {
														radarChart.data.datasets[0].data[i] = inputValue;
														radarChart.update();
													}
													
												}
												setTimeout(() => {
													$("#hex-val-total").val(parseFloat((Number($(".hex-input").eq(0).val())+Number($(".hex-input").eq(1).val())+Number($(".hex-input").eq(2).val())+Number($(".hex-input").eq(3).val())+Number($(".hex-input").eq(4).val())+Number($(".hex-input").eq(5).val()))/(6)).toFixed(2));	
												}, 100);
												let valueArr = [];
												for(let i = 0 ; i<$(".hex-input").length; i++){
													let storageValue = parseFloat([$(".hex-input")[i].value]).toFixed(2);
													valueArr.push(storageValue);
												}
												$(".esca-left-side button").eq(3).addClass("done");
												sessionStorage.setItem("data-3",JSON.stringify(valueArr));
											}
										}
									},
									scales: {
										r: {
										min: 0,
										max: 2,
										angleLines: {
											display: true,
	
											color: '#404040',
											borderDash:[5,5],
											},
											grid: {
												color: function(context) {
													return context.index === context.chart.scales.r.ticks.length - 1 ? 'white' : '#404040';
												},
												lineWidth: function(context) {
													return context.index === context.chart.scales.r.ticks.length - 1 ? 2 : 1;
												},
												borderRadius: 14
											},
											pointLabels: {
												color: '#FFF',
												font: {
													size: 16,
													weight: "bold"
												}
											},
											ticks: {
											display:false,
											stepSize: 0.4,
											showLabelBackdrop: false
											}
										}
									},
									animation: {
									duration: 500,
									easing: 'easeOutQuart'
									},
									onHover: function(event, chartElement) {
										if (chartElement.length > 0) {
											var point = chartElement[0];
											var label = radarChart.data.labels[point.index];
											if(label === "발열"){
												$(".q4-description-name").html("발열")
												$(".q4-description-body").html("제품을 낮은 온도로 유지해줄 발열제어능력을 의미합니다.\n\n0일 때 온전한 성능을 발휘할 수 있는 최소한의 쿨러만 설치되며, 2일 때 예산을 초과편성하지 않는 선에서의 최고의 쿨링성능을 제공합니다.")
											}else if(label ==="소재"){
												$(".q4-description-name").html("소재")
												$(".q4-description-body").html("하드웨어적 제품 가치를 의미합니다.\n\n강판의 종류, 두께, 강도, 열전도율, 베어링 방식, 방열판 구조, 쿨링솔루션 등을 의미합니다.\n\n0일 때 소재를 전혀 고려하지 않고 호환성만 검토하며\n\n2일 때 하드웨어적으로 완성에 가까운 제품을 선정하게 됩니다.")
											}else if(label === "소음"){
												$(".q4-description-name").html("소음")
												$(".q4-description-body").html("제품의 상세설명 상 표기 데시벨을 점수화하여 기록된 자료입니다.\n\nBeta버전으로, 실측 테스트가 진행되지 않아 알고리즘 연산식에서 배제됩니다.\n\n수치 변동에 따라 제품 선정 변경점이 존재하지 않습니다.")
											}else if(label === "QC"){
												$(".q4-description-name").html("QC")
												$(".q4-description-body").html("제품의 결함율을 나타냅니다.\n\n단순한 출고 결함율만이 아닌 최근 해당 제품 혹은 제품의 제조사, 제품군의 라인업/칩셋 등의 이슈를 다룹니다.\n\n0일 때 당장의 리콜/판매금지 제품을 제외하곤 모든 가능성을 열어두며, 2일 때 이름값을 다소 지불하더라도 입증된 메이저 제품군만을 취급합니다.")
											}else if(label === "안정"){
												$(".q4-description-name").html("안정(안정성)")
												$(".q4-description-body").html("제품의 성능을 온전하게 유지하고 수명을 올려줄 모든 수단을 의미합니다.\n\n0일 때 가격대비 퍼포먼스 표기 성능이 가장 높은 제품을 선택하고, 2일 때 제품의 체급을 낮춰서라도 프리미엄 라인업을 선정합니다.")
											}else if(label === "AS"){
												$(".q4-description-name").html("AS")
												$(".q4-description-body").html("제품들의 사후처리 가능성을 나타냅니다.\n\n수리규정, 유통사 평판 등이 이에 해당합니다.\n0일 때 AS를 전혀 감안하지 않으며, 2일 때 AS의 가격가치를 제품 성능보다도 우선시합니다.")
											}else {
												$(".q4-description-name").html("")
												$(".q4-description-body").html("가성비 : (깡통 독3사) 최소한의 기준치를 충족한 제품군들 중 성능만을 위해 예산을 소요합니다.\n가격대 성능비가 가장 좋지만 체급에 비해 종합 안정성이 떨어집니다.\n\n메인스트림 : (필수옵션 소나타)해당 예산대의 평균적인 제품군을 선정합니다. 예산 내의 이상적인 견적을 받을 수 있습니다.\n\n프리미엄 : (풀옵 경차)예산에 비해 과한 제품 종합 안정성을 보장합니다.\n각 라인업별 최고의 제품들만 선별하여 활용하겠지만, 성능은 돈값을 못한다는 이야기를 듣기 쉽습니다.")
											}
										}
									}
								};
	
								radarChart = new Chart(ctx, {
									type: 'radar',
									data: data,
									options: options
								});
							}
							function q4InputType(el){
								if($(el).val().includes('-') || $(el).val().includes('+') || !/^[0-9.]+$/.test($(el).val()) || ($(el).val().match(/\./g) || []).length > 1 || $(el).val().length > 4){
									let val = $(el).val();
									$(el).val(val.slice(0,-1));
								}else {
									const hexInputs = $(".hex-input");
	
									for(let i = 0 ; i<hexInputs.length; i++){
										const inputValue = parseFloat(hexInputs[i].value);
										if(hexInputs[i].value < 0 || hexInputs[i].value>2){
											alert("0이상 2미만으로 입력해주세요!");
											setTimeout(() => {
												hexInputs[i].value = "1.00";
												radarChart.data.datasets[0].data[i] = 1;
												radarChart.update();
											}, 1);
											radarChart.data.datasets[0].data[i] = inputValue;
										}else {
											radarChart.data.datasets[0].data[i] = inputValue;
											radarChart.update();
										}
										
									}
									setTimeout(() => {
										$("#hex-val-total").val(parseFloat((Number($(".hex-input").eq(0).val())+Number($(".hex-input").eq(1).val())+Number($(".hex-input").eq(2).val())+Number($(".hex-input").eq(3).val())+Number($(".hex-input").eq(4).val())+Number($(".hex-input").eq(5).val()))/(6)).toFixed(2));	
									}, 100);
	
									let value = [];
									for(let i = 0 ; i<$(".hex-input").length; i++){
										let storageValue = parseFloat([$(".hex-input")[i].value]).toFixed(2);
										value.push(storageValue);
									}
									$(".esca-left-side button").eq(3).addClass("done");
									sessionStorage.setItem("data-3",JSON.stringify(value));
								}
							}
							function q4MouseEnter(el){
								if($(el).html() === "발열"){
									$(".q4-description-name").html("발열")
									$(".q4-description-body").html("제품을 낮은 온도로 유지해줄 발열제어능력을 의미합니다.<br>0일 때 온전한 성능을 발휘할 수 있는 최소한의 쿨러만 설치되며, 2일 때 예산을 초과편성하지 않는 선에서의 최고의 쿨링성능을 제공합니다.")
								}else if($(el).html() ==="소재"){
									$(".q4-description-name").html("소재")
									$(".q4-description-body").html("하드웨어적 제품 가치를 의미합니다.<br>강판의 종류, 두께, 강도, 열전도율, 베어링 방식, 방열판 구조, 쿨링솔루션 등을 의미합니다.<br>0일 때 소재를 전혀 고려하지 않고 호환성만 검토하며<br>2일 때 하드웨어적으로 완성에 가까운 제품을 선정하게 됩니다.")
								}else if($(el).html() === "소음"){
									$(".q4-description-name").html("소음")
									$(".q4-description-body").html("제품의 상세설명 상 표기 데시벨을 점수화하여 기록된 자료입니다.<br>Beta버전으로, 실측 테스트가 진행되지 않아 알고리즘 연산식에서 배제됩니다.<br>수치 변동에 따라 제품 선정 변경점이 존재하지 않습니다.")
								}else if($(el).html() === "QC"){
									$(".q4-description-name").html("QC")
									$(".q4-description-body").html("제품의 결함율을 나타냅니다.<br>단순한 출고 결함율만이 아닌 최근 해당 제품 혹은 제품의 제조사, 제품군의 라인업/칩셋 등의 이슈를 다룹니다.<br>0일 때 당장의 리콜/판매금지 제품을 제외하곤 모든 가능성을 열어두며, 2일 때 이름값을 다소 지불하더라도 입증된 메이저 제품군만을 취급합니다.")
								}else if($(el).html() === "안정"){
									$(".q4-description-name").html("안정(안정성)")
									$(".q4-description-body").html("제품의 성능을 온전하게 유지하고 수명을 올려줄 모든 수단을 의미합니다.<br>0일 때 가격대비 퍼포먼스 표기 성능이 가장 높은 제품을 선택하고, 2일 때 제품의 체급을 낮춰서라도 프리미엄 라인업을 선정합니다.")
								}else if($(el).html() === "AS"){
									$(".q4-description-name").html("AS")
									$(".q4-description-body").html("제품들의 사후처리 가능성을 나타냅니다.<br>수리규정, 유통사 평판 등이 이에 해당합니다.<br>0일 때 AS를 전혀 감안하지 않으며, 2일 때 AS의 가격가치를 제품 성능보다도 우선시합니다.")
								}else {
									$(".q4-description-name").html("")
									$(".q4-description-body").html("가성비 : (깡통 독3사) 최소한의 기준치를 충족한 제품군들 중 성능만을 위해 예산을 소요합니다.<br>가격대 성능비가 가장 좋지만 체급에 비해 종합 안정성이 떨어집니다.<br><br>메인스트림 : (필수옵션 소나타)해당 예산대의 평균적인 제품군을 선정합니다. 예산 내의 이상적인 견적을 받을 수 있습니다.<br><br>프리미엄 : (풀옵 경차)예산에 비해 과한 제품 종합 안정성을 보장합니다.<br>각 라인업별 최고의 제품들만 선별하여 활용하겠지만, 성능은 돈값을 못한다는 이야기를 듣기 쉽습니다.")
								}
							}
							let prevTotalVal = 1;
							function totalValue(){
								let count = 6;
								const hexInputs = $(".hex-input");
								
								const totalVal = Number(parseFloat($("#hex-val-total").val()).toFixed(2));
								const allInputs = (Number($(".hex-input").eq(0).val())+Number($(".hex-input").eq(1).val())+Number($(".hex-input").eq(2).val())+Number($(".hex-input").eq(3).val())+Number($(".hex-input").eq(4).val())+Number($(".hex-input").eq(5).val()))/6;

								if($("#hex-val-total").val() ==="0"){
									for(let i = 0 ; i<hexInputs.length; i++){
										hexInputs[i].value = "0.00"
										radarChart.data.datasets[0].data[i] = "0";
									}
								}else if($("#hex-val-total").val() ==="2"){
									for(let i = 0 ; i<hexInputs.length; i++){
										hexInputs[i].value = "2.00"
										radarChart.data.datasets[0].data[i] = "2";
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
												radarChart.data.datasets[0].data[i] = inputVal;
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
												radarChart.data.datasets[0].data[i] = inputVal;
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
								radarChart.update();

								let value = [];
								for(let i = 0 ; i<$(".hex-input").length; i++){
									let storageValue = parseFloat([$(".hex-input")[i].value]).toFixed(2);
									value.push(storageValue);
								}
								$(".esca-left-side button").eq(3).addClass("done");
								sessionStorage.setItem("data-3",JSON.stringify(value));
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1" question="04" style="display: none;">
							<div class="d-flex flex-column h-100">
								<div class="d-flex flex-column gap-3 mb-3">
									<h3 class="text-white fw-bold">투자할 부분의 예산을 세분화 하여 편성 해주세요</h3>
									<h5 class="text-white fw-bold">상세수치를 드래그 혹은 직접 입력하여 설정 가능합니다(0.00~2.00)</h5>
								</div>
	
								<div class="d-flex gap-4 justify-content-between w-100 flex-grow-1">
									<div class="q4-left-section d-flex flex-column w-50 justify-content-around align-items-center">
										<canvas id="radarChart" style="width:100%; height:100%;"></canvas>
	
										<div class="d-flex flex-column w-100 gap-2 ">
											<input type="range" class="form-range w-75 mx-auto" min="0" max="2" step="0.01" id="hex-val-total" onmouseenter="javascript:q4MouseEnter(this)" oninput="javascript:totalValue()">
											<label for="hex-val-total" class="form-label text-center ms-2 text-light" onmouseenter="javascript:q4MouseEnter(this)">가성비 <- 메인스트림 -> 프리미엄</label>
										</div>
									</div>
									<div class="q4-right-section d-flex flex-column w-50 gap-4 justify-content-center align-items-center">
										<div class="q4-description-box p-4 d-flex flex-column gap-3 position-relative w-100">
											<div class="q4-description-name text-light fs-4 fw-bold">
											</div>
											<div class="q4-description-body text-light">
											</div>
										</div>

										<div class="d-flex flex-column gap-3 w-100">
											<div class="d-flex justify-content-between align-items-center gap-3">
												<div class="d-flex justify-content-around p-3 align-items-center q4-desciption-input-group h-100 flex-1">
													<span class="text-light flex-1 text-center fw-semibold" onmouseenter="q4MouseEnter(this)">발열</span>
													<span class="q4-desciption-divider h-75"></span>
													<input type="text" class="text-light flex-1 text-center border-0 form-control p-0 hex-input" oninput="javascript:q4InputType(this)" chart-cd="1" value="1.00">
												</div>
												<div class="d-flex justify-content-around p-3 align-items-center q4-desciption-input-group h-100 flex-1">
													<span class="text-light flex-1 text-center fw-semibold" onmouseenter="q4MouseEnter(this)">소재</span>
													<span class="q4-desciption-divider h-75"></span>
													<input type="text" class="text-light flex-1 text-center border-0 form-control p-0 hex-input" oninput="javascript:q4InputType(this)" chart-cd="2" value="1.00">
												</div>
											</div>
											<div class="d-flex justify-content-between align-items-center gap-3">
												<div class="d-flex justify-content-around p-3 align-items-center q4-desciption-input-group h-100 flex-1">
													<span class="text-light flex-1 text-center fw-semibold" onmouseenter="q4MouseEnter(this)">AS</span>
													<span class="q4-desciption-divider h-75"></span>
													<input type="text" class="text-light flex-1 text-center border-0 form-control p-0 hex-input" oninput="javascript:q4InputType(this)" chart-cd="3" value="1.00">
												</div>
												<div class="d-flex justify-content-around p-3 align-items-center q4-desciption-input-group h-100 flex-1">
													<span class="text-light flex-1 text-center fw-semibold" onmouseenter="q4MouseEnter(this)">소음</span>
													<span class="q4-desciption-divider h-75"></span>
													<input type="text" class="text-light flex-1 text-center border-0 form-control p-0 hex-input" oninput="javascript:q4InputType(this)" chart-cd="4" value="1.00">
												</div>
											</div>
											<div class="d-flex justify-content-between align-items-center gap-3">
												<div class="d-flex justify-content-around p-3 align-items-center q4-desciption-input-group h-100 flex-1">
													<span class="text-light flex-1 text-center fw-semibold" onmouseenter="q4MouseEnter(this)">안정</span>
													<span class="q4-desciption-divider h-75"></span>
													<input type="text" class="text-light flex-1 text-center border-0 form-control p-0 hex-input" oninput="javascript:q4InputType(this)" chart-cd="5" value="1.00">
												</div>
												<div class="d-flex justify-content-around p-3 align-items-center q4-desciption-input-group h-100 flex-1">
													<span class="text-light flex-1 text-center fw-semibold" onmouseenter="q4MouseEnter(this)">QC</span>
													<span class="q4-desciption-divider h-75"></span>
													<input type="text" class="text-light flex-1 text-center border-0 form-control p-0 hex-input" oninput="javascript:q4InputType(this)" chart-cd="6" value="1.00">
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- 질문4 끝 -->

						<!-- 질문5 시작 -->
						<script>
							function q5ButtonToggle(el){
								if(!$(el).hasClass("active")){
									$(".q5-buttons").each(function(){
										if($(this).hasClass("active")){
											$(this).button("toggle");
										}
									})
									$(el).button("toggle");
									$(".esca-left-side button").eq(4).addClass("done");
									sessionStorage.setItem("data-4",$(el).attr("button-cd"));
								}else {
									$(el).button("toggle");
									$(".esca-left-side button").eq(4).removeClass("done");
									sessionStorage.setItem("data-4","");
								}
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1" question="05" style="display: none;">
							
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">WIFI, 블루투스 옵션이 포함된 PC가 필요하신가요?</h3>
								<h5 class="text-white fw-bold"></h5>
							</div>
							
							<div class="d-flex gap-4 mb-3 w-50">
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q5-buttons" button-cd="0" onclick="javascript:q5ButtonToggle(this)">
									<span class="text-white fw-semibold">필요합니다</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q5-buttons" button-cd="1" onclick="javascript:q5ButtonToggle(this)">
									<span class="text-white fw-semibold">필요없습니다</span>
								</button>
							</div>
						</div>
						<!-- 질문5 끝 -->

						<!-- 질문6 시작 -->
						<script>
							function q6ButtonToggle(el){
								if(!$(el).hasClass("active")){
									$(".q6-buttons").each(function(){
										if($(this).hasClass("active")){
											$(this).button("toggle");
										}
									})
									$(el).button("toggle");
									sessionStorage.setItem("data-5",$(el).attr("button-cd"));
									$(".esca-left-side button").eq(5).addClass("done");
								}else {
									$(el).button("toggle");
									sessionStorage.setItem("data-5","");
									$(".esca-left-side button").eq(5).removeClass("done");
								}
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1" question="06" style="display: none;">
							
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">선호하는 CPU 제조사를 선택해주세요</h3>
								<h5 class="text-white fw-bold"></h5>
							</div>
							
							<div class="d-flex gap-4 mb-3 w-75">
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q6-buttons" button-cd="0" onclick="javascript:q6ButtonToggle(this)">
									<span class="text-white fw-semibold">Intel</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q6-buttons" button-cd="1" onclick="javascript:q6ButtonToggle(this)">
									<span class="text-white fw-semibold">AMD</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q6-buttons" button-cd="2" onclick="javascript:q6ButtonToggle(this)">
									<span class="text-white fw-semibold">상관없음</span>
								</button>
							</div>
						</div>
						<!-- 질문6 끝 -->
						<!-- 질문7 시작 -->
						<script>
							function q7ButtonToggle(el){
								if(!$(el).hasClass("active")){
									$(".q7-buttons").each(function(){
										if($(this).hasClass("active")){
											$(this).button("toggle");
										}
									})
									$(el).button("toggle");
									sessionStorage.setItem("data-6",$(el).attr("button-cd"))
									$(".esca-left-side button").eq(6).addClass("done");
								}else {
									$(el).button("toggle");
									sessionStorage.setItem("data-6","")
									$(".esca-left-side button").eq(6).removeClass("done");
								}
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1" question="07" style="display: none;">
							
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">내장그래픽이 필요하십니까?</h3>
								<h5 class="text-white fw-bold"></h5>
							</div>
							
							<div class="d-flex gap-4 mb-3 w-75">
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q7-buttons" button-cd="0" onclick="javascript:q7ButtonToggle(this)">
									<span class="text-white fw-semibold">필요합니다</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q7-buttons" button-cd="1" onclick="javascript:q7ButtonToggle(this)">
									<span class="text-white fw-semibold">필요없습니다</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q7-buttons" button-cd="2" onclick="javascript:q7ButtonToggle(this)">
									<span class="text-white fw-semibold">상관없음</span>
								</button>
							</div>
						</div>
						<!-- 질문7 끝 -->
						<!-- 질문8 시작 -->
						<script>
							function q8ButtonToggle(el){
								if(!$(el).hasClass("active")){
									$(".q8-buttons").each(function(){
										if($(this).hasClass("active")){
											$(this).button("toggle");
										}
									})
									$(el).button("toggle");
									sessionStorage.setItem("data-7",$(el).attr("button-cd"))
									$(".esca-left-side button").eq(7).addClass("done");
								}else {
									$(el).button("toggle");
									sessionStorage.setItem("data-7","")
									$(".esca-left-side button").eq(7).removeClass("done");
								}
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1" question="08" style="display: none;">
							
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">수냉쿨러를 선호하십니까?</h3>
								<h5 class="text-white fw-bold"></h5>
							</div>
							
							<div class="d-flex gap-4 mb-3 w-75">
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q8-buttons" button-cd="0" onclick="javascript:q8ButtonToggle(this)">
									<span class="text-white fw-semibold my-auto">선호합니다</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q8-buttons" button-cd="1" onclick="javascript:q8ButtonToggle(this)">
									<span class="text-white fw-semibold">선호하지</span>
									<span class="text-white fw-semibold">않습니다</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q8-buttons" button-cd="2" onclick="javascript:q8ButtonToggle(this)">
									<span class="text-white fw-semibold my-auto">상관없음</span>
								</button>
							</div>
						</div>
						<!-- 질문8 끝 -->

						<!-- 질문9 시작 -->
						<!-- 질문9 끝 -->

						<!-- 질문10 시작 -->
						<script>
							function q10ButtonToggle(el){
								if(!$(el).hasClass("active")){
									$(".q10-buttons").each(function(){
										if($(this).hasClass("active")){
											$(this).button("toggle");
										}
									})
									$(el).button("toggle");
									sessionStorage.setItem("data-9",$(el).attr("button-cd"))
									$(".esca-left-side button").eq(9).addClass("done");
								}else {
									$(el).button("toggle");
									sessionStorage.setItem("data-9","")
									$(".esca-left-side button").eq(9).removeClass("done");
								}
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1" question="10" style="display: none;">
							
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">메모리(램)카드의 버전을 DDR4, DDR5 중에서 골라주세요</h3>
								<h5 class="text-white fw-bold"></h5>
							</div>
							
							<div class="d-flex gap-4 mb-3 w-75">
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q10-buttons" button-cd="0" onclick="javascript:q10ButtonToggle(this)">
									<span class="text-white fw-semibold">DDR4</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q10-buttons" button-cd="1" onclick="javascript:q10ButtonToggle(this)">
									<span class="text-white fw-semibold">DDR5</span>
									<span class="text-white fw-semibold"></span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q10-buttons" button-cd="2" onclick="javascript:q10ButtonToggle(this)">
									<span class="text-white fw-semibold">상관없음</span>
								</button>
							</div>
						</div>
						<!-- 질문10 끝 -->

						<!-- 질문11 시작 -->
						<script>
							function q11ButtonToggle(el){
								if(!$(el).hasClass("active")){
									$(".q11-buttons").each(function(){
										if($(this).hasClass("active")){
											$(this).button("toggle");
										}
									})
									$(el).button("toggle");
									sessionStorage.setItem("data-10",$(el).attr("button-cd"))
									$(".esca-left-side button").eq(10).addClass("done");
								}else {
									$(el).button("toggle");
									sessionStorage.setItem("data-10","");
									$(".esca-left-side button").eq(10).removeClass("done");
								}
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1" question="11" style="display: none;">
							
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">벌크나 멀티팩을 선호 하십니까?</h3>
								<h5 class="text-white fw-bold"></h5>
							</div>
							
							<div class="d-flex gap-4 mb-3 w-100">
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q11-buttons" button-cd="0" onclick="javascript:q11ButtonToggle(this)">
									<span class="text-white fw-semibold">벌크 선호</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q11-buttons" button-cd="1" onclick="javascript:q11ButtonToggle(this)">
									<span class="text-white fw-semibold">멀티팩 선호</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q11-buttons" button-cd="2" onclick="javascript:q11ButtonToggle(this)">
									<span class="text-white fw-semibold">둘다 선호</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q11-buttons" button-cd="3" onclick="javascript:q11ButtonToggle(this)">
									<span class="text-white fw-semibold">둘다 싫음</span>
								</button>
							</div>
						</div>
						<!-- 질문11 끝 -->

						<!-- 질문12 시작 -->
						<script>
							function q12ButtonToggle(el){
								if(!$(el).hasClass("active")){
									$(".q12-buttons").each(function(){
										if($(this).hasClass("active")){
											$(this).button("toggle");
										}
									})
									$(el).button("toggle");
									sessionStorage.setItem("data-11",$(el).attr("button-cd"))
									$(".esca-left-side button").eq(11).addClass("done");
								}else {
									$(el).button("toggle");
									sessionStorage.setItem("data-11","");
									$(".esca-left-side button").eq(11).removeClass("done");
								}
							}
						</script>
						<div class="question-box-item w-100 flex-grow-1" question="12" style="display: none;">
							
							<div class="d-flex flex-column gap-3 mb-3">
								<h3 class="text-white fw-bold">C드라이브(SSD)의 용량을 선택해주세요</h3>
								<h5 class="text-white fw-bold"></h5>
							</div>
							
							<div class="d-flex gap-4 mb-3 w-100">
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q12-buttons" button-cd="0" onclick="javascript:q12ButtonToggle(this)">
									<span class="text-white fw-semibold">예산에 맞게</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q12-buttons" button-cd="1" onclick="javascript:q12ButtonToggle(this)">
									<span class="text-white fw-semibold">256GB</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q12-buttons" button-cd="2" onclick="javascript:q12ButtonToggle(this)">
									<span class="text-white fw-semibold">512GB</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q12-buttons" button-cd="3" onclick="javascript:q12ButtonToggle(this)">
									<span class="text-white fw-semibold">1024GB(1TB)</span>
								</button>
							</div>
							<div class="d-flex gap-4 mb-3 w-100">
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q12-buttons" button-cd="4" onclick="javascript:q12ButtonToggle(this)">
									<span class="text-white fw-semibold">2048GB(2TB)</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q12-buttons" disabled style="opacity: 0!important;" >
									<span class="text-white fw-semibold">1024GB(1TB)</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q12-buttons" disabled style="opacity: 0!important;" >
									<span class="text-white fw-semibold">1024GB(1TB)</span>
								</button>
								<button type="button" class="btn btn-secondary d-flex flex-column p-5 gap-2 align-items-center flex-1 check q12-buttons" disabled style="opacity: 0!important;" >
									<span class="text-white fw-semibold">1024GB(1TB)</span>
								</button>
							</div>
						</div>
						<!-- 질문12 끝 -->
						<div class="question-box-item-buttons d-flex gap-3 justify-content-between align-items-center">
							<div class="d-flex gap-4 justify-content-start">
								<button type="button" class="btn btn-secondary px-5 fw-bold esca-prev-btn" question="00" disabled onclick="javascript:prevBtn(this)">이전</button>
								<button type="button" class="btn btn-light px-5 fw-bold esca-next-btn" question="02" onclick="javascript:nextBtn(this)">다음</button>
							</div>
							<button type="button" class="btn btn-primary px-5 fw-bold esca-btn" onclick="javascript:estimateBtn(this)" disabled>견적산출</button>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	<div class="modal fade" id="loading-modal" aria-hidden="true" aria-labelledby="select-date" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="d-flex flex-column align-items-center p-5 gap-2 position-relative">
					<div class="fw-bold text-dark fs-5">알고리즘이 부품을 추천중입니다</div>
					<div class="text-dark fs-6">최적의 견적을 추천드리겠습니다</div>
					<div class="spinner-border text-primary mt-3" role="status">
					</div>
					<svg class="position-absolute" style="bottom: 56px;" width="16" height="16" viewBox="0 0 34 32" fill="none" xmlns="http://www.w3.org/2000/svg">
						<rect y="7" width="34" height="25" rx="4" fill="#DBDBDB"/>
						<rect x="9" y="14" width="4" height="4" rx="2" fill="#9B9B9B"/>
						<rect x="21" y="14" width="4" height="4" rx="2" fill="#9B9B9B"/>
						<rect x="9" y="21" width="16" height="4" rx="2" fill="#9B9B9B"/>
						<path d="M15 2C15 0.89543 15.8954 0 17 0C18.1046 0 19 0.895431 19 2V5C19 6.10457 18.1046 7 17 7C15.8954 7 15 6.10457 15 5V2Z" fill="#B4B4B4"/>
					</svg>
				</div>
			</div>
		</div>
	</div>
</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>