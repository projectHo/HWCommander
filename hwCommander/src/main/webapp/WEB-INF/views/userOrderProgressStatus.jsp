<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 주문진핸현황</title>
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
	$(function(){
		// bootstrap tooltip
		const tooltipList = $('[data-bs-toggle="tooltip"]').map(function() {
			return new bootstrap.Tooltip($(this)[0]);
		});
		
		$(".user-name").html(masterInfoObject.ordererName);
		$(".order-name").html(masterInfoObject.orderName);
		if(masterInfoObject.orderStateCd === "01"){
			$("#box-1").addClass("status-now").addClass("fs-5");
			$("#box-2").addClass("status-now-near").attr("onclick","javascript:noticeYet()");
			$("#box-3").removeAttr("onclick","javascript:clickBoxThree()").attr("onclick","javascript:noticeYet()");
			$("#box-4").removeAttr("onclick","javascript:clickBoxFour()").attr("onclick","javascript:noticeYet()");
			$("#box-5").removeAttr("onclick","javascript:clickBoxFive()").attr("onclick","javascript:noticeYet()");
			$("#box-6").removeAttr("onclick","javascript:clickBoxSix()").attr("onclick","javascript:noticeYet()");
			$("#box-7").removeAttr("onclick","javascript:clickBoxSeven()").attr("onclick","javascript:noticeYet()");
			$("#box-8").removeAttr("onclick","javascript:clickBoxEgiht()").attr("onclick","javascript:noticeYet()");
		}else if(masterInfoObject.orderStateCd === "02"){
			$("#box-1").addClass("status-now-near");
			$("#box-2").addClass("status-now").addClass("fs-5");
			$("#box-3").addClass("status-now-near").attr("onclick","javascript:noticeYet()");
			$("#box-4").removeAttr("onclick","javascript:clickBoxFour()").attr("onclick","javascript:noticeYet()");
			$("#box-5").removeAttr("onclick","javascript:clickBoxFive()").attr("onclick","javascript:noticeYet()");
			$("#box-6").removeAttr("onclick","javascript:clickBoxSix()").attr("onclick","javascript:noticeYet()");
			$("#box-7").removeAttr("onclick","javascript:clickBoxSeven()").attr("onclick","javascript:noticeYet()");
			$("#box-8").removeAttr("onclick","javascript:clickBoxEgiht()").attr("onclick","javascript:noticeYet()");
		}else if(masterInfoObject.orderStateCd === "03"){
			$("#box-2").addClass("status-now-near");
			$("#box-3").addClass("status-now").addClass("fs-5");
			$("#box-4").addClass("status-now-near").attr("onclick","javascript:noticeYet()");
			$("#box-5").removeAttr("onclick","javascript:clickBoxFive()").attr("onclick","javascript:noticeYet()");
			$("#box-6").removeAttr("onclick","javascript:clickBoxSix()").attr("onclick","javascript:noticeYet()");
			$("#box-7").removeAttr("onclick","javascript:clickBoxSeven()").attr("onclick","javascript:noticeYet()");
			$("#box-8").removeAttr("onclick","javascript:clickBoxEgiht()").attr("onclick","javascript:noticeYet()");
		}else if(masterInfoObject.orderStateCd === "04"){
			$("#box-3").addClass("status-now-near");
			$("#box-4").addClass("status-now").addClass("fs-5");
			$("#box-5").addClass("status-now-near").attr("onclick","javascript:noticeYet()");
			$("#box-6").removeAttr("onclick","javascript:clickBoxSix()").attr("onclick","javascript:noticeYet()");
			$("#box-7").removeAttr("onclick","javascript:clickBoxSeven()").attr("onclick","javascript:noticeYet()");
			$("#box-8").removeAttr("onclick","javascript:clickBoxEgiht()").attr("onclick","javascript:noticeYet()");
		}else if(masterInfoObject.orderStateCd === "05"){
			$("#box-4").addClass("status-now-near");
			$("#box-5").addClass("status-now").addClass("fs-5");
			$("#box-6").addClass("status-now-near").attr("onclick","javascript:noticeYet()");
			$("#box-7").removeAttr("onclick","javascript:clickBoxSeven()").attr("onclick","javascript:noticeYet()");
			$("#box-8").removeAttr("onclick","javascript:clickBoxEgiht()").attr("onclick","javascript:noticeYet()");
		}else if(masterInfoObject.orderStateCd === "06"){
			$("#box-5").addClass("status-now-near");
			$("#box-6").addClass("status-now").addClass("fs-5");
			$("#box-7").addClass("status-now-near").attr("onclick","javascript:noticeYet()");
			$("#box-8").removeAttr("onclick","javascript:clickBoxEgiht()").attr("onclick","javascript:noticeYet()");
		}else if(masterInfoObject.orderStateCd === "07"){
			$("#box-6").addClass("status-now-near");
			$("#box-7").addClass("status-now").addClass("fs-5");
			$("#box-8").addClass("status-now-near").attr("onclick","javascript:noticeYet()");
		}else if(masterInfoObject.orderStateCd === "08"){
			$("#box-8").addClass("status-now").addClass("fs-5");
			$("#box-7").addClass("status-now-near");
		}
	})

	function noticeYet(){
		alert("아직 해당 단계가 아닙니다!");
	}

	var Pattern = /\((.*?)\)/;
	var masterInfoMatch = Pattern.exec("${orderMasterVO}");
	var masterInfoValues = masterInfoMatch[1];

	var masterInfoArray = masterInfoValues.split(", ");
	var masterInfoObject = {};
	for (var i = 0; i < masterInfoArray.length; i++) {
		var keyValue = masterInfoArray[i].split("=");
		var key = keyValue[0];
		var value = keyValue[1];
		masterInfoObject[key] = value;
	}
	
	let now;
	let nowNear;
	function mouseInBox(el){
		now = $(".status-container").find(".status-now");
		nowNear = $(".status-container").find(".status-now-near");
		now.removeClass("status-now").removeClass("fs-5");
		nowNear.removeClass("status-now-near");
		$(el).addClass("status-this").addClass("fs-5")
		$(el).next().next().addClass("status-near");
		$(el).prev().prev().addClass("status-near");
	}
	function mouseOutBox(el){
		$(el).removeClass("status-this").removeClass("fs-5");
		$(el).next().next().removeClass("status-near");
		$(el).prev().prev().removeClass("status-near");
		now.addClass("status-now").addClass("fs-5");
		nowNear.addClass("status-now-near");
	}
	function clickBoxOne(){
		// 약관 조항 재확인 용도, 결제 전 약관 동의서 내용을 구매 당시의 버전으로 게시한다.
		// 수정 필요
		location.href = "/termsOfService.do"
	}
	function clickBoxTwo(){
		// 결제정보 (수령인, 배송지, 연락처, 현금연수증/세금계산서 정보, 결제 금액, 결제 수단-카드 시 카드정보, 계좌이체 시 소비자가 기재한 입금자 명 및 입금받은 계좌 정보)
		location.href = "userReceipt.do?id=" + masterInfoObject.id;
	}
	function clickBoxThree(){
		// 제품 신품상태 개봉 영상이 담김(클라우드 연동이 되기 전까진 유저가 적을 수 있는 메일 입력칸 생성 후 파일발송 / 클라우드 연동 후엔 영상이 재생 가능한 페이지 혹은 파일 다운로드가 가능한 페이지 만들기)
		
	}
	function clickBoxFour(){
		// 조립 완료 시의 사진 포함(클라우드 연동이 되기 전까진 유저가 적을 수 있는 메일 입력칸 생성 후 Admin이 회사용 메일로 직접 파일발송 / 클라우드 연동 후엔 Admin의 사진파일 게시 가능한 페이지 만들기)
		
	}
	function clickBoxFive(){
		// 시행된 작업과 설치된 드라이버 버전 입력(Admin의 텍스트 입력 가능한 페이지 만들기)

	}
	function clickBoxSix(){
		// 포장 상태 사진 기입(클라우드 연동이 되기 전까진 유저가 적을 수 있는 메일 입력칸 생성 후 Admin이 회사용 메일로 직접 파일발송 / 클라우드 연동 후엔 Admin의 사진파일 게시 가능한 페이지 만들기)

	}
	function clickBoxSeven(){
		// 송장번호와 제품 배송상태 확인 가능한 페이지(송장번호 등록 시 우체국택배 조회 가능한 api 따오기//불가능 시 상태 Admin의 수기입력)

	}
	function clickBoxEight(){
		// 최종 견적서 내용과 추천인 상태 등을 조회할 수 있는 견적산출 결과물, AS가용상태 조회

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
			<div class="estimateCalc_background pt-5 pb-5" style="width: 70% !important">
				<div class="mb-3 ps-5 ms-5">
					<span class="user-name fs-2 fw-bold"></span>
					<b class="fs-2">님의 진행현황</b>
					<p>※ 상태가 배송단계로 넘어갔을 경우 배송지 변경은 불가능합니다!! ※</p>
					<span>주문 제품 명 : </span>
					<b class="order-name fw-bold"></b>
				</div>
				<div class="d-flex align-items-center status-container">
					<div class="progress status-progress">
						<div class="progress-bar status-progress-bar bg-info" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="box text-center status-box d-flex align-items-center justify-content-center status-font-size" id="box-1" onmouseenter="javascript:mouseInBox(this)" onmouseleave="javascript:mouseOutBox(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="청약철회 및 소프트웨어 조항에 동의하셨습니다.(약관 재확인 바로가기)" onclick="javascript:clickBoxOne()">
						<span class="fw-bold text-white">청약철회 및<br>소프트웨어<br>조항 동의 완료</span>
					</div>
					<div class="progress status-progress">
						<div class="progress-bar status-progress-bar bg-success" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="box text-center status-box d-flex align-items-center justify-content-center" id="box-2" onmouseenter="javascript:mouseInBox(this)" onmouseleave="javascript:mouseOutBox(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="결제완료(영수증 바로가기)" onclick="javascript:clickBoxTwo()">
						<span class="fw-bold text-white">결제 완료</span>
					</div>
					<div class="progress status-progress">
						<div class="progress-bar status-progress-bar bg-info" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="box text-center status-box d-flex align-items-center justify-content-center" id="box-3" onmouseenter="javascript:mouseInBox(this)" onmouseleave="javascript:mouseOutBox(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="주문하신 부품들을 공수중에 있습니다." onclick="javascript:clickBoxThree()">
						<span class="fw-bold text-white">제품 공수 중</span>
					</div>
					<div class="progress status-progress">
						<div class="progress-bar status-progress-bar bg-danger" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="box text-center status-box d-flex align-items-center justify-content-center" id="box-4" onmouseenter="javascript:mouseInBox(this)" onmouseleave="javascript:mouseOutBox(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="주문하신 컴퓨터를 조립 중입니다. 제품 공수 완료 탭에서 신품 인증에 관련한 자료들이 있으니 확인해주시면 감사하겠습니다." onclick="javascript:clickBoxFour()">
						<span class="fw-bold text-white">조립 중</span>
					</div>
					<div class="progress status-progress">
						<div class="progress-bar status-progress-bar bg-info" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="box text-center status-box d-flex align-items-center justify-content-center" id="box-5" onmouseenter="javascript:mouseInBox(this)" onmouseleave="javascript:mouseOutBox(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="조립 완료 후 윈도우 설치 및 드라이버를 세팅 중입니다." onclick="javascript:clickBoxFive()">
						<span class="fw-bold text-white">시스템 구성중</span>
					</div>
					<div class="progress status-progress">
						<div class="progress-bar status-progress-bar bg-success" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="box text-center status-box d-flex align-items-center justify-content-center" id="box-6" onmouseenter="javascript:mouseInBox(this)" onmouseleave="javascript:mouseOutBox(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="모든 세팅이 끝나고 포장 후 택배사에 인계했습니다." onclick="javascript:clickBoxSix()">
						<span class="fw-bold text-white">출고</span>
					</div>
					<div class="progress status-progress">
						<div class="progress-bar status-progress-bar bg-danger" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="box text-center status-box d-flex align-items-center justify-content-center" id="box-7" onmouseenter="javascript:mouseInBox(this)" onmouseleave="javascript:mouseOutBox(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="배송이 출발했습니다. 곧 제품을 받아보실 수 있을겁니다." onclick="javascript:clickBoxSeven()">
						<span class="fw-bold text-white">지역배송 출발</span>
					</div>
					<div class="progress status-progress">
						<div class="progress-bar status-progress-bar bg-info" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
					<div class="box text-center status-box d-flex align-items-center justify-content-center" id="box-8" onmouseenter="javascript:mouseInBox(this)" onmouseleave="javascript:mouseOutBox(this)" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="제품이 배송지에 도착했습니다. 케이스에 들어간 내부 포장재를 제거 후 사용해주세요." onclick="javascript:clickBoxEight()">
						<span class="fw-bold text-white">도착</span>
					</div>
					<div class="progress status-progress">
						<div class="progress-bar status-progress-bar bg-success" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
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