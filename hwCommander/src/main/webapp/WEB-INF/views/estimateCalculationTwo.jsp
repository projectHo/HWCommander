<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 견적산출</title>
<!-- Required meta tags -->
<meta charset="utf-8">
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
	$(function () {
		animateBackgroundColor();
	});

	let progress = 0;
	function animateBackgroundColor() {
		$(".donut-container").css(
			"background",
			"conic-gradient(#df22ee 0% " + progress + "%, #f2f2f2 100% 0%)"
		);
		
		if (progress < 100) {
			progress += 5;
			setTimeout(animateBackgroundColor, 20);
		} else {
			$(".donut-fill").html("2");
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
	const delInput = $("<input>").attr({
		type: "text",
		class: "delete-input",
		required: true,
		style: "display:none;"
	});
	$(document).ready(function() {

		const tooltipTriggerList = $('[data-bs-toggle="tooltip"]');
		const tooltipList = tooltipTriggerList.map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();
		const forms = $(".needs-validation");
		forms.append(delInput);
		
		
		
		
		const inputElement = $("#typingInput");
		const text = "주 사용 목적은 무엇입니까? (다중선택 가능)";
		let index = 0;
		
		function typeText() {
			if (index < text.length) {
			inputElement.val(function(i, val) {
				return val + text.charAt(index);
			});
			index++;
			setTimeout(typeText, 50);
			}
		}
		
		typeText();

		const modal = new bootstrap.Modal($("#use-collecter"));
		
	    $(".list-game").on("click", function(e) {
			const games = {
				FPS: ["PlayerUnknown's Battlegrounds", "Apex Legend", "Valorant","기타"],
				AOS: ["League of Legends", "Dota 2", "Heros of the Storm","기타"],
				RPG: ["Lost Ark", "Diablo IV", "Dungeon and Fighter","기타"],
				RTS: ["FIFA Online 4", "Starcraft Remastered", "Warcraft III Reforged","기타"],
				레이싱: ["Forza Horizon 5", "Assetto Corsa", "Grand Theft Auto V","기타"]
			};
			const HTMLs = $(e.target).html();
			$(".collector-name").html(HTMLs);

			if (games.hasOwnProperty(HTMLs)) {
				[$(".t-name-first"), $(".t-name-second"), $(".t-name-third"), $(".t-name-fourth")].forEach((elem, index) => {
				elem.html(games[HTMLs][index]);
				});
			}
			const ratings = $(".rating");
			[$(".t-name-first"), $(".t-name-second"), $(".t-name-third"), $(".t-name-fourth")].forEach((elem, index) => {
				elem.off("click").on("click", () => {
					if(elem.css("color") === "rgb(255, 0, 0)"){
						elem.css("color","black");
					}else {
						elem.css("color","red");
					}
					if(ratings.eq(index).css("display") === "none"){
						ratings.eq(index).css("display","block");
					}else if (ratings.eq(index).css("display") === "block"){
						ratings.eq(index).css("display","none");
					}
					
					const selectedKey = $(".collector-name").text();
					const selectValue = elem.text();
					const newRow = $("<tr></tr>").css("display","none").addClass("table-list-names");

					const thElement = $("<th></th>").attr("scope", "row").addClass("ps-3 align-middle");
					const input1 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).attr("value", selectedKey).css("border","none").css("text-align","center").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-genre");
					thElement.append(input1);
					newRow.append(thElement);

					const tdElement1 = $("<td></td>").addClass("t-submit ps-4 align-middle");
					const input2 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).attr("value", selectValue).css("border","none").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-name");
					const isDuplicate = $(".use-list-name").toArray().some(element => $(element).val() === selectValue);
					if (isDuplicate) {
 						 alert("중복된 요소입니다. 다른 값을 선택해주세요.");
						 elem.css("color","black");
					}else {
					tdElement1.append(input2);
					newRow.append(tdElement1);
					const tdElement2 = $("<td></td>").addClass("align-middle");
					const input3 = $("<input>").attr("type", "number").attr("required", true).attr("placeholder", "0~100").attr("max", "100").attr("min", "0").css("border", "none").css("font-weight", "bold").css("outline","none").addClass("use-list-rating");
					tdElement2.append(input3);
					newRow.append(tdElement2);
					const tdElement3 = $("<td></td>");
					const deleteButton = $("<button></button>").addClass("btn btn-danger").text("삭제");
					deleteButton.on("click", () => {
						newRow.remove();
						if ($(".table-body").find("tr").length === 0) {
							$(".table-container").css("display", "none");
							forms.append(delInput);
							forms.removeClass("was-validated");
						}
					});
					tdElement3.append(deleteButton);
					newRow.append(tdElement3);
					$(document).on('input',".use-list-rating",function(e) {
						const value = parseInt($(e.target).val(), 10) || 0;
						if (value > 100) {
							alert('100 이하로 입력해주세요!');
							$(e.target).val('');
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
					

					const tableBody = $(".table-body");
						const lastRow = tableBody.find("tr:last");
						if (lastRow.length > 0) {
							lastRow.after(newRow);
						} else {
							tableBody.append(newRow);
						}
					}
					const modalSubBtn = $(".modal-submit-btn");
					modalSubBtn.off("click").on("click", () => {
						$(".table-container").css("display", "block");
						$(".table-list-names").css("display","table-row");
						
						modal.hide();
						[$(".t-name-first"), $(".t-name-second"), $(".t-name-third"), $(".t-name-fourth")].forEach(elem => {
							elem.css("color", "black");
						});
						$(".delete-input").remove();
						tdElement2.eq(index).html(ratings.eq(index).val())
						ratings.css("display","none").val("");
					});	
				})
			});
			
		});

		$(".list-work").on("click", function(e) {
			const works = {
				"2D 그래픽": ["CAD", "Illustrator", "PhotoShop","기타"],
				"3D 그래픽": ["Cinema 4D", "Blender", "3DS MAX","기타"],
				코딩: ["Web Publicing", "Embedded", "VSC","기타"],
				영상편집: ["Premiere pro", "DaVinci Resolve", "PowerDirector","기타"],
				문서작업: ["Excel", "CAPS CCTV", "SAP ERP","기타"]
			};

			const HTMLs = $(e.target).html();
			$(".collector-name").html(HTMLs);

			if (works.hasOwnProperty(HTMLs)) {
				[$(".t-name-first"), $(".t-name-second"), $(".t-name-third"), $(".t-name-fourth")].forEach((elem, index) => {
				elem.html(works[HTMLs][index]);
				});
			}

			const ratings = $(".rating");
			[$(".t-name-first"), $(".t-name-second"), $(".t-name-third"), $(".t-name-fourth")].forEach((elem, index) => {
				elem.off("click").on("click", () => {
					if(elem.css("color") === "rgb(255, 0, 0)"){
						elem.css("color","black");
					}else {
						elem.css("color","red");
					}
					if(ratings.eq(index).css("display") === "none"){
						ratings.eq(index).css("display","block");
					}else if (ratings.eq(index).css("display") === "block"){
						ratings.eq(index).css("display","none");
					}
					
					const selectedKey = $(".collector-name").text();
					const selectValue = elem.text();
					const newRow = $("<tr></tr>").css("display","none").addClass("table-list-names");

					const thElement = $("<th></th>").attr("scope", "row").addClass("ps-3 align-middle");
					const input1 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).attr("value", selectedKey).css("border","none").css("text-align","center").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-genre");
					thElement.append(input1);
					newRow.append(thElement);

					const tdElement1 = $("<td></td>").addClass("t-submit ps-4 align-middle");
					const input2 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).attr("value", selectValue).css("border","none").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-name");
					const isDuplicate = $(".use-list-name").toArray().some(element => $(element).val() === selectValue);
					if (isDuplicate) {
 						 alert("중복된 요소입니다. 다른 값을 선택해주세요.");
						 elem.css("color","black");
					}else {
					tdElement1.append(input2);
					newRow.append(tdElement1);
					const tdElement2 = $("<td></td>").addClass("align-middle");
					const input3 = $("<input>").attr("type", "number").attr("required", true).attr("placeholder", "0~100").attr("max", "100").attr("min", "0").css("border", "none").css("font-weight", "bold").css("outline","none").addClass("use-list-rating");
					tdElement2.append(input3);
					newRow.append(tdElement2);
					const tdElement3 = $("<td></td>");
					const deleteButton = $("<button></button>").addClass("btn btn-danger").text("삭제");
					deleteButton.on("click", () => {
						newRow.remove();
						if ($(".table-body").find("tr").length === 0) {
							$(".table-container").css("display", "none");
							forms.append(delInput);
							forms.removeClass("was-validated");
						}
					});
					tdElement3.append(deleteButton);
					newRow.append(tdElement3);
					$(document).on('input',".use-list-rating",function(e) {
						const value = parseInt($(e.target).val(), 10) || 0;
						if (value > 100) {
							alert('100 이하로 입력해주세요!');
							$(e.target).val('');
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
					

					const tableBody = $(".table-body");
						const lastRow = tableBody.find("tr:last");
						if (lastRow.length > 0) {
							lastRow.after(newRow);
						} else {
							tableBody.append(newRow);
						}
					}
					const modalSubBtn = $(".modal-submit-btn");
					modalSubBtn.off("click").on("click", () => {
						$(".table-container").css("display", "block");
						$(".table-list-names").css("display","table-row");
						
						modal.hide();
						[$(".t-name-first"), $(".t-name-second"), $(".t-name-third"), $(".t-name-fourth")].forEach(elem => {
							elem.css("color", "black");
						});
						$(".delete-input").remove();
						tdElement2.eq(index).html(ratings.eq(index).val())
						ratings.css("display","none").val("");
					});	
				})
			});
		});
		
		
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
			const input1 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).attr("value", "서핑").css("border","none").css("text-align","center").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-surf");
			thElement.append(input1);
			newRow.append(thElement);

			const tdElement1 = $("<td></td>").addClass("t-submit ps-4 align-middle");
			const input2 = $("<input>").attr("type", "text").attr("readonly", true).attr("disabled", true).css("border","none").css("font-weight","bold").css("background-color", "inherit").addClass("use-list-name");
			tdElement1.append(input2);
			newRow.append(tdElement1);

			const tdElement2 = $("<td></td>").addClass("align-middle");
			const input3 = $("<input>").attr("type", "number").attr("required", true).attr("placeholder", "0~100").attr("max", "100").attr("min", "0").css("border", "none").css("font-weight", "bold").css("outline","none").addClass("use-list-rating");
			$(document).on('input',".use-list-rating",function(e) {
				const value = parseInt($(e.target).val(), 10) || 0;
				if (value > 100) {
					alert('100 이하로 입력해주세요!');
					$(e.target).val('');
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
		const labelTable = $("#label-table");
		const labels = labelTable.find("label");
		const noResultRow = $("<tr>");
		const noResultCell = $("<td>");
		const noResultText = document.createTextNode("일치하는 결과가 없습니다.");

		function searchLabel() {
			const searchInput = $("#search-input").val().toLowerCase();
			const matchedLabels = [];

			labels.each(function() {
				const label = $(this);
				const labelName = label.text().toLowerCase();

				if (labelName.includes(searchInput)) {
				matchedLabels.push(label);
				}
			});

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
			} else {
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
		$(".pre-button").on("click", () => {
			window.location.href = "http://localhost:8080/estimateCalculationOne.do";
		})
		
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
				 				<div class="list-group mb-3 w-75 text-center">
								  <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collecter">FPS</button>
								  <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collecter">AOS</button>
								  <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collecter">RPG</button>
								  <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collecter">RTS</button>
								  <button type="button" class="list-group-item list-group-item-action list-game" data-bs-toggle="modal" data-bs-target="#use-collecter">레이싱</button>
								</div>
				 			</div>
				 			<div class="col">
				 				<div class="list-group mb-1 w-75 text-center margin-center">
								  <button type="button" class="list-group-item list-group-item-action mb-3 bgc-disabled" disabled aria-current="true">작업</button>
							    </div>
				 				<div class="list-group mb-3 w-75 text-center margin-center">
								  <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collecter">2D 그래픽</button>
								  <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collecter">3D 그래픽</button>
								  <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collecter">코딩</button>
								  <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collecter">영상편집</button>
								  <button type="button" class="list-group-item list-group-item-action list-work" data-bs-toggle="modal" data-bs-target="#use-collecter">문서작업</button>
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
									<button type="button" class="form-control marin-center w-50 pre-button">이전 질문</button>
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
				 		<div class="modal fade" id="use-collecter" tabindex="-1" aria-labelledby="collecter" aria-hidden="true" data-bs-backdrop="static">
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
											<input type="text" class="form-control" id="search-input" placeholder="검색어를 입력하세요" oninput="searchLabel()">
										</form>
									  </tr>
									  <tr>
										<th scope="col">이름</th>
									  </tr>
									</thead>
									<tbody id="label-table">
									  <tr>
										<td>
											<input type="checkbox" class="btn-check" id="btn-check" autocomplete="off">
											<label class="t-name-first" for="btn-check"></label>
										</td>
									  </tr>
									  <tr>
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
									  </tr>
									</tbody>
								  </table>
								</div>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary modal-btn" data-bs-dismiss="modal">취소</button>
						        <button type="button" class="btn btn-primary modal-btn modal-submit-btn">저장</button>
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
