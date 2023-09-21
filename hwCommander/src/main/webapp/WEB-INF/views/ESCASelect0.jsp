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

<!-- 09.15 사이드바 토글 js-->
<script src="/resources/js/ESCA_NEW_Script.js"></script>
<!-- 09.12 단독 스타일시트 추가 -->
<link rel="stylesheet" href="/resources/css/ESCASelect.css">

<!-- 09.18 데이터 전송 js -->
<script src="/resources/js/escaSendData.js"></script>
<!-- 09.18 반응형 추가 -->
<script src="/resources/js/ESCA_NEW_Resize.js"></script>
<link rel="stylesheet" href="/resources/css/escaMQ.css">
<!-- 09.08 date picker js css 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.min.css" integrity="sha512-aQb0/doxDGrw/OC7drNaJQkIKFu6eSWnVMAwPN64p6sZKeJ4QCDYL42Rumw2ZtL8DB9f66q4CnLIUnAw28dEbg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.standalone.min.css" integrity="sha512-t+00JqxGbnKSfg/4We7ulJjd3fGJWsleNNBSXRk9/3417ojFqSmkBfAJ/3+zpTFfGNZyKxPVGwWvaRuGdtpEEA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script>
	const loginUser = "${loginUser}";

	$(function(){		
		$("#ESCA_modal").modal("show");
		

		// bootstrap tooltip base
		const tooltipTriggerList = $('[data-bs-toggle="tooltip"]');
		const tooltipList = tooltipTriggerList.map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();

		for(let i = 0 ; i <= btnList.length ; i++){
			if(btnList[i].processLgCd == "01"){
				const games = $("<button></button>").attr("type","button").attr("data-bs-toggle","modal").attr("data-bs-target","#q3-modal").addClass("list-group-item list-group-item-action").html(btnList[i].processTypeExclusiveCdNm).attr("id",btnList[i].processTypeExclusiveCd).attr("onclick","javascript:modalOpen(this.id,this)");
				$(".q3-game").append(games);
			}else if(btnList[i].processLgCd == "02"){
				const works = $("<button></button>").attr("type","button").attr("data-bs-toggle","modal").attr("data-bs-target","#q3-modal").addClass("list-group-item list-group-item-action").html(btnList[i].processTypeExclusiveCdNm).attr("id",btnList[i].processTypeExclusiveCd).attr("onclick","javascript:modalOpen(this.id,this)");
				$(".q3-work").append(works);
			}
		}
	})

	// 초반 모달 기능
	function modalNewBtn(){
		sessionStorage.setItem("targetData","")
		for(let i = 0; i<=19 ; i++){
			sessionStorage.setItem("data-" + i, "");
		}
		$("#ESCA_modal").modal("hide");
	}
	function chooseDate(){
		$("#time-chooser").removeClass("d-flex").addClass("d-none");
		$('#date-chooser').children().css("display","block");
		$('#date-chooser').datepicker({
			language: 'ko',
			format: 'yyyy-mm-dd',
			startDate: '2023-03-01',
			endDate: new Date(),
			autoclose: true,
		}).on("changeDate", function(e){
			$("#date-input").val(e.format("yyyy-mm-dd"));
			if($("#time-input").val() != ""){
				$("#date-time-result").val($("#date-input").val() + " " + $("#time-input").val());	
			}else if($("#time-input").val() == ""){
				$("#date-time-result").val($("#date-input").val() + " " + "00:00:00");	
			}
		});
	}
	function chooseTime(){
		$('#date-chooser').children().css("display","none");
		$("#time-chooser").removeClass("d-none").addClass("d-flex");
	}
	function changeTime(){
		$("#time-input").val($("#time-chooser").children().val());
		if($("#date-input").val() != ""){
			$("#date-time-result").val($("#date-input").val() + " " + $("#time-input").val());
		}
	}
	function checkResult(){
		if($("#date-time-result").val() == ""){
			alert("날짜를 선택해주세요!");
		}else {
			sessionStorage.setItem("targetData",$("#date-time-result").val())
			for(let i = 0; i<=19 ; i++){
				sessionStorage.setItem("data-" + i, "");
			}
			$("#select-date").modal("hide");	
		}
	}
	function resetTime(){
		$("#time-chooser").children().val("00:00:00");
		chooseDate();
		chooseTime();
		changeTime();
	}
	// 견적산출 버튼 반응형 이벤트
	function resizeEsBtn(){
		if($("body").hasClass("sb-sidenav-toggled")){
			$("#es-btn").css("display","none");
		}else {
			setTimeout(() => {
				$("#es-btn").css("display","block");    
			}, 100);
		}
	}
	
	// 질문 목록 클릭 이벤트
	function clickQestionList(el){
		$(".q-base").removeClass("show").css("display","none");
		var qnum = $(el).attr("qnum");
		for(var i = 1 ; i<=20 ; i++ ){
			if( i != qnum){
				$(".q-" + i).removeClass("show").css("display","none");
			}
		}
		setTimeout(() => {
			$(".q-" + qnum).addClass("show");
		}, 100);
		$(".q-" + qnum).css("display","block");
	}
	// 질문 페이지 별 이벤트들
	// 1번질문
	function qestionOneBtns(el){
		if($(el).attr("val") == "1"){
			sessionStorage.setItem("data-0",0);
		}else if($(el).attr("val") == "2"){
			sessionStorage.setItem("data-0",1);
		}else {
			sessionStorage.setItem("data-0",2);
		}
		$(".q1-badge").html("OS : " + $(el).attr("qname"));
	}

	// 2번질문
	function qestionTwoBtns(el){
		if($(el).val() < 0){
			alert("0원 이상으로 입력해주세요~");
			$(el).val("");
		}else if($(el).val() > 500){
			alert("500만원 이하로 입력해주세요!");
			$(el).val("");
		}else if (isNaN(parseFloat($(el).val())) && $(el).val() != ""){
			alert("숫자만 입력해주세요!!");
			$(el).val("");
		}

		$(".q2-badge").html("Price : " + $(el).val());

		sessionStorage.setItem("data-1",$(el).val())
	}

	// 3번 질문
	function qestionThreeBtns(el){

	}
	const btnList = JSON.parse(`${processResourceTypeCodeInfoVOList}`);
	const modalList = JSON.parse(`${processResourceMasterVOList}`);


