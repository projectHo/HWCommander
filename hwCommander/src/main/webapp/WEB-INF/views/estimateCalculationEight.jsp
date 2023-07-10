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
		const text = " 테마 색상을 선택해주세요!(메인컬러 택 1, 서브컬러 택 1)";
		if (index < text.length) {
		$("#typingInput").val(function(i, val) {
			return val + text.charAt(index);
		});
		index++;
		setTimeout(typeText, 50);
		}
	}
	function returnPageBtn(){
		sessionStorage.removeItem("eight-Data");
		window.location.href = "estimateCalculationSeven.do";
	}
	function clickEstimateBtn(el){
		if($("#answer-y").prop("checked") === false && $("#answer-n").prop("checked") === false && $("#answer-o").prop("checked") === false){
			alert("선택은 필수에요!");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
		}else {
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			window.location.href = "estimateCalculationResult.do";
		}
	}
	function clickNextBtn(el){
		if($("#answer-y").prop("checked") === false && $("#answer-n").prop("checked") === false && $("#answer-o").prop("checked") === false){
			alert("선택은 필수에요!");
			$(el).addClass("is-invalid");
			setTimeout(() => {
				$(el).removeClass("is-invalid");
			}, 2000);
		}else {
			$(el).addClass("is-valid");
			setTimeout(() => {
				$(el).removeClass("is-valid");
			}, 2000);
			window.location.href = "estimateCalculationNine.do";
		}
	}
	$(function () {
	typeText();
	animateDonutGauge();
	// bootstrap tooltip
	const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
		return new bootstrap.Tooltip($(this)[0]);
	}).get();

	if(sessionStorage.getItem("eight-Data")){
		const eightData = sessionStorage.getItem("eight-Data");
		const yesBtn = $("#answer-y");
		const noBtn = $("#answer-n");
		if(eightData === "1"){
			yesBtn.prop("checked",true);
		}else if (eightData === "0"){
			noBtn.prop("checked",true);
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
					<div class="row pb-5">
						<div class="col-6">
							<div class="card" style="width: 18rem;">
								<div class="card-body">
									<h5 class="card-title">메인 컬러 : <span class="picked-main-color"></span></h5>
									<div class="container">
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(0,0,0);"></div> Black</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(0,122,192);"></div> Blue</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(112,63,58);"></div> Brown</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(222,182,62);"></div> Gold</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(94,94,94);"></div> Gray</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(199,198,116);"></div> Green</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(212,37,114);"></div> Magenta</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(143,215,212);"></div> Mint</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(239,124,31);"></div> Orange</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(236,180,186);"></div> Pink</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(173,108,200);"></div> Purple</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(252,46,70);"></div> Red</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(220,218,221);"></div> Silver</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(255,255,255);"></div> White</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(255,213,33);"></div> Yellow</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2"></div> 상관없음</span></div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-6">
							<div class="card" style="width: 18rem;">
								<div class="card-body">
									<h5 class="card-title">서브 컬러 : <span class="picked-sub-color"></span></h5>
									<div class="container">
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(0,0,0);"></div> Black</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(0,122,192);"></div> Blue</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(112,63,58);"></div> Brown</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(222,182,62);"></div> Gold</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(94,94,94);"></div> Gray</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(199,198,116);"></div> Green</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(212,37,114);"></div> Magenta</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(143,215,212);"></div> Mint</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(239,124,31);"></div> Orange</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(236,180,186);"></div> Pink</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(173,108,200);"></div> Purple</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(252,46,70);"></div> Red</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(220,218,221);"></div> Silver</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(255,255,255);"></div> White</span></div>
										</div>
										<div class="row">
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2" style="background-color: rgb(255,213,33);"></div> Yellow</span></div>
											<div class="col-6"><span class="card-text d-flex align-items-center"><div class="color-container me-2"></div> 상관없음</span></div>
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
