<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


<html>
<head>
<title>현우의 컴퓨터 공방 - 환불내역</title>
<!-- Required meta tags -->
<meta charset="UTF-8">

<link rel="stylesheet" href="/resources/css/ver_02/refundInfo.css">
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
    let refundReasonUserWrite;
    let refundReasonCd;
    let a = "${refundInfoVO}";
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

    function cancleRefundBtn(){
        if(confirm("환불요청을 취소하시겠습니까?")){
            $.ajax({
                type: "post",
                url: "/user/refundDeleteLogic.do",
                data: {
                    id: "${refundInfoVO.id}",
                    orderId: "${orderMasterVO.id}"
                },
                dataType: "json",
                success: function(response) {
                    alert("정상적으로 취소되었습니다!");
                    if(loginCheck()) {
                        location.href ="/user/myPage.do";
                    }
                },
                error: function(xhr, status, error) {
                    alert("요청 실패했습니다.. 다시 시도해주세요!");
                    console.log(error);
                    location.reload();
                }
            });
        }else {
            return false;
        }
    }

    function showListBtn(){
		if(loginCheck()){
			location.href = "/user/myPage.do";
		}
	}

    function changeRefundReason(el){
        if(refundReasonCd == "99" && refundReasonUserWrite == ""){
            alert("상세사유를 입력해주세요");
            return false;
        }else {
            if(confirm("수정하시겠습니까?")){
                $.ajax({
                    type: "post",
                    url: "/user/updateRefundReasonCdAndUserWrite.do",
                    data: {
                        id: "${refundInfoVO.id}",
                        refundReasonCd: refundReasonCd,
                        refundReasonUserWrite: refundReasonUserWrite,
                    },
                    dataType: "json",
                    success: function() {
                        alert("수정 완료되었습니다.");
                        if(loginCheck()) {
                            location.reload();
                        }
                    },
                    error: function() {
                        alert("수정 실패했습니다.. 다시 시도해주세요!");
                        location.reload();
                    }
                });
            }else {
                return false;
            }
        }
    }
    function refundReasonDropdownBtn(el){
		$(".refund-reason-title").html($(el).html());
		if($(el).attr("cd") == "99"){
			$(".refund-user-write").addClass("show")
			$("#refundReasonText").attr("disabled",false);

            refundReasonUserWrite = String($("#refundReasonText").val());
		}else {
            $(".refund-user-write").removeClass("show")
			$("#refundReasonText").attr("disabled",true);

            refundReasonUserWrite = "";
		}
		refundReasonCd = $(el).attr("cd");
	}
    function refundReasonUserWriteText(el){
		if($(el).val().length > 200){
            $(el).val($(el).val().substring(0, 200));
			alert("200자 이내로 입력해주세요");
		}
		refundReasonUserWrite = String($(el).val());
	}

    function disAgreeTerms(){
        let refundPartialAgreeCd = "03";
        if(confirm("부분 환불에 동의하지 않으시면 추가심사가 필요합니다.")){
            $.ajax({
                type: "post",
                url: "/user/updateRefundPartialAgreeCd.do",
                data: {
                    id: "${refundInfoVO.id}",
                    refundPartialAgreeCd: refundPartialAgreeCd
                },
                dataType: "json",
                success: function() {
                    alert("처리가 완료되었습니다.");
                    if(loginCheck()) {
                        location.reload();
                    }
                },
                error: function() {
                    alert("요청 실패했습니다.. 다시 시도해주세요!");
                    location.reload();
                }
            });
        }else {
            return false;
        }
    }
    function agreeTerms(){
        let refundPartialAgreeCd = "02";
        if(confirm("동의하시면 안내드린 내용으로 환불 처리 됩니다!")){
            $.ajax({
                type: "post",
                url: "/user/updateRefundPartialAgreeCd.do",
                data: {
                    id: "${refundInfoVO.id}",
                    refundPartialAgreeCd: refundPartialAgreeCd
                },
                dataType: "json",
                success: function() {
                    alert("처리가 완료되었습니다.");
                    if(loginCheck()) {
                        location.reload();
                    }
                },
                error: function() {
                    alert("요청 실패했습니다.. 다시 시도해주세요!");
                    location.reload();
                }
            });
        }else {
            return false;
        }
    }

	$(function(){
        if("${refundInfoVO.requestRefundPrice}" != "${refundInfoVO.determinRefundPrice}" && Number("${refundInfoVO.refundStateCd}") == Number("02") && "${refundInfoVO.refundPartialAgreeCd}" == ""){
            $("#secondTermsModal").modal("show");
        }
	})

