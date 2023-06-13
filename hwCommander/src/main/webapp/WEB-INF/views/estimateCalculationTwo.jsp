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
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>

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
			 		<form class="needs-validation" action="#" novalidate>
				 		<div class="row pb-2">
				 			<div class="col">
				 				<div class="list-group mb-1 w-75 text-center">
								  <button type="button" class="list-group-item list-group-item-action text center mb-3 bgc-disabled" disabled aria-current="true">게임</button>
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
								  <button type="button" class="list-group-item list-group-item-action text center mb-3 bgc-disabled" disabled aria-current="true">작업</button>
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
								  <button type="button" class="btn btn-outline-success list-group-item list-group-item-action text center mb-3 bgc-disabled" aria-current="true">서핑</button>
							    </div>
				 			</div>
				 		</div>
				 		<div class="row table-style p-1 mb-3" style="display: block;">
							<div class="container">
								<table class="table table-submit">
									<thead>
										<tr>
										<th scope="col">번호</th>
										<th scope="col" class="submit-name">목록</th>
										<!-- <th scope="col">비중</th> -->
										</tr>
									</thead>
									<tbody>
										<tr>
										<th scope="row" class="ps-3">1</th>
										<td class="t-submit-first"></td>
										<!-- <td></td> -->
										</tr>
										<tr>
										<th scope="row" class="ps-3">2</th>
										<td class="t-submit-second"></td>
										<!-- <td></td> -->
										</tr>
										<tr>
										<th scope="row" class="ps-3">3</th>
										<td class="t-submit-third"></td>
										<!-- <td></td> -->
										</tr>
									</tbody>
								</table>
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
				 		<div class="modal fade" id="use-collecter" tabindex="-1" aria-labelledby="use-collecter" aria-hidden="true">
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
						        <button type="button" class="btn btn-primary modal-btn">저장</button>
						      </div>
						    </div>
						  </div>
						</div>
			 		</form>
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
	<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
	<!-- <script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script> -->
	<!-- 06.13 부트스트랩 js cdn 추가 -->
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
		const text = "주 사용 용도는 어떤용도 입니까? (다중선택 가능)";
		let index = 0;
	
		function typeText() {
			if (index < text.length) {
				inputElement.value += text.charAt(index);
				index++;
				setTimeout(typeText, 50);
			}
		}
	
		typeText();
		
		// modal
		const collectorName = document.querySelector(".collector-name");
		const listGames = document.querySelectorAll(".list-game");
		const listWorks = document.querySelectorAll(".list-work");
		const modalBody = document.querySelector(".modal-body");
		const tNameFirst = document.querySelector(".t-name-first");
		const tNameSecond = document.querySelector(".t-name-second");
		const tNameThird = document.querySelector(".t-name-third");
		const tNameFourth = document.querySelector(".t-name-fourth")
		listGames.forEach((game) => {
			game.addEventListener("click",(e) => {
				collectorName.innerHTML = "";
				tNameFirst.innerHTML = "";
				tNameSecond.innerHTML = "";
				tNameThird.innerHTML = "";
				let HTMLs = e.target.innerHTML;
				collectorName.innerHTML = HTMLs;
				if(HTMLs === "FPS"){
					tNameFirst.innerHTML = "PlayerUnknown's Battlegrounds";
					tNameSecond.innerHTML = "Apex Legend";
					tNameThird.innerHTML = "Valorant";
				}else if (HTMLs === "AOS"){
					tNameFirst.innerHTML = "League of Legends";
					tNameSecond.innerHTML = "Dota 2";
					tNameThird.innerHTML = "Heros of the Storm";
				}else if (HTMLs === "RPG"){
					tNameFirst.innerHTML = "Lost Ark";
					tNameSecond.innerHTML = "Diablo IV";
					tNameThird.innerHTML = "Dungeon and Fighter";
				}else if (HTMLs === "RTS"){
					tNameFirst.innerHTML = "FIFA Online 4";
					tNameSecond.innerHTML = "Starcraft Remastered";
					tNameThird.innerHTML = "Warcraft III Reforged";
				}else if (HTMLs === "레이싱"){
					tNameFirst.innerHTML = "Forza Horizon 5";
					tNameSecond.innerHTML = "Assetto Corsa";
					tNameThird.innerHTML = "Grand Theft Auto V";
				}
			})
		})
		listWorks.forEach((work) => {
			work.addEventListener("click",(e) => {
				collectorName.innerHTML = "";
				tNameFirst.innerHTML = "";
				tNameSecond.innerHTML = "";
				tNameThird.innerHTML = "";
				let HTMLs = e.target.innerHTML;
				collectorName.innerHTML = HTMLs;

				if(HTMLs === "2D 그래픽"){
					tNameFirst.innerHTML = "CAD";
					tNameSecond.innerHTML = "Illustrator";
					tNameThird.innerHTML = "PhotoShop";
				}else if (HTMLs === "3D 그래픽"){
					tNameFirst.innerHTML = "Cinema 4D";
					tNameSecond.innerHTML = "Blender";
					tNameThird.innerHTML = "3DS MAX";
				}else if (HTMLs === "코딩"){
					tNameFirst.innerHTML = "Web Publicing";
					tNameSecond.innerHTML = "Embedded";
					tNameThird.innerHTML = "VSC";
				}else if (HTMLs === "영상편집"){
					tNameFirst.innerHTML = "Premiere pro";
					tNameSecond.innerHTML = "DaVinci Resolve";
					tNameThird.innerHTML = "PowerDirector";
				}else if (HTMLs === "문서작업"){
					tNameFirst.innerHTML = "Excel";
					tNameSecond.innerHTML = "CAPS CCTV";
					tNameThird.innerHTML = "SAP ERP";
				}
			})
		})

		
		tNameFirst.addEventListener("click",()=>{
			tNameFirst.style.color = "red";
		})
		tNameSecond.addEventListener("click",()=>{
			tNameSecond.style.color = "red";
		})
		tNameThird.addEventListener("click",()=>{
			tNameThird.style.color = "red";
		})
		tNameFourth.addEventListener("click",()=>{
			tNameFourth.style.color = "red";
		})
		const modalBtn = document.querySelectorAll(".modal-btn");
		
		modalBtn.forEach((btn)=>{
			btn.addEventListener("click", ()=>{
				tNameFirst.style.color = "black";
				tNameSecond.style.color = "black";
				tNameThird.style.color = "black";
				tNameFourth.style.color = "black";
			})
		})
		//modal search
		let labelTable = document.getElementById("label-table");
		let labels = labelTable.getElementsByTagName("label");
		let noResultRow = document.createElement("tr");
		let noResultCell = document.createElement("td");
		let noResultText = document.createTextNode("일치하는 결과가 없습니다.");

		function searchLabel() {
		let searchInput = document.getElementById("search-input").value.toLowerCase();
		let matchedLabels = [];

		for (let i = 0; i < labels.length; i++) {
			let label = labels[i];
			let labelName = label.innerHTML.toLowerCase();

			if (labelName.includes(searchInput)) {
			matchedLabels.push(label);
			}
		}

		if (matchedLabels.length > 0) {
			// 일치하는 결과가 있는 경우 정렬
			matchedLabels.sort(function (a, b) {
			let aIndex = a.innerHTML.toLowerCase().indexOf(searchInput);
			let bIndex = b.innerHTML.toLowerCase().indexOf(searchInput);
			
			if (aIndex === bIndex) {
				return a.innerHTML.toLowerCase().localeCompare(b.innerHTML.toLowerCase());
			}
			
			return aIndex - bIndex;
			});
			
			// 기존 행을 모두 숨김
			hideAllRows();

			// 일치하는 결과를 보여줌
			for (let j = 0; j < matchedLabels.length; j++) {
			let matchedLabel = matchedLabels[j];
			let row = matchedLabel.parentNode.parentNode;
			row.style.display = "table-row";
			}
		} else {
			// 일치하는 결과가 없는 경우
			hideAllRows();

			noResultCell.setAttribute("colspan", "2");
			noResultCell.appendChild(noResultText);
			noResultRow.appendChild(noResultCell);
			labelTable.appendChild(noResultRow);
		}
		}

		function hideAllRows() {
		for (let k = 0; k < labelTable.rows.length; k++) {
			let row = labelTable.rows[k];
			row.style.display = "none";
		}

		if (noResultRow.parentNode === labelTable) {
			labelTable.removeChild(noResultRow);
		}
		}

		document.getElementById("search-input").addEventListener("input", function () {
		searchLabel();
		});
	</script>
	
</body>
</html>
