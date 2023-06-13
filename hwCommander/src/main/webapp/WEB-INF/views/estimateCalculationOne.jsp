<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
    <!-- 아래쪽에 부트스트랩 5.2.3 js 추가 -->
    <!--<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script> -->
    <link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet" />

    <script>
      var progress = 0;
      
      $(function () {
        animateBackgroundColor();
      });

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
    </script>
  </head>
  <body>
    <%@ include file="./common/header.jsp" %>

    <div class="basic_background w-100">
      <div class="d-flex">
        <!-- 빈 영역 -->
        <div class="h-25 justify-content-start" style="width: 15% !important"></div>

        <!-- 작업영역 -->
     
 		<div class="estimateCalc_background p-2" style="width: 70% !important">
 			<div class="w-75 container">
		 		<div class="row mt-2 pb-4">
		 			<div class="col-2 text-center">
		 				<div class="donut-container margin-center">
	                  		<div class="donut-fill">0</div>
	                  </div>
		 			</div>
		 			<div class="col-8 d-flex p-2">
		 				<input id="typingInput" class="form-control text-center" type="text" readonly aria-label="본체 예상 한도" disabled />
		 			</div>
		 			<div class="col-2 d-flex flex-column-reverse">
		 				<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="0원으로 입력시 요구사항의 최소 견적으로 자동 산출됩니다." style="cursor:pointer">
		 			</div>
		 		</div>
		 		<form class="needs-validation" action="/estimateCalculationTwo.do" novalidate>
			 		<div class="row pb-2">
			 			<div class="col">
			 				<div class="input-group has-validation text-end d-flex flex-end justify-content-center margin-center mb-5 w-50 calc-input-element">
							  <input type="number" class="form-control input-field text-end w-50" min="0" max="500" placeholder="ex) 300" id="validationCustomUsername" aria-describedby="inputGroupPrepend" required/>
							  <span class="input-group-text" id="inputGroupPrepend">만원</span>
							  <div class="invalid-feedback fs-5" style="font-weight: bold;">정확한 금액을 입력해 주세요!</div>
							</div>
			 			</div>
			 		</div>
			 		<div class="row pb-2">
		 		<!-- 	<div class="col">
			 				<button type="submit" class="form-control marin-center w-50">이전 질문</button>
			 			</div>
	 			 -->
	 			 		<div class="col"></div>
			 			<div class="col">
			 				<button type="button" class="form-control calc-one-final margin-center">견적 보기</button>
	                		<div class="invalid-feedback fs-5 calc-one-final-text text-center" style="display: none; font-weight: bold;">2페이지 까지는 필수 질문입니다!</div>
			 			</div>
			 			<div class="col">
			 				<button type="submit" class="form-control margin-center w-50">다음 질문</button>
			 			</div>
			 		</div>
		 		</form>
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

    <%@ include file="./common/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
    <script>
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
    
    
    (() => {
        "use strict";
        const forms = document.querySelectorAll(".needs-validation");
        Array.from(forms).forEach((form) => {
          form.addEventListener(
            "submit",
            (event) => {
              if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
              }
              form.classList.add("was-validated");
            },
            false
          );
        });
      })();
    
    
    const calcOneSubmit = document.querySelector(".calc-one-final");
    const calcOneText = document.querySelector(".calc-one-final-text");
    calcOneSubmit.addEventListener("click", () =>{
    	calcOneText.style.display = "block";
    })

    const inputElement = document.getElementById('typingInput');
	const text = "본체의 가용 예산 한도는 얼마입니까? (최대 500만원)";
	let index = 0;

	function typeText() {
		if (index < text.length) {
			inputElement.value += text.charAt(index);
			index++;
			setTimeout(typeText, 50);
		}
	}

	typeText();


    </script>
  </body>
</html>
