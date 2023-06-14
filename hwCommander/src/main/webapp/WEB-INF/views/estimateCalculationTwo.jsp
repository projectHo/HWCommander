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
	let progress = 0;
	
	$(function () {
	  animateBackgroundColor();
	});
	
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
	
	$(document).ready(function() {
  	  const tooltipTriggerList = $('[data-bs-toggle="tooltip"]');
  	  const tooltipList = tooltipTriggerList.map(function() {
  	    return new bootstrap.Tooltip($(this)[0]);
  	  }).get();
  	  
  	  (() => {
  	    "use strict";
  	    const forms = $(".needs-validation");
  	    forms.each(function() {
  	      $(this).on("submit", function(event) {
  	        if (!this.checkValidity()) {
  	          event.preventDefault();
  	          event.stopPropagation();
  	        }
  	        $(this).addClass("was-validated");
  	      });
  	    });
  	  })();
  	  
  	  const calcOneSubmit = $(".calc-one-final");
  	  const calcOneText = $(".calc-one-final-text");
  	  calcOneSubmit.on("click", function() {
  	    calcOneText.css("display", "block");
  	  });
  	  
  	  const inputElement = $("#typingInput");
  	  const text = "본체의 가용 예산 한도는 얼마입니까? (최대 500만원)";
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
  	});
	
	$(document).ready(function() {
		  const collectorName = $(".collector-name");
		  const tNameFirst = $(".t-name-first");
		  const tNameSecond = $(".t-name-second");
		  const tNameThird = $(".t-name-third");

		  $(".list-game").on("click", function(e) {
		    const games = {
		      FPS: ["PlayerUnknown's Battlegrounds", "Apex Legend", "Valorant"],
		      AOS: ["League of Legends", "Dota 2", "Heros of the Storm"],
		      RPG: ["Lost Ark", "Diablo IV", "Dungeon and Fighter"],
		      RTS: ["FIFA Online 4", "Starcraft Remastered", "Warcraft III Reforged"],
		      레이싱: ["Forza Horizon 5", "Assetto Corsa", "Grand Theft Auto V"]
		    };

		    const HTMLs = $(e.target).html();
		    collectorName.html(HTMLs);

		    if (games.hasOwnProperty(HTMLs)) {
		      [tNameFirst, tNameSecond, tNameThird].forEach((elem, index) => {
		        elem.html(games[HTMLs][index]);
		      });
		    }
		  });

		  $(".list-work").on("click", function(e) {
		    const works = {
		      "2D 그래픽": ["CAD", "Illustrator", "PhotoShop"],
		      "3D 그래픽": ["Cinema 4D", "Blender", "3DS MAX"],
		      코딩: ["Web Publicing", "Embedded", "VSC"],
		      영상편집: ["Premiere pro", "DaVinci Resolve", "PowerDirector"],
		      문서작업: ["Excel", "CAPS CCTV", "SAP ERP"]
		    };

		    const HTMLs = $(e.target).html();
		    collectorName.html(HTMLs);

		    if (works.hasOwnProperty(HTMLs)) {
		      [tNameFirst, tNameSecond, tNameThird].forEach((elem, index) => {
		        elem.html(works[HTMLs][index]);
		      });
		    }
		  });

		  [tNameFirst, tNameSecond, tNameThird].forEach(elem => {
		    elem.on("click", function() {
		      $(this).css("color", "red");
		    });
		  });

		  $(".modal-btn").on("click", function() {
		    [tNameFirst, tNameSecond, tNameThird].forEach(elem => {
		      elem.css("color", "black");
		    });
		  });
		});

	$(document).ready(function() {
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

			const modalSubmitBtn = $(".modal-submit-btn");
			const modalElement = $("#use-collecter");
			const modal = new bootstrap.Modal(modalElement);
			const tableContainer = $(".table-container");
			const tableBody = $(".table-body");

			modalSubmitBtn.on("click", () => {
				tableContainer.css("display", "block");

				const newRow = $("<tr></tr>");

				const thElement = $("<th></th>").attr("scope", "row").addClass("ps-3");
				newRow.append(thElement);

				const tdElement1 = $("<td></td>").addClass("t-submit-first");
				newRow.append(tdElement1);

				const tdElement2 = $("<td></td>");
				const deleteButton = $("<button></button>").addClass("btn btn-danger").text("삭제");
				deleteButton.on("click", () => {
					newRow.remove();
				});
				tdElement2.append(deleteButton);
				newRow.append(tdElement2);

				tableBody.append(newRow);
				modal.hide();
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
								  <label class="btn btn-outline-secondary" for="work-surf" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="단독 선택 후 견적 보기 가능합니다!">서핑</label>
							    </div>
				 			</div>
				 		</div>
				 		<div class="row table-style p-1 mb-3 table-container" style="display: none;">
							<div class="container">
								<form class="needs-validation" action="#" novalidate>
									<table class="table table-submit">
										<thead>
											<tr>
											<th scope="col">장르</th>
											<th scope="col" class="submit-name">목록</th>
											<th scope="col"></th>
											</tr>
										</thead>
										<tbody class="table-body">
											<!-- <tr>
												<th scope="row" class="ps-3"></th>
												<td class="t-submit-first"></td>
												<td><button class="btn btn-danger delete-button">삭제</button></td>
											</tr> -->
										</tbody>
									</table>
								</form>
							</div>
						</div>
				 		<div class="row mb-4">
			 			 	<div class="col">
				 				<button type="button" class="form-control marin-center w-50">이전 질문</button>
				 			</div>
				 			<div class="col">
				 				<button type="button" class="form-control calc-one-final margin-center">견적 보기</button>
		                		<div class="invalid-feedback fs-5 calc-one-final-text text-center" style="display: none; font-weight: bold;">2페이지 까지는 필수 질문입니다!</div>
				 			</div>
				 			<div class="col d-flex justify-content-end">
				 				<button type="button" class="form-control w-50 margin-left-auto">다음 질문</button>
				 			</div>
				 		</div>
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
										<!-- <th scope="col">비중</th> -->
									  </tr>
									</thead>
									<tbody id="label-table">
									  <tr>
										<td>
											<input type="checkbox" class="btn-check" id="btn-check" autocomplete="off">
											<label class="t-name-first" for="btn-check"></label>
										</td>
										<!-- <td class="rating"></td> -->
									  </tr>
									  <tr>
										<td>
											<input type="checkbox" class="btn-check" id="btn-check" autocomplete="off">
											<label class="t-name-second" for="btn-check"></label>
										</td>
										<!-- <td class="rating"></td> -->
									  </tr>
									  <tr>
										<td>
											<input type="checkbox" class="btn-check" id="btn-check" autocomplete="off">
											<label class="t-name-third" for="btn-check"></label>
										</td>
										<!-- <td class="rating"></td> -->
									  </tr>
									  <tr>
										<td>
											<input type="checkbox" class="btn-check" id="btn-check" autocomplete="off">
											<label class="t-name-fourth" for="btn-check">기타</label>
										</td>
										<!-- <td class="rating"></td> -->
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
