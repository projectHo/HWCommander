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
	
	

	function deleteButton(elem) {
		var forms = $(".needs-validation");
		const delInput = $("<input>").addClass("delete-input").attr("required",true).css("display","none");
		$(elem).parent().parent().remove();
		if ($(".table-body").find("tr").length === 0) {
			$(".table-container").css("display", "none");
			forms.append(delInput);
			forms.removeClass("was-validated");
		}
	};
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
			$(".donut-fill").html("2");
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
	function listRating(e) {
		const value = parseInt($(e.target).val(), 10) || 0;
		if (value > 100) {
			alert("100 이하로 입력해주세요!");
			$(e.target).val('');
		}else if (value < 1){
			$(e.target).val('');
			alert("1 이상입니다~")
		}

		let total = 0; 
		$(".use-list-rating").each(function() {
			total += parseInt($(this).val(), 10) || 0;
		});

		if (total > 100) {
			alert("100 이하로 입력해주세요!!");
			$('.use-list-rating').val('');
		}
	};
	function modalSubmit() {
		if ($(".table-body").find("tr").length > 0) {
			$("#use-collector").modal('hide');
			$(".table-container").css("display", "block");
			$(".table-list-names").css("display","table-row");
			$(".delete-input").remove();
			$("input#search-input").val('');
			$("#label-table").find("tr").remove();
		}else{
			alert("목록을 선택하시거나 취소버튼을 눌러주세요!")
		}
	};
	function modalCancel() {
		$("input#search-input").val('');
		$("#label-table").find("tr").remove();



		// const removableTr = $(".table-list-names").filter(function(){
		// 	return $(this).css("display")==="none";
		// });
		// removableTr.remove();
		// [$(".t-name-first"), $(".t-name-second"), $(".t-name-third"), $(".t-name-fourth")].forEach((elem)=>{
		// 		elem.css("color","rgb(33,37,41)");
		// 		elem.html("");
		// })
	};

	function returnOnePage(){
		var formData = JSON.parse(sessionStorage.getItem("formdata"));
		window.location.href = "estimateCalculationOne.do";
	}

	function makeModalList(id, elem) {
		var dataBtn = ${processResourceTypeCodeInfoVOList};
		var modalList = ${processResourceMasterVOList};
		
		const clickedTab = id;
		$(".collector-name").html($(elem).html());
		for(let i = 0; i<=modalList.length;i++){
			let paddingI = String(i+1).padStart(2,'0');
			let checkData = dataBtn[i];
			
			if(modalList[i].processTypeExclusiveCd===clickedTab){
				const tableBody = $("#label-table");
				const trTag = $("<tr></tr>");
				const tdTag = $("<td></td>");

				const inputTag = $("<input>").attr("type","checkbox").attr("autocomplete","off").addClass("btn-check").attr("id",modalList[i].id);
				const inputLabel = $("<label></label>").attr("for",modalList[i].id).html(modalList[i].processName).attr("onclick","javascript:selectModalList(this)");
				tableBody.append(trTag);
				trTag.append(tdTag);
				tdTag.append(inputTag);
				tdTag.append(inputLabel);
			}
		}
	}
	
	function selectModalList(elem){
		const clickedItemHtml = $(elem).html();
		const clickedItemId = $(elem).prev().attr("id");
		const modalName = $(".collector-name").html();

		const tableIds = $(".table-body").find("input[id]");
		let isDuplicate = $(".use-list-name").toArray().some(elem => $(elem).attr("id") === clickedItemId);
		if($(elem).css("color") === "rgb(33, 37, 41)"){
			tableIds.each(function () {
				const elementId = $(this).attr("id");
				console.log(isDuplicate)
				if(elementId === clickedItemId){
					isDuplicate = true;
				}else{
					return false;
				}
			})
			if (isDuplicate && !$(elem).data("duplicateChecked")) {
				$(elem).data("duplicateChecked", true);
				alert("중복된 요소입니다. 다른 값을 선택해주세요.");
			}else if(!isDuplicate){
				$(elem).data("duplicateChecked", false);
				const newRow = $("<tr></tr>").css("display","none").addClass("table-list-names");

				const thElement = $("<th></th>").attr("scope", "row").addClass("ps-3 align-middle");
				const input1 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).attr("value", modalName).css("border","none").css("text-align","center").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-genre");
				thElement.append(input1);
				newRow.append(thElement);

				const tdElement1 = $("<td></td>").addClass("t-submit ps-4 align-middle");
				const input2 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).attr("value", clickedItemHtml).css("border","none").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-name").attr("id",clickedItemId);
				tdElement1.append(input2);
				newRow.append(tdElement1);
				const tdElement2 = $("<td></td>").addClass("align-middle");
				const input3 = $("<input>").attr("type", "number").attr("required", true).attr("placeholder", "0~100").attr("max", "100").attr("min", "0").css("border", "none").css("font-weight", "bold").css("outline","none").addClass("use-list-rating");
				tdElement2.append(input3);
				newRow.append(tdElement2);
				const tdElement3 = $("<td></td>");
				const deleteButton = $("<button></button>").addClass("btn btn-danger").text("삭제").attr("onclick","javascript:deleteButton(this)").attr("type","button");
				
				tdElement3.append(deleteButton);
				newRow.append(tdElement3);
				// $(document).on("input",".use-list-rating",listRating(e))
				
				

				const tableBody = $(".table-body");
					const lastRow = tableBody.find("tr:last");
					if (lastRow.length > 0) {
						lastRow.after(newRow);
					} else {
						tableBody.append(newRow);
					}
				
				
				$(elem).css("color","red");
			}
		}else{
			const removeTr = $(".table-list-names").filter(function() {
				return $(this).find(".use-list-name").val() === selectValue;
			});
			removeTr.remove();		
			$(this).css("color","rgb(33,37,41)");
			console.log("start4")
		}
	}
	$(function () {
		
	animateDonutGauge();

	// search input
	
	const noResultText = document.createTextNode("일치하는 결과가 없습니다.");
	const labelTable = $("#label-table");
	const noResultRow = $("<tr>");
	const noResultCell = $("<td>");
	function searchLabel() {
		const labels = labelTable.find("label");
		const searchInput = $("#search-input").val().toLowerCase();
		const matchedLabels = [];
		console.log(labels);
		labels.each(function() {
			const label = $(this);
			const labelName = label.text().toLowerCase();

			if (labelName.includes(searchInput)) {
				matchedLabels.push(label);
			}
		});
		for(let i = 0 ; i < labels.length; i++){
			console.log(labels[i]);
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

	// bootstrap tooltip
	const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
		return new bootstrap.Tooltip($(this)[0]);
	}).get();
	
	// add base input
	$(".needs-validation").append($("<input>").attr({type: "text",class: "delete-input",required: true,style: "display:none;"}));
	// typing question text
	let index = 0;
	function typeText() {
		const text = "주 사용 목적은 무엇입니까? (다중선택 가능)";
		if (index < text.length) {
		$("#typingInput").val(function(i, val) {
			return val + text.charAt(index);
		});
		index++;
		setTimeout(typeText, 50);
		}
	}
	typeText();
	// list
	
	var modalList = ${processResourceMasterVOList};
	var dataBtn = ${processResourceTypeCodeInfoVOList};
	function makeGameList() {	
		const gameList = $(".list-game");
		const gameBtn = $("<button></button>").attr("type","button").attr("data-bs-toggle","modal").attr("data-bs-target","#use-collector").addClass("list-group-item list-group-item-action").html(dataBtn[i].processTypeExclusiveCdNm).attr("onclick","javascript:makeModalList(this.id,this)").attr("id",dataBtn[i].processTypeExclusiveCd);
		gameList.append(gameBtn);
	}
	function makeWorkList() {		
		const gameList = $(".list-work");
		const gameBtn = $("<button></button>").attr("type","button").attr("data-bs-toggle","modal").attr("data-bs-target","#use-collector").addClass("list-group-item list-group-item-action").html(dataBtn[i].processTypeExclusiveCdNm).attr("id",dataBtn[i].processTypeExclusiveCd).attr("onclick","javascript:makeModalList(this.id,this)");
		gameList.append(gameBtn);
	}
	for (var i = 0; i<dataBtn.length; i++){
		if(i<5){
			makeGameList();
		}else {
			makeWorkList();
		}
	}
	
	$(".surf-btn").on("click",()=>{
		if ($("#work-surf").prop('checked')===true){
			alert("중복 안됩니다")
			setTimeout(() => {
				$("#work-surf").prop('checked', true);
			}, 0);
		}else {
		$(".table-container").css("display", "block");
			
		const newRow = $("<tr></tr>");

		const thElement = $("<th></th>").attr("scope", "row").addClass("ps-3 align-middle");
		const input1 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).attr("value", "서핑").css("border","none").css("text-align","center").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-surf").attr("id","PR999999");
		thElement.append(input1);
		newRow.append(thElement);

		const tdElement1 = $("<td></td>").addClass("t-submit ps-4 align-middle");
		const input2 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).css("border","none").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-name");
		tdElement1.append(input2);
		newRow.append(tdElement1);

		const tdElement2 = $("<td></td>").addClass("align-middle");
		const input3 = $("<input>").attr("type", "number").attr("required", true).attr("placeholder", "0~100").attr("max", "100").attr("min", "0").css("border", "none").css("font-weight", "bold").css("outline","none").addClass("use-list-rating").attr("value","100");
		$(document).on('input',".use-list-rating",function(e) {
			const value = parseInt($(e.target).val(), 10) || 0;
			if (value > 100) {
				alert('100 이하로 입력해주세요!');
				$(e.target).val('');
			} else if (value < 1) {
				$(e.target).val('');
				alert("1 이상입니다~!")
			}

			let total = 0; 
			$('.use-list-rating').each(function() {
				total += parseInt($(this).val(), 10) || 0;
			});

			if (total > 100) {
				alert('100 이하로 입력해주세요!!');
				$('.use-list-rating').val('');
			}
		});
		tdElement2.append(input3);
		newRow.append(tdElement2);
		const tdElement3 = $("<td></td>");
		const deleteButton = $("<button></button>").addClass("btn btn-danger").text("삭제");
		deleteButton.on("click", () => {
			let delInput = $(".delete-input");
			newRow.remove();
			$("#work-surf").prop('checked',false);
			if ($(".table-body").find("tr").length === 0) {
				$(".table-container").css("display", "none");
				forms.append(delInput);
				forms.removeClass("was-validated");
			}
		});
		tdElement3.append(deleteButton);
		newRow.append(tdElement3);

		const tableBody = $(".table-body");
		const lastRow = tableBody.find("tr:last");
		if (lastRow.length > 0) {
			lastRow.after(newRow);
		} else {
			tableBody.append(newRow);
		}

		$(".delete-input").remove();
		}
	});
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
					console.log(totalRating);
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
				}
			});
		});
	})();
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
			<div class="estimateCalc_background p-2" style="width: 70% !important">
	 			<div class="w-75 container">
			 		<div class="row mt-4 pb-4">
			 			<div class="col-2 text-center">
			 				<div class="donut-container margin-center">
		                  		<div class="donut-fill">1</div>
		                  </div>
			 			</div>
			 			<div class="col-8 d-flex p-2">
			 				<input id="typingInput" class="form-control text-center" type="text" readonly aria-label="사용 용도" disabled />
			 			</div>
						<div class="col-2 d-flex flex-column-reverse">
			 				<img src="resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="기타 선택시 일반적인 PC로 구성됩니다!" style="cursor:pointer">
			 			</div>
			
			 		</div>
			 		
				 		<div class="row pb-2">
				 			<div class="col">
				 				<div class="list-group mb-1 w-75 text-center">
								  <button type="button" class="list-group-item list-group-item-action mb-3 bgc-disabled" disabled aria-current="true">게임</button>
							    </div>
				 				<div class="list-group mb-3 w-75 text-center list-game">
								  <!-- <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collector"></button>
								  <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collector"></button>
								  <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collector"></button>
								  <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collector"></button>
								  <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collector"></button> -->
								</div>
				 			</div>
				 			<div class="col">
				 				<div class="list-group mb-1 w-75 text-center margin-center">
								  <button type="button" class="list-group-item list-group-item-action mb-3 bgc-disabled" disabled aria-current="true">작업</button>
							    </div>
				 				<div class="list-group mb-3 w-75 text-center margin-center list-work">
								  <!-- <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collector"></button>
								  <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collector"></button>
								  <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collector"></button>
								  <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collector"></button>
								  <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collector"></button> -->
								</div>
				 			</div>
				 			<div class="col d-flex justify-content-end">
				 				<div class="list-group mb-1 w-75 text-center">
								  <input type="checkbox" class="btn-check" id="work-surf" autocomplete="off">
								  <label class="btn btn-outline-secondary surf-btn" for="work-surf">서핑</label>
							    </div>
				 			</div>
						</div>
						<form class="needs-validation" action="#" novalidate>
							<!-- <input type="text" class="delete-input" required style="display:none;"> -->
							<div class="row table-style p-1 mb-3 table-container" style="display: none;">
								<div class="container">
									<table class="table table-submit">
										<thead>
											<tr>
												<th scope="col" class="text-center" style="width: 15%;">장르</th>
												<th scope="col" class="submit-name ps-4">목록</th>
												<th scope="col" style="width:20%">비중</th>
												<th scope="col" style="width:10%"></th>
											</tr>
										</thead>
										<tbody class="table-body">
											<!-- <c:forEach var="item" items="">
												<tr class="table-list-names" style="display: none;">
													<th scope="row" class="ps-3 align-middle">
														<input type="text" class="use-list-genre" style="border:none; text-align:center;font-weight:bold;background-color:inherit;" disabled readpm;u>
													</th>
													<td class="t-submit ps-4 align-middle">
														<input type="text" class="use-list-name" style="border: none; font-weight: bold; background-color: inherit; readonly disabled">
													</td>
													<td class="align-middle">
														<input type="number" placeholder="0~100" max="100" min="0" class="use-list-rating" style="border: none; font-weight: bold; outline: none;" required>
													</td>
													<td>
														<button class="btn btn-danger">삭제</button>
													</td>
												</tr>
											</c:forEach> -->
											<!-- <tr>
												<th scope="row" class="ps-3">
													<input type="text" required>
												</th>
												<td class="t-submit-first">
													<input type="text" required>
												</td>
												<td class="t-submit">
													<input type="number" required>
												</td>
												<td><button class="btn btn-danger delete-button">삭제</button></td>
											</tr> -->
										</tbody>
									</table>
								</div>
							</div>
							<div class="row mb-4">
								<div class="col">
									<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:returnOnePage()">이전 질문</button>
								</div>
								<div class="col">
									<button type="submit" class="form-control calc-two-final margin-center">견적 보기</button>
									<div class="invalid-feedback fs-5 calc-two-final-text-use text-center" style="display: none; font-weight: bold;">사용 용도를 선택해주세요!</div>
									<div class="invalid-feedback fs-5 calc-two-final-text-rating text-center" style="display: none; font-weight: bold;">비중을 정확하게 입력해주세요!(100%)</div>
								</div>
								<div class="col">
									<button type="submit" class="form-control w-50 margin-left-auto">다음 질문</button>
								</div>
							</div>
						</form>
				 		<div class="modal fade" id="use-collector" tabindex="-1" aria-labelledby="collecter" aria-hidden="true" data-bs-backdrop="static">
						  <div class="modal-dialog">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h1 class="modal-title fs-5 collector-name"></h1>
						        <button type="button" class="btn-close modal-btn" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <div class="modal-body">
								<div class="container">
						       	  <table class="table">
									<thead>
									  <tr>
										<form class="form-inline">
											<input type="text" class="form-control" id="search-input" placeholder="검색어를 입력하세요">
										</form>
									  </tr>
									  <tr>
										<th scope="col">이름</th>
									  </tr>
									</thead>
									<tbody id="label-table">
									  <!-- <tr>
										<td>
											<input type="checkbox" class="btn-check" id="btn-check" autocomplete="off">
											<label class="t-name-second" for="btn-check"></label>
										</td>
									  </tr>
									  <tr>
										<td>
											<input type="checkbox" class="btn-check" id="btn-check" autocomplete="off">
											<label class="t-name-third" for="btn-check"></label>
										</td>
									  </tr>
									  <tr>
										<td>
											<input type="checkbox" class="btn-check" id="btn-check" autocomplete="off">
											<label class="t-name-fourth" for="btn-check"></label>
										</td>
									  </tr> -->
									</tbody>
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
	 		</div>
			
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 15%!important;"></div>
		
		
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
