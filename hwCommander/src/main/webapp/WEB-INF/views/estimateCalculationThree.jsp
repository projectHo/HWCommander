<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<>
<head>
<title>현우의 컴퓨터 공방 - 견적산출</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>

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
	
	function returnTwoPage() {
		window.location.href = "estimateCalculationTwo.do";
	}
	$(function () {
	// bootstrap tooltip
	const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
		return new bootstrap.Tooltip($(this)[0]);
	}).get();
	// donut
	animateDonutGauge();
	// modal esc delete
	$('#use-collector').off('keydown.dismiss.bs.modal');
	// submit
	var forms = $(".needs-validation");
	(function() {
		"use strict";
		const calcTwoTextUse = $(".calc-two-final-text-use");
		const calcTwoTextRating = $(".calc-two-final-text-rating");

		
		forms.each(function() {
			$(this).on("submit", function(event) {
				const countRating = $('.use-list-rating').length;
				let totalRating = 0;
				$('.use-list-rating').each(function() {
					totalRating += parseInt($(this).val(), 10) || 0;
				});
				if ($(".table-container").css("display")==="block" && totalRating !== 100){
					event.preventDefault();
					calcTwoTextRating.css("display", "block");
					setTimeout(() => {
						calcTwoTextRating.css("display", "none");
					}, 3000);
				}else if (!this.checkValidity()) {
					event.preventDefault();
					calcTwoTextUse.css("display", "block");
					setTimeout(() => {
						calcTwoTextUse.css("display", "none");
					}, 3000);
				} else if (this.checkValidity() && totalRating === 100){
					$(this).addClass("was-validated");
					let value = [];
					for(let i = 0 ; i<$(".use-list-name").length; i++){
						let paddingI = String(i+1).padStart(2,'0');
						let storageValue = [$(".use-list-name")[i].id,$(".use-list-rating")[i].value,$(".use-list-genre")[i].id];
						value.push(storageValue);
					}
					if(sessionStorage.getItem("second-Data")){
						sessionStorage.removeItem("second-Data");
					}
					sessionStorage.setItem("second-Data",JSON.stringify(value))
				}
			});
		});
	})();
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
			<div class="estimateCalc_background p-2" style="width: 70%!important;">
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
							<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="이 페이지부터 견적 산출이 가능합니다!" style="cursor:pointer">
						</div>
		   
					</div>
					<form class="needs-validation" action="#" novalidate>
						<div class="row pb-2">
							
						</div>
						<div class="row mb-4">
							<div class="col">
								<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:returnTwoPage()">이전 질문</button>
							</div>
							<div class="col">
								<button type="button" class="form-control calc-two-final margin-center">견적 보기</button>
							</div>
							<div class="col">
								<button type="submit" class="form-control w-50 margin-left-auto">다음 질문</button>
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