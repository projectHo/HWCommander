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

<!-- 09.12 단독 스타일시트 추가 -->
<link rel="stylesheet" href="/resources/css/ESCASelect.css">


<!-- 09.08 date picker js css 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/js/bootstrap-datepicker.min.js" integrity="sha512-LsnSViqQyaXpD4mBBdRYeP6sRwJiJveh2ZIbW41EBrNmKxgr/LFZIiWT6yr+nycvhvauz8c2nYMhrP80YhG7Cw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/locales/bootstrap-datepicker.ko.min.js" integrity="sha512-L4qpL1ZotXZLLe8Oo0ZyHrj/SweV7CieswUODAAPN/tnqN3PA1P+4qPu5vIryNor6HQ5o22NujIcAZIfyVXwbQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.min.css" integrity="sha512-aQb0/doxDGrw/OC7drNaJQkIKFu6eSWnVMAwPN64p6sZKeJ4QCDYL42Rumw2ZtL8DB9f66q4CnLIUnAw28dEbg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.10.0/css/bootstrap-datepicker3.standalone.min.css" integrity="sha512-t+00JqxGbnKSfg/4We7ulJjd3fGJWsleNNBSXRk9/3417ojFqSmkBfAJ/3+zpTFfGNZyKxPVGwWvaRuGdtpEEA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script>
	$(function(){		
		// bootstrap tooltip base
		const tooltipTriggerList = $('[data-bs-toggle="tooltip"]');
		const tooltipList = tooltipTriggerList.map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();

		// 텍스트 애니메이션
		typeText();

	})

	let index = 0;
	function typeText() {
		const inputElement = $("#typingInput");
		const text = "저희 홈페이지에서 견적산출을 해본 적 있으신가요?";
		if (index < text.length) {
			inputElement.val(function(i, val) {
			return val + text.charAt(index);
			});
			index++;
			setTimeout(typeText, 50);
		}
	}
	function modalPrev(){
		$(".modal-footer").css("display","block");
		$('#datepicker-input').datepicker({
			language: 'ko',
			format: 'yyyy-mm-dd',
			startDate: '2023-03-01',
			endDate: new Date(),
			autoclose: true,
		});
	}
	function clickAnswerBtn(el){
		if($(el).children().html() == "새로하기"){
			for(let i = 0; i<=19 ; i++){
				sessionStorage.setItem("data-" + i, "");
			}
			sessionStorage.setItem("targetData" , "");
			location.href = "/ESCA/ESCA_00_ver_1_0.do";	
		}else if($(el).children().html() == "과거기준"){
			$("#select-modal").modal("show");
		}else {
			location.href = "/";
		}
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
			location.href = "/ESCA/ESCA_00_ver_1_0.do";
		}
	}
	function resetTime(){
		$("#time-chooser").children().val("00:00:00");
		chooseDate();
		chooseTime();
		changeTime();
	}
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	<div class="modal fade" id="select-modal" data-bs-backdrop="static" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
			<div class="modal-header justify-content-center">
			  <h1 class="modal-title fs-5 pt-2">과거견적 조회하기</h1>
			</div>
			<div class="modal-body pt-0">
				<div class="row">
					<div class="col-md">
						<p><div class="btn btn-primary" onclick="javascript:chooseDate()">날짜선택</div></p>
						<p><input type="text" class="form-control bg-light" disabled id="date-input" onclick="javascript:chooseDate()"></input></p>
						<p><div class="btn btn-primary" onclick="javascript:chooseTime()">시간선택</div></p>
						<p><input type="text" class="form-control bg-light" id="time-input" disabled></p>
						<small class="fz-6">시간 미선택시 00:00:00으로 입력됩니다</small>
					</div>
					<div class="col-md">
						<div id="date-chooser"></div>
						<div class="mt-2 p-2 pb-0 d-none" id="time-chooser">
							<input type="time" value="13:33:31" step="1" onchange="javascript:changeTime()">
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
						<input type="text" class="form-control bg-light" id="date-time-result" disabled>
					</div>
					<div class="col-md text-end">
						<button class="btn btn-primary w-50" onclick="javascript:checkResult()">시작하기</button>
					</div>
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
				<div class="w-75 container">
					<div class="row mt-2 pb-4">
						<div class="col-md-2"></div>
						<div class="col-md-8 d-flex p-2">
							<input id="typingInput" class="form-control text-center pt-3 fs-5" type="text" readonly aria-label="본체 예상 한도" disabled />
						</div>
						<div class="col-md-2 d-flex flex-column-reverse">
							<img src="/resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="버튼에 마우스를 올리면 설명이 나와요!" style="cursor:pointer">
						</div>
					</div>
				   <div class="row pb-3">
					   <div class="col-md d-flex justify-content-center">
						   <input type="radio" class="btn-check" name="btnradio" id="answer-a">
						   <label class="btn btn-outline-secondary w-75" for="answer-a" onclick="javascript:clickAnswerBtn(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="처음 이용하시거나 과거 견적산출이 필요 없으신 경우 새로 진행합니다."><p class="pt-2 m-0">새로하기</p></label>
					   </div>
					   <div class="col-md d-flex justify-content-center">
						   <input type="radio" class="btn-check" name="btnradio" id="answer-b">
						   <label class="btn btn-outline-secondary w-75" for="answer-b" onclick="javascript:clickAnswerBtn(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="견적산출을 했던 날짜를 선택합니다. 날짜 기준으로 다시 견적산출을 진행합니다."><p class="pt-2 m-0">과거기준</p></label>
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
