<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - Order Detail</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<link href="/resources/css/sbAdmin-styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        
<script>
var firstOrderStateCd;
var firstVideoRequestCd;

    $(function() {
    	dataSetting();
    });
    
function dataSetting() {
	$("#viewId").val("${orderMasterVO.id}");
	$("#orderDateStr").val("${orderMasterVO.orderDateStr}");
	$("#orderName").val("${orderMasterVO.orderName}");
	$("#totOrderPriceStr").val("${orderMasterVO.totOrderPriceStr}");
	$("#orderStateCd").val("${orderMasterVO.orderStateCd}");
	$("#ordererUserId").val("${orderMasterVO.ordererUserId}");
	$("#ordererName").val("${orderMasterVO.ordererName}");
	$("#ordererHpNumber").val("${orderMasterVO.ordererHpNumber}");
	$("#ordererMail").val("${orderMasterVO.ordererMail}");
	$("#recipientName").val("${orderMasterVO.recipientName}");
	$("#recipientHpNumber").val("${orderMasterVO.recipientHpNumber}");
	$("#recipientHpNumber2").val("${orderMasterVO.recipientHpNumber2}");
	$("#recipientZipcode").val("${orderMasterVO.recipientZipcode}");
	$("#recipientJibunAddr").val("${orderMasterVO.recipientJibunAddr}");
	$("#recipientRoadAddr").val("${orderMasterVO.recipientRoadAddr}");
	$("#recipientDetailAddr").val("${orderMasterVO.recipientDetailAddr}");
	$("#orderRequest").val("${orderMasterVO.orderRequest}");
	$("#deliveryRequest").val("${orderMasterVO.deliveryRequest}");
	$("#paymentMethod").val("${orderMasterVO.paymentMethod}");
	$("#videoRequestCd").val("${orderMasterVO.videoRequestCd}");
	$("#waybillNumber").val("${orderMasterVO.waybillNumber}");
	
	$("#id").val("${orderMasterVO.id}");
	
	firstOrderStateCd = "${orderMasterVO.orderStateCd}";
	firstVideoRequestCd = "${orderMasterVO.videoRequestCd}";
}

function orderStateCdUpdate() {
	if("00" == $('#orderStateCd').val()) {
		alert("결제상태를 선택하세요.");
		$('#orderStateCd').focus();
		return false;
	}
	
    if(firstOrderStateCd == $('#orderStateCd').val()) {
    	alert("변경된 내용이 없습니다.");
    	$('#orderStateCd').focus();
    	return false;
    }
    
    $('#order_state_cd_update_form_id').val($('#id').val());
    $('#order_state_cd_update_form_orderStateCd').val($('#orderStateCd').val());
    
	if(confirm("결제상태를 수정 하시겠습니까?")) {
	    $.ajax({
	        type: "post",
	        url: "/admin/updateOrderStateCd.do",
	        data: $("#order_state_cd_update_form").serialize(),
	        dataType: 'json',
	        success: function (data) {
	        	if(data == 2) {
	        		alert("수정완료");
	        		firstOrderStateCd = $('#orderStateCd').val();
	        	}else {
	        		alert("수정실패");
	        	}
	            console.log(data);
	        }
	    });
	}
}

function videoRequestUpdate() {
	if("00" == $('#videoRequestCd').val()) {
		alert("영상요청을 선택하세요.");
		$('#videoRequestCd').focus();
		return false;
	}
	
    if(firstVideoRequestCd == $('#videoRequestCd').val()) {
    	alert("변경된 내용이 없습니다.");
    	$('#videoRequestCd').focus();
    	return false;
    }
    
    $('#request_cd_update_form_id').val($('#id').val());
    $('#request_cd_update_form_videoRequestCd').val($('#videoRequestCd').val());

	if(confirm("영상요청정보를 수정 하시겠습니까?")) {
	    $.ajax({
	        type: "post",
	        url: "/admin/updateVideoRequestCd.do",
	        data: $("#request_cd_update_form").serialize(),
	        dataType: 'json',
	        success: function (data) {
	        	if(data == 2) {
	        		alert("수정완료");
	        		firstVideoRequestCd = $('#videoRequestCd').val();
	        	}else {
	        		alert("수정실패");
	        	}
	            console.log(data);
	        }
	    });
	}
}

