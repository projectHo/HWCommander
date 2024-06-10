<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ page
language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
  <head>
    <title>현우의 컴퓨터 공방 - 견적산출</title>
    <!-- Required meta tags -->
    <meta charset="utf-8" />
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

    <script>

    </script>
  </head>
  <body>

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
		 				<img src="/resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="0원으로 입력시 요구사항의 최소 견적으로 자동 산출됩니다." style="cursor:pointer">
		 			</div>
		 		</div>
			 		<div class="row pb-2">
			 			<div class="col">
			 				<div class="input-group has-validation text-end d-flex flex-end justify-content-center margin-center mb-5 w-50 calc-input-element">
							  <input type="text" class="form-control input-field text-end w-50 first-q-input fs-5 pt-2" min="0" max="500" placeholder="ex) 300" id="can-pay-val" aria-describedby="inputGroupPrepend" required oninput="javascript:priceCheck(this)"/>
							  <span class="input-group-text fs-5 pt-2" id="inputGroupPrepend">만원</span>
							</div>
			 			</div>
			 		</div>
			 		<div class="row pb-2">
						<div class="col">
							<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:clickReturnBtn()"><p class="pt-2 m-0">이전 질문</p></button>
						</div>
			 			<div class="col">
			 				<button type="button" class="form-control margin-center" onclick="javascript:clickEstimateBtn(this)"><p class="pt-2 m-0">견적 보기</p></button>
	                		<div class="fs-5 text-center" style="display: none; font-weight: bold; color: red;">2번 질문까지는 필수 질문입니다!</div>
			 			</div>
			 			<div class="col">
			 				<button type="button" class="form-control margin-center w-50 next-btn" onclick="javascript:clickNextBtn()"><p class="pt-2 m-0">다음 질문</p></button>
			 			</div>
			 		</div>
		 	</div>
 		</div>
        <!-- 빈 영역 -->
        <div class="justify-content-end" style="width: 15% !important"></div>
      </div>

  </body>
</html>
