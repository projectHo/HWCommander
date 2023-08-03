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
			$(".donut-fill").html("17");
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
	function clickAnswerBtn(el){
		if($(el).html() === "선택하기"){

		}
	}
	function clickReturnBtn(){
		sessionStorage.setItem("data-17","");
		location.href = "estimateCalculationSixteen.do";
	}
	function clickEstimateBtn(el){
		if($("#answer-a").prop("checked") === false && $("#answer-b").prop("checked") === false && $("#answer-c").prop("checked") === false && $("#answer-d").prop("checked") === false && $("#answer-e").prop("checked") === false){
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
			sendAllData();
		}
	}
	function clickNextBtn(el){
		if($("#answer-a").prop("checked") === false && $("#answer-b").prop("checked") === false && $("#answer-c").prop("checked") === false && $("#answer-d").prop("checked") === false && $("#answer-e").prop("checked") === false){
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
			window.location.href = "estimateCalculationEighteen.do";
		}
	}
	$(function () {
		// donut
		animateDonutGauge();
		$(".donut-fill").css("left","calc(50% - 22px)");
		// typing question text
		let index = 0;
		function typeText() {
			const text = "싫어하시는 브랜드가 있으신가요?";
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
		if(sessionStorage.getItem("data-14")){
			const storedData = sessionStorage.getItem("data-14");
			if(storedData === "1"){
				$("#answer-a").prop("checked",true);
			}else if (storedData === "HOME"){
				$("#answer-b").prop("checked",true);
			}
		}
		// search input
	
	const noResultText = document.createTextNode("일치하는 결과가 없습니다.");
	const labelTable = $("#label-table");
	const noResultRow = $("<tr>");
	const noResultCell = $("<td>");
	function searchLabel() {
		const labels = labelTable.find("label");
		const searchInput = $("#search-input").val().toLowerCase();
		const matchedLabels = [];
		labels.each(function() {
			const label = $(this);
			const labelName = label.text().toLowerCase();

			if (labelName.includes(searchInput)) {
				matchedLabels.push(label);
			}
		});
		for(let i = 0 ; i < labels.length; i++){
		}
		const searchInputValue = $("#search-input").val().trim();
		if (matchedLabels.length > 0) {
			matchedLabels.sort(function(a, b) {
			const aIndex = a.text().toLowerCase().indexOf(searchInput);
			const bIndex = b.text().toLowerCase().indexOf(searchInput);

			if (aIndex === bIndex) {
				return a.text().toLowerCase().localeCompare(b.text().toLowerCase());
			}

			return aIndex - bIndex;
			});
			
			hideAllRows();
			
			matchedLabels.forEach(function(matchedLabel) {
			const row = matchedLabel.closest("tr");
			row.css("display", "table-row");
			});
		}else {
			hideAllRows();

			noResultCell.attr("colspan", "2");
			noResultCell.append(noResultText);
			noResultRow.append(noResultCell);
			labelTable.append(noResultRow);
		}
	}
	function hideAllRows() {
		labelTable.find("tr").css("display", "none");

		if (noResultRow.parent().is(labelTable)) {
			noResultRow.remove();
		}
	}

	$("#search-input").on("input", function() {
		searchLabel();
	});
});
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
								 <div class="donut-fill"">16</div>
							</div>
						</div>
						<div class="col-8 d-flex p-2">
							<input id="typingInput" class="form-control text-center fs-5 pt-2" type="text" readonly aria-label="예산 편성" disabled />
						</div>
					    <div class="col-2 d-flex flex-column-reverse">
							<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="선택하신 브랜드는 제외하고 견적 산출 해드립니다! 상관없으시다면 <상관없음> 체크해주세요!" style="cursor:pointer">
						</div>
					</div>
					<div class="row pb-5">
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-a">
							<label class="btn btn-outline-secondary w-75 d-flex align-items-center justify-content-center" for="answer-a" data-bs-toggle="modal" data-bs-target="#brand-selector" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">선택하기</p></label>
						</div>
						<div class="col d-flex justify-content-center">
							<input type="radio" class="btn-check" name="btnradio" id="answer-b">
							<label class="btn btn-outline-secondary w-75 d-flex align-items-center justify-content-center" for="answer-b" onclick="javascript:clickAnswerBtn(this)"><p class="pt-2 m-0">상관없음</p></label>
						</div>
					</div>
					<div class="row mb-4">
						<div class="col-4">
							<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:clickReturnBtn()"><p class="pt-2 m-0">이전 질문</p></button>
						</div>
						<div class="col-4">
							<button type="button" class="form-control margin-center" onclick="javascript:clickEstimateBtn(this)"><p class="pt-2 m-0">견적 보기</p></button>
						</div>
						<div class="col-4">
							<button type="button" class="form-control margin-left-auto w-50" onclick="javascript:clickNextBtn(this)"><p class="pt-2 m-0">다음 질문</p></button>
						</div>
					</div>
					<div class="row mb-4">
						<div class="col-6">
							<!-- 선택된 내용 박스 -->
						</div>
						<div class="col-6"></div>
					</div>
				</div>
				<div class="modal fade" id="brand-selector" tabindex="-1" aria-labelledby="selector" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
					<div class="modal-dialog">
					  <div class="modal-content">
						<div class="modal-header">
						  <h1 class="modal-title fs-4">브랜드 선택하기</h1>
						  <button type="button" class="btn-close modal-btn" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">
						  <div class="container">
							   <table class="table">
							  <thead>
								<tr>
								  <form class="form-inline">
									  <input type="text" class="form-control" id="search-input" placeholder="검색어를 입력하세요" oninput="javascript:searchLabel()">
								  </form>
								</tr>
								<tr>
								  <th scope="col">브랜드명</th>
								</tr>
							  </thead>
							  <tbody id="label-table"></tbody>
							</table>
						  </div>
						</div>
						<div class="modal-footer">
						  <button type="button" class="btn btn-secondary modal-btn" data-bs-dismiss="modal" onclick="javascript:modalCancel()">취소</button>
						  <button type="button" class="btn btn-primary modal-btn modal-submit-btn" onclick="javascript:modalSubmit()">저장</button>
						</div>
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
