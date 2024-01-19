<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<head>
<title>현우의 컴퓨터 공방 - 주문현황</title>
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
<link rel="stylesheet" href="/resources/css/infoM.css">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
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
    let refundCd;
	function refundReasonDropdownBtn(el){
		$(".refund-reason-title").html($(el).html());
		refundCd = $(el).attr("cd");
		if($(el).attr("cd") == "99"){
			$(".refund-user-write").addClass("show");
		}else {
			$(".refund-user-write").removeClass("show");
		}
	}
    function refundReasonUserWriteText(el){
		refundReasonUserWrite = String($(el).val());
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
    function cancleRefundBtn() {
        history.back();
    }
	$(function(){
		$("#refundModal").modal("show");
	})
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start info-m-empty-space"></div>
			<!-- 작업영역 -->
			<div class="w-100 estimateCalc_background pt-5 pb-5 ps-2 pe-2">
				
			</div>
            <div class="modal fade" id="refundModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h1 class="modal-title fs-5">환불 요청</h1>
                      <button type="button" class="btn-close" onclick="javascript:cancleRefundBtn()"></button>
                    </div>
                    <div class="modal-body">
                        <!-- 단일 -->
                        <c:if test="${orderDetailVOList[0].productOrderQty == 1}">
                            <div class="dropdown w-50 mb-3">
                                <button class="btn btn-outline-dark dropdown-toggle refund-reason-title w-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    환불 사유
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">단순변심</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">개봉시 파손</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">사용 중 문제 발생</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="02" onclick="javascript:refundReasonDropdownBtn(this)">오배송</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="02" onclick="javascript:refundReasonDropdownBtn(this)">구성품 누락</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="03" onclick="javascript:refundReasonDropdownBtn(this)">도착 시 파손</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="99" onclick="javascript:refundReasonDropdownBtn(this)">기타</a></li>
                                </ul>
                            </div>
                            <div class="form-floating mb-3 refund-user-write fade">
                                <input type="text" class="form-control" id="refundReason" placeholder="" autocomplete="off" oninput="javascript:refundReasonUserWriteText(this)">
                                <label for="refundReason">환불 사유</label>
                            </div>
                        </c:if>
                        <!-- 복수 -->
                        <c:if test="${orderDetailVOList[0].productOrderQty > 1}">
                            <div class="d-flex gap-2">
                                <div class="w-50 mb-5">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="refundCount" autocomplete="off" oninput="javascript:refundCount(this)">
                                        <label for="refundCount">환불 수량(최대 ${orderDetailVOList[0].productOrderQty}개)</label>
                                    </div>
                                </div>
                                <div class="w-50 mb-5">
                                    <div class="form-floating">
                                        <input type="text" class="form-control" id="refundBoxCount" autocomplete="off" oninput="javascript:refundBoxCount(this)">
                                        <label for="refundBoxCount">박스 수량(최대 ${orderDetailVOList[0].boxQty}개)</label>
                                    </div>
                                </div>
                            </div>
                            <div class="dropdown w-50 mb-3">
                                <button class="btn btn-secondary dropdown-toggle refund-reason-title w-100 h-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    환불 사유
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">단순변심</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">개봉시 파손</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">사용 중 문제 발생</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="02" onclick="javascript:refundReasonDropdownBtn(this)">오배송</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="02" onclick="javascript:refundReasonDropdownBtn(this)">구성품 누락</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="03" onclick="javascript:refundReasonDropdownBtn(this)">도착 시 파손</a></li>
                                    <li><a class="dropdown-item" href="javascript:void(0);" cd="99" onclick="javascript:refundReasonDropdownBtn(this)">기타(직접입력)</a></li>
                                </ul>
                            </div>
                            <div class="form-floating refund-user-write mb-3 fade">
                                <input type="text" class="form-control" id="refundReason" placeholder="" autocomplete="off" oninput="javascript:refundReasonUserWriteText(this)">
                                <label for="refundReason">환불 사유</label>
                            </div>
                        </c:if>
                    </div>
                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="javascript:cancleRefundBtn()">취소</button>
                      <button type="button" class="btn btn-danger" onclick="javascript:requestRefundBtn()">환불 요청</button>
                    </div>
                  </div>
                </div>
            </div>
			<!-- 빈 영역 -->
			<div class="justify-content-end info-m-empty-space"></div>
		</div>
		
		<!-- 2022.11.16 디자인이미지 추가 -->
		<div class="mt-5 mx-5 mypage-bt-imgs" style="height: 15%!important;">
			<img class="img-fluid float-end" src="/resources/img/layer-34-1200x107.png" alt="">
		</div>
		<div class="mt-2 mx-5 mypage-bt-imgs" style="height: 15%!important;">
			<img class="img-fluid" src="/resources/img/layer-26.png" alt="">
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
</body>
</html>