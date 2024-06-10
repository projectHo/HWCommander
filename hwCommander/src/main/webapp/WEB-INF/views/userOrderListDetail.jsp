<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


<html>
<head>
<title>현우의 컴퓨터 공방 - 주문내역</title>
<!-- Required meta tags -->
<meta charset="UTF-8">

<link rel="stylesheet" href="/resources/css/ver_02/orderListDetail.css">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<!-- 23.07.15 다음 카카오 map api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

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

	let refundReasonUserWrite = "";
	$(function(){
		// str 대체
		let boxPrice = "${orderDetailVOList[0].boxTotPrice}";
		let ordererHpNumber = "${orderMasterVO.recipientHpNumber}";
		let ordererHpNumber2 = "${orderMasterVO.recipientHpNumber2}";
		$(".box-price-tag").html(boxPrice.replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원");
		$(".recipient-hp-number").val(ordererHpNumber.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3"));
		$(".recipient-hp-number-2").val(ordererHpNumber2.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3"));
	})

	function findDaumAddr() {
		new daum.Postcode({
			oncomplete: function(data) {
				$(".recipient-zip-code").val(data.zonecode).removeClass("w-75");
				$(".recipient-jibun-addr").val(data.jibunAddress);
				$(".recipient-road-addr").val(data.roadAddress);
				$(".recipient-detail-addr").val("").attr("disabled",false).focus();

				
				$(".recipient-zip-code").next("button").addClass("d-none");
				$(".recipient-detail-addr").next("button").addClass("d-none");
				$(".recipient-detail-addr").next().next("button").removeClass("d-none");
			}
		}).open();
	}

	function saveBtn(el){
		$(el).addClass("d-none");
		$(el).prev("button").removeClass("d-none");
		$(el).prev().prev("input").attr("disabled",true);
	}

	function textCount(el){
		if($(el).val().length > 50){
			alert("50자 이내로 입력 해주세요!");
			$(el).val($(el).val().substring(0, 50));
		}
	}

	function showListBtn(){
		if(loginCheck()){
			location.href = "/user/myPage.do";
		}
	}

	function writeReviewBtn(){
		if(loginCheck()){
			location.href = "/만들면 넣자";
		}
	}

	function refundReasonDropdownBtn(el){
		$(".refund-reason-title").html($(el).html());
		if($(el).attr("cd") == "99"){
			$(".refund-user-write").addClass("show")
			$("#refundReasonText").attr("disabled",false);
		}else {
			$(".refund-user-write").removeClass("show")
			$("#refundReasonText").attr("disabled",true);
		}
		return refundCd = $(el).attr("cd");
	}
	function refundReasonUserWriteText(el){
		if($(el).val().length > 200){
            $(el).val($(el).val().substring(0, 200));
			alert("200자 이내로 입력해주세요");
		}
		return refundReasonUserWrite = String($(el).val());
	}

	function refundCount(el){
		if("${orderDetailVOList[0].boxQty}" != "0"){
			if(Number($(el).val()) > Number("${orderDetailVOList[0].productOrderQty}")){
				$(el).val("${orderDetailVOList[0].productOrderQty}").focus();
				$("#refundBoxCount").val("${orderDetailVOList[0].boxQty}");
			}
			if(Number($(el).val()) == Number("${orderDetailVOList[0].productOrderQty}")){
				$("#refundBoxCount").val("${orderDetailVOList[0].boxQty}");
			}
			if(Number("${orderDetailVOList[0].productOrderQty}") - Number($(el).val()) > Number("${orderDetailVOList[0].boxQty}")){
				let box = Number("${orderDetailVOList[0].boxQty}") - (Number("${orderDetailVOList[0].productOrderQty}") - Number($(el).val()));
				$("#refundBoxCount").val(String(box));
			}
		}else {
			$("#refundBoxCount").val("${orderDetailVOList[0].boxQty}");
		}
	}
	function refundBoxCount(el){
		if("${orderDetailVOList[0].boxQty}" != "0"){
			if(Number($(el).val()) > Number("${orderDetailVOList[0].boxQty}")){
				$(el).val("${orderDetailVOList[0].boxQty}").focus();
			}
			if(Number($("#refundCount").val()) == Number("${orderDetailVOList[0].productOrderQty}")){
				$(el).val("${orderDetailVOList[0].boxQty}");
			}
			if(Number("${orderDetailVOList[0].productOrderQty}") - Number($("#refundCount").val()) > Number("${orderDetailVOList[0].boxQty}")){
				let box = Number("${orderDetailVOList[0].boxQty}") - (Number("${orderDetailVOList[0].productOrderQty}") - Number($("#refundCount").val()));
				$("#refundBoxCount").val(String(box));
			}
		}else {
			$("#refundBoxCount").val("${orderDetailVOList[0].boxQty}");
		}
	}

	function cancleOrderBtn(){
		if(confirm("정말 취소 하시겠습니까?")){
			$.ajax({
				type: "post",
				url: "/order/orderDeleteLogic.do",
				data: {
					id: "${orderMasterVO.id}"
				},
				dataType: "json",
				success: function(response) {
					alert("정상적으로 삭제했습니다!");
					location.href = "/user/myPage.do";
				},
				error: function(xhr, status, error) {
					alert("삭제를 실패했습니다. 다시 시도해주세요");
					location.reload();
				}
			});
		}else {
			return false;
		}
	}

	function requestVideoBtn(){
		if(confirm("회원가입시 입력하신 이메일로 영상을 요청하시겠습니까?")){
			$.ajax({
				type: "post",
				url: "/user/orderVideoRequestToAdminLogic.do",
				data: {
					id: "${orderMasterVO.id}"
				},
				dataType: "json",
				success: function(response) {
					alert("정상적으로 요청했습니다! 회원가입시 입력해주신 이메일로 완료되는 순서대로 보내드릴게요!");
					location.reload();
				},
				error: function(xhr, status, error) {
					alert("요청에 실패했습니다.. 다시 입력해주세요!");
				}
			});
		}
	}

	function editBtn(el){
		if(loginCheck()){
			if($(el).html() == "수정"){
				$(el).prev("input").attr("disabled",false);
				$(el).addClass("d-none");
				$(el).next("button").removeClass("d-none");
			}else {
				if($(el).attr("data") == "recipientHpNumber2"){
					let ordererHpNumber2 = "${orderMasterVO.recipientHpNumber2}";
					if($(".recipient-hp-number-2").val() == ordererHpNumber2.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3")){
						alert("변동사항이 없습니다!");
						saveBtn(el);
					}else if($(".recipient-hp-number-2").val() === ""){
						if(confirm("추가 연락처를 삭제할까요?")){
							$.ajax({
								type: "post",
								url: "/user/orderUpdateRecipientHpNumber2Logic.do",
								data: {
									id: "${orderMasterVO.id}",
									recipientHpNumber2: $(".recipient-hp-number-2").val()
								},
								dataType: "json",
								success: function(response) {
									alert("정상적으로 삭제됐습니다!");
									location.reload();
								},
								error: function(xhr, status, error) {
									alert("수정에 실패했습니다.. 다시 입력해주세요!");
								}
							});
						}else {
							return false;
						}
					}else if($(".recipient-hp-number-2").val().length < 9 || $(".recipient-hp-number-2").val().length > 11 || !/^[0-9]*$/.test($(".recipient-hp-number-2").val())){
						alert("번호를 정확히 입력해주세요! ex) 01012345678");
						$(".recipient-hp-number-2").focus();
					}else {
						if(confirm("입력하신 번호 : " + $(".recipient-hp-number-2").val() + "\n이대로 저장 하시겠습니까?")){
							$.ajax({
								type: "post",
								url: "/user/orderUpdateRecipientHpNumber2Logic.do",
								data: {
									id: "${orderMasterVO.id}",
									recipientHpNumber2: $(".recipient-hp-number-2").val()
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

				if($(el).attr("data") == "recipientAddr"){
					if($(".recipient-detail-addr").val() === ""){
						alert("상세 주소를 입력해주세요!");
						$(".recipient-detail-addr").focus();
					}else{
						if(confirm("주소를 다시한번 확인해주세요!\n\n" + "지번주소 : " + $(".recipient-jibun-addr").val() + "\n도로명 주소 : " + $(".recipient-road-addr").val() + "\n상세주소 : " + $(".recipient-detail-addr").val() + "\n\n이대로 저장할까요?")){
							$.ajax({
								type: "post",
								url: "/user/orderUpdateAddrsLogic.do",
								data: {
									id: "${orderMasterVO.id}",
									recipientJibunAddr: $(".recipient-jibun-addr").val(),
									recipientRoadAddr: $(".recipient-road-addr").val(),
									recipientDetailAddr: $(".recipient-detail-addr").val(),
									recipientZipcode: $(".recipient-zip-code").val()
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

				if($(el).attr("data") == "orderReq"){
					if($(el).prev().prev("input").val() === ""){
						if(confirm("요청내용을 삭제할까요?")){
							$.ajax({
								type: "post",
								url: "/user/orderUpdateOrderRequest.do",
								data: {
									id: "${orderMasterVO.id}",
									orderRequest: $(el).prev().prev("input").val()
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
								url: "/user/orderUpdateOrderRequest.do",
								data: {
									id: "${orderMasterVO.id}",
									orderRequest: $(el).prev().prev("input").val()
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

	function requestRefundBtn(){
		if($("#refundCount").val() == ""){
			alert("환불 수량을 입력해주세요");
			return false;
		}
		if($("#refundBoxCount").val() == ""){
			alert("박스 수량을 입력해주세요");
			return false;
		}
		if(refundCd == null){
			alert("환불 사유를 선택해주세요");
			return false;
		}
		if($("#refundReason").parent().hasClass("show") && $("#refundReason").val() == ""){
			alert("환불 사유를 입력해주세요");
			return false;
		}
		
		var form = new FormData();
	
		if("${orderDetailVOList[0].productOrderQty}" == 1){
			let productPrice;
			let boxPrice;
			let requestRefundPrice;
			productPrice = "${orderDetailVOList[0].productPrice}";
			boxPrice = Number("${orderDetailVOList[0].boxQty}") * 5000;
			requestRefundPrice = Number(productPrice) + Number(boxPrice);
			var refundInfoVO = {
				orderId : "${orderDetailVOList[0].id}",
				orderSeq : "${orderDetailVOList[0].seq}",
				productId : "${orderDetailVOList[0].productId}",
				productPrice : "${orderDetailVOList[0].productPrice}",
				refundQty : 1,
				requestRefundPrice : requestRefundPrice,
				refundStateCd : "01",
				refundReasonCd : refundCd,
				refundReasonUserWrite : refundReasonUserWrite,
			};
			let orderStateCd = "09";

			form.append("refundInfoVO",JSON.stringify(refundInfoVO));
			form.append("orderStateCd",orderStateCd);

			if(confirm("환불 요청하시겠습니까?")){
				$.ajax({
					type: "post",
					url: "/user/refundInfoRegistLogic.do",
					data: form,
					processData: false,
        			contentType: false,
					success: function(response) {
						alert("정상적으로 요청했습니다!");
						location.href = "/user/myPage.do";
					},
					error: function(xhr, status, error) {
						alert("요청에 실패했습니다.. 다시 입력해주세요!");
						location.reload();
						console.log(error);
					}
				});
			}else {
				return false;
			}
		}
		if("${orderDetailVOList[0].productOrderQty}" > 1){
			let orderStateCd;
			let productPrice;
			let boxPrice;
			let totRefundPrice;
			if("${orderDetailVOList[0].productOrderQty}" == $("#refundCount").val()){
				orderStateCd = "09";
				productPrice = "${orderDetailVOList[0].productPrice}" * $("#refundCount").val();
				boxPrice = 5000 * $("#refundBoxCount").val();
				totRefundPrice = productPrice + boxPrice;
			}else {
				orderStateCd = "11";
				productPrice = "${orderDetailVOList[0].productPrice}" * $("#refundCount").val();
				boxPrice = 5000 * $("#refundBoxCount").val();
				totRefundPrice = productPrice + boxPrice;
			}
			totRefundPrice = String(totRefundPrice);
			var refundInfoVO = {
				orderId : "${orderDetailVOList[0].id}",
				orderSeq : "${orderDetailVOList[0].seq}",
				productId : "${orderDetailVOList[0].productId}",
				productPrice : "${orderDetailVOList[0].productPrice}",
				refundQty : $("#refundCount").val(),
				requestRefundPrice : totRefundPrice,
				refundStateCd : "01",
				refundReasonCd : refundCd,
				refundReasonUserWrite : refundReasonUserWrite,
			};
			

			form.append("refundInfoVO",JSON.stringify(refundInfoVO));
			form.append("orderStateCd",orderStateCd);

			if(confirm("환불 요청하시겠습니까?")){
				$.ajax({
					type: "post",
					url: "/user/refundInfoRegistLogic.do",
					data: form,
					processData: false,
        			contentType: false,
					success: function(response) {
						alert("정상적으로 요청했습니다!");
						location.href = "/user/myPage.do";
					},
					error: function(xhr, status, error) {
						alert("요청에 실패했습니다.. 다시 입력해주세요!");
						console.log(error);
					}
				});
			}else {
				return false;
			}
		}
	}
</script>

</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="order-detail-container w-100 py-5">
		<div class="container mb-5">
			<form id="order_detail_form">
				<div class="d-flex flex-column align-items-center justify-content-center gap-4">
					<h2 class="fw-bold text-white m-0">주문 상세</h2>
					<div class="d-flex gap-4 w-100">
						<div class="d-flex flex-column gap-4 w-100">
							<div class="order-detail-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 fw-bold">주문 상품</h4>
								<div class="d-flex align-items-start justify-content-between gap-5">
									<div class="d-flex flex-column py-2 gap-2 h-100">
										<h4 class="fw-bold text-white">${orderMasterVO.orderName}</h4>
										<h5 class="fw-semibold text-white">결제 금액 : ${orderMasterVO.totOrderPriceStr}원</h5>
										<c:if test="${orderMasterVO.waybillNumber != null}">
											<h5 class="fw-semibold text-white">운송장 번호 : ${orderMasterVO.waybillNumber}</h5>
										</c:if>
										<c:if test="${orderMasterVO.waybillNumber == null}">
											<h5 class="fw-semibold text-white">운송장 번호 : 발송 전</h5>
										</c:if>
									</div>
									<div class="d-flex gap-2">
										<button type="button" class="btn btn-secondary btn-sm px-3 d-none">배송현황</button>
										<c:if test="${orderMasterVO.orderStateCd > 1}">
											<button type="button" class="btn btn-danger btn-sm px-3" data-bs-toggle="modal" data-bs-target="#refundTermsModal">환불요청</button>
											<c:if test="${orderMasterVO.videoRequestCd != 2}">
												<c:if test="${orderMasterVO.videoRequestCd != 9}">
													<c:if test="${orderMasterVO.videoRequestCd != 10}">
														<button type="button" class="btn btn-primary btn-sm px-3" onclick="javascript:requestVideoBtn()">영상요청</button>
													</c:if>
												</c:if>
											</c:if>
										</c:if>
										<c:if test="${orderMasterVO.orderStateCd == 1}">
											<button type="button" class="btn btn-danger btn-sm px-3" onclick="javascript:cancleOrderBtn()">구매 취소</button>
										</c:if>
									</div>
								</div>
							</div>
							<div class="order-detail-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 mb-3 fw-bold">주문자 정보</h4>

								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">주문 날짜</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary" placeholder="주문 날짜" disabled autocomplete="off" value="${orderMasterVO.orderDateStr}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">주문 번호</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary" placeholder="주문 번호" disabled autocomplete="off" value="${orderMasterVO.id}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">결제 상태</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary" placeholder="결제 상태" disabled autocomplete="off" value="${orderMasterVO.orderStateCdNm}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3 d-none">
									<h6 class="fw-bold">추천인</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary w-75" placeholder="추천인" autocomplete="off">
											<button type="button" class="btn btn-secondary btn-lg h-100 flex-grow-1">확인</button>
										</div>
									</div>
								</div>
							</div>
							<div class="order-detail-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 mb-3 fw-bold">배송지 정보</h4>

								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">수령인</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary" placeholder="수령인 이름" value="${orderMasterVO.recipientName}" autocomplete="off" disabled>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">연락처</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary recipient-hp-number" placeholder="수령인 핸드폰 번호" autocomplete="off" disabled>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">추가 연락처</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary recipient-hp-number-2 w-75" placeholder="추가 핸드폰 번호( - 없이 입력해주세요)" autocomplete="off" disabled>
											<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1" onclick="javascript:editBtn(this)">수정</button>
											<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1 d-none" onclick="javascript:editBtn(this)" data="recipientHpNumber2">저장</button>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">우편번호</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary w-75 recipient-zip-code" placeholder="우편번호" disabled value="${orderMasterVO.recipientZipcode}" autocomplete="off">
											<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1" onclick="javascript:findDaumAddr()">수정</button>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">지번주소</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary recipient-jibun-addr" placeholder="지번주소" disabled value="${orderMasterVO.recipientJibunAddr}" autocomplete="off">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">도로명주소</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary recipient-road-addr" placeholder="도로명 주소" disabled value="${orderMasterVO.recipientRoadAddr}" autocomplete="off">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">상세주소</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary w-75 recipient-detail-addr" placeholder="상세 주소" autocomplete="off" disabled value="${orderMasterVO.recipientDetailAddr}">
											<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1" onclick="javascript:editBtn(this)">수정</button>
											<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1 d-none" onclick="javascript:editBtn(this)" data="recipientAddr">저장</button>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">주문 요청사항</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary w-75" placeholder="주문 요청사항(50자 이내로 입력해주세요)" value="${orderMasterVO.orderRequest}" autocomplete="off" disabled oninput="javascript:textCount(this)">
											<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1" onclick="javascript:editBtn(this)">수정</button>
											<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1 d-none" onclick="javascript:editBtn(this)" data="orderReq">저장</button>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">배송 요청사항</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary w-75" placeholder="배송 요청사항(50자 이내로 입력해주세요)" autocomplete="off" value="${orderMasterVO.deliveryRequest}" disabled oninput="javascript:textCount(this)">
											<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1" onclick="javascript:editBtn(this)">수정</button>
											<button type="button" class="btn btn-secondary btn-lg h-100 fw-bold flex-grow-1 d-none" onclick="javascript:editBtn(this)" data="deliveryReq">저장</button>
										</div>
									</div>
								</div>
							</div>
							<div class="order-detail-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 mb-3 fw-bold">결제 정보</h4>

								<div class="d-flex justify-content-between align-items-center gap-3 w-100">
									<h6 class="fw-bold flex-grow-1">상태</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary" placeholder="결제 상태" disabled autocomplete="off" value="${orderMasterVO.orderStateCdNm}">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3 w-100">
									<h6 class="fw-bold flex-grow-1">수단</h6>
									<div class="my-info-check-after-input-boxs w-75">
										<div class="position-relative">
											<c:if test="${orderMasterVO.paymentMethod == 'Card'}">
												<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary" placeholder="결제 수단" disabled autocomplete="off" value="카드">
											</c:if>
											<c:if test="${orderMasterVO.paymentMethod != 'Card'}">
												<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary" placeholder="결제 수단" disabled autocomplete="off" value="계좌이체">
											</c:if>
										</div>
									</div>
								</div>
								<c:if test="${orderMasterVO.paymentMethod != 'Card'}">
									<div class="d-flex justify-content-between align-items-center gap-3 w-100">
										<h6 class="fw-bold flex-grow-1">계좌번호</h6>
										<div class="my-info-check-after-input-boxs w-75">
											<div class="position-relative">
												<input type="text" class="order-detail-inputs text-white form-control p-3 border-secondary" placeholder="계좌 번호" disabled autocomplete="off" value="645-910900-07207 하나은행 이해창(현우의 컴퓨터 공방)">
											</div>
										</div>
									</div>
								</c:if>
							</div>
							<div class="d-flex gap-3 justify-content-center align-items-center my-5 pb-5 pt-3">
								<button type="button" class="btn btn-lg px-5 fs-6 fw-bold btn-light" onclick="javascript:showListBtn()">목록 보기</button>
								<button type="button" class="btn btn-lg px-5 fs-6 fw-bold btn-primary d-none" onclick="javascript:writeReviewBtn()">리뷰 작성</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- 환불 모달 -->
	<div class="modal fade" tabindex="-1" data-bs-backdrop="static" aria-hidden="true" data-bs-keyboard="false" id="refundTermsModal">
		<div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-body p-5 text-center">
					<p>Modal body text goes here.</p>
					<p>Modal body text goes here.</p>
					<p>Modal body text goes here.</p>
					<p>Modal body text goes here.</p>
					<p>Modal body text goes here.</p>
					<p>Modal body text goes here.</p>
					<p>Modal body text goes here.</p>
					<div class="d-flex gap-3 justify-content-center mt-4">
						<button type="button" class="btn fw-bold btn-light px-5 border-1 border-black" data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn fw-bold btn-dark px-5" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#refundReasonModal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" tabindex="-1" data-bs-backdrop="static" aria-hidden="true" data-bs-keyboard="false" id="refundReasonModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-body p-5 text-center">
					<div class="dropdown mb-3">
						<h5 class="m-0 mb-2 fw-bold">환불 사유 선택</h5>
						<button class="btn btn-outline-dark dropdown-toggle w-100 d-flex justify-content-center align-items-center gap-3 mb-3 refund-reason-title" type="button" data-bs-toggle="dropdown" aria-expanded="false">
							환불 사유
						</button>
						<ul class="dropdown-menu w-100">
							<li><a class="dropdown-item" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">단순변심</a></li>
							<li><a class="dropdown-item" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">개봉시 파손</a></li>
							<li><a class="dropdown-item" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">사용 중 문제 발생</a></li>
							<li><a class="dropdown-item" cd="02" onclick="javascript:refundReasonDropdownBtn(this)">오배송</a></li>
							<li><a class="dropdown-item" cd="02" onclick="javascript:refundReasonDropdownBtn(this)">구성품 누락</a></li>
							<li><a class="dropdown-item" cd="03" onclick="javascript:refundReasonDropdownBtn(this)">도착 시 파손</a></li>
							<li><a class="dropdown-item" cd="99" onclick="javascript:refundReasonDropdownBtn(this)">기타</a></li>
						</ul>
						<c:if test="${orderDetailVOList[0].productOrderQty > 1}">
							<div class="d-flex gap-3">
								<div class="flex-1 mb-3">
									<div class="form-floating">
										<input type="text" class="form-control" id="refundCount" autocomplete="off" oninput="javascript:refundCount(this)">
										<label for="refundCount">환불 수량(최대 ${orderDetailVOList[0].productOrderQty}개)</label>
									</div>
								</div>
								<div class="flex-1 mb-3">
									<div class="form-floating">
										<input type="text" class="form-control" id="refundBoxCount" autocomplete="off" oninput="javascript:refundBoxCount(this)">
										<label for="refundBoxCount">박스 수량(최대 ${orderDetailVOList[0].boxQty}개)</label>
									</div>
								</div>
							</div>
						</c:if>
						<div class="form-floating mb-3 refund-user-write fade">
							<input type="text" class="form-control" id="refundReasonText" placeholder="50자 이내로 입력해주세요" autocomplete="off" oninput="javascript:refundReasonUserWriteText(this)" disabled>
							<label for="refundReasonText">상세 사유</label>
						</div>
					</div>
					<div class="d-flex gap-3 justify-content-center mt-4 w-100">
						<button type="button" class="btn fw-bold btn-light px-5 border-1 border-black flex-1" data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn fw-bold btn-danger px-5 flex-1" onclick="javascript:requestRefundBtn()">환불 요청</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="./common/footer.jsp" %>
</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>
