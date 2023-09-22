<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 영수증</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css" />
<link rel="stylesheet" href="/resources/css/users.css">
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
	let aa = "${loginUser}";
	let bb = "${orderMasterVO}";
	let recipeintPhoneNumber = "${orderMasterVO.recipientHpNumber}";
	$(function(){
		$(".order-name").html("${orderMasterVO.orderName}");
		$(".order-date").html("${orderMasterVO.orderDateStr}");
		$(".recipient-name").html("${orderMasterVO.recipientName}");
		$(".order-price").html("${orderMasterVO.totOrderPriceStr}");
		$(".recipient-hp").html(recipeintPhoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3'));
		$(".recipient-addr").html("${orderMasterVO.recipientRoadAddr}" + " " + "${orderMasterVO.recipientDetailAddr}");
		if("${orderMasterVO.paymentMethod}" == "Card"){
			$(".payment-method").html("카드결제");
		}else{
			$(".payment-method").html("계좌이체");
		}
	})
	function print(){
		$("#printButton").css("display","none");
		const elementsToPrint1 = $('.basic_background').eq(0).clone(); // 복사하여 새 요소 생성
		const elementsToPrint2 = $('.basic_background').eq(1).clone(); // 복사하여 새 요소 생성

		// 새 창에 복사한 요소 삽입
		const printWindow = window.open('', '_blank');
		printWindow.document.write('<html><head><title>현우의 컴퓨터 공방 주문영수증 - 인쇄하기</title><style> * {color:black; text-decoration:none;}</style></head><body>');
		printWindow.document.write(elementsToPrint1.html()); // 선택한 요소 삽입
		printWindow.document.write(elementsToPrint2.html()); // 선택한 요소 삽입
		printWindow.document.write('</body></html>');
		printWindow.document.close();

		// 프린트 명령 실행
		printWindow.print();
		$("#printButton").css("display","block");
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
			<div class="estimateCalc_background p-5" style="width: 70% !important">
				<div class="d-flex justify-content-between mb-3">
					<h2>주문 영수증</h2>
					<button class="btn btn-primary me-2 pb-0" id="printButton" onclick="javascript:print()">인쇄하기</button>
				</div>
				<table class="table table-secondary table-bordered" id="receipt-table">
					<thead>
						<tr>
							<th scope="col" id="first-th">결제 품목</th>
							<th scope="col" class="order-name"></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th scope="row">결제일</th>
							<td class="order-date"></td>
						</tr>
						<tr>
							<th scope="row">수령인</th>
							<td class="recipient-name"></td>
						</tr>
						<tr>
							<th scope="row">배송지</th>
							<td class="recipient-addr"></td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td class="recipient-hp"></td>
						</tr>
						<!-- <tr>
							<th scope="row">현금영수증/세금계산서</th>
							<td></td>
						</tr> -->
						<tr>
							<th scope="row">결제 금액</th>
							<td class="order-price"></td>
						</tr>
						<tr>
							<th scope="row">결제 수단</th>
							<td class="payment-method"></td>
						</tr>
					</tbody>
				</table>
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
