<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 반품몰 상세</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap & jquery -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<link rel="stylesheet" href="/resources/css/ver_02/ESCA_RESULT.css">

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<!-- 캡쳐 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>

<script>
    $(function() {
		if ("${productMaster}" == ""){
			$("#resultErrorModal").modal("show");
			return false;
		}
		boxHeadInput();
		answersMatches();
    });
    function loginCheck() {
		var check = false;
		if("${loginUser}" == "") {
			alert("로그인 후 이용해주세요.");
			location.href = "/user/login.do";
		}else {
			check = true;
		}
		return check;
	}

	function answersMatches(){
		const urlString = location.href;
		var matches = urlString.match(/answer\d+%3C(.*?)%3E/g);
		let values = [];

		for(let i = 0; i < 20; i++){
			if(i != 2 && i != 7 && i != 1){
				let a = matches[i].match(/answer\d{1,2}/);
				let b = matches[i].match(/%3C(.*?)%3E/);
				b = b[1].split("%2C");
				if(b[0] != "null" && b[1] != "null"){
					b.unshift(a[0]);
					values.push(b);
				}
			}else if (i == 1 || i == 2){
				let a = matches[i].match(/answer\d{1,2}/);
				let b = matches[i].match(/%3C(.*?)%3E/)[1];
				let c = b.split("%3A");
				let d = [a[0]];
				c.forEach(function(part) {
					d = d.concat(part.split("%2C"));
				})
				values.push(d);
			}
		}
		for(let i = values.length-1 ; i >= 0 ; i--){
			if(values[i][0] == "answer0"){
				if(values[i][2] == "0"){
					$(".answer1-p").after('<small><p class="mb-0 pb-1">┖ OS : 프리도스(+0원)</p></small>');
				}else if(values[i][2] == "1"){
					$(".answer1-p").after('<small><p class="mb-0 pb-1">┖ OS : COEM(+150,000원)</p></small>');
				}else if(values[i][2] == "2"){
					$(".answer1-p").after('<small><p class="mb-0 pb-1">┖ OS : Fpp(+180,000원)</p></small>');
				}
			}
			if(values[i][0] == "answer1"){
				$(".answer2-p").after('<small><p class="mb-0 pb-1">┖ 예산 : ' + values[i][2].replace(/\B(?=(\d{3})+(?!\d))/g, ',') + "원</p></small>");
			}
			if(values[i][0] == "answer2"){
				let answer3a;
				for(let j = values[i].length-2; j >= 1; j-=2){
					if(values[i][j] == "PR000001"){
						answer3a = "Apex Legend";
					}
					if(values[i][j] == "PR000002"){
						answer3a = "Valorant";
					}
					if(values[i][j] == "PR000029"){
						answer3a = "PUBG";
					}
					if(values[i][j] == "PR000032"){
						answer3a = "[FPS 기타]";
					}
					if(values[i][j] == "PR000003"){
						answer3a = "League of Legends";
					}
					if(values[i][j] == "PR000004"){
						answer3a = "Dota 2";
					}
					if(values[i][j] == "PR000005"){
						answer3a = "Heros of the Storm";
					}
					if(values[i][j] == "PR000033"){
						answer3a = "[AOS 기타]";
					}
					if(values[i][j] == "PR000006"){
						answer3a = "Lost Ark";
					}
					if(values[i][j] == "PR000007"){
						answer3a = "Diablo IV";
					}
					if(values[i][j] == "PR000008"){
						answer3a = "Dungeon and Fighter";
					}
					if(values[i][j] == "PR000009"){
						answer3a = "FIFA Online 4";
					}
					if(values[i][j] == "PR000010"){
						answer3a = "Starcraft Remastered";
					}
					if(values[i][j] == "PR000011"){
						answer3a = "Warcraft III Reforged";
					}
					if(values[i][j] == "PR000012"){
						answer3a = "Forza Horizon 5";
					}
					if(values[i][j] == "PR000013"){
						answer3a = "Assetto Corsa";
					}
					if(values[i][j] == "PR000014"){
						answer3a = "Grand Theft Auto V";
					}
					if(values[i][j] == "PR000015"){
						answer3a = "Illustrator";
					}
					if(values[i][j] == "PR000016"){
						answer3a = "PhotoShop";
					}
					if(values[i][j] == "PR000030"){
						answer3a = "CAD";
					}
					if(values[i][j] == "PR000017"){
						answer3a = "Cinema 4D";
					}
					if(values[i][j] == "PR000018"){
						answer3a = "Blender";
					}
					if(values[i][j] == "PR000019"){
						answer3a = "3DS MAX";
					}
					if(values[i][j] == "PR000020"){
						answer3a = "Web Publicing";
					}
					if(values[i][j] == "PR000021"){
						answer3a = "Embedded";
					}
					if(values[i][j] == "PR000022"){
						answer3a = "VSC";
					}
					if(values[i][j] == "PR000023"){
						answer3a = "Premiere Pro";
					}
					if(values[i][j] == "PR000024"){
						answer3a = "DaVinci Resolve";
					}
					if(values[i][j] == "PR000025"){
						answer3a = "PowerDirector";
					}
					if(values[i][j] == "PR000031"){
						answer3a = "After Effect";
					}
					if(values[i][j] == "PR000026"){
						answer3a = "Excel";
					}
					if(values[i][j] == "PR000027"){
						answer3a = "CAPS CCTV";
					}
					if(values[i][j] == "PR000028"){
						answer3a = "SAP ERP";
					}
					$(".answer3-p").after('<small><p class="mb-0 pb-1">┖ 이름 :  ' + answer3a + " / 비중 : " + Math.round(values[i][j+1]) + "%</p></small>");
				}
			}
			if(values[i][0] == "answer3" && values[i][2] != "null"){
				$(".answer4-p").after('<small><p class="mb-0 pb-1">┖ 발열 : ' + values[i][2] + "점 / 소재 : " + values[i][4] + "점 / AS : " + values[i][6] + "점 / 소음 : " + values[i][8] + "점 / 안정성 : " + values[i][10] + "점 / QC : " + values[i][12] + "점</p></small>");
			}
			if(values[i][0] == "answer4"){
				let answer4;
				if(values[i][2] == "0"){
					answer4 = "필요";
				}else if(values[i][2] == "1"){
					answer4 = "불필요";
				}
				$(".answer5-p").after('<small><p class="mb-0 pb-1">┖ 무선 : ' + answer4 + '</p></small>');
			}
			if(values[i][0] == "answer5"){
				let answer5;
				if(values[i][2] == "0"){
					answer5 = "Intel";
				}else if(values[i][2] == "1"){
					answer5 = "Amd";
				}else {
					answer5 = "상관없음";
				}
				$(".answer6-p").after('<small><p class="mb-0 pb-1">┖ CPU : ' + answer5 + '</p></small>');
			}
			if(values[i][0] == "answer6"){
				let answer6;
				if(values[i][2] == "0"){
					answer6 = "필요";
				}else if(values[i][2] == "1"){
					answer6 = "불필요";
				}else {
					answer6 = "상관없음";
				}
				$(".answer7-p").after('<small><p class="mb-0 pb-1">┖ 내장그래픽 : ' + answer6 + '</p></small>');
			}
			if(values[i][0] == "answer7"){
				let answer7;
				if(values[i][2] == "0"){
					answer7 = "필요";
				}else if(values[i][2] == "1"){
					answer7 = "불필요";
				}else {
					answer7 = "상관없음";
				}
				$(".answer8-p").after('<small><p class="mb-0 pb-1">┖ 수냉쿨러 : ' + answer7 + '</p></small>');
			}
			if(values[i][0] == "answer8"){
				let answer8;
				if(values[i][2] == "0"){
					answer8 = "DDR4";
				}else if(values[i][2] == "1"){
					answer8 = "DDR5";
				}else {
					answer8 = "상관없음";
				}
				$(".answer9-p").after('<small><p class="mb-0 pb-1">┖ 램버전 : ' + answer8 + '</p></small>');
			}
			if(values[i][0] == "answer10"){
				let answer10;
				if(values[i][2] == "0"){
					answer10 = "벌크";
				}else if(values[i][2] == "1"){
					answer10 = "멀티팩";
				}else if(values[i][2] == "2") {
					answer10 = "둘다 좋음";
				}else {
					answer10 = "둘다 싫음";
				}
				$(".answer11-p").after('<small><p class="mb-0 pb-1">┖ 벌크&멀티팩 : ' + answer10 + '</p></small>');
			}
			if(values[i][0] == "answer11"){
				let answer11;
				if(values[i][2] == "0"){
					answer11 = "예산에 맞게";
				}else if(values[i][2] == "1"){
					answer11 = "256GB";
				}else if(values[i][2] == "2") {
					answer11 = "512GB";
				}else if(values[i][2] == "3"){
					answer11 = "1024GB";
				}else {
					answer11 = "2048GB";
				}
				$(".answer12-p").after('<small><p class="mb-0 pb-1">┖ SSD : ' + answer11 + '</p></small>');
			}
		}
	}

	function boxQtyCheckBox(){
		if($("#boxCheck").prop("checked") == true){
			$("#itemBoxQty").attr("value",1);
			boxQtys = 1;
		}else if($("#boxCheck").prop("checked") == false){
			$("#itemBoxQty").attr("value",0);
			boxQtys = 0;
		}
	}

	function goOrderSheet(){
		if(loginCheck()) {
			location.href = "/order/sheet.do?accessRoute=banpum&productIds=" + $("#itemId").val() + "&orderQtys=" + $("#itemQty").val() + "&boxQtys=" + $("#itemBoxQty").val();
		}
	}
	function clickReturnBtn() {
		if(loginCheck()){
			location.href = "/ESCA/ESCASelect.do";
		}
		sessionStorage.clear();
	}
	let orderQtys = 0;
	let boxQtys = 0;
	function clickOrderBtn() {
		if(sessionStorage.getItem("pay") == "y"){
			if(orderQtys == 0){
				alert("주문 수량을 확인해주세요");

			}else if(loginCheck()){
				location.href = "/order/sheet.do?accessRoute=direct&productIds="+"${productMaster.id}"+"&orderQtys="+orderQtys+"&boxQtys="+boxQtys;
			}
		}else {
			alert("과거 견적 기준으로는 구매하실 수 없습니다!");
		}
	}
	function clickSinglOrderBtn(el){
		if(sessionStorage.getItem("pay") == "y"){
			if(loginCheck()){
				location.href = "/order/sheet.do?accessRoute=direct&productIds="+"${productMaster.id}"+"&orderQtys=1"+"&boxQtys="+ boxQtys;
			}
		}else {
			alert("과거 견적 기준으로는 구매하실 수 없습니다!");
		}
	}
	const numberCheck = /^[0-9]+$/;
	function itemsOrderControl(el){
		if($(".order-item-qty").val().length>=1 && !numberCheck.test($(".order-item-qty").val())){
			alert("올바르게 입력해주세요");
			$(".order-item-qty").val("");
			return false;
		}
		if(Number($(".order-item-qty").val()) >= Number("${productMaster.productQty}")){
			$(".order-item-qty").val("${productMaster.productQty}");
		}
		if($(el).attr("control-cd") == "0"){
			if($(".order-item-qty").val() == "0"){
				$(".order-item-qty").val("0");
			}else {
				$(".order-item-qty").val(Number($(".order-item-qty").val())-1);
			}
		}else if($(el).attr("control-cd") == "1"){
			if($(".order-item-qty").val() == "${productMaster.productQty}"){
				$(".order-item-qty").val("${productMaster.productQty}");
			}else {
				$(".order-item-qty").val(Number($(".order-item-qty").val())+1);
			}
		}
		orderQtys = $(".order-item-qty").val();
	}
	function boxsOrderControl(el){
		if($(".order-box-qty").val().length>=1 && !numberCheck.test($(".order-box-qty").val())){
			alert("올바르게 입력해주세요");
			$(".order-box-qty").val("");
			return false;
		}
		if(Number($(".order-box-qty").val()) >= Number("${productMaster.productQty}")){
			$(".order-box-qty").val("${productMaster.productQty}");
		}
		if($(el).attr("control-cd") == "0"){
			if($(".order-box-qty").val() == "0"){
				$(".order-box-qty").val("0");
			}else {
				$(".order-box-qty").val(Number($(".order-box-qty").val())-1);
			}
		}else if($(el).attr("control-cd") == "1"){
			if($(".order-box-qty").val() == $(".order-item-qty").val()){
				$(".order-box-qty").val($(".order-box-qty").val());
			}else if($(".order-box-qty").val() == "${productMaster.productQty}"){
				$(".order-box-qty").val("${productMaster.productQty}");
			}else {
				$(".order-box-qty").val(Number($(".order-box-qty").val())+1);
			}
		}
		boxQtys = $(".order-box-qty").val();
	}
	function clickCaptureBtn(){
		html2canvas(document.querySelector("#capture-container")).then(canvas => {
			saveAs(canvas.toDataURL('image/png'),"HWC-Capture.png");
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
					if(loginCheck()){
						location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
					}
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
					if(loginCheck()){
						location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
					}
				},
				error: function() {
					alert("저장에 실패했습니다.");
				}
			})
		}
	}
	function boxHeadInput(){
		$("#id-input").val("ID : " + "${loginUser.id}");
		const currentDate = new Date();
		const year = currentDate.getFullYear();
		const month = String(currentDate.getMonth() + 1).padStart(2, "0");
		const day = String(currentDate.getDate()).padStart(2, "0");
		const hours = currentDate.getHours();
		const minutes = currentDate.getMinutes();
		const seconds = currentDate.getSeconds();
		const formattedDate = year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;

		if(sessionStorage.getItem("targetData") == ""){
			$("#date-input").val("Date : " + formattedDate);
		}else if(sessionStorage.getItem("pay") == "y"){
			$("#date-input").val("Date : " + formattedDate);
		}else {
			$("#date-input").val("Date : " + sessionStorage.getItem("targetData"));
		}

		const urlString = location.href;
		const matchedId = urlString.match(/userId%2C([^%]+)/);
		if(matchedId == null){
			const matchedId = urlString.match(/userId%2C([^%]+)/);
		}else {
			const recommenderName = matchedId[1];
			if("${loginUser.id}" != recommenderName){
				$("#recommender-input").parent().css("display","block");
				$("#recommender-input").val("추천인 ID : "+ recommenderName).css("display","block");
			}
		}
	}
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="w-100" style="background-color: #0F0F14;">
		<div class="container px-5 py-5">
			<div class="d-flex flex-column gap-5">
				<div class="d-flex justify-content-center align-items-center">
					<h2 class="fw-bold text-light">견적산출 결과</h2>
				</div>
				<div class="d-flex gap-5" id="capture-container" style="color: #FFF;">
					<div class="w-50">
						<div class="w-100 h-100 rounded d-flex flex-column gap-3">
							<img src="${productMaster.productImage}" class="img-fluid rounded w-100 flex-1 border-1 border border-secondary" alt="...">
							<div class="d-flex gap-3">
								<div class="input-group flex-1">
									<input type="text" class="form-control text-light px-3 py-2" id="id-input"aria-label="Text input with checkbox" value="ID : error" style="background-color: transparent;" disabled>
								</div>
								<div class="input-group flex-1 result-inputs" style="display: none;">
									<input type="text" class="form-control text-light px-3 py-2" id="recommender-input" value="추천인 : 오류" style="background-color: transparent;" disabled>
								</div>
							</div>
							<div class="input-group w-100 result-inputs">
								<input type="text" class="form-control text-light px-3 py-2" id="date-input"aria-label="Text input with checkbox" value="Date : 0000-00-00" style="background-color: transparent;" disabled>
							</div>
						</div>
					</div>
					<div class="w-50 d-flex flex-column text-start text-light gap-2">
						<h3 class="fw-bold">${productMaster.productName}</h3>
						<h2 class="fw-bold answer2-p">${productMaster.productPriceStr}</h2>
						<h6>택배배송* 영업일 기준 약 2일 소요 | 배송비 무료 [우체국 택배]</h6>
						<h5 class="mt-2 fw-semibold">상세정보</h5>
						<div class="d-flex flex-column gap-1">
							<c:forEach var="item" items="${productDetail}">
								<c:if test="${item.partsTypeCdNm == 'CPU'}">
									<h6 class="m-0 answer6-p">${item.partsTypeCdNm} : <span>${item.partsName}</span></h6>	
								</c:if>
								<c:if test="${item.partsTypeCdNm == 'Cooler'}">
									<h6 class="m-0 answer8-p">${item.partsTypeCdNm} : <span>${item.partsName}</span></h6>	
								</c:if>
								<c:if test="${item.partsTypeCdNm == 'MB'}">
									<h6 class="m-0 answer5-p">${item.partsTypeCdNm} : <span>${item.partsName}</span></h6>	
								</c:if>
								<c:if test="${item.partsTypeCdNm == 'RAM'}">
									<h6 class="m-0 answer9-p">${item.partsTypeCdNm} : <span>${item.partsName}</span></h6>	
								</c:if>
								<c:if test="${item.partsTypeCdNm != 'CPU' && item.partsTypeCdNm != 'Cooler' && item.partsTypeCdNm != 'MB' && item.partsTypeCdNm != 'RAM'}">
									<h6 class="m-0">${item.partsTypeCdNm} : <span>${item.partsName}</span></h6>
								</c:if>
							</c:forEach>
							<h6 class="m-0 answer1-p">OS : <span>${productMaster.windowsName}</span></h6>
							<h6 class="m-0 answer3-p">사용 용도</h6>
							<h6 class="m-0 answer4-p">기타</h6>
							
						</div>
						<div class="w-100 border-top my-2" style="border-color: #404040!important;"></div>

						<c:if test="${productMaster.productQty != 1}">
							<div class="d-flex flex-column gap-2">
								<h5 class="fw-semibold m-0 d-flex align-items-center">상품 수량&nbsp;<div class="fs-6">| 최대 <span>${productMaster.productQty}</span>개</div></h5>
								<div class="d-flex border border-1 mb-2" style="border-radius: 4px; border-color: #D3D3D3; height: 44px; min-width: 166px; max-width: 200px;">
									<div class="w-25 d-flex justify-content-center align-items-center btn" style="border-right: 1px solid #D3D3D3; border-radius: 0;" control-cd="0" onclick="javascript:itemsOrderControl(this)">
										<svg width="17" height="3" viewBox="0 0 17 3" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd" d="M16.5 1.25C16.5 1.94036 15.9404 2.5 15.25 2.5L1.25 2.5C0.559644 2.5 -6.23395e-08 1.94036 -4.01598e-08 1.25C-1.79802e-08 0.559643 0.559644 -9.47993e-07 1.25 -9.06937e-07L15.25 -7.43391e-08C15.9404 -3.32827e-08 16.5 0.559644 16.5 1.25Z" fill="#D3D3D3"/>
										</svg>
									</div>
									<div class="w-50 d-flex justify-content-center align-items-center">
										<div class="w-100 d-flex justify-content-center align-items-center h-100">
											<input type="text" value="0" class="text-center form-control border-0 mx-1 bg-transparent text-white order-item-qty" oninput="javascript:itemsOrderControl(this)">
										</div>
									</div>
									<div class="w-25 d-flex justify-content-center align-items-center" style="background-color: #D3D3D3; cursor: pointer;" control-cd="1" onclick="javascript:itemsOrderControl(this)">
										<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd" d="M10.25 2C10.25 1.30964 9.69036 0.75 9 0.75C8.30964 0.75 7.75 1.30964 7.75 2V7.41675H2C1.30964 7.41675 0.75 7.97639 0.75 8.66675C0.75 9.3571 1.30964 9.91675 2 9.91675H7.75V16C7.75 16.6904 8.30964 17.25 9 17.25C9.69036 17.25 10.25 16.6904 10.25 16V9.91675H16C16.6904 9.91675 17.25 9.3571 17.25 8.66675C17.25 7.97639 16.6904 7.41675 16 7.41675H10.25V2Z" fill="#0F0F14"/>
										</svg>
									</div>
								</div>
								<h5 class="fw-semibold m-0 d-flex align-items-center">박스 추가&nbsp;<div class="fs-6">| 최대 수량은 상품 수량을 넘을 수 없습니다</div></h5>
								<div class="d-flex border border-1" style="border-radius: 4px; border-color: #D3D3D3; height: 44px; min-width: 166px; max-width: 200px;">
									<div class="w-25 d-flex justify-content-center align-items-center btn" style="border-right: 1px solid #D3D3D3; border-radius: 0;" control-cd="0" onclick="javascript:boxsOrderControl(this)">
										<svg width="17" height="3" viewBox="0 0 17 3" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd" d="M16.5 1.25C16.5 1.94036 15.9404 2.5 15.25 2.5L1.25 2.5C0.559644 2.5 -6.23395e-08 1.94036 -4.01598e-08 1.25C-1.79802e-08 0.559643 0.559644 -9.47993e-07 1.25 -9.06937e-07L15.25 -7.43391e-08C15.9404 -3.32827e-08 16.5 0.559644 16.5 1.25Z" fill="#D3D3D3"/>
										</svg>
									</div>
									<div class="w-50 d-flex justify-content-center align-items-center">
										<div class="w-100 d-flex justify-content-center align-items-center h-100">
											<input type="text" value="0" class="text-center form-control border-0 mx-1 bg-transparent text-white order-box-qty" oninput="javascript:boxsOrderControl(this)">
										</div>
									</div>
									<div class="w-25 d-flex justify-content-center align-items-center" style="background-color: #D3D3D3; cursor: pointer;" control-cd="1" onclick="javascript:boxsOrderControl(this)">
										<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
											<path fill-rule="evenodd" clip-rule="evenodd" d="M10.25 2C10.25 1.30964 9.69036 0.75 9 0.75C8.30964 0.75 7.75 1.30964 7.75 2V7.41675H2C1.30964 7.41675 0.75 7.97639 0.75 8.66675C0.75 9.3571 1.30964 9.91675 2 9.91675H7.75V16C7.75 16.6904 8.30964 17.25 9 17.25C9.69036 17.25 10.25 16.6904 10.25 16V9.91675H16C16.6904 9.91675 17.25 9.3571 17.25 8.66675C17.25 7.97639 16.6904 7.41675 16 7.41675H10.25V2Z" fill="#0F0F14"/>
										</svg>
									</div>
								</div>
							</div>
							<div class="w-100 border-top my-2" style="border-color: #404040!important;"></div>
						</c:if>
						<c:if test="${productMaster.productQty == 1}">
							<div class="d-flex align-items-center gap-2">
								<input type="checkbox" id="boxCheck" class="form-check-input bg-dark m-0" onclick="javacript:boxQtyCheckBox()">
								<label for="boxCheck"><h6 class="m-0 d-flex align-items-center">사용된 제품 박스 추가(+5,000원)</h6></label>
							</div>
							<div class="w-100 border-top my-2" style="border-color: #404040!important;"></div>
						</c:if>

						<div class="d-flex flex-column">
							<h6>배송 주의사항*</h6>
							<div class="m-0" style="font-size: 12px;">도서산간 지역의 경우 배송이 제한되거나 추가요금이 발생할 수 있습니다.</div>
							<div class="m-0" style="font-size: 12px;">AS 기준은 각 부품의 유통사 규정에 따르며 해당 쇼핑몰에서 1년간 무상 AS를 지원해드립니다.</div>
							<div class="m-0 mt-2" style="font-size: 12px;">제품 견본 이미지는 케이스의 외관을 보여드리기 위함입니다.</div>
							<div class="m-0" style="font-size: 12px;">내장제품의 형태가 상이하니 케이스의 형태만 확인하여 선택 부탁드립니다.</div>
						</div>
					</div>
				</div>
				<c:if test="${productMaster.productQty != 1}">
					<div class="d-flex justify-content-between align-items-center mb-5 gap-4">
						<button type="button" class="btn btn-secondary btn-lg fw-bold px-5" onclick="javascript:clickReturnBtn()">뒤로가기</button>
						<div class="d-flex align-items-center gap-3">
							<button type="button" class="btn btn-light btn-lg fw-bold px-5" onclick="javascript:clickCaptureBtn()">캡쳐하기</button>
							<button type="button" class="btn btn-light btn-lg fw-bold px-5" data-bs-toggle="modal" data-bs-target="#modal-description">질문저장</button>
							<button type="button" class="btn btn-primary btn-lg fw-bold px-5" onclick="javascript:clickOrderBtn()">주문하기</button>
						</div>
					</div>
				</c:if>
				<c:if test="${productMaster.productQty == 1}">
					<div class="d-flex justify-content-center align-items-center mb-5 gap-4">
						<button type="button" class="btn btn-secondary btn-lg fw-bold px-5" onclick="javascript:clickReturnBtn()">뒤로가기</button>
						<div class="d-flex align-items-center gap-3">
							<button type="button" class="btn btn-light btn-lg fw-bold px-5" data-bs-toggle="modal" data-bs-target="#modal-description">캡쳐하기</button>
							<button type="button" class="btn btn-light btn-lg fw-bold px-5" onclick="javascript:goOrderSheet()">질문저장</button>
							<button type="button" class="btn btn-primary btn-lg fw-bold px-5" onclick="javascript:clickSinglOrderBtn()">주문하기</button>
						</div>
					</div>
				</c:if>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
	<div class="modal fade" id="resultErrorModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog modal-dialog-centered">
		  <div class="modal-content">
			<div class="modal-header border-0">
			  <h1 class="modal-title fs-5">견적산출 오류!</h1>
			</div>
			<div class="modal-body">
			  견적 산출 중 오류가 발생했습니다...!!<br>조건을 바꿔서 다시하시거나 이벤트몰을 이용해주세요!
			</div>
			<div class="modal-footer border-0">
			  <button type="button" class="btn btn-secondary" onclick="javascript:location.href = '/' ">홈페이지</button>
			  <button type="button" class="btn btn-primary" onclick="javascript:clickReturnBtn()">다시하기</button>
			</div>
		  </div>
		</div>
	</div>


	<div class="modal fade" data-bs-backdrop="static" id="modal-description" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content p-3">
				<div class="modal-body">
					<h3 class="text-center mb-3">견적의 이름을 입력해주세요!</h3>
					<input type="text" class="form-control" placeholder="최대 20자" oninput="javascript:descriptionInput(this)">
				</div>
				<div class="modal-footer border-0 w-100 d-flex gap-3">
					<button type="button" class="btn btn-light border-1 border border-dark fw-bold flex-1" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-dark fw-bold flex-1" onclick="javascript:goSaveBtn()">저장</button>
				</div>
			</div>
		</div>
	</div>

</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>