</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="side-empty"></div>
			<!-- 작업영역 -->

			<!-- 기본 선택 모달 -->
			<div class="modal fade" id="ESCA_modal" aria-hidden="true" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header justify-content-center">
							<h5 class="modal-title">반갑습니다 현우의 컴퓨터 공방 입니다!</h5>
						</div>
						<div class="modal-body text-center">
							<h4 class="p-2">견적산출 기준을 정해주세요!</h4>
							<div class="text-center d-sm-flex align-items-center modal-btn-col new-btn">
								<button type="button" class="w-25 btn btn-primary modal-btn pb-0" onclick="javascript:modalNewBtn()">
									새로하기
								</button>
								<h5 class="w-75 ps-3 text-breaks">
									처음 이용하시거나 과거 견적산출이 필요 없으신 경우 새로 진행합니다.
								</h5>
							</div>
							<div class="text-center d-sm-flex align-items-center mt-2 modal-btn-col">
								<button type="button" class="w-25 btn btn-primary modal-btn pb-0" data-bs-target="#select-date" data-bs-toggle="modal">
									날짜선택
								</button>
								<h5 class="w-75 ps-3 text-breaks">
									<p>견적산출을 했던 날짜를 선택합니다.</p>
									<p>날짜 기준으로 다시 견적산출을 진행합니다.</p>
								</h5>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 날짜 선택 모달 -->
			<div class="modal fade" id="select-date" aria-hidden="true" aria-labelledby="select-date" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header text-center">
							<h1 class="modal-title fs-5">날짜 선택</h1>
						</div>
						<div class="modal-body">
							<div class="row">
								<div class="col-md">
									<p><div class="btn btn-primary pb-0" onclick="javascript:chooseDate()">날짜선택</div></p>
									<p><input type="text" class="form-control pb-0 bg-light" disabled id="date-input" onclick="javascript:chooseDate()"></input></p>
									<p><div class="btn btn-primary pb-0" onclick="javascript:chooseTime()">시간선택</div></p>
									<p><input type="text" class="form-control pb-0 bg-light" id="time-input" disabled></p>
									<small class="fz-6">시간 미선택시 00:00:00으로 입력됩니다</small>
								</div>
								<div class="col-md">
									<div id="date-chooser"></div>
									<div class="mt-2 p-2 pb-0 d-none" id="time-chooser">
										<input type="time" class="pb-0" value="13:33:31" step="1" onchange="javascript:changeTime()">
										<div id="time-refresher" class="ps-4" onclick="javascript:resetTime()">
											<svg width="32px" height="32px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#CCCCCC" stroke-width="1.6799999999999997"> <path opacity="0.5" d="M3.46447 3.46447C2 4.92893 2 7.28595 2 12C2 16.714 2 19.0711 3.46447 20.5355C4.92893 22 7.28595 22 12 22C16.714 22 19.0711 22 20.5355 20.5355C22 19.0711 22 16.714 22 12C22 7.28595 22 4.92893 20.5355 3.46447C19.0711 2 16.714 2 12 2C7.28595 2 4.92893 2 3.46447 3.46447Z" fill="#1C274C"></path> <path d="M12.0096 5.25C8.62406 5.25 5.83333 7.79988 5.46058 11.0833H5.00002C4.69658 11.0833 4.42304 11.2662 4.30701 11.5466C4.19099 11.8269 4.25534 12.1496 4.47005 12.364L5.63832 13.5307C5.93113 13.8231 6.40544 13.8231 6.69825 13.5307L7.86651 12.364C8.08122 12.1496 8.14558 11.8269 8.02955 11.5466C7.91353 11.2662 7.63998 11.0833 7.33654 11.0833H6.97332C7.33642 8.63219 9.45215 6.75 12.0096 6.75C13.541 6.75 14.9136 7.42409 15.8479 8.49347C16.1204 8.80539 16.5942 8.83733 16.9061 8.56479C17.2181 8.29226 17.25 7.81846 16.9775 7.50653C15.7702 6.12471 13.9916 5.25 12.0096 5.25Z" fill="#1C274C"></path> <path d="M18.3618 10.4693C18.069 10.1769 17.5947 10.1769 17.3018 10.4693L16.1336 11.636C15.9189 11.8504 15.8545 12.1731 15.9705 12.4534C16.0866 12.7338 16.3601 12.9167 16.6636 12.9167H17.0268C16.6637 15.3678 14.548 17.25 11.9905 17.25C10.4591 17.25 9.08654 16.5759 8.15222 15.5065C7.87968 15.1946 7.40589 15.1627 7.09396 15.4352C6.78203 15.7077 6.7501 16.1815 7.02263 16.4935C8.22995 17.8753 10.0085 18.75 11.9905 18.75C15.376 18.75 18.1668 16.2001 18.5395 12.9167H19.0001C19.3035 12.9167 19.5771 12.7338 19.6931 12.4534C19.8091 12.1731 19.7448 11.8504 19.53 11.636L18.3618 10.4693Z" fill="#1C274C"></path> </g><g id="SVGRepo_iconCarrier"> <path opacity="0.5" d="M3.46447 3.46447C2 4.92893 2 7.28595 2 12C2 16.714 2 19.0711 3.46447 20.5355C4.92893 22 7.28595 22 12 22C16.714 22 19.0711 22 20.5355 20.5355C22 19.0711 22 16.714 22 12C22 7.28595 22 4.92893 20.5355 3.46447C19.0711 2 16.714 2 12 2C7.28595 2 4.92893 2 3.46447 3.46447Z" fill="#1C274C"></path> <path d="M12.0096 5.25C8.62406 5.25 5.83333 7.79988 5.46058 11.0833H5.00002C4.69658 11.0833 4.42304 11.2662 4.30701 11.5466C4.19099 11.8269 4.25534 12.1496 4.47005 12.364L5.63832 13.5307C5.93113 13.8231 6.40544 13.8231 6.69825 13.5307L7.86651 12.364C8.08122 12.1496 8.14558 11.8269 8.02955 11.5466C7.91353 11.2662 7.63998 11.0833 7.33654 11.0833H6.97332C7.33642 8.63219 9.45215 6.75 12.0096 6.75C13.541 6.75 14.9136 7.42409 15.8479 8.49347C16.1204 8.80539 16.5942 8.83733 16.9061 8.56479C17.2181 8.29226 17.25 7.81846 16.9775 7.50653C15.7702 6.12471 13.9916 5.25 12.0096 5.25Z" fill="#1C274C"></path> <path d="M18.3618 10.4693C18.069 10.1769 17.5947 10.1769 17.3018 10.4693L16.1336 11.636C15.9189 11.8504 15.8545 12.1731 15.9705 12.4534C16.0866 12.7338 16.3601 12.9167 16.6636 12.9167H17.0268C16.6637 15.3678 14.548 17.25 11.9905 17.25C10.4591 17.25 9.08654 16.5759 8.15222 15.5065C7.87968 15.1946 7.40589 15.1627 7.09396 15.4352C6.78203 15.7077 6.7501 16.1815 7.02263 16.4935C8.22995 17.8753 10.0085 18.75 11.9905 18.75C15.376 18.75 18.1668 16.2001 18.5395 12.9167H19.0001C19.3035 12.9167 19.5771 12.7338 19.6931 12.4534C19.8091 12.1731 19.7448 11.8504 19.53 11.636L18.3618 10.4693Z" fill="#1C274C"></path> </g></svg>
										</div>
									</div>
									
								</div>
							</div>
						</div>
						<div class="modal-footer justify-content-between">
							<div class="row w-100">
								<div class="col-md-6 ps-0">
									<input type="text" class="pb-0 form-control bg-light" id="date-time-result" disabled>
								</div>
								<div class="col-md text-end">
									<button class="btn btn-primary pb-0 w-50" id="select-date-modal-start-btn" onclick="javascript:checkResult()">시작하기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- ui 업데이트 시안 -->
			<div class="container main-box">
				<div class="d-flex mt-3 mb-5 rounded" id="wrapper">
					<!-- Sidebar-->
					<div class="border-end bg-white" id="sidebar-wrapper">
						<div class="sidebar-heading border-bottom bg-light ps-2">질문 목록</div>
						<ul class="list-group list-group-flush">
							<a class="list-group-item list-group-item-action list-group-item-primary p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="1">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 1번
									<div class="d-flex">
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q1-badge"></span>
										<span class="badge bg-danger rounded-pill pt-2">필수</span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-primary p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="2">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 2번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q2-badge"></span>
										<span class="badge bg-danger rounded-pill pt-2">필수</span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-primary p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="3">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 3번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2 q3-badge"></span>
										<span class="badge bg-danger rounded-pill pt-2">필수</span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="4">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 4번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="5">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 5번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="6">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 6번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="7">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 7번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="8">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 8번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="9">
								<li class="d-flex justify-content-between align-items-center pt-2">
									질문 9번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="10>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 10번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="11>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 11번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="12>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 12번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="13>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 13번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="14>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 14번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="15>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 15번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="16>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 16번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="17>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 17번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="18>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 18번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="19>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 19번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
							<a class="list-group-item list-group-item-action list-group-item-light p-2" href="#!" onclick="javascript:clickQestionList(this)" qnum="20>
								<li class="d-flex justify-content-between align-items-center pt-2"">
									질문 20번
									<div>
										<span class="badge bg-primary rounded-pill pt-2 pe-2"></span>
									</div>
								</li>
							</a>
						</ul>
					</div>
					<!-- Page content wrapper-->
					<div id="page-content-wrapper" class="bg-white w-100">
						<!-- Top navigation-->
						<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom navbar-header">
							<div class="container-fluid">
								<button class="btn btn-primary" id="sidebarToggle">목록 보기</button>
								<button type="button" class="btn btn-success" id="es-btn" onclick="javascript:sendAllData()">견적 산출</button>
							</div>
						</nav>
						<!-- Page content-->
						<div class="container-fluid q-box">
							<h1 class="mt-4">견적산출</h1>
							<div class="q-base fade show">
								<h2 class="mt-4">질문은 총 20개 입니다. 1~3번은 필수 질문입니다!</h2>
								<h3 class="mt-3">목록의 질문을 클릭해서 질문에 답해주세요!</h3>
							</div>
							<!-- 1번 질문 -->
							<div class="q-1 fade">
								<h2 class="mt-4">질문 1번</h2>
								<h3 class="mt-3">OS(윈도우) 라이센스가 필요하신가요?</h3>
								<div class="mt-2 mb-5 row">
									<div class="col-xxl-2 question-col-3">
										<input type="radio" class="btn-check" name="btnradio" id="answer-a">
										<label class="btn btn-outline-secondary w-75" for="answer-a" val="1" qname="프리도스" onclick="javascript:qestionOneBtns(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Free Dos(OS 미설치) : 구매 후 바로 사용하실 수 없고 윈도우를 직접 설치하셔야 합니다. 최적화가 되어있지 않고, 드라이버가 담긴 USB를 제공합니다!"><p class="pt-2 m-0">프리도스</br>0원</p></label>
									</div>
									<div class="col-xxl-2 question-col-3">
										<input type="radio" class="btn-check" name="btnradio" id="answer-b">
										<label class="btn btn-outline-secondary w-75" for="answer-b" val="2" qname="COEM" onclick="javascript:qestionOneBtns(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="COEM(메인보드 귀속형) : 최적화 작업을 무상 진행합니다. 윈도우는 해당 PC를 폐기하거나 메인보드의 수명이 다하거나 당사 귀책 외의 사항으로 교체 시 라이선스를 재구매하셔야 합니다!"><p class="pt-2 m-0">COEM</br>150,000원</p></label>
									</div>
									<div class="col-xxl-2 question-col-3">
										<input type="radio" class="btn-check" name="btnradio" id="answer-c">
										<label class="btn btn-outline-secondary w-75" for="answer-c" val="3" qname="FPP" onclick="javascript:qestionOneBtns(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Fpp(라이센스 구매형) : 최적화 작업을 무상 진행합니다. 윈도우는 해당 PC를 폐기하거나 교체 할 경우 라이센스를 유지하고 다른 PC로 이전 가능합니다."><p class="pt-2 m-0">Fpp</br>180,000원</p></label>
									</div>
									<div class="col-md-6"></div>
								</div>
								<p class="mt-4 mb-0 q-1-p">최적화란?</p>
								<p class="q-1-p">윈도우 최적화, 드라이버 업데이트, 바이오스 설정 및 업데이트, 각 업데이트 내용은 이슈 없는 버전으로 리빌딩합니다.</p>
							</div>

							<!-- 2번 질문 -->
							<div class="q-2 fade">
								<h2 class="mt-4">질문 2번</h2>
								<h3 class="mt-3">본체에 투자하실 최대 한도는 얼마인가요? (최대 500만원)</h3>
								<div class="mt-2 mb-5 row">
									<div class="col-md">
										<div class="input-group has-validation text-end d-flex flex-end justify-content-center mb-5 calc-input-element">
											<input type="text" class="form-control input-field text-end w-50 first-q-input fs-5 pt-2" min="0" max="500" placeholder="ex) 300" id="can-pay-val" aria-describedby="inputGroupPrepend" required oninput="javascript:qestionTwoBtns(this)"/>
											<span class="input-group-text fs-5 pt-2" id="inputGroupPrepend">만원</span>
										</div>
									</div>
									<div class="col-md-6"></div>
								</div>
							</div>

							<!-- 3번 질문 -->
							<div class="q-3 fade">
								<h2 class="mt-4">질문 3번</h2>
								<h3 class="mt-3">주 사용 목적을 선택해주세요 (다중선택 가능)</h3>
								<div class="row">
									<div class="col-md-3">
										<input class="form-control text-center q3-game-head" type="text" value="게임" disabled readonly>
									</div>
									<div class="col-md-3">
										<input class="form-control text-center q3-work-head" type="text" value="작업" disabled readonly>
									</div>
									<div class="col-md-3">
										<input class="form-control text-center q3-surf-head" type="text" value="서핑" disabled readonly>
									</div>
								</div>
								<div class="row mt-3">
									<div class="col-md-3 text-center">
										<div class="list-group q3-game" processLgCd="01"></div>
									</div>
									<div class="col-md-3 text-center">
										<div class="list-group q3-work" processLgCd="02"></div>
									</div>
									<div class="col-md-3 text-center">
										<div class="list-group q3-surf" processLgCd="03">
											<button class="list-group-item list-group-item-action" type="button" id="PR999999">서핑</button>
										</div>
									</div>
								</div>
								<table class="table table-secondary table-striped table-hover mt-3 border rounded q3-table" style="display: none;">
									<thead>
										<tr>
											<th scope="col">장르</th>
											<th scope="col">비중</th>
											<th scope="col">이름</th>
											<th scope="col">삭제</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th>1</th>
											<td>1</td>
											<td>1</td>
										</tr>
										<tr>
											<th>2</th>
											<td>2</td>
											<td>2</td>
										</tr>
										<tr>
											<th>3</th>
											<td>3</td>
											<td>3</td>
										</tr>
									</tbody>
								  </table>
							</div>

							<!-- 3번 질문 모달 -->
							<div class="modal fade" id="q3-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h1 class="modal-title fs-5" id="staticBackdropLabel">Modal title</h1>
											<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
										...
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
											<button type="button" class="btn btn-primary">Understood</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 빈 영역 -->
			<div class="side-empty" style="width: 10%!important;"></div>
		</div>
	</div>
	
	<%@ include file="./common/footer.jsp" %>
</body>
</html>
