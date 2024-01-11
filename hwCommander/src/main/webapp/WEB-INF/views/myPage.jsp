<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<head>
<title>현우의 컴퓨터 공방 - 마이페이지</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css">

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>
<link rel="stylesheet" href="/resources/css/mypage.css">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%
	String enc_data = String.valueOf(request.getAttribute("enc_data"));
	String integrity_value = String.valueOf(request.getAttribute("integrity_value"));
	String token_version_id = String.valueOf(request.getAttribute("token_version_id"));
%>
<script>
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
	// 주문 현황
	let objectNum;
	let objStateCd;
	function goOrderListDetailPage(){
		if(objStateCd > 6 && objStateCd < 8){
			alert("상태가 배송단계로 넘어갔을 경우 배송지 변경은 불가합니다!");
		}
		location.href = "/user/orderListDetail.do?id=" + objectNum;
	}	
	function clickOrderList(el){
		objStateCd = $(el).find(".item-cd").attr("cd");
		let orderNumber = $(el).find(".item-id").html();
		objectNum = encodeURIComponent(orderNumber);
		goOrderListDetailPage();
	}
	function clickOrderDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-order-detail").css("display","block");
		setTimeout(() => {
			$(".card-order-detail").addClass("show");
		}, 100);
	}

	// 환불 내역
	function clickRefundList(el){
		if(loginCheck()) {
			location.href = "/user/refundInfo.do?id=" + $(el).find(".item-id").attr("name");
		}
	}
	function clickRefundDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-refund-detail").css("display","block")
		setTimeout(() => {
			$(".card-refund-detail").addClass("show");
		}, 100);;
	}
	
	// 문의 내역
	function clickInquiryDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-inquiry-detail").css("display","block")
		setTimeout(() => {
			$(".card-inquiry-detail").addClass("show");
		}, 100);;
	}

	
	// 견적저장소
	function clickEstimateStorageDetail(){
		if(loginCheck()) {
			location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
		}
	}
	// 내 정보
	function checkMyInfo(){
		$.ajax({
			type: "post",
			url: "/user/idAndPwCheck.do",
			data: {
				id: $("#myId").val(),
				pw: $("#myPw").val()
			},
			dataType: "json",
			success: function(response) {
				if (response === true) {
					$(".card-list").removeClass("show").css("display","none");
					$(".card-user-info-detail").css("display","block")
					setTimeout(() => {
						$(".card-user-info-detail").addClass("show");
						$(".card-user-info").remove();
					}, 100);
				} else {
					alert("아이디 비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				}
				
			},
			error: function(xhr, status, error) {
				alert("통신에 실패했습니다. 다시 시도해주세요.");
				location.reload();
			}
		});
	}
	function clickUserInfoDetail(){
		if($(".card-user-info").length > 0){
			$(".card-list").removeClass("show").css("display","none");
			$(".card-user-info").css("display","block")
			setTimeout(() => {
				$(".card-user-info").addClass("show");
			}, 100);
		}else {
			$(".card-list").removeClass("show").css("display","none");
			$(".card-user-info-detail").css("display","block")
			setTimeout(() => {
				$(".card-user-info-detail").addClass("show");
			}, 100);
		}
	}
	function infoCheckHp(){
		const numberCheck = /^[0-9]+$/;	
		if ($('.recipient-next-hp').val().length>=1 && !numberCheck.test($('.recipient-next-hp').val())) {
			alert("휴대폰번호는 숫자만 입력 가능합니다.");
			$('.recipient-next-hp').val("");
			$('.recipient-next-hp').focus();
		}
	}
	
	function findDaumAddr() {
		new daum.Postcode({
			oncomplete: function(data) {
				$(".recipient-zip-code").val(data.zonecode);
				$(".recipient-jibun-addr").val(data.jibunAddress);
				$(".recipient-road-addr").val(data.roadAddress);
				$(".recipient-detail-addr").val("");
			}
		}).open();
	}
	
	function hpNumberAuthentication() {
		if($('#di').val().trim() != null && $('#di').val().trim() != "") {
			alert("이미 정상적으로 인증을 완료하였습니다.");
			return false;
		}
		
		window.name ="Parent_window";
		
		window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		
		document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/service.cb";
		document.form_chk.target = "popupChk";
		document.form_chk.submit();
	}
	function editAddrBtn(){
		findDaumAddr();
	}
	function changeCancleBtn(){
		$(".phone-container").removeClass("d-none");
		$(".addr-container").removeClass("d-none");
		$(".email-container").removeClass("d-none");
		$(".btn-first").removeClass("d-none");
		$(".btn-second").removeClass("show").addClass("d-none");
		$(".base-info").removeClass("d-none").addClass("show");
		$(".changeable-info").removeClass("show").addClass("d-none");
		setTimeout(() => {
			$(".phone-container").addClass("show");
			$(".addr-container").addClass("show");
			$(".email-container").addClass("show");
			$(".btn-first").addClass("show");
		}, 50);

	}
	function changePhoneInfoBtn(el){
		$(el).parent().addClass("fade").addClass("d-none");
		$(el).parent().next().removeClass("d-none");
		$(".addr-container").addClass("fade");
		$(".email-container").addClass("fade");
		setTimeout(() => {
			$(el).parent().next().addClass("show");
			$(".addr-container").addClass("d-none");
			$(".email-container").addClass("d-none");
		}, 50);
		$(".changeable-phone-info").prev().addClass("d-none").addClass("fade");
		$(".changeable-phone-info").removeClass("d-none").addClass("show");
	}
	function changeMailInfoBtn(el){
		$(el).parent().addClass("fade").addClass("d-none");
		$(el).parent().next().removeClass("d-none");
		$(".phone-container").addClass("fade");
		$(".addr-container").addClass("fade");
		setTimeout(() => {
			$(el).parent().next().addClass("show");
			$(".phone-container").addClass("d-none");
			$(".addr-container").addClass("d-none");
		}, 50);
		$(".changeable-email-info").prev().addClass("d-none").addClass("fade");
		$(".changeable-email-info").removeClass("d-none").addClass("show");
	}
	function changeAddrInfoBtn(el){
		$(el).parent().addClass("fade").addClass("d-none");
		$(el).parent().next().removeClass("d-none");
		$(".phone-container").addClass("fade");
		$(".email-container").addClass("fade");
		setTimeout(() => {
			$(el).parent().next().addClass("show");
			$(".phone-container").addClass("d-none");
			$(".email-container").addClass("d-none");
		}, 50);
		$(".changeable-addr-info").prev().addClass("d-none").addClass("fade");
		$(".changeable-addr-info").removeClass("d-none").addClass("show");
	}
	function UserInfoChangeSave(){
		if(confirm("수정 하시겠습니까?")){
			$.ajax({
				type: "post",
				url: "/user/userInfoUpdateLogic.do",
				data: {
					id: "${loginUser.id}",
					pw: "${loginUser.pw}",
					sexCd: "${loginUser.sexCd}",
					name: "${loginUser.name}",
					birth: "${loginUser.birth}",
					hpNumber: $('.recipient-next-hp').val(),
					jibunAddr: $(".recipient-jibun-addr").val(),
					roadAddr: $(".recipient-road-addr").val(),
					detailAddr: $(".recipient-detail-addr").val(),
					zipcode: $(".recipient-zip-code").val(),
					mail: $(".recipient-mail-addr").val(),
					mailKey: "${loginUser.mailKey}",
					mailConfirm: "${loginUser.mailConfirm}",
					regDtm: "${loginUser.regDtm}",
					updtDtm: "${loginUser.updtDtm}",
					di: "${loginUser.di}",
				},
				dataType: "json",
				success: function(response) {
					alert("정상적으로 수정되었습니다! 수정된 내용이 보이지 않으시면 재 로그인 해주세요!");
					location.reload();				
				},
				error: function(xhr, status, error) {
					alert("통신에 실패했습니다. 다시 시도해주세요.");
					location.reload();
				}
			});
		}else {
			return false;
		}
	}
	function changeMailAddr(){
		if($('.recipient-mail-addr').val().trim() == "" || $('.recipient-mail-addr').val().trim() == null) {
			alert("이메일을 입력하세요.");
			$('.recipient-mail-addr').focus();
			return false;
		}
		
		const mailCheckRegExp = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");

		if (!mailCheckRegExp.test($('.recipient-mail-addr').val())) {
			alert("올바른 이메일 형식을 입력해주세요");
			$('.recipient-mail-addr').focus();
			return false;
		}

		if("${loginUser.mail}" == $(".recipient-mail-addr").val()){
			alert("변경된 내용이 없습니다. 다시 확인해주세요");
			return false;
		}
		if(confirm("수정 하시겠습니까? 확인을 누르시면 로그아웃되며 이메일 인증 전 로그인 불가능합니다.")){
			$.ajax({
				type: "post",
				url: "/user/userMailInfoUpdateLogic.do",
				data: {
					id: "${loginUser.id}",
					pw: "${loginUser.pw}",
					sexCd: "${loginUser.sexCd}",
					name: "${loginUser.name}",
					birth: "${loginUser.birth}",
					hpNumber: $('.recipient-next-hp').val(),
					jibunAddr: $(".recipient-jibun-addr").val(),
					roadAddr: $(".recipient-road-addr").val(),
					detailAddr: $(".recipient-detail-addr").val(),
					zipcode: $(".recipient-zip-code").val(),
					mail: $(".recipient-mail-addr").val(),
					mailKey: "${loginUser.mailKey}",
					mailConfirm: "N",
					regDtm: "${loginUser.regDtm}",
					updtDtm: "${loginUser.updtDtm}",
					di: "${loginUser.di}",
				},
				dataType: "json",
				success: function(response) {
					alert("이메일 인증 후 정상 반영됩니다! 이메일 인증 후 재로그인 해주세요!");
					location.href = "/user/logoutLogic.do";			
				},
				error: function(xhr, status, error) {
					alert("통신에 실패했습니다. 다시 시도해주세요.");
					location.reload();
				}
			});
		}else {
			return false;
		}
	}
	// 회원 탈퇴
	function clickSecessionDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-secession-detail").css("display","block")
		setTimeout(() => {
			$(".card-secession-detail").addClass("show");
		}, 100);
	}
	function secessionMoalOpen(){
		if($("#user-id").val() == "${loginUser.id}"){
			$("#secessionModal").modal("show");
		}else{
			alert("아이디를 정확히 입력해주세요");
		}
	}
	function secessionBtn(){
		$.ajax({
			type: "post",
			url: "/user/tempDeleteAccountLogic.do",
			data: {
				id: $("#user-id").val()
			},
			dataType: "json",
			success: function(){
				alert("탈퇴 신청이 완료되었습니다. 메인화면으로 이동합니다.");
				location.href = "/user/logoutLogic.do";
			},
			error: function() {
				alert("알수없는 이유로 요청 실패했습니다. 다시 시도해주시거나 고객센터에 문의해주세요.");
				location.reload();
			}
		})
	}
	$(function(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-order-detail").css("display","block").addClass("show");
	})
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start mypage-empty-space"></div>
			<!-- 작업영역 -->
			<div class="estimateCalc_background p-2 pt-5 pb-5 mypage-main-space">
				<div class="row h-100">
					<div class="col-2 ps-4 pe-0">
						<div class="accordion accordion-flush" id="accordionFlushExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingOne">
									<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="true">
										구매 정보
									</button>
								</h2>
								<div id="flush-collapseOne" class="accordion-collapse collapse show" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
									<div class="accordion-body">
										<div class="list-group list-group-flush">
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickOrderDetail()">
												주문 현황
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickRefundDetail()">
												환불 내역
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:alert('준비중입니다.')">
												배송지 관리(주소록)
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:alert('준비중입니다.')">
												사업장 관리
											</a>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingTwo">
									<button class="accordion-button accordion-button-single collapsed" onclick="javascript:alert('준비중입니다.')">
										혜택 정보
									</button>
								</h2>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingThree">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false">
										내 글 관리
									</button>
								</h2>
								<div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
									<div class="accordion-body">
										<div class="list-group list-group-flush">
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickInquiryDetail()">
												문의 사항
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:alert('준비중입니다.')">
												리뷰 관리
											</a>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingOne">
									<button class="accordion-button accordion-button-single collapsed" type="button" onclick="javascript:clickEstimateStorageDetail()">
										견적 저장소
									</button>
								</h2>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingOne">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFive" aria-expanded="false">
										회원 정보
									</button>
								</h2>
								<div id="flush-collapseFive" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
									<div class="accordion-body">
										<div class="list-group list-group-flush">
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickUserInfoDetail()">
												내 정보
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickSecessionDetail()">
												회원 탈퇴
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-10">
						<div class="card h-100">
						<!-- 주문 현황 -->
							<div class="card-body fade card-list card-order-detail">
								<h2 class="card-title">Hwcommander</h2>
								<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님의 주문내역</h6>
								<p class="card-text order-tbody">
									<table class="table table-hover table-light">
										<thead>
											<tr>
												<th scope="col">주문날짜</th>
												<th scope="col">상품명</th>
												<th scope="col">주문번호</th>
												<th scope="col">주문금액</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${orderMasterVOList}">
												<c:choose>
        											<c:when test="${item.orderStateCd < 09 || item.orderStateCd == 11}">
														<tr style="cursor: pointer;" onclick="javascript:clickOrderList(this)">
															<a href="javascript:goOrderListDetailPage()">
																<td scope="row">${item.orderDateStr}</td>
																<td>${item.orderName}</td>
																<td class="item-id">${item.id}</td>
																<td>${item.totOrderPriceStr}원</td>
																<td class="item-cd" cd="${item.orderStateCd}">${item.orderStateCdNm}</td>
															</a>
														</tr>
													</c:when>
												</c:choose>
											</c:forEach>
										</tbody>
									</table>
								</p>
							</div>
						<!-- 진행 현황 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						<!-- 환불 내역 -->
						<div class="card-body fade card-list card-refund-detail">
							<h2 class="card-title">Hwcommander</h2>
							<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님의 환불내역</h6>
							<p class="card-text order-tbody">
								<table class="table table-hover table-light">
									<thead>
										<tr>
											<th scope="col">주문날짜</th>
											<th scope="col">상품명</th>
											<th scope="col">주문번호</th>
											<th scope="col">주문금액</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="item" items="${refundInfoVOList}">
											<tr style="cursor: pointer;" onclick="javascript:clickRefundList(this)">
												<a href="javascript:goOrderListDetailPage()">
													<c:forEach var="orderItem" items="${orderMasterVOList}">
														<c:if test="${orderItem.id == item.orderId}">
															<td scope="row">${orderItem.orderDateStr}</td>
															<td>${orderItem.orderName}</td>
														</c:if>
													</c:forEach>
													<td class="item-id" name="${item.id}">${item.orderId}</td>
													<td>${item.requestRefundPrice}원</td>
													<c:forEach var="orderItem" items="${orderMasterVOList}">
														<c:if test="${orderItem.id == item.orderId}">
															<td class="item-cd" cd="${item.refundStateCd}">${orderItem.orderStateCdNm}</td>
														</c:if>
													</c:forEach>
												</a>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</p>
						</div>
						<!-- 배송지 관리 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						<!-- 사업장 관리 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						

						<!-- 문의 사항 -->
							<div class="card-body fade card-list card-inquiry-detail">
								<h2 class="card-title">Hwcommander</h2>
								<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님의 문의사항</h6>
								<p class="card-text">고객센터 전화를 통해 문의해주시기 바랍니다.</p>
								<p><span>고객센터 : <a href="tel:010-7625-0478" class="card-link">010-7625-0478</a></span></p>								
							</div>
						<!-- 리뷰 관리 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						

						<!-- 사전확인 -->
							<div class="card-body fade card-list card-user-info">
								<h2 class="card-title">Hwcommander</h2>
								<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님</h6>
								<p class="card-text">
									<div class="form-floating mb-3 col-6 mx-auto mt-5">
										<input type="text" class="form-control" id="myId" placeholder="">
										<label for="floatingInput">ID</label>
									</div>
									<div class="form-floating mb-5 col-6 mx-auto">
										<input type="password" class="form-control" id="myPw" placeholder="">
										<label for="floatingPassword">Password</label>
									</div>
									<div class="d-flex justify-content-center">
										<button type="button" class="btn btn-outline-secondary" onclick="javascript:checkMyInfo()">확인</button>
									</div>
								</p>
							</div>
						<!-- 내 정보 -->
							<div class="card-body fade card-list card-user-info-detail">
								<h2 class="card-title">Hwcommander</h2>
								<h6 class="card-subtitle mb-2 text-muted d-flex justify-content-between">${loginUser.name}님의 회원정보</h6>
								<p class="card-text order-tbody">
									<table class="table table-light" style="border-collapse: separate;">
										<thead>
											<tr>
												<th scope="col" style="width: 20%;">이름</th>
												<th scope="col" style="font-weight: 400;">${loginUser.name}</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">생년월일</th>
												<td>${loginUser.birth}</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">
													<div class="d-flex justify-content-between align-items-center">
														<span>
															휴대폰 번호
														</span>
														<span class="phone-container">
															<span class="change-phone btn-first">
																<button class="btn btn-outline-success btn-sm pb-0 pt-1" onclick="javascript:changePhoneInfoBtn(this)">수정</button>
															</span>
															<span class="change-phone btn-second d-none fade">
																<button class="btn btn-outline-danger btn-sm pb-0 pt-1" onclick="javascript:changeCancleBtn()">취소</button>
																<button class="btn btn-outline-primary btn-sm pb-0 pt-1" onclick="javascript:UserInfoChangeSave()">저장</button>
															</span>
														</span>
													</div>
												</th>
												<td class="align-middle">
													<span class="base-info">
														${loginUser.hpNumber}
													</span>
													<div class="input-group changeable-info changeable-phone-info d-none fade">
														<input maxlength="11" type="text" class="form-control recipient-next-hp" aria-describedby="button-addon" oninput="javascript:infoCheckHp()" value="${loginUser.hpNumber}">
														<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon" onclick="javascript:hpNumberAuthentication()">인증하기</button>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">
													<div class="d-flex justify-content-between align-items-center">
														<span>
															주소
														</span>
														<span class="addr-container">
															<span class="change-addr btn-first">
																<button class="btn btn-outline-success btn-sm pb-0 pt-1" onclick="javascript:changeAddrInfoBtn(this)">수정</button>
															</span>
															<span class="change-addr btn-second fade d-none">
																<button class="btn btn-outline-danger btn-sm pb-0 pt-1" onclick="javascript:changeCancleBtn()">취소</button>
																<button class="btn btn-outline-primary btn-sm pb-0 pt-1" onclick="javascript:UserInfoChangeSave()">저장</button>
															</span>
														</span>
													</div>
												</th>
												<td class="align-middle">
													<span class="base-info">
														${loginUser.zipcode}
													</span>
													<div class="input-group changeable-info changeable-addr-info d-none fade">
														<input type="text" class="form-control recipient-zip-code" aria-label="Recipient's addr" aria-describedby="button-addon2" readonly="readonly" value="${loginUser.zipcode}">
														<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon2" onclick="javascript:editAddrBtn()">찾기</button>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">지번주소</th>
												<td>
													<span class="base-info">
														${loginUser.jibunAddr}
													</span>
													<input type="text" class="form-control recipient-jibun-addr changeable-info changeable-addr-info d-none fade" aria-label="Recipient's Ji addr" readonly="readonly" value="${loginUser.jibunAddr}">
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">도로명주소</th>
												<td>
													<span class="base-info">
														${loginUser.roadAddr}
													</span>
													<input type="text" class="form-control recipient-road-addr changeable-info changeable-addr-info d-none fade" aria-label="Recipient's Road addr" readonly="readonly" value="${loginUser.roadAddr}">
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">상세주소</th>
												<td>
													<span class="base-info">
														${loginUser.detailAddr}
													</span>
													<input type="text" class="form-control recipient-detail-addr changeable-info changeable-addr-info d-none fade" aria-label="Recipient's Detail addr" aria-describedby="button-addon3" value="${loginUser.detailAddr}">
													
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">
													<div class="d-flex justify-content-between align-items-center">
														<span>
															E-mail
														</span>
														<span class="email-container">
															<span class="change-email btn-first">
																<button class="btn btn-outline-success btn-sm pb-0 pt-1" onclick="javascript:changeMailInfoBtn(this)">수정</button>
															</span>
															<span class="change-email btn-second fade d-none">
																<button class="btn btn-outline-danger btn-sm pb-0 pt-1" onclick="javascript:changeCancleBtn()">취소</button>
																<button class="btn btn-outline-primary btn-sm pb-0 pt-1" onclick="javascript:changeMailAddr()">저장</button>
															</span>
														</span>
													</div>
												</th>
												<td class="align-middle">
													<span class="base-info">
														${loginUser.mail}
													</span>
													<div class="input-group changeable-info changeable-email-info d-none fade">
														<input type="text" class="form-control recipient-mail-addr" aria-label="Recipient's delivery required" aria-describedby="button-addon5" value="${loginUser.mail}">
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">가입일</th>
												<td>${loginUser.regDtm}</td>
											</tr>
										</tbody>
									</table>
								</p>
							</div>
						<!-- 회원 탈퇴 -->
							<div class="card-body fade card-list card-secession-detail">
								<h2 class="card-title">Hwcommander</h2>
								<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님</h6>
								<p class="card-text">
									<div class="form-floating mb-3 col-6 mx-auto mt-5">
										<input type="text" class="form-control" id="user-id" placeholder="">
										<label for="floatingInput">ID</label>
									</div>
									<div class="d-flex justify-content-center">
										<button type="button" class="btn btn-outline-secondary" onclick="javascript:secessionMoalOpen()">회원 탈퇴</button>
									</div>
								</p>
							</div>
							<div class="modal fade" id="secessionModal" tabindex="-1" aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h2>회원 탈퇴</h2>
											<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<div class="row p-2">
												정말 회원 탈퇴 하시겠습니까?<br>회원 탈퇴 신청시 개인정보 보호법에 따라 1년간 정보 보관 후 폐기합니다.
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary" box="0" data-bs-dismiss="modal">취소</button>
											<button type="button" class="btn btn-primary" box="1" onclick="javascript:secessionBtn()">탈퇴</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 01.11 모바일 환경 구성 -->
			<div class="estimateCalc_background mypage-main-mobile p-2 pt-4 pb-4 mb-3 w-100">
				<div class="accordion accordion-flush" id="accordionFlushMobile">
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-mobile-headingOne">
							<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#flush-mobile-collapseOne" aria-expanded="true">
								구매 정보
							</button>
						</h2>
						<div id="flush-mobile-collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionFlushMobile">
							<div class="accordion-body">
								<div class="list-group list-group-flush">
									<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickOrderDetail()">
										주문 현황
									</a>
									<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickRefundDetail()">
										환불 내역
									</a>
									<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:alert('준비중입니다.')">
										배송지 관리(주소록)
									</a>
									<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:alert('준비중입니다.')">
										사업장 관리
									</a>
								</div>
							</div>
						</div>
					</div>
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-mobile-headingTwo">
							<button class="accordion-button accordion-button-single collapsed" onclick="javascript:alert('준비중입니다.')">
								혜택 정보
							</button>
						</h2>
					</div>
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-mobile-headingThree">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-mobile-collapseThree" aria-expanded="false">
								내 글 관리
							</button>
						</h2>
						<div id="flush-mobile-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushMobile">
							<div class="accordion-body">
								<div class="list-group list-group-flush">
									<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickInquiryDetail()">
										문의 사항
									</a>
									<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:alert('준비중입니다.')">
										리뷰 관리
									</a>
								</div>
							</div>
						</div>
					</div>
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-mobile-headingFour">
							<button class="accordion-button accordion-button-single collapsed" type="button" onclick="javascript:clickEstimateStorageDetail()">
								견적 저장소
							</button>
						</h2>
					</div>
					<div class="accordion-item">
						<h2 class="accordion-header" id="flush-mobile-headingFive">
							<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-mobile-collapseFive" aria-expanded="false">
								회원 정보
							</button>
						</h2>
						<div id="flush-mobile-collapseFive" class="accordion-collapse collapse" aria-labelledby="flush-headingFive" data-bs-parent="#accordionFlushMobile">
							<div class="accordion-body">
								<div class="list-group list-group-flush">
									<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickUserInfoDetail()">
										내 정보
									</a>
									<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickSecessionDetail()">
										회원 탈퇴
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end mypage-empty-space"></div>
		</div>
		
		<!-- 2022.11.16 디자인이미지 추가 -->
		<div class="mt-5 mx-5 mypage-bt-imgs" style="height: 15%!important;">
			<img class="img-fluid float-end" src="/resources/img/layer-34-1200x107.png" alt="">
		</div>
		<div class="mt-2 mx-5 mypage-bt-imgs" style="height: 15%!important;">
			<img class="img-fluid" src="/resources/img/layer-26.png" alt="">
		</div>
	</div>

	<input type="hidden" id="di" name="di" value="" />
	<form name="form_chk" id="form_chk">
		<input type="hidden" id="m" name="m" value="service" />
		<input type="hidden" id="token_version_id" name="token_version_id" value="<%=token_version_id%>" />
		<input type="hidden" id="enc_data" name="enc_data" value="<%=enc_data%>" />
		<input type="hidden" id="integrity_value" name="integrity_value" value="<%=integrity_value%>" />
  </form>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
</body>
</html>