function waybillNumberUpdate() {
	    
    $('#waybill_number_form_id').val($('#id').val());
    $('#waybill_number_form_waybill_number').val($('#waybillNumber').val());

	if(confirm("송장번호를 수정 하시겠습니까?")) {
	    $.ajax({
	        type: "post",
	        url: "/admin/updateWaybillNumber.do",
	        data: $("#waybill_number_form").serialize(),
	        dataType: 'json',
	        success: function (data) {
	        	if(data == 2) {
	        		alert("수정완료");
	        	}else {
	        		alert("수정실패");
	        	}
	            console.log(data);
	        }
	    });
	}
}

function goRefundUpdate(refundId) {
	location.href = "refundUpdate.do?id="+refundId;
}

</script>
</head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="main.do">Admin Page</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- go main-->
            <div class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <a class="btn btn-dark" href="/">Main</a>
            </div>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">부품관리</div>
                            <a class="nav-link" href="gpuManagement.do">
                                GPU
                            </a>
                            <a class="nav-link" href="cpuManagement.do">
                                CPU
                            </a>
                            <a class="nav-link" href="mbManagement.do">
                                MB
                            </a>
                            <a class="nav-link" href="ramManagement.do">
                                RAM
                            </a>
                            <a class="nav-link" href="psuManagement.do">
                                PSU
                            </a>
                            <a class="nav-link" href="caseManagement.do">
                                CASE
                            </a>
                            <a class="nav-link" href="coolerManagement.do">
                                Cooler
                            </a>
                            <a class="nav-link" href="hddManagement.do">
                                HDD
                            </a>
                            <a class="nav-link" href="ssdManagement.do">
                                SSD
                            </a>
                            <a class="nav-link" href="sfManagement.do">
                                SF
                            </a>
                            <a class="nav-link" href="makerManagement.do">MAKER</a>
                            <div class="sb-sidenav-menu-heading">완본체관리</div>
                            <a class="nav-link" href="productManagement.do">Product(폐기예정)</a>
                            <a class="nav-link" href="banpumManagement.do">Banpum</a>
                            <div class="sb-sidenav-menu-heading">Process Resource</div>
                            <a class="nav-link" href="resourceTypeCodeManagement.do">
								Type Code
                            </a>
                            <a class="nav-link" href="resourceMasterManagement.do">
								Category(Master)
                            </a>
                            <a class="nav-link" href="resourceDetailManagement.do">
								Resource Data(Detail)
                            </a>
                            <div class="sb-sidenav-menu-heading">주문관리</div>
                            <a class="nav-link" href="orderManagement.do">
								Order
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">With Bootstrap5</div>
                        Made from WonHo
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
				<main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Order Detail</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="orderManagement.do">Order</a></li>
                            <li class="breadcrumb-item active">Order Detail</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                Order 상세정보
                            </div>
                        </div>
                        <form id="order_master_form">
                        	<div class="card mb-4">
                               <div class="card-body">
                                   <input type="hidden" id="id" name="id">
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="viewId" name="viewId" type="text" placeholder="Enter viewId" disabled/>
                                               <label for="viewId">주문번호</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="orderDateStr" name="orderDateStr" type="text" placeholder="Enter orderDateStr" disabled/>
                                               <label for="orderDateStr">주문날짜</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="totOrderPriceStr" name="totOrderPriceStr" type="text" placeholder="Enter totOrderPriceStr" disabled/>
                                               <label for="totOrderPriceStr">총 주문금액</label>
                                           </div>
                                       </div>
                                       <div class="col-md-2">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="orderStateCd" name="orderStateCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${order_state_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="orderStateCd">결제상태</label>
                                           </div>
                                       </div>
                                       <div class="col-md-1">
                                           <div class="form-floating mt-1 float-end">
												<a class="btn btn-secondary btn-lg" id="btn_order_state_cd_update" onclick="javascript:orderStateCdUpdate()">Update</a>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="ordererUserId" name="ordererUserId" type="text" placeholder="Enter ordererUserId" disabled/>
                                               <label for="ordererUserId">주문자ID</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="ordererName" name="ordererName" type="text" placeholder="Enter ordererName" disabled/>
                                               <label for="ordererName">주문자명</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="ordererHpNumber" name="ordererHpNumber" type="text" placeholder="Enter ordererHpNumber" disabled/>
                                               <label for="ordererHpNumber">주문자 휴대폰번호</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="ordererMail" name="ordererMail" type="text" placeholder="Enter ordererMail" disabled/>
                                               <label for="ordererMail">주문자 이메일</label>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="row mb-3">
                                       <div class="col-md-6">
                                           <div class="form-floating">
                                               <input class="form-control" id="orderName" name="orderName" type="text" placeholder="Enter orderName" disabled/>
                                               <label for="orderName">주문이름</label>
                                           </div>
                                       </div>
                                       <div class="col-md-2">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="videoRequestCd" name="videoRequestCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${video_request_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="videoRequestCd">영상요청</label>
                                           </div>
                                       </div>
                                       <div class="col-md-1">
                                           <div class="form-floating mt-1 float-end">
												<a class="btn btn-secondary btn-lg" id="btn_video_request_cd_update" onclick="javascript:videoRequestUpdate()">Update</a>
                                           </div>
                                       </div>
                                       <div class="col-md-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="waybillNumber" name="waybillNumber" type="text" placeholder="Enter waybillNumber"/>
                                               <label for="waybillNumber">송장번호</label>
                                           </div>
                                       </div>
                                       <div class="col-md-1">
                                           <div class="form-floating mt-1 float-end">
												<a class="btn btn-secondary btn-lg" id="btn_waybill_number_update" onclick="javascript:waybillNumberUpdate()">Update</a>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                        	</div>
                        	<div class="card mb-4">
                               <div class="card-body">
                                   <input type="hidden" id="id" name="id">
                                   <div class="row mb-3">
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="recipientName" name="recipientName" type="text" placeholder="Enter recipientName" disabled/>
                                               <label for="recipientName">수령인</label>
                                           </div>
                                       </div>
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="recipientHpNumber" name="recipientHpNumber" type="text" placeholder="Enter recipientHpNumber" disabled/>
                                               <label for="recipientHpNumber">연락처</label>
                                           </div>
                                       </div>
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="recipientHpNumber2" name="recipientHpNumber2" type="text" placeholder="Enter recipientHpNumber2" disabled/>
                                               <label for="recipientHpNumber2">추가 연락처</label>
                                           </div>
                                       </div>
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="recipientZipcode" name="recipientZipcode" type="text" placeholder="Enter recipientZipcode" disabled/>
                                               <label for="recipientZipcode">주소</label>
                                           </div>
                                       </div>
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="recipientJibunAddr" name="recipientJibunAddr" type="text" placeholder="Enter recipientJibunAddr" disabled/>
                                               <label for="recipientJibunAddr">지번주소</label>
                                           </div>
                                       </div>
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="recipientRoadAddr" name="recipientRoadAddr" type="text" placeholder="Enter recipientRoadAddr" disabled/>
                                               <label for="recipientRoadAddr">도로명주소</label>
                                           </div>
                                       </div>
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="recipientDetailAddr" name="recipientDetailAddr" type="text" placeholder="Enter recipientDetailAddr" disabled/>
                                               <label for="recipientDetailAddr">상세주소</label>
                                           </div>
                                       </div>
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="orderRequest" name="orderRequest" type="text" placeholder="Enter orderRequest" disabled/>
                                               <label for="orderRequest">주문 시 요청사항</label>
                                           </div>
                                       </div>
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="deliveryRequest" name="deliveryRequest" type="text" placeholder="Enter deliveryRequest" disabled/>
                                               <label for="deliveryRequest">배송 시 요청사항</label>
                                           </div>
                                       </div>
                                       <div class="col-md-12 mb-2">
                                           <div class="form-floating">
                                               <input class="form-control" id="paymentMethod" name="paymentMethod" type="text" placeholder="Enter paymentMethod" disabled/>
                                               <label for="paymentMethod">결제 수단</label>
                                           </div>
                                       </div>
                                   </div>
                               </div>
                        	</div>
                        </form>
                        
                        <!-- 상품정보  order_detail & refund_info-->
                        <form id="order_detail_and_refund_info_form">
                        	<c:forEach var="orderDetailVO" items="${orderDetailVOList}" varStatus="status1">
								<div class="card mb-4">
	                               <div class="card-body">
	                                   <input type="hidden" id="seq_${status1.index}" name="seq" value="${orderDetailVO.seq}">
	                                   <div class="row">
	                                   		<label>주문제품 _${status1.count}</label>
	                                   </div>
	                                   <div class="row mb-3">
	                                       <div class="col-md-3">
	                                           <div class="form-floating">
	                                               <input class="form-control" id="productId_${status1.index}" name="productId" type="text" value="${orderDetailVO.productId}" placeholder="Enter productId" disabled/>
	                                               <label for="productId">제품ID</label>
	                                           </div>
	                                       </div>
	                                       <div class="col-md-3">
	                                           <div class="form-floating">
	                                               <input class="form-control" id="productName_${status1.index}" name="productName" type="text" value="${orderDetailVO.productName}" placeholder="Enter productName" disabled/>
	                                               <label for="productName">제품명</label>
	                                           </div>
	                                       </div>
	                                       <div class="col-md-3">
	                                           <div class="form-floating">
	                                               <input class="form-control" id="productPrice_${status1.index}" name="productPrice" type="text" value="${orderDetailVO.productPrice}" placeholder="Enter productPrice" disabled/>
	                                               <label for="productPrice">제품가격</label>
	                                           </div>
	                                       </div>
	                                       <div class="col-md-3">
	                                           <div class="form-floating">
	                                               <input class="form-control" id="productOrderQty_${status1.index}" name="productOrderQty" type="text" value="${orderDetailVO.productOrderQty}" placeholder="Enter productOrderQty" disabled/>
	                                               <label for="productOrderQty">제품주문수량</label>
	                                           </div>
	                                       </div>
	                                   </div>
	                                   <div class="row mb-3">
	                                       <div class="col-md-3">
	                                           <div class="form-floating">
	                                               <input class="form-control" id="boxQty_${status1.index}" name="boxQty" type="text" value="${orderDetailVO.boxQty}" placeholder="Enter boxQty" disabled/>
	                                               <label for="boxQty">제품박스수량</label>
	                                           </div>
	                                       </div>
	                                       <div class="col-md-3">
	                                           <div class="form-floating">
	                                               <input class="form-control" id="boxTotPrice_${status1.index}" name="boxTotPrice" type="text" value="${orderDetailVO.boxTotPrice}" placeholder="Enter boxTotPrice" disabled/>
	                                               <label for="boxTotPrice">제품박스 총 금액</label>
	                                           </div>
	                                       </div>
	                                   </div>
	                                   <div class="row">
	                                   		<label>주문제품 _${status1.count}에 대한 환불정보 </label>
	                                   </div>
										<c:if test="${empty orderDetailVO.refundInfoVOList}">
											<div class="row mb-3">
												<label>환불정보가 없습니다.</label>
											</div>
										</c:if>
										
										<c:if test="${not empty orderDetailVO.refundInfoVOList}">
											<c:forEach var="refundInfoVO" items="${orderDetailVO.refundInfoVOList}" varStatus="status2">
												<div class="row">
	                                   				<label>환불정보_${status2.count} </label>
                                   				</div>
			                                   <div class="row mb-3">
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="refundId_${status1.index}_${status2.index}" name="refundId" type="text" value="${refundInfoVO.id}" placeholder="Enter refundId" disabled/>
			                                               <label for="refundId">환불ID</label>
			                                           </div>
			                                       </div>
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="refundQty_${status1.index}_${status2.index}" name="refundQty" type="text" value="${refundInfoVO.refundQty}" placeholder="Enter refundQty" disabled/>
			                                               <label for="refundQty">환불수량</label>
			                                           </div>
			                                       </div>
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="requestRefundPrice_${status1.index}_${status2.index}" name="requestRefundPrice" type="text" value="${refundInfoVO.requestRefundPrice}" placeholder="Enter requestRefundPrice" disabled/>
			                                               <label for="requestRefundPrice">신청 환불금액</label>
			                                           </div>
			                                       </div>
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="determinRefundPrice_${status1.index}_${status2.index}" name="determinRefundPrice" type="text" value="${refundInfoVO.determinRefundPrice}" placeholder="Enter determinRefundPrice" disabled/>
			                                               <label for="determinRefundPrice">결정 환불금액</label>
			                                           </div>
			                                       </div>
		                                       </div>
		                                       <div class="row mb-3">
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="refundStateCdNm_${status1.index}_${status2.index}" name="refundStateCdNm" type="text" value="${refundInfoVO.refundStateCdNm}" placeholder="Enter refundStateCdNm" disabled/>
			                                               <label for="refundStateCdNm">환불상태코드명</label>
			                                           </div>
			                                       </div>
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="refundReasonCdNm_${status1.index}_${status2.index}" name="refundReasonCdNm" type="text" value="${refundInfoVO.refundReasonCdNm}" placeholder="Enter refundReasonCdNm" disabled/>
			                                               <label for="refundReasonCdNm">환불사유코드명</label>
			                                           </div>
			                                       </div>
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="refundReasonUserWrite_${status1.index}_${status2.index}" name="refundReasonUserWrite" type="text" value="${refundInfoVO.refundReasonUserWrite}" placeholder="Enter refundReasonUserWrite" disabled/>
			                                               <label for="refundReasonUserWrite">환불사유 구매자 직접입력</label>
			                                           </div>
			                                       </div>
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="refundContent_${status1.index}_${status2.index}" name="refundContent" type="text" value="${refundInfoVO.refundContent}" placeholder="Enter refundContent" disabled/>
			                                               <label for="refundContent">환불내용</label>
			                                           </div>
			                                       </div>
			                                   </div>
		                                       <div class="row">
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="refundRemarks_${status1.index}_${status2.index}" name="refundRemarks" type="text" value="${refundInfoVO.refundRemarks}" placeholder="Enter refundRemarks" disabled/>
			                                               <label for="refundRemarks">환불비고</label>
			                                           </div>
			                                       </div>
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="refundPartialAgreeContent_${status1.index}_${status2.index}" name="refundPartialAgreeContent" type="text" value="${refundInfoVO.refundPartialAgreeContent}" placeholder="Enter refundPartialAgreeContent" disabled/>
			                                               <label for="refundPartialAgreeContent">환불부분동의내용</label>
			                                           </div>
			                                       </div>
			                                       <div class="col-md-3">
			                                           <div class="form-floating">
			                                               <input class="form-control" id="refundPartialAgreeCdNm_${status1.index}_${status2.index}" name="refundPartialAgreeCdNm" type="text" value="${refundInfoVO.refundPartialAgreeCdNm}" placeholder="Enter refundPartialAgreeCdNm" disabled/>
			                                               <label for="refundPartialAgreeCdNm">환불부분동의코드명</label>
			                                           </div>
			                                       </div>
			                                   </div>
			                                   <div class="row">
			                                       <div class="col-md-12">
			                                           <div class="form-floating mt-2 float-end">
			                                               <a class="btn btn-secondary btn-sm" id="btn_go_refund_update" onclick="javascript:goRefundUpdate('${refundInfoVO.id}')">Go Update Page</a>
			                                           </div>
			                                       </div>
			                                   </div>
		                                   </c:forEach>
										</c:if>
	                                   
	                               </div>
	                        	</div>
                        	</c:forEach>
                        </form>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; HW Commander 2023</div>
                            <div>
                                <a>Dream</a>
                                &middot;
                                <a>Desire</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        
        
        <script src="/resources/js/sbAdmin-sidebar-script.js"></script>
        
		<form id="order_state_cd_update_form" method="post">
			<input type="hidden" id="order_state_cd_update_form_id" name="id">
			<input type="hidden" id="order_state_cd_update_form_orderStateCd" name="orderStateCd">
		</form>
        
		<form id="request_cd_update_form" method="post">
			<input type="hidden" id="request_cd_update_form_id" name="id">
			<input type="hidden" id="request_cd_update_form_videoRequestCd" name="videoRequestCd">
		</form>
		
		<form id="waybill_number_form" method="post">
			<input type="hidden" id="waybill_number_form_id" name="id">
			<input type="hidden" id="waybill_number_form_waybill_number" name="waybillNumber">
		</form>
		
    </body>
</html>
