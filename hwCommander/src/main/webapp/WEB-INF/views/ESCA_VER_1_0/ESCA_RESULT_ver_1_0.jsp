<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 견적산출 결과</title>
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

<!-- 08.23 캡쳐 스크립트 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>

<script>
	$(function() {
		if (productMaster == ""){
			$("#resultErrorModal").modal("show");
			return false;
		}
		const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		}).get();
		// 부품 이름 입력 & 총 가격 계산
		enterPartsText();
		insertRams();
		boxHeadInput();
	})
	let productMaster = "${productMaster}";
	let mbInfo = "${productMbDetailInfo}";
	let productDet = "${productDetail}";
	let partsRam = "${partsRam}";
	let partsRam2 = "${productRamDetailInfo}";
	let loginUser = "${loginUser}";
	
	// 마스터 리스트화
	const productMasterDetail = productMaster.substring(1, productMaster.length - 1);
	const productMasterSplit = productMasterDetail.split('PartsproductMasterHistoryVO(');
	
	const productMasterResult = {};
	let productMasterIdVal = "";
	let productMasterIndex = 0;
	productMasterSplit.forEach(item => {
	const keyValuePairs = item.split(', ');
	const detail = {};
	keyValuePairs.forEach(pair => {
		const [key, value] = pair.split('=');
		detail[key] = value;
	});
	
	if (!productMasterResult[productMasterIndex]) {
		productMasterResult[productMasterIndex] = [];
	}
	productMasterResult[productMasterIndex].push(detail);	
	productMasterIndex++;
	});
		
		
	// 추천된 마더보드 리스트화
	const mbDetail = mbInfo.substring(1, mbInfo.length - 1);
	const mbSplit = mbDetail.split('PartsMbHistoryVO(');
	
	const mbResult = {};
	let mbIdVal = "";
	let mbIndex = 0;
	mbSplit.forEach(item => {
	const keyValuePairs = item.split(', ');
	const detail = {};
	keyValuePairs.forEach(pair => {
		const [key, value] = pair.split('=');
		detail[key] = value;
	});
	
	if (!mbResult[mbIndex]) {
		mbResult[mbIndex] = [];
	}
	mbResult[mbIndex].push(detail);	
	mbIndex++;
	});

	// 추천된 부품 디테일 리스트화
	const productDetail = productDet.substring(1, productDet.length - 1);
	const productSplit = productDetail.split('ProductDetailVO(');
	
	const productResult = {};
	let productIdVal = "";
	let productIndex = 0;
	productSplit.forEach(item => {
	const keyValuePairs = item.split(', ');
	const detail = {};
	keyValuePairs.forEach(pair => {
		const [key, value] = pair.split('=');
		detail[key] = value;
	});
	
	if (!productResult[productIndex]) {
		productResult[productIndex] = [];
	}
	productResult[productIndex].push(detail);	
	productIndex++;
	});

	// 전체 램 리스트화
	const ramDetail = partsRam.substring(1, partsRam.length - 1);
	const ramSplit = ramDetail.split('PartsRamVO(');

	const ramResult = {};
	var ramIdVal = "";
	let ramIndex = 0;
	ramSplit.forEach(item => {
	const keyValuePairs = item.split(', ');
	const detail = {};
	keyValuePairs.forEach(pair => {
		const [key, value] = pair.split('=');
		detail[key] = value;
	});
	if (!ramResult[ramIndex]) {
		ramResult[ramIndex] = [];
	}
	ramResult[ramIndex].push(detail);
	ramIndex++;
	});

	function enterPartsText () {
		$(".gpu-text").html(productResult[1][0].partsName);
		$(".cpu-text").html(productResult[2][0].partsName);
		$(".mb-text").html(productResult[3][0].partsName);
		$(".cooler-text").html(productResult[4][0].partsName);
		$(".case-text").html(productResult[5][0].partsName);
		$(".psu-text").html(productResult[6][0].partsName);
		$(".ram-text").html(productResult[7][0].partsName);
		$(".ssd-text").html(productResult[8][0].partsName);
		$(".price-text").html("${productMaster.productPriceStr}");
	}
	
	function clickReturnBtn () {
		location.href = "/ESCA/ESCASelect.do";
		sessionStorage.clear();
	}
	function clickOrderBtn() {
		// 09.06 오류 상태 추가 및 램 변경시 업데이트 로직 추가 필요
		if(sessionStorage.getItem("pay") == "y"){
			location.href = "/order/sheet.do?accessRoute=direct&productIds="+"${productMaster.id}";
		}else {
			alert("과거 견적 기준으로는 구매하실 수 없습니다!");
		}
	}

	function clickSaveBtn(){
		$("#modal-description").modal("show");
	}

	let differencePrices = [];
	let ramRufIndex = 1;
	let basedRam = productResult[6][0].partsPrice;
	for (let i = 1; i<Object.keys(ramResult).length; i++){
		if(ramResult[i][0].partsPrice !== "0" && ramResult[i][0].partsPrice !== "9999999"){
			let defferenceRam = ramResult[i][0].partsPrice;
			let calcPrices = Number(defferenceRam) - Number(basedRam);
			differencePrices.push(calcPrices);
		}
	}
	function insertRams(){
		for(let i = 1; i<Object.keys(ramResult).length; i++){
			if(ramResult[i][0].partsPrice !== "0" && ramResult[i][0].partsPrice !== "9999999" && mbResult[0][0].memSocCd === ramResult[i][0].memSocCd){
				let li = $("<li></li>");
				let button = $("<button></button>").addClass("dropdown-item").attr("cd",i).attr("nb",ramRufIndex).attr("type","button").attr("onclick","javascript:clickChangeRam(this)").html(ramResult[i][0].partsName + "(" + differencePrices[ramRufIndex-1] + ")");
				li.append(button);
				$(".dropdown-menu.ram").append(li);
				ramRufIndex++;
			}
		}
	}

	function clickChangeRam(e){
		if($(e).attr("cd") === "0"){
			enterPartsText();
		}else {
			const ramCd = $(e).attr("cd");
			const ramI = $(e).attr("nb");
			$(".ram-text").html(ramResult[ramCd][0].partsName);
			$(".price-text").html(((Number("${productMaster.productPrice}") + differencePrices[ramI-1]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원"));
		}
	}
	// 캡쳐 기능
	function clickCaptureBtn(){
		html2canvas(document.querySelector("#capture-container")).then(canvas => {
			$(".change-ram-btn").css("display","none");
			saveAs(canvas.toDataURL('image/png'),"capture-test.png");
			$(".change-ram-btn").css("display","inline-block");
		});
	};
	function saveAs(uri, filename) { 
		var link = document.createElement('a'); 
		if (typeof link.download === 'string') { 
			link.href = uri; 
			link.download = filename; 
			document.body.appendChild(link); 
			link.click(); 
			document.body.removeChild(link); 
		} else { 
			window.open(uri); 
		} 
	}
	function modalButtons(el){
		if($(el).hasClass("btn-secondary")){
			location.href = "/";
			sessionStorage.clear();
		}else {
			// for(let i = 0; i<=19 ; i++){
			// 	sessionStorage.setItem("data-" + i, "");
			// }
			sessionStorage.clear();
			location.href = "/ESCA/ESCASelect.do";
		}
	}
	
	function boxHeadInput(){
		$("#id-input").val("ID : " + "${loginUser.id}");

		if(sessionStorage.getItem("targetData") == ""){
			const currentDate = new Date();
			const year = currentDate.getFullYear();
			const month = String(currentDate.getMonth() + 1).padStart(2, "0");
			const day = String(currentDate.getDate()).padStart(2, "0");
			const hours = currentDate.getHours();
			const minutes = currentDate.getMinutes();
			const seconds = currentDate.getSeconds();
			const formattedDate = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
			$("#date-input").val("Date : " + formattedDate);
		}else {
			$("#date-input").val("Date : " + sessionStorage.getItem("targetData"));
		}

		const urlString = location.href;
		const matchedId = urlString.match(/userId%2C([^%]+)/);
		const recommenderName = matchedId[1];
		if("${loginUser.id}" != recommenderName){
			$("#recommender-input").parent().css("display","block");
			$("#recommender-input").val("추천인 ID : "+ recommenderName).css("display","block");
		}
	}
	function descriptionInput(el){
		if($(el).val().length > 20){
			alert("20자 이내로 입력해주세요!");
			$(el).val("");
		}
	}
	function goSaveBtn(){
		if("${userEscasStorageVOList.size()}" == 50){
			if(confirm("저장된 견적이 50개 이상입니다. 가장 오래된 견적을 삭제 후 저장하시겠습니까?")){
				$.ajax({
				type: "post",
				url: "/user/escaStorageMaxRegistLogic.do",
				data: {
					userId : "${loginUser.id}",
					escasStorageDescription: $("#modal-description").find("input").val(),
					escasUrlParameter: "${escasUrlParameter}",
					escasLogicVersion: "${escasLogicVersion}"
				},
				dataType: "json",
				success: function() {
					alert("성공적으로 저장되었습니다.");
					location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
				},
				error: function() {
					alert("저장에 실패했습니다.");
				}
			})	
			}else {
				return false;
			}
		}else {
			$.ajax({
				type: "post",
				url: "/user/escaStorageRegistLogic.do",
				data: {
					userId : "${loginUser.id}",
					escasStorageDescription: $("#modal-description").find("input").val(),
					escasUrlParameter: "${escasUrlParameter}",
					escasLogicVersion: "${escasLogicVersion}"
				},
				dataType: "json",
				success: function() {
					alert("성공적으로 저장되었습니다.");
					location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
				},
				error: function() {
					alert("저장에 실패했습니다.");
				}
			})
		}
	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="modal fade" id="resultErrorModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
			<div class="modal-header">
			  <h1 class="modal-title fs-5">견적산출 오류!</h1>
			</div>
			<div class="modal-body">
			  견적 산출 중 오류가 발생했습니다...!!<br>조건을 바꿔서 다시하시거나 이벤트몰을 이용해주세요!
			</div>
			<div class="modal-footer">
			  <button type="button" class="btn btn-secondary" onclick="javascript:modalButtons(this)">홈페이지</button>
			  <button type="button" class="btn btn-primary" onclick="javascript:modalButtons(this)">다시하기</button>
			</div>
		  </div>
		</div>
	  </div>
	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<!-- 작업영역 -->
			<div id="capturedImage"></div>
			<div class="estimateCalc_background p-5" id="capture-container" style="width: 70% !important">
				<div class="row">
					<div class="row w-100">
						<div class="col-md-2">
							<div class="input-group mb-3 w-100">
								<input type="text" class="form-control pb-0 ps-3" id="id-input"aria-label="Text input with checkbox" value="ID : error" style="background-color: #fff;" disabled>
							</div>
						</div>
						<div class="col"></div>
						<div class="col-md-2">
							<div class="input-group w-100" style="display: none;">
								<input type="text" class="form-control pb-0 ps-3 w-100" id="recommender-input" value="추천인 : 오류" style="background-color: #fff;" disabled>
							</div>
						</div>
						<div class="col-md-3">
							<div class="input-group w-100">
								<input type="text" class="form-control pb-0 ps-3 text-center" id="date-input"aria-label="Text input with checkbox" value="Date : 0000-00-00" style="background-color: #fff;" disabled>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="card mb-3">
							<div class="row g-0">
							  <div class="col-md-4 pt-3 ps-2">
								<img src="${productMaster.productImage}" class="img-fluid rounded-start" alt="...">
								<p class="p-2">제품 견본 이미지는 케이스의 외관을 보여드리기 위함입니다. 내장제품의 형태가 상이하니 케이스의 형태만 확인하여 선택 부탁드립니다.</p>
							  </div>
							  <div class="col-md-8">
								<div class="card-body">
									<div class="row">
										<div class="col">
											<h4 class="card-title position-relative result-index">제품 상세 정보</h4>
										</div>
										<div class="col d-flex gap-2 justify-content-end">
											<div class="dropdown">
												<button class="btn btn-secondary dropdown-toggle change-ram-btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
													Ram 변경하기
												</button>
												<ul class="dropdown-menu ram">
													<li><button class="dropdown-item" cd="0" type="button" onclick="clickChangeRam(this)">추천 램으로 돌아가기</button></li>
												</ul>
											</div>
											<div class="dropdown">
												<button class="btn btn-secondary dropdown-toggle change-case-btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
													케이스 변경하기
												</button>
												<ul class="dropdown-menu">
													<li></li>
												</ul>
											</div>
										</div>
									</div>
									<div class="container mb-3 position-relative result-index">
										<p class="card-text mb-0 fw-bold pb-1">가격 : <span class="fw-normal price-text">오류</span></p>
										<p class="card-text mb-0 fw-bold pb-1">CPU : <span class="fw-normal cpu-text">오류</span></p>
										<p class="card-text mb-0 fw-bold pb-1">Cooler : <span class="fw-normal cooler-text">오류</span></p>
										<p class="card-text mb-0 fw-bold pb-1">MB : <span class="fw-normal mb-text">오류</span></p>
										<p class="card-text mb-0 fw-bold pb-1">GPU : <span class="fw-normal gpu-text">오류</span></p>
										<p class="card-text mb-0 fw-bold pb-1">SSD : <span class="fw-normal ssd-text">오류</span></p>
										<p class="card-text mb-0 fw-bold pb-1">CASE : <span class="fw-normal case-text">오류</span></p>
										<p class="card-text mb-0 fw-bold">PSU : <span class="fw-normal psu-text">오류</span></p>
										<p class="card-text mb-0 fw-bold">RAM : <span class="fw-normal ram-text">오류</span></p>
									</div>
									<!-- <h4 class="card-title">제품 설명</h4>
									<div class="container mb-3">
										<p class="card-text fw-bold">제품설명블라블라</p>
									</div> -->
									<h4 class="card-title position-relative result-index">배송 정보</h4>
									<div class="container mb-3 position-relative result-index">
										<p class="card-text mb-0 fw-bold pb-1">배송기간 : <span class="fw-normal delivery-period">영업일 기준 1~2일</span></p>
										<p class="card-text mb-0 fw-bold pb-1">택배사 : <span class="fw-normal delivery-period">우체국택배</span></p>
										<p class="card-text mb-0 fw-bold"><small class="text-muted">도서산간 지역의 경우 배송이 제한되거나 추가요금이 발생할 수 있습니다.</small></p>
										<p class="card-text"><small class="text-muted">AS 기준은 각 부품의 유통사 규정에 따르며 해당 쇼핑몰에서 1년간 무상 AS를 지원해드립니다.</small></p>
									</div>
								</div>
							  </div>
							</div>
						  </div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<button type="button" class="form-control" onclick="javascript:clickReturnBtn()">다시하기</button>
					</div>
					<div class="col-3"></div>
					<div class="col">
						<button type="button" class="form-control" onclick="javascript:clickOrderBtn()">주문하기</button>
					</div>
					<div class="col">
						<button type="button" class="form-control" onclick="javascript:clickCaptureBtn()">캡쳐하기</button>
					</div>
					<div class="col">
						<button type="button" class="form-control" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="질문에 대한 답변들을 저장합니다. 추후 견적 산출시 현재 견적과 다를 수 있으니 참고 부탁드립니다!!" onclick="javascript:clickSaveBtn()">질문저장</button>
					</div>
				</div>
	 		</div>
			<div class="modal fade" data-bs-backdrop="static" id="modal-description" tabindex="-1" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5">질문 저장하기</h1>
						</div>
						<div class="modal-body">
							<h3 class="text-center">견적의 이름을 입력해주세요!</h3>
							<input type="text" class="form-control" placeholder="최대 20자" oninput="javascript:descriptionInput(this)">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							<button type="button" class="btn btn-primary" onclick="javascript:goSaveBtn()">저장</button>
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
	<input type="hidden" name="${userEscasStorageVOList.size()}" class="storage-size">
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
