<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
  <head>
    <title>현우의 컴퓨터 공방 - 견적산출</title>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous" />
    <link rel="stylesheet" href="/resources/css/main.css" />
    <link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css" />
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
	<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet" />

    <script>
		var progress = 0;

		function clickAnswerBtn(el){
			if($(el).children().html().includes("프리도스")){
				sessionStorage.setItem("data-0",0);
			}else if($(el).children().html().includes("COEM")){
				sessionStorage.setItem("data-0",1);
			}else if($(el).children().html().includes("Fpp")){
				sessionStorage.setItem("data-0",2);
			}
		}	

		function clickNextBtn(el) {
			if($("#answer-a").prop("checked") === false && $("#answer-b").prop("checked") === false && $("#answer-c").prop("checked") === false){
				alert("셋중에 하나를 클릭해주세요!");
				$(el).addClass("is-invalid");
				setTimeout(() => {
					$(el).removeClass("is-invalid");
				}, 2000);
			}else {
				$(el).addClass("is-valid");
				setTimeout(() => {
					$(el).removeClass("is-valid");
				}, 2000);
				window.location.href = "ESCA_01_ver_1_0.do";
			}
		}

		function clickEstimateBtn(el) {
			$(el).next().css("display","block");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).next().css("display","none");
				$(el).removeClass("is-invalid");
			}, 3000);
		}
			
		function animateBackgroundColor() {
			$(".donut-container").css(
			"background",
			"conic-gradient(#df22ee 0% " + progress + "%, #f2f2f2 100% 0%)"
			);

			if (progress < 100) {
			progress += 3;
			setTimeout(animateBackgroundColor, 20);
			} else {
				$(".donut-fill").html("1");
			goToZero();
			}
		}

		function goToZero() {
			$(".donut-container").css(
			"background",
			"conic-gradient(#df22ee 0% " + progress + "%, #f2f2f2 100% 0%)"
			);
			progress -= 3;
			if (progress > 0) {
			setTimeout(goToZero, 20);
			}
		}
			
		let index = 0;
		function typeText() {
			const inputElement = $("#typingInput");
			const text = "OS(윈도우) 라이센스가 필요하신가요?";
			if (index < text.length) {
				inputElement.val(function(i, val) {
				return val + text.charAt(index);
				});
				index++;
				setTimeout(typeText, 50);
			}
		}

		$(function () {
			for(let i = 1; i<=19 ; i++){
				sessionStorage.setItem("data-" + i, "");
			}
			if(!sessionStorage.getItem("targetData")){
				sessionStorage.setItem("targetData" , "");
			}
			// bootstrap tooltip base
			const tooltipTriggerList = $('[data-bs-toggle="tooltip"]');
			const tooltipList = tooltipTriggerList.map(function() {
				return new bootstrap.Tooltip($(this)[0]);
			}).get();
			// 견적산출 데이터처리부(수신)
			if(sessionStorage.getItem("data-0")){
				if(sessionStorage.getItem("data-0") === "0"){
					$("#answer-a").prop("checked",true);
				}else if (sessionStorage.getItem("data-0") === "1"){
					$("#answer-b").prop("checked",true);
				}else if (sessionStorage.getItem("data-0") === "2"){
					$("#answer-c").prop("checked",true);
				}
			}
			
			// functions			
			typeText();
		});

		
		
	  
   

    </script>
  </head>
  <body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="basic_background w-100">
      <div class="d-flex">
        <!-- 빈 영역 -->
        <div class="h-25 justify-content-start" style="width: 15% !important"></div>

        <!-- 작업영역 -->
     
 		<div class="estimateCalc_background p-5" style="width: 70% !important">
 			<div class="w-75 container">
		 		<div class="row mt-2 pb-4">
		 			<div class="col-2 text-center">
		 				<div class="donut-container margin-center">
	                  		<div class="donut-fill">0</div>
	                  </div>
		 			</div>
		 			<div class="col-8 d-flex p-2">
		 				<input id="typingInput" class="form-control text-center pt-3 fs-5" type="text" readonly aria-label="본체 예상 한도" disabled />
		 			</div>
		 			<div class="col-2 d-flex flex-column-reverse">
		 				<img src="/resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="버튼에 마우스를 올리면 설명이 나와요!" style="cursor:pointer">
		 			</div>
		 		</div>
				<div class="row pb-3">
					<div class="col d-flex justify-content-center">
						<input type="radio" class="btn-check" name="btnradio" id="answer-a">
						<label class="btn btn-outline-secondary w-75" for="answer-a" onclick="javascript:clickAnswerBtn(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Free Dos(OS 미설치) : 구매 후 바로 사용하실 수 없고 윈도우를 직접 설치하셔야 합니다. 최적화가 되어있지 않고, 드라이버가 담긴 USB를 제공합니다!"><p class="pt-2 m-0">프리도스</br>0원</p></label>
					</div>
					<div class="col d-flex justify-content-center">
						<input type="radio" class="btn-check" name="btnradio" id="answer-b">
						<label class="btn btn-outline-secondary w-75" for="answer-b" onclick="javascript:clickAnswerBtn(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="COEM(메인보드 귀속형) : 최적화 작업을 무상 진행합니다. 윈도우는 해당 PC를 폐기하거나 메인보드의 수명이 다하거나 당사 귀책 외의 사항으로 교체 시 라이선스를 재구매하셔야 합니다!"><p class="pt-2 m-0">COEM</br>150,000원</p></label>
					</div>
					<div class="col d-flex justify-content-center">
						<input type="radio" class="btn-check" name="btnradio" id="answer-c">
						<label class="btn btn-outline-secondary w-75" for="answer-c" onclick="javascript:clickAnswerBtn(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Fpp(라이센스 구매형) : 최적화 작업을 무상 진행합니다. 윈도우는 해당 PC를 폐기하거나 교체 할 경우 라이센스를 유지하고 다른 PC로 이전 가능합니다."><p class="pt-2 m-0">Fpp</br>180,000원</p></label>
					</div>
				</div>
				<div class="row pb-2">
					<div class="col"></div>
					<div class="col-2 d-flex justify-content-center">
						<label class="btn btn-outline-secondary w-75" for="answer-d" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="윈도우 최적화, 드라이버 업데이트, 바이오스 설정 및 업데이트, 각 업데이트 내용은 이슈 없는 버전으로 리빌딩합니다."><p class="pt-2 m-0">최적화란?</p></label>
					</div>
					<div class="col"></div>
				</div>
				<div class="row pb-2">
					<div class="col"></div>
					<div class="col">
						<button type="button" class="form-control margin-center" onclick="javascript:clickEstimateBtn(this)"><p class="pt-2 m-0">견적 보기</p></button>
						<div class="fs-5 text-center mt-2" style="display: none; font-weight: bold; color: red;">2번 질문까지는 필수 질문입니다!</div>
					</div>
					<div class="col">
						<button type="button" class="form-control margin-center w-50 next-btn" onclick="javascript:clickNextBtn(this)"><p class="pt-2 m-0">다음 질문</p></button>
					</div>
				</div>
		 	</div>
 		</div>
        <!-- 빈 영역 -->
        <div class="justify-content-end" style="width: 15% !important"></div>
      </div>

      <!-- 2022.11.16 디자인이미지 추가 -->
      <div class="mt-5 mx-5" style="height: 15% !important">
        <img
          class="img-fluid float-end"
          src="/resources/img/layer-34-1200x107.png"
          alt="" />
      </div>
      <div class="mt-2 mx-5" style="height: 15% !important">
        <img class="img-fluid" src="/resources/img/layer-26.png" alt="" />
      </div>
    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
</html>
