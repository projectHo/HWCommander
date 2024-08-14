<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.File" %>
<head>
<title>HWCommander - 마이페이지</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<link rel="stylesheet" href="/resources/css/ver_02/myPage.css">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>


<!-- daum map api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function() {

	})
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

	function estimateStorageBtn(){
		if(loginCheck()){
			location.href = "/user/estimateStorage.do?id=${loginUser.id}";
		}
	}

	function clickMenus(el){
		let select = $(el).attr("menu");
		if(select == "delivery-addr-detail" || select == "company-addr-detail"){
			alert("준비중입니다");
		}else if(select == "requests" || select == "reviews"){
			alert("준비중입니다");
		}else {
			$(".accordion-body h6").removeClass("active");
			$(el).addClass("active");
	
			$(".description-boxs").addClass("fade");
			setTimeout(() => {
				$(".description-boxs").addClass("d-none");
				$("." + select).removeClass("d-none");
				setTimeout(() => {
					$("." + select).removeClass("fade");
				}, 50);
			}, 100);
		}
	}

	function checkInfos(){
		var form = $("#myInfoCheckForm").serialize();
		$.ajax({
			type: "post",
			url: "/user/idAndPwCheck.do",
			data: form,
			async: false,
			dataType: "json",
			success: function(response) {
				if (response === true) {
					$(".my-info-check-before").removeClass("show").addClass("d-none");
					$(".my-info-check-after").removeClass("d-none").removeClass("fade");
					setTimeout(() => {
						$(".my-info-check-after").addClass("show");
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
	function comnOnKeyUp() {
		if (window.event.keyCode == 13) {
			checkInfos();
		}
	}
	function secession(){
		$.ajax({
			type: "post",
			url: "/user/tempDeleteAccountLogic.do",
			data: {
				id: $("#secessionCheckId").val()
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
	function orderDetailPage(el){
		if($(el).attr("orderCd") > 6 && $(el).attr("orderCd") < 8){
			alert("상태가 배송단계로 넘어갔을 경우 배송지 변경은 불가합니다!");
		}
		location.href = "/user/orderListDetail.do?id=" + encodeURIComponent($(el).attr("orderId"));
	}
	function refundList(el){
		if(loginCheck()) {
			location.href = "/user/refundInfo.do?id=" + $(el).attr("item-id");
		}
	}

	function findDaumAddr() {
		new daum.Postcode({
			oncomplete: function(data) {
				$(".my-info-zip-code").val(data.zonecode).removeClass("w-75");
				$(".my-info-jibun-addr").val(data.jibunAddress);
				$(".my-info-road-addr").val(data.roadAddress);
				$(".my-info-detail-addr").val("").attr("disabled",false).focus();

				
				$(".my-info-zip-code").next("button").addClass("d-none");
				$(".my-info-detail-addr").addClass("w-75")
				$(".my-info-detail-addr").next("button").removeClass("d-none");
			}
		}).open();
	}

	function secessionBtn(){
		$.ajax({
			type: "post",
			url: "/user/tempDeleteAccountLogic.do",
			data: {
				id: $("#secessionCheckId").val()
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

	function secessionMoalOpen(){
		if($("#secessionCheckId").val() == "${loginUser.id}"){
			$("#secessionModal").modal("show");
		}else{
			alert("아이디를 정확히 입력해주세요");
		}
	}

	function editBtn(el){
		if(loginCheck()){
			if($(el).html() == "수정"){
				$(el).prev("input").attr("disabled",false);
				$(el).addClass("d-none");
				$(el).next("button").removeClass("d-none");
			}else {
				if($(el).attr("data") == "address"){
					if($(".my-info-detail-addr").val() === ""){
						alert("상세 주소를 입력해주세요!");
						$(".my-info-detail-addr").focus();
					}else{
						if(confirm("주소를 다시한번 확인해주세요!\n\n" + "지번주소 : " + $(".my-info-jibun-addr").val() + "\n도로명 주소 : " + $(".my-info-road-addr").val() + "\n상세주소 : " + $(".my-info-detail-addr").val() + "\n\n이대로 저장할까요?")){
							$.ajax({
								type: "post",
								url: "/user/userInfoUpdateLogic.do",
								data: {
									id: "${loginUser.id}",
									pw: "${loginUser.pw}",
									sexCd: "${loginUser.sexCd}",
									name: "${loginUser.name}",
									birth: "${loginUser.birth}",
									hpNumber: "${loginUser.hpNumber}",
									jibunAddr: $(".my-info-jibun-addr").val(),
									roadAddr: $(".my-info-road-addr").val(),
									detailAddr: $(".my-info-detail-addr").val(),
									zipcode: $(".my-info-zip-code").val(),
									mail: "${loginUser.mail}",
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
				}

				if($(el).attr("data") == "email"){
					if($('.my-info-mail').val().trim() == "" || $('.my-info-mail').val().trim() == null) {
						alert("이메일을 입력하세요.");
						$('.my-info-mail').focus();
						return false;
					}
					
					const mailCheckRegExp = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");

					if (!mailCheckRegExp.test($('.my-info-mail').val())) {
						alert("올바른 이메일 형식을 입력해주세요");
						$('.my-info-mail').focus();
						return false;
					}

					if("${loginUser.mail}" == $(".my-info-mail").val()){
						alert("변경된 내용이 없습니다. 다시 확인해주세요");
						return false;
					}

					if(confirm("확인을 누르시면 로그아웃되며 이메일 인증 전 로그인 불가능합니다.\n\n이메일 주소 : " + $(".my-info-mail").val() + "\n\n위 주소로 인증메일을 발송 하시겠습니까?")){
						$.ajax({
							type: "post",
							url: "/user/userMailInfoUpdateLogic.do",
							data: {
								id: "${loginUser.id}",
								pw: "${loginUser.pw}",
								sexCd: "${loginUser.sexCd}",
								name: "${loginUser.name}",
								birth: "${loginUser.birth}",
								hpNumber: "${loginUser.hpNumber}",
								jibunAddr: "${loginUser.jibunAddr}",
								roadAddr: "${loginUser.roadAddr}",
								detailAddr: "${loginUser.detailAddr}",
								zipcode: "${loginUser.zipcode}",
								mail: $(".my-info-mail").val(),
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

				if($(el).attr("data") == "hpNumber"){
					alert("준비중");
					// if($(".my-info-detail-addr").val() === ""){
					// 	alert("상세 주소를 입력해주세요!");
					// 	$(".my-info-detail-addr").focus();
					// }else{
					// 	if(confirm("주소를 다시한번 확인해주세요!\n\n" + "지번주소 : " + $(".my-info-jibun-addr").val() + "\n도로명 주소 : " + $(".my-info-road-addr").val() + "\n상세주소 : " + $(".my-info-detail-addr").val() + "\n\n이대로 저장할까요?")){
					// 		$.ajax({
					// 			type: "post",
					// 			url: "/user/userInfoUpdateLogic.do",
					// 			data: {
					// 				id: "${loginUser.id}",
					// 				pw: "${loginUser.pw}",
					// 				sexCd: "${loginUser.sexCd}",
					// 				name: "${loginUser.name}",
					// 				birth: "${loginUser.birth}",
					// 				hpNumber: "${loginUser.hpNumber}",
					// 				jibunAddr: $(".my-info-jibun-addr").val(),
					// 				roadAddr: $(".my-info-road-addr").val(),
					// 				detailAddr: $(".my-info-detail-addr").val(),
					// 				zipcode: $(".my-info-zip-code").val(),
					// 				mail: "${loginUser.mail}",
					// 				mailKey: "${loginUser.mailKey}",
					// 				mailConfirm: "${loginUser.mailConfirm}",
					// 				regDtm: "${loginUser.regDtm}",
					// 				updtDtm: "${loginUser.updtDtm}",
					// 				di: "${loginUser.di}",
					// 			},
					// 			dataType: "json",
					// 			success: function(response) {
					// 				alert("정상적으로 수정되었습니다! 수정된 내용이 보이지 않으시면 재 로그인 해주세요!");
					// 				location.reload();				
					// 			},
					// 			error: function(xhr, status, error) {
					// 				alert("통신에 실패했습니다. 다시 시도해주세요.");
					// 				location.reload();
					// 			}
					// 		});
					// 	}else {
					// 		return false;
					// 	}
					// }
				}

				if($(el).attr("data") == "deliveryReq"){
					if($(el).prev().prev("input").val() === ""){
						if(confirm("요청내용을 삭제할까요?")){
							$.ajax({
								type: "post",
								url: "/user/orderUpdateDeliveryRequest.do",
								data: {
									id: "${orderMasterVO.id}",
									deliveryRequest: $(el).prev().prev("input").val()
								},
								dataType: "json",
								success: function(response) {
									alert("정상적으로 삭제되었습니다!");
									location.reload();
								},
								error: function(xhr, status, error) {
									alert("수정에 실패했습니다.. 다시 입력해주세요!");
								}
							});
						}else {
							return false;
						}
					}else {
						if(confirm("작성내용 : " + $(el).prev().prev("input").val() + "\n\n이대로 저장 하시겠습니까?")){
							$.ajax({
								type: "post",
								url: "/user/orderUpdateDeliveryRequest.do",
								data: {
									id: "${orderMasterVO.id}",
									deliveryRequest: $(el).prev().prev("input").val()
								},
								dataType: "json",
								success: function(response) {
									alert("정상적으로 수정됐습니다!");
									location.reload();
								},
								error: function(xhr, status, error) {
									alert("수정에 실패했습니다.. 다시 입력해주세요!");
								}
							});
						}
					}
				}
			}
		}
	}
</script>
</head>
<body>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	
	<div class="my-page-container py-5 w-100">
		<div class="container mb-5">
			<div class="my-page-box">
				<h1 class="fw-bold text-white text-center my-page-head-text pb-5 mb-0">마이페이지</h1>
				<div class="d-flex">
					<div class="d-flex flex-column gap-3 p-3 w-25 my-page-left-side">
						<div class="accordion d-flex flex-column gap-3" id="accordionExample">
							<div class="accordion-item">
							  <h2 class="accordion-header">
								<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
								  <h5 class="fw-bold m-0">구매정보</h5>
								</button>
							  </h2>
							  <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
								<div class="accordion-body d-flex flex-column gap-2 px-4">
								  <h6 class="m-0 active" menu="order-detail" onclick="javascript:clickMenus(this)"><a class="text-semibold text-decoration-none text-white">주문 현황</a></h6>
								  <h6 class="m-0" menu="refund-detail" onclick="javascript:clickMenus(this)"><a class="text-semibold text-decoration-none text-white">환불 내역</a></h6>
								  <h6 class="m-0" menu="delivery-addr-detail" onclick="javascript:clickMenus(this)"><a class="text-semibold text-decoration-none text-white">배송지 관리</a></h6>
								  <h6 class="m-0" menu="company-addr-detail" onclick="javascript:clickMenus(this)"><a class="text-semibold text-decoration-none text-white">사업장 관리</a></h6>
								</div>
							  </div>
							</div>
							<div class="accordion-item">
							  <h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
									<h5 class="fw-bold m-0">내 글 관리</h5>
								</button>
							  </h2>
							  <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
								<div class="accordion-body d-flex flex-column gap-2 px-4">
									<h6 class="m-0" menu="requests" onclick="javascript:clickMenus(this)"><a class="text-semibold text-decoration-none text-white">문의사항</a></h6>
									<h6 class="m-0" menu="reviews" onclick="javascript:clickMenus(this)"><a class="text-semibold text-decoration-none text-white">리뷰 관리</a></h6>
								</div>
							  </div>
							</div>
							<div class="accordion-item">
							  <h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
									<h5 class="fw-bold m-0">회원정보</h5>
								</button>
							  </h2>
							  <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent=      "#accordionExample">
								<div class="accordion-body d-flex flex-column gap-2 px-4">
									<h6 class="m-0" menu="my-info" onclick="javascript:clickMenus(this)"><a class="text-semibold text-decoration-none text-white">내 정보</a></h6>
									<h6 class="m-0" menu="secession" onclick="javascript:clickMenus(this)"><a class="text-semibold text-decoration-none text-white">회원 탈퇴</a></h6>
								</div>
							  </div>
							</div>
							<div class="accordion-item">
							  <h2 class="accordion-header">
								<button class="accordion-button collapsed no-arrow" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour" onclick="javascript:estimateStorageBtn()">
									<h5 class="fw-bold m-0">견적저장소</h5>
								</button>
							  </h2>
							  <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
								
							  </div>
							</div>
						</div>
					</div>
					<div class="d-flex flex-column gap-3 p-3 flex-grow-1 description-boxs order-detail">
						<c:set var="length" value="${fn:length(orderMasterVOList)}" />
						<c:forEach var="item" items="${orderMasterVOList}">
							<c:choose>
								<c:when test="${item.orderStateCd < 09 || item.orderStateCd == 11}">
									<div class="order-detail-items d-flex justify-content-between align-items-center text-white" orderCd="${item.orderStateCd}" orderId="${item.id}" onclick="javascript:orderDetailPage(this)">
										<div class="d-flex flex-column gap-2 p-4">
											<h4 class="fw-bold m-0">${item.orderName}</h4>
											<h6 class="m-0">옵션 : 박스 추가 1개 &nbsp;| &nbsp;5000원</h6>
											<h6 class="m-0">결제 금액 : ${item.totOrderPriceStr}</h6>
											<h6 class="m-0 mt-1 mb-2 text-primary">${item.orderStateCdNm}</h6>
											<h6 class="m-0 text-secondary">${item.orderDateStr} 주문 &nbsp;| &nbsp;${item.id}</h6>
										</div>
										<h6 class="m-0 me-3"><a class="text-decoration-none text-secondary"></a>자세히보기 ></h6>
									</div>
									<div class="order-detail-divider my-1"></div>
								</c:when>
							</c:choose>
						</c:forEach>
					</div>
					<div class="d-flex flex-column gap-3 p-3 flex-grow-1 description-boxs refund-detail fade d-none">
						<c:forEach var="item" items="${refundInfoVOList}">
							<c:forEach var="orderItem" items="${orderMasterVOList}">
								<c:if test="${orderItem.id == item.orderId}">
									<div class="order-detail-items d-flex justify-content-between align-items-center text-white" onclick="javascript:refundList(this)" item-id="${item.id}">
										<div class="d-flex flex-column gap-2 p-4">
											<h4 class="fw-bold m-0">${orderItem.orderName}</h4>
											<h6 class="m-0">옵션 : 박스 추가 1개 &nbsp;| &nbsp;5000원</h6>
											<h6 class="m-0">환불요청 금액 : ${item.requestRefundPriceStr}</h6>
											<h6 class="m-0 mt-1 mb-2 text-primary">${item.refundStateCdNm}</h6>
											<h6 class="m-0 text-secondary">${orderItem.orderDateStr} 환불요청 &nbsp;| &nbsp;${item.orderId}</h6>
										</div>
										<h6 class="m-0 me-3"><a class="text-decoration-none text-secondary"></a>자세히보기 ></h6>
									</div>
									<div class="order-detail-divider my-1"></div>
								</c:if>
							</c:forEach>
						</c:forEach>
					</div>
					<div class="d-flex flex-column gap-3 p-3 flex-grow-1 description-boxs delivery-addr-detail fade d-none">
						<button type="button" class="btn btn-lg text-white">배송지관리</button>
						<button type="button" class="btn btn-lg text-white">배송지관리</button>
						<button type="button" class="btn btn-lg text-white">배송지관리</button>
						<button type="button" class="btn btn-lg text-white">배송지관리</button>
						<button type="button" class="btn btn-lg text-white">배송지관리</button>
					</div>
					<div class="d-flex flex-column gap-3 p-3 flex-grow-1 description-boxs company-addr-detail fade d-none">
						<button type="button" class="btn btn-lg text-white">사업장관리</button>
						<button type="button" class="btn btn-lg text-white">사업장관리</button>
						<button type="button" class="btn btn-lg text-white">사업장관리</button>
						<button type="button" class="btn btn-lg text-white">사업장관리</button>
						<button type="button" class="btn btn-lg text-white">사업장관리</button>
					</div>

					<div class="d-flex flex-column gap-3 p-3 px-4 flex-grow-1 description-boxs my-info fade d-none">
						<form id="myInfoCheckForm">
							<div class="d-flex flex-column gap-3 my-info-check-before fade show" >
								<h5 class="m-0 text-white fw-bold">내 정보</h5>
								<h6 class="m-0 text-white">소중한 개인정보를 위해 아이디와 비밀번호를 확인해주세요</h6>
								<div class="d-flex flex-column gap-2">
									<h6 class="text-white">아이디</h6>
									<input type="text" id="myInfoCheckId" name="id" placeholder="아이디를 입력해주세요" class="form-control p-3" autocomplete="off" onkeyup="javascript:comnOnKeyUp()">
								</div>
								<div class="d-flex flex-column gap-2">
									<h6 class="text-white">비밀번호</h6>
									<input type="password" id="myInfoCheckPw" name="pw" placeholder="비밀번호를 입력해주세요" class="form-control p-3" onkeyup="javascript:comnOnKeyUp()">
								</div>
								<button type="button" class="btn btn-lg btn-secondary w-100 fw-bold py-3 mb-2" onclick="javascript:checkInfos()">회원확인</button>
							</div>
						</form>
						<div class="d-flex flex-column gap-3 my-info-check-after fade d-none">
							<div class="d-flex justify-content-between align-items-center gap-3">
								<h5 class="fw-bold">이름</h5>
								<div class="my-info-check-after-input-boxs flex-grow-1">
									<div class="position-relative">
										<input type="text" class="my-info-after-inputs text-white form-control p-3 border-secondary" placeholder="" value="${loginUser.name}" disabled>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-between align-items-center gap-3">
								<h5 class="fw-bold">생년월일</h5>
								<div class="my-info-check-after-input-boxs flex-grow-1">
									<div class="position-relative">
										<input type="text" class="my-info-after-inputs text-white form-control p-3 border-secondary" placeholder="" value="${loginUser.birth}" disabled>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-between align-items-center gap-3">
								<h5 class="fw-bold">휴대폰 번호</h5>
								<div class="my-info-check-after-input-boxs flex-grow-1">
									<div class="position-relative d-flex gap-3 align-items-center h-100">
										<!-- 본인인증 가능할 떄 script 수정 -->
										<input type="text" class="my-info-after-inputs text-white form-control p-3 border-secondary w-75" placeholder="" value="${loginUser.hpNumber}" disabled>
										<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1" onclick="javascript:alert('준비중입니다... 고객센터로 문의해주세요')">수정</button>
										<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1 d-none" onclick="javascript:editBtn(this)" data="hpNumber">저장</button>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-between align-items-center gap-3">
								<h5 class="fw-bold">이메일</h5>
								<div class="my-info-check-after-input-boxs flex-grow-1">
									<div class="position-relative d-flex gap-3 align-items-center h-100">
										<input type="text" class="my-info-after-inputs text-white form-control p-3 border-secondary w-75 my-info-mail" placeholder="" value="${loginUser.mail}" disabled>
										<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1" onclick="javascript:editBtn(this)">수정</button>
										<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1 d-none" onclick="javascript:editBtn(this)" data="email">저장</button>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-between align-items-center gap-3">
								<h5 class="fw-bold">주소</h5>
								<div class="my-info-check-after-input-boxs flex-grow-1">
									<div class="position-relative d-flex gap-3 align-items-center h-100">
										<input type="text" class="my-info-after-inputs text-white form-control p-3 border-secondary w-75 my-info-zip-code" placeholder="" value="${loginUser.zipcode}" disabled>
										<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1" onclick="javascript:findDaumAddr()">수정</button>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-between align-items-center gap-3">
								<h5 class="fw-bold">지번 주소</h5>
								<div class="my-info-check-after-input-boxs flex-grow-1">
									<div class="position-relative">
										<input type="text" class="my-info-after-inputs text-white form-control p-3 border-secondary my-info-jibun-addr" placeholder="" value="${loginUser.jibunAddr}" disabled>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-between align-items-center gap-3">
								<h5 class="fw-bold">도로명 주소</h5>
								<div class="my-info-check-after-input-boxs flex-grow-1">
									<div class="position-relative">
										<input type="text" class="my-info-after-inputs text-white form-control p-3 border-secondary my-info-road-addr" placeholder="" value="${loginUser.roadAddr}" disabled>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-between align-items-center gap-3">
								<h5 class="fw-bold">상세 주소</h5>
								<div class="my-info-check-after-input-boxs flex-grow-1">
									<div class="position-relative d-flex gap-3 h-100 align-items-center">
										<input type="text" class="my-info-after-inputs text-white form-control p-3 border-secondary my-info-detail-addr" placeholder="" value="${loginUser.detailAddr}" disabled>
										<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1 d-none" onclick="javascript:editBtn(this)" data="address">저장</button>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-between align-items-center gap-3">
								<h5 class="fw-bold">가입일</h5>
								<div class="my-info-check-after-input-boxs flex-grow-1">
									<div class="position-relative">
										<input type="text" class="my-info-after-inputs text-white form-control p-3 border-secondary" placeholder="" value="${loginUser.regDtm}" disabled>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="p-3 px-4 flex-grow-1 description-boxs secession fade d-none">
						<div class="secession-container d-flex flex-column gap-3">
							<h5 class="fw-bold text-white m-0">회원탈퇴</h5>
							<h6 class="fw-bold text-danger m-0">* 회원 탈퇴시 개인정보는 개인정보 보호법에 따라 1년간 보관된 후 삭제됩니다.</h6>
							<input type="text" id="secessionCheckId" placeholder="아이디를 입력해주세요" class="form-control p-3" autocomplete="off">
							<button type="button" class="btn btn-lg btn-secondary fw-bold py-3 mb-2 w-100" onclick="javascript:secessionMoalOpen()">회원 탈퇴</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	

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
</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>