</script>

</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="refund-info-container w-100 py-5">
		<div class="container mb-5">
			<form id="refund_info_form">
				<div class="d-flex flex-column align-items-center justify-content-center gap-4">
					<h2 class="fw-bold text-white m-0">환불 상세</h2>
					<div class="d-flex gap-4 w-100">
						<div class="d-flex flex-column gap-4 w-100">
							<div class="refund-info-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 fw-bold">주문 상품</h4>
								<div class="d-flex align-items-start justify-content-between gap-5">
									<div class="d-flex flex-column py-2 gap-2 h-100">
										<h4 class="fw-bold text-white">${orderMasterVO.orderName}</h4>
										<h5 class="fw-semibold text-white">결제 금액 : ${orderMasterVO.totOrderPriceStr}원</h5>
										<h5 class="fw-semibold text-white">주문 번호 : ${orderMasterVO.id}</h5>
										<h5 class="fw-semibold text-white">주문 날짜 : ${orderMasterVO.orderDateStr}</h5>
									</div>
									<div class="d-flex gap-2">
                                        <c:if test="${refundInfoVO.refundStateCd == 1}">
                                            <button type="button" class="btn btn-secondary btn-sm px-3 fw-bold" onclick="javascript:cancleRefundBtn()">환불 취소</button>
                                        </c:if>
									</div>
								</div>
							</div>
							<div class="refund-info-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 mb-3 fw-bold">환불 정보</h4>

								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">환불 수량</h6>
									<div class="w-75">
										<div class="position-relative">
											<input type="text" class="refund-info-inputs text-white form-control p-3 border-secondary" placeholder="주문 날짜" disabled autocomplete="off" value="${refundInfoVO.refundQty}개">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
									<h6 class="fw-bold">환불 요청 금액</h6>
									<div class="w-75">
										<div class="position-relative">
											<input type="text" class="refund-info-inputs text-white form-control p-3 border-secondary" placeholder="주문 번호" disabled autocomplete="off" value="${refundInfoVO.requestRefundPriceStr}원">
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
                                    <h6 class="fw-bold">환불 사유</h6>
									<div class="w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
                                            <c:if test="${refundInfoVO.refundStateCd == 1}">
                                                <input type="text" class="refund-info-inputs text-white form-control p-3 border-secondary w-75" placeholder="환불 사유" disabled value="${refundInfoVO.refundReasonCdNm}" autocomplete="off">
                                                <button type="button" class="btn btn-secondary flex-grow-1 h-100" data-bs-toggle="modal" data-bs-target="#refundReasonModal">수정</button>
                                            </c:if>
                                            <c:if test="${refundInfoVO.refundStateCd != 1}">
                                                <input type="text" class="refund-info-inputs text-white form-control p-3 border-secondary w-100 fw-bold" placeholder="환불 사유" disabled value="${refundInfoVO.refundReasonCdNm}" autocomplete="off">
                                            </c:if>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-between align-items-center gap-3">
                                    <h6 class="fw-bold">환불 상세 사유</h6>
									<div class="w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="refund-info-inputs text-white form-control p-3 border-secondary" placeholder="환불 상세 사유" disabled value="${refundInfoVO.refundReasonUserWrite}" autocomplete="off">
										</div>
									</div>
								</div>
							</div>
							<div class="refund-info-boxs d-flex flex-column gap-3 text-white p-4 px-5">
								<h4 class="m-0 mb-3 fw-bold">환불 현황</h4>
                                
                                <div class="d-flex justify-content-between align-items-center gap-3">
                                    <h6 class="fw-bold">환불 결정금액</h6>
									<div class="w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="refund-info-inputs text-white form-control p-3 border-secondary" placeholder="환불 결정 금액" disabled value="${refundInfoVO.determinRefundPriceStr}" autocomplete="off">
										</div>
									</div>
								</div>
                                <div class="d-flex justify-content-between align-items-center gap-3">
                                    <h6 class="fw-bold">환불 상태</h6>
									<div class="w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<input type="text" class="refund-info-inputs text-white form-control p-3 border-secondary" placeholder="환불 상태" disabled value="${refundInfoVO.refundStateCdNm}" autocomplete="off">
										</div>
									</div>
								</div>
                                <div class="d-flex justify-content-between align-items-center gap-3">
                                    <h6 class="fw-bold">결제 방식</h6>
									<div class="w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
                                            <c:if test="${orderMasterVO.paymentMethod == 'Card'}">
                                                <input type="text" class="refund-info-inputs text-white form-control p-3 border-secondary" placeholder="결제 방식" disabled value="카드결제" autocomplete="off">
                                            </c:if>
                                            <c:if test="${orderMasterVO.paymentMethod == 'account-transfer'}">
                                                <input type="text" class="refund-info-inputs text-white form-control p-3 border-secondary" placeholder="결제 방식" disabled value="계좌이체" autocomplete="off">
                                            </c:if>
										</div>
									</div>
								</div>
                                <div class="d-flex justify-content-between gap-3">
                                    <h6 class="fw-bold">환불 내용</h6>
									<div class="w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<textarea type="text" class="refund-info-inputs text-white form-control p-3 border-secondary" placeholder="환불 내용" disabled value="${refundInfoVO.refundContentStr}" autocomplete="off">${refundInfoVO.refundContentStr}</textarea>
										</div>
									</div>
								</div>
                                <div class="d-flex justify-content-between gap-3">
                                    <h6 class="fw-bold">비고</h6>
									<div class="w-75">
										<div class="position-relative d-flex gap-3 align-items-center h-100">
											<textarea type="text" class="refund-info-inputs text-white form-control p-3 border-secondary" placeholder="비고" disabled value="${refundInfoVO.refundRemarksStr}" autocomplete="off">${refundInfoVO.refundRemarksStr}</textarea>
										</div>
									</div>
								</div>
							</div>
							<div class="d-flex gap-3 justify-content-center align-items-center my-5 pb-5 pt-3">
								<button type="button" class="btn btn-lg px-5 fs-6 fw-bold btn-light" onclick="javascript:showListBtn()">목록 보기</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- 환불 수정 모달 -->
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
						<div class="form-floating mb-3 refund-user-write fade">
							<input type="text" class="form-control" id="refundReasonText" placeholder="50자 이내로 입력해주세요" autocomplete="off" oninput="javascript:refundReasonUserWriteText(this)" disabled>
							<label for="refundReasonText">상세 사유</label>
						</div>
					</div>
					<div class="d-flex gap-3 justify-content-center mt-4 w-100">
						<button type="button" class="btn fw-bold btn-light px-5 border-1 border-black flex-1" data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn fw-bold btn-danger px-5 flex-1" onclick="javascript:changeRefundReason()">수정</button>
					</div>
				</div>
			</div>
		</div>
	</div>

    <!-- 2차동의 모달 -->
    <div class="modal fade" id="secondTermsModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-body">
                    <h3 class="m-0 mb-3 fw-bold">환불심사 결과 동의서</h3>
                    <div class="m-0">
                        ${refundInfoVO.refundPartialAgreeContentStr}
                    </div>
                    <div class="d-flex mt-3 gap-3 w-100">
                        <button type="button" class="btn flex-1 btn-secondary" onclick="javascript:disAgreeTerms()">비동의</button>
                        <button type="button" class="btn flex-1 btn-primary" onclick="javascript:agreeTerms()">동의</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

	<%@ include file="./common/footer.jsp" %>
</body>
</html>