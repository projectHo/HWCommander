<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 주문내역</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css" />
<link rel="stylesheet" href="/resources/css/userOrderListDetail.css" />
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

<!-- 23.07.15 다음 카카오 map api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	let width = window.outerWidth;
	// 데이터 불러오기
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
	function loadData(){
		if("${orderMasterVO.orderStateCd}" == 1){
			$(".pay-state").html("결제 이전");
		}else if("${orderMasterVO.orderStateCd}" == 9) {
			$(".pay-state").html("환불 요청");
		}else if("${orderMasterVO.orderStateCd}" == 10){
			$(".pay-state").html("환불 완료");
		}else {
			$(".pay-state").html("결제 완료");
		}
		$(".recipient-hp").html(masterInfoObject.recipientHpNumber.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3"));
		$(".recipient-next-hp").val(masterInfoObject.recipientHpNumber2.replace(/(\d{3})(\d{4})(\d{4})/, "$1-$2-$3"));
		if(masterInfoObject.paymentMethod == "Card"){
			$(".payment-meth").html("카드");
		}else if(masterInfoObject.paymentMethod == "account-transfer"){
			$(".payment-meth").html("계좌이체");
		}
	};
	// 다음 지도
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
	// 수정버튼
	function editHpBtn(){
		if($(".recipient-next-hp").val() == masterInfoObject.recipientHpNumber2){
			alert("변동사항이 없습니다!");
		}else if($(".recipient-next-hp").val() === ""){
			if(confirm("추가 연락처를 삭제할까요?")){
				$.ajax({
				type: "post",
				url: "/user/orderUpdateRecipientHpNumber2Logic.do",
				data: {
					id: "${orderMasterVO.id}",
					recipientHpNumber2: $(".recipient-next-hp").val()
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
		}else if($(".recipient-next-hp").val().length < 11){
			alert("번호를 정확히 입력해주세요! ex) 01012345678");
			$(".recipient-next-hp").focus();
		}else {
			if(confirm("입력하신 번호 : " + $(".recipient-next-hp").val() + "\n이대로 저장 하시겠습니까?")){
				$.ajax({
					type: "post",
					url: "/user/orderUpdateRecipientHpNumber2Logic.do",
					data: {
						id: "${orderMasterVO.id}",
						recipientHpNumber2: $(".recipient-next-hp").val()
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
	
	function editAddrBtn(){
		findDaumAddr();
	}

	function saveAddrBtn(){
		if(masterInfoObject.recipientJibunAddr == $(".recipient-jibun-addr").val() && masterInfoObject.recipientRoadAddr == $(".recipient-road-addr").val() && masterInfoObject.recipientDetailAddr == $(".recipient-detail-addr").val() && masterInfoObject.recipientZipcode == $(".recipient-zip-code").val()){
			alert("변경사항이 없습니다!");
		}else if($(".recipient-detail-addr").val() === ""){
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
	function clickReqInput(el){
		$(".text-counter").css("display","none");
		if($(el).hasClass("order-req")){
			orderTextCount();
			$("._order").css("display","block");
		}else {
			deliveryTextCount();
			$("._delivery").css("display","block");
		}
	}
	function reqInput(el){
		if($(el).val().length > 50){
			$(el).val($(el).val().substring(0, 50));
		}
	}
	function orderTextCount(){
		let num = $(".order-req").val().length;
		$("._order").html(num + "/50");
	}
	function deliveryTextCount(){
		let num = $(".delivery-req").val().length;
		$("._delivery").html(num + "/50");
	}
	function insertOrderCountText(el){
		let num = $("#modalOrderReq").val().length;
		$(".text-counter-order-modal").html(num + "/50");
	}
	function modalOrderTextCount(){
		let num = $("#modalOrderReq").val().length;
		$(".text-counter-order-modal").html(num + "/50");
	}
	function insertDeliveryCountText(el){
		let num = $("#modalDeliveryReq").val().length;
		$(".text-counter-delivery-modal").html(num + "/50");
	}
	function modalDeliveryTextCount(){
		let num = $("#modalDeliveryReq").val().length;
		$(".text-counter-delivery-modal").html(num + "/50");
	}
	function orderReqModalSave(){
		let input = $("#modalOrderReq").val();
		if(input === "${orderMasterVO.orderRequest}"){
			alert("변경사항이 없습니다!");
		}else if(input === ""){
			if(confirm("요청내용을 삭제할까요?")){
				$.ajax({
					type: "post",
					url: "/user/orderUpdateOrderRequest.do",
					data: {
						id: "${orderMasterVO.id}",
						orderRequest: input
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
			if(confirm("작성내용 : " + input + "\n\n이대로 저장 하시겠습니까?")){
				$.ajax({
					type: "post",
					url: "/user/orderUpdateOrderRequest.do",
					data: {
						id: "${orderMasterVO.id}",
						orderRequest: input
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
	function deliveryReqModalSave(){
		let input = $("#modalDeliveryReq").val();
		if(input === "" && "${orderMasterVO.deliveryRequest}" != input){
			if(confirm("요청내용을 삭제할까요?")){
				$.ajax({
					type: "post",
					url: "/user/orderUpdateDeliveryRequest.do",
					data: {
						id: "${orderMasterVO.id}",
						deliveryRequest: input
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
		}else if(input === "${orderMasterVO.deliveryRequest}"){
			alert("변경 사항이 없습니다!");
		}else {
			if(confirm("작성내용 : " + input + "\n\n이대로 저장 하시겠습니까?")){
				$.ajax({
					type: "post",
					url: "/user/orderUpdateDeliveryRequest.do",
					data: {
						id: "${orderMasterVO.id}",
						deliveryRequest: input
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
	function editOrderReqBtn(){
		if($(".order-req").val() === "${orderMasterVO.orderRequest}"){
			alert("변경사항이 없습니다!");
		}else if($(".order-req").val() === ""){
			if(confirm("요청내용을 삭제할까요?")){
				$.ajax({
					type: "post",
					url: "/user/orderUpdateOrderRequest.do",
					data: {
						id: "${orderMasterVO.id}",
						orderRequest: $(".order-req").val()
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
			if(confirm("작성내용 : " + $(".order-req").val() + "\n\n이대로 저장 하시겠습니까?")){
				$.ajax({
					type: "post",
					url: "/user/orderUpdateOrderRequest.do",
					data: {
						id: "${orderMasterVO.id}",
						orderRequest: $(".order-req").val()
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
	
	function editDeliveryReqBtn(){
		if($(".delivery-req").val() === "" && "${orderMasterVO.deliveryRequest}" != $(".delivery-req").val()){
			if(confirm("요청내용을 삭제할까요?")){
				$.ajax({
					type: "post",
					url: "/user/orderUpdateDeliveryRequest.do",
					data: {
						id: "${orderMasterVO.id}",
						deliveryRequest: $(".delivery-req").val()
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
		}else if($(".delivery-req").val() === "${orderMasterVO.deliveryRequest}"){
			alert("변경 사항이 없습니다!");
		}else {
			if(confirm("작성내용 : " + $(".delivery-req").val() + "\n\n이대로 저장 하시겠습니까?")){
				$.ajax({
					type: "post",
					url: "/user/orderUpdateDeliveryRequest.do",
					data: {
						id: "${orderMasterVO.id}",
						deliveryRequest: $(".delivery-req").val()
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
	function clickStatusBtn(){
		if(masterInfoObject.orderStateCdNm === "환불 요청"){
			alert("환불 진행중입니다!")
		}else {
			location.href = "orderProgressStatus.do?id=" + encodeURIComponent(masterInfoObject.id);
		}
	}
	
	function requestVideoBtn(){
		if("${orderMasterVO.orderStateCd}" != "01"){
			if("${orderMasterVO.orderStateCd}" === "09"){
				alert("환불 진행중입니다!");
			}else if("${orderMasterVO.orderStateCd}" === "10"){
				alert("환불 완료된 주문입니다!");
			}else if(masterInfoObject.videoRequestCdNm === "요청"){
				alert("이미 요청하셨습니다!");
			}else {
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
		}else {
			alert("아직 결제 전입니다! 결제 후 이용해주세요~!");
		}
	}
	function scrollTerms(elem){
		var scrollTop = $(elem).scrollTop();
		var innerHeight = $(elem).innerHeight();
		var scrollHeight = $(elem).prop('scrollHeight');
		if (scrollTop + innerHeight >= scrollHeight) {
			$("#agree-terms").removeClass("btn-outline-primary").addClass("btn-primary").attr("disabled",false);
		}
	}
	let refundReasonUserWrite = null;
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
		if($(el).val().length > 200){
            $(el).val($(el).val().substring(0, 200));
		}
		refundReasonUserWrite = String($(el).val());
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
	function checkHp(){
		const numberCheck = /^[0-9]+$/;	
		if ($('.recipient-next-hp').val().length>=1 && !numberCheck.test($('.recipient-next-hp').val())) {
			alert("휴대폰번호는 숫자만 입력 가능합니다.");
			$('.recipient-next-hp').val("");
			$('.recipient-next-hp').focus();
		}
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
	function trSettings(){
		$(".trs").children().remove();
		if(width < 768){
			let oneChildA = $(`<th style="width: 30%;" scope="row">상품명</th>`);
			let oneChildB = $(`<td>${orderMasterVO.orderName}</td>`);
			$(".tr-one").append(oneChildA);
			$(".tr-one").append(oneChildB);
			let twoChildA = $(`<th style="width: 30%;">주문날짜</th>`);
			let twoChildB = $(`<td>${orderMasterVO.orderDateStr}</td>`);
			$(".tr-two").append(twoChildA);
			$(".tr-two").append(twoChildB);
			let threeChildA = $(`<th style="width: 30%;" scope="row">주문자</th>`);
			let threeChildB = $(`<td>${orderMasterVO.ordererName}</td>`);
			$(".tr-three").append(threeChildA);
			$(".tr-three").append(threeChildB);
			let fourChildA = $(`<th style="width: 30%;">결제상태</th>`);
			let fourChildB = $(`<td class="pay-state"></td>`);
			$(".tr-four").append(fourChildA);
			$(".tr-four").append(fourChildB);
			let fiveChildA = $(`<th style="width: 30%;" scope="row">주문번호</th>`);
			let fiveChildB = $(`<td>${orderMasterVO.id}</td>`);
			$(".tr-five").append(fiveChildA);
			$(".tr-five").append(fiveChildB);
			let sixChildA = $(`<th style="width: 30%;">이메일 주소</th>`);
			let sixChildB = $(`<td>${orderMasterVO.ordererMail}</td>`);
			$(".tr-six").append(sixChildA);
			$(".tr-six").append(sixChildB);
			$(".p-tags-a").html("주문 시<br>요청사항");
			$(".p-tags-b").html("배송 시<br>요청사항");
		}else if(width >= 1024){
			let oneChildA = $(`<th style="width: 20%;" scope="row">상품명</th>`);
			let oneChildB = $(`<td>${orderMasterVO.orderName}</td>`);
			let oneChildC = $(`<th style="width: 20%;" scope="row">주문번호</th>`);
			let oneChildD = $(`<td>${orderMasterVO.id}</td>`);
			$(".tr-one").append(oneChildA);
			$(".tr-one").append(oneChildB);
			$(".tr-one").append(oneChildC);
			$(".tr-one").append(oneChildD);
			let twoChildA = $(`<th style="width: 20%;">주문날짜</th>`);
			let twoChildB = $(`<td>${orderMasterVO.orderDateStr}</td>`);
			let twoChildC = $(`<th style="width: 20%;" scope="row">주문자</th>`);
			let twoChildD = $(`<td>${orderMasterVO.ordererName}</td>`);
			$(".tr-two").append(twoChildA);
			$(".tr-two").append(twoChildB);
			$(".tr-two").append(twoChildC);
			$(".tr-two").append(twoChildD);
			let threeChildA = $(`<th style="width: 20%;">결제상태</th>`);
			let threeChildB = $(`<td class="pay-state"></td>`);
			let threeChildC = $(`<th style="width: 20%;">이메일 주소</th>`);
			let threeChildD = $(`<td>${orderMasterVO.ordererMail}</td>`);
			$(".tr-three").append(threeChildA);
			$(".tr-three").append(threeChildB);
			$(".tr-three").append(threeChildC);
			$(".tr-three").append(threeChildD);
			$(".p-tags-a").html("주문 시 요청사항");
			$(".p-tags-b").html("배송 시 요청사항");
		}
	}
	function reqBtnSetting(){
		$(".order-req-input-group").find(".btn").remove();
		$(".delivery-req-input-group").find(".btn").remove();
		if(width < 1440){
			$(".order-req-input-group").append(`<button class="btn btn-outline-secondary btn-s" type="button" data-bs-toggle="modal" data-bs-target="#orderReqModal" onclick="javascript:insertOrderCountText(this)">수정</button>`);
			$(".delivery-req-input-group").append(`<button class="btn btn-outline-secondary btn-s" type="button" data-bs-toggle="modal" data-bs-target="#deliveryReqModal" onclick="javascript:insertDeliveryCountText(this)">수정</button>`);
			$(".order-req").attr("readonly",true);
			$(".delivery-req").attr("readonly",true);
		}else if(width >= 1440){
			$(".order-req-input-group").append(`<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon4" onclick="javascript:editOrderReqBtn()">저장</button>`);
			$(".delivery-req-input-group").append(`<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon5" onclick="javascript:editDeliveryReqBtn()">저장</button>`);
			$(".order-req").attr("readonly",false);
			$(".delivery-req").attr("readonly",false);
		}
	}
	$(function(){
		trSettings();
		reqBtnSetting();
		loadData();
		$(window).on("resize",function(){
			width = window.outerWidth;
			trSettings();
			reqBtnSetting();
			loadData();
		})
		var Pattern = /\((.*?)\)/;
		var userInfoMatch = Pattern.exec("${loginUser}");
		var userInfoValues = userInfoMatch[1];

		var userInfoArray = userInfoValues.split(", ");
		var userInfoObject = {};
		for (var i = 0; i < userInfoArray.length; i++) {
			var keyValue = userInfoArray[i].split("=");
			var key = keyValue[0];
			var value = keyValue[1];
			userInfoObject[key] = value;
		}
		$(".user-name").html(userInfoObject.name);
		if(Number("${orderMasterVO.orderStateCd}") == 6 || Number("${orderMasterVO.orderStateCd}") == 7){
			$(".btn-s").attr("data-bs-toggle","tooltip").attr("data-bs-placement","right").attr("data-bs-title","배송 단계부터는 수정이 불가능합니다!").css("cursor","not-allowed").attr("onclick","");
			$("input").attr("disabled","disabled");
		}

		// 부트스트랩 툴팁
		const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
		const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))

		// 계좌이체 결제 전
		if(masterInfoObject.orderStateCd == 1 && masterInfoObject.paymentMethod == "account-transfer"){
			$(".account-numb-tr").css("display","table-row");
		}
	})
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start order-list-detail-empty-space"></div>
			<!-- 작업영역 -->
			<div class="estimateCalc_background p-md-5 pt-5 pb-5 order-list-detail-main-space">
				<div class="container">
					<div class="buttons mb-3 d-md-flex justify-content-md-between">
						<h2 class="mb-3 text-center">
							<span class="user-name"></span>
							<b>님의 주문 상세내역</b>
						</h2>
						<div class="mt-2 text-end">
							<c:if test="${orderMasterVO.orderStateCd == 1}">
								<button class="btn btn-outline-success me-md-2" type="button" onclick="javascript:cancleOrderBtn()">주문 취소</button>
							</c:if>
							<c:if test="${orderMasterVO.orderStateCd > 1 && orderMasterVO.orderStateCd != 11}">
								<button class="btn btn-outline-primary me-md-2" type="button" onclick="javascript:clickStatusBtn()">현황 확인</button>
								<button class="btn btn-outline-success me-md-2" type="button" onclick="javascript:requestVideoBtn()">영상 요청</button>
								<button class="btn btn-outline-danger" type="button" data-bs-toggle="modal" data-bs-target="#refundTermModal">환불 요청</button>
							</c:if>
							<c:if test="${orderMasterVO.orderStateCd == 11}">
								<button class="btn btn-outline-primary me-md-2" type="button" onclick="javascript:clickStatusBtn()">현황 확인</button>
								<button class="btn btn-outline-success me-md-2" type="button" onclick="javascript:requestVideoBtn()">영상 요청</button>
							</c:if>
						</div>	
					</div>
					<table class="table table-secondary table-bordered" style="border-collapse: separate;">
						<tbody class="trs-body">
							<tr class="tr-one trs"></tr>
							<tr class="tr-two trs"></tr>
							<tr class="tr-three trs"></tr>
							<tr class="tr-four trs"></tr>
							<tr class="tr-five trs"></tr>
							<tr class="tr-six trs"></tr>
						</tbody>
					</table>
					<table class="table table-secondary table-bordered" style="border-collapse: separate;">
						<thead>
							<tr>
								<th class="first-th" scope="col">수령인</th>
								<th scope="col" style="font-weight: 400;">${orderMasterVO.recipientName}</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">연락처</th>
								<td class="recipient-hp"></td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">추가 연락처</th>
								<td>
									<div class="input-group">
										<input maxlength="11" type="text" class="form-control recipient-next-hp" aria-label="Recipient's another hpNumber" aria-describedby="button-addon" oninput="javascript:checkHp()" placeholder="ex)01012345678">
										<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon" onclick="javascript:editHpBtn()">저장</button>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">주소</th>
								<td>
									<div class="input-group">
										<input type="text" class="form-control recipient-zip-code" aria-label="Recipient's addr" aria-describedby="button-addon2" readonly="readonly" value="${orderMasterVO.recipientZipcode}">
										<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon2" onclick="javascript:editAddrBtn()">찾기</button>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">지번주소</th>
								<td>
									<input type="text" class="form-control recipient-jibun-addr" aria-label="Recipient's Ji addr" readonly="readonly" value="${orderMasterVO.recipientJibunAddr}">
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">도로명주소</th>
								<td>
									<input type="text" class="form-control recipient-road-addr" aria-label="Recipient's Road addr" readonly="readonly" value="${orderMasterVO.recipientRoadAddr}">
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle">상세주소</th>
								<td>
									<div class="input-group">
										<input type="text" class="form-control recipient-detail-addr" aria-label="Recipient's Detail addr" aria-describedby="button-addon3" value="${orderMasterVO.recipientDetailAddr}">
										<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon3" onclick="javascript:saveAddrBtn()">저장</button>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle p-tags-a">주문 시 요청사항</th>
								<td class="req-input-tds">
									<div class="input-group order-req-input-group">
										<input type="text" class="form-control order-req" aria-label="Recipient's order required" aria-describedby="button-addon4" value="${orderMasterVO.orderRequest}" oninput="javascript:reqInput(this); orderTextCount();" onclick="clickReqInput(this)" placeholder="최대 50자">
									</div>
									<div class="text-counter _order"></div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="align-middle p-tags-b">배송 시 요청사항</th>
								<td class="req-input-tds">
									<div class="input-group delivery-req-input-group">
										<input type="text" class="form-control delivery-req" aria-label="Recipient's delivery required" aria-describedby="button-addon5" value="${orderMasterVO.deliveryRequest}" oninput="javascript:reqInput(this); deliveryTextCount();" onclick="clickReqInput(this)" placeholder="최대 50자">
									</div>
									<div class="text-counter _delivery"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">상태</th>
								<td>${orderMasterVO.orderStateCdNm}</td>
							</tr>
							<tr>
								<th scope="row">결제 수단</th>
								<td class="payment-meth"></td>
							</tr>
							<tr class="account-numb-tr" style="display: none;">
								<th scope="row">입금계좌 번호</th>
								<td class="account-numb">645-910900-07207 하나은행 이해창(현우의 컴퓨터 공방)</td>
							</tr>
							<tr>
								<th class="align-middle" scope="row">결제 금액</th>
								<td>${orderMasterVO.totOrderPriceStr}원</td>
							</tr>
						</tbody>
					</table>
					<!-- 환불 약관 모달 -->
					<div class="modal fade" id="refundTermModal" aria-hidden="true" tabindex="-1">
						<div class="modal-dialog modal-dialog-centered modal-lg modal-dialog-scrollable">
						  <div class="modal-content">
							<div class="modal-header">
							  <h1 class="modal-title fs-5">환불 약관</h1>
							  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body" onscroll="javascript:scrollTerms(this)">
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
								<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Incidunt vero impedit nobis, ipsam iusto fugiat laboriosam rem nesciunt quidem eum veniam aspernatur autem maiores? Consectetur nam tempore autem sequi dolores.</p>
							</div>
							<div class="modal-footer">
							  <button class="btn btn-primary" id="agree-terms" data-bs-target="#refundModal" data-bs-toggle="modal" disabled>약관 동의</button>
							</div>
						  </div>
						</div>
					  </div>
					<!-- 환불 모달 -->
					<div class="modal fade" id="refundModal" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
						  <div class="modal-content">
							<div class="modal-header">
							  <h1 class="modal-title fs-5">환불 요청</h1>
							  <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
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
							  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							  <button type="button" class="btn btn-danger" onclick="javascript:requestRefundBtn()">환불 요청</button>
							</div>
						  </div>
						</div>
					</div>
					<!-- 모바일용 주문 요청사항 모달 -->
					<div class="modal fade" id="orderReqModal" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
						  <div class="modal-content">
							<div class="modal-header">
							  <h1 class="modal-title fs-5">주문 시 요청사항</h1>
							  <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
							</div>
							<div class="modal-body position-relative p-0 m-3">
								<textarea class="form-control" id="modalOrderReq" cols="30" rows="4" oninput="javascript:reqInput(this); modalOrderTextCount()">${orderMasterVO.orderRequest}</textarea>
								<div class="text-counter-order-modal position-absolute bottom-0 end-0 me-2"></div>
							</div>
							<div class="modal-footer">
							  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							  <button type="button" class="btn btn-primary" onclick="javascript:orderReqModalSave()">저장</button>
							</div>
						  </div>
						</div>
					</div>
					<!-- 모바일용 배송 요청사항 모달 -->
					<div class="modal fade" id="deliveryReqModal" tabindex="-1" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered">
						  <div class="modal-content">
							<div class="modal-header">
							  <h1 class="modal-title fs-5">배송 시 요청사항</h1>
							  <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
							</div>
							<div class="modal-body position-relative p-0 m-3">
								<textarea class="form-control" id="modalDeliveryReq" cols="30" rows="4" oninput="javascript:reqInput(this); modalDeliveryTextCount()">${orderMasterVO.deliveryRequest}</textarea>
								<div class="text-counter-delivery-modal position-absolute bottom-0 end-0 me-2"></div>
							</div>
							<div class="modal-footer">
							  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
							  <button type="button" class="btn btn-primary" onclick="javascript:deliveryReqModalSave()">저장</button>
							</div>
						  </div>
						</div>
					</div>
				</div>
	 		</div>
			
			<!-- 빈 영역 -->
			<div class="justify-content-end order-list-detail-empty-space"></div>
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
