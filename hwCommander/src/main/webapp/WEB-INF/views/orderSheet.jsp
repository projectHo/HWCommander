<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inicis.std.util.SignatureUtil"%>
<%@page import="java.util.*"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 이벤트 몰</title>
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
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>

<!-- 이니시스js -->
<!--테스트 JS-->
<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<!--운영 JS -->
<!-- 
<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
 -->

<%

	String mid					= "INIpayTest";		                    // 상점아이디					
	String signKey			    = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS";	// 웹 결제 signkey
	
	String mKey = SignatureUtil.hash(signKey, "SHA-256");

	String timestamp			= SignatureUtil.getTimestamp();			// util에 의해서 자동생성
	String oid			= "TESTORD0000001";	// 가맹점 주문번호(가맹점에서 직접 설정)
	String price				= String.valueOf(request.getAttribute("productPrice")); // 상품가격(특수기호 제외, 가맹점에서 직접 설정)
	
	Map<String, String> signParam = new HashMap<String, String>();

	signParam.put("oid", oid);
	signParam.put("price", price);
	signParam.put("timestamp", timestamp);

	String signature = SignatureUtil.makeSignature(signParam);
	
%>

<script>

    $(function() {
    	
    	$('#productListInfoTable').DataTable({ 
    	    bAutoWidth: false,
    	    columnDefs: [
    	    { width: "20%", targets : 0 },
    	    { width: "50%", targets: 1 },
    	    { width: "20%", targets: 2 }
    	    ],
    		// 표시 건수기능 숨기기
    		lengthChange: false,
    		// 검색 기능 숨기기
    		searching: false,
    		// 정렬 기능 숨기기
    		ordering: false,
    		// 정보 표시 숨기기
    		info: false,
    		// 페이징 기능 숨기기
    		paging: false
    	 });
    	
    	//orderer set
    	$("#ordererName").val("${loginUser.name}");
    	$("#ordererHpNumber").val("${loginUser.hpNumber}");
    	$("#ordererMail").val("${loginUser.mail}");
    	
    	//recipient set
    	/* 
    	private String recipientName;
    	private String recipientHpNumber;
    	private String recipientHpNumber2;
    	private String recipientAddr;
    	private String orderRequest;
    	private String deliveryRequest;
    	private String paymentMethod;
    	private String waybillNumber;
    	 */
    	
    });
    
function btnCheckOutClick() {
	//alert("나! 결제한다!!!");
	
	// 주문번호 생성하는 ajax 태운 뒤 성공 시 이니시스 호출해야함.

	$("#inicis_goodname").val("${productName}");
	
	$("#inicis_buyername").val($("#ordererName").val());
	$("#inicis_buyertel").val($("#ordererHpNumber").val());
	$("#inicis_buyeremail").val($("#ordererMail").val());
	
	console.log("테스트금액 : "+$("#inicis_price").val());
	
	INIStdPay.pay('inicisSendForm');
	
}


</script>
</head>
<body>

	<form id="order_sheet_form">
		<div class="container">
			<div class="card mt-4 mb-4">
				<div class="card-header">
					<div class="d-flex">
						<div class="me-auto d-flex align-items-center">상품 정보</div>
					</div>
				</div>
				<div class="card-body">
					<table id="productListInfoTable" class="table">
						<thead>
							<tr>
								<th>상품이미지</th>
								<th>상품명</th>
								<th>상품가격</th>
							</tr>
						</thead>

						<tbody>
							<c:forEach var="item" items="${productList}">
								<tr>
									<td>
                                      	<%-- 임시 몰루이미지 
                                      	<img class="img-fluid rounded mx-auto d-block" src="/resources/img/tempImage_200x200.png">
                                      	 --%>
                                      	<img class="img-fluid rounded mx-auto d-block" src="${item.productImage}" alt="" style="cursor:pointer; width:200px; height:200px; object-fit:contain;">
									</td>
									<td class="align-middle">${item.productName}</td>
									<td class="align-middle">${item.productPriceStr}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>


			<div class="card mt-4 mb-4">
				<div class="card-header">
					<div class="d-flex">
						<div class="me-auto d-flex align-items-center">주문자 정보</div>
					</div>
				</div>
				<div class="card-body">
					<div class="mb-3 row">
						<label for="ordererName" class="col-sm-2 col-form-label">주문자 이름</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="ordererName" name="ordererName" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="ordererHpNumber" class="col-sm-2 col-form-label">주문자 휴대폰번호</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="ordererHpNumber" name="ordererHpNumber" required>
						</div>
					</div>
					<div class="row">
						<label for="ordererMail" class="col-sm-2 col-form-label">주문자 이메일</label>
						<div class="col-sm-5">
							<input type="email" class="form-control" id="ordererMail" name="ordererMail" required>
						</div>
					</div>
				</div>
			</div>

			<div class="card mt-4 mb-4">
				<div class="card-header">
					<div class="d-flex">
						<div class="me-auto d-flex align-items-center">배송지 정보</div>
					</div>
				</div>
				<div class="card-body">
					<div class="mb-3 row">
						<label for="recipientName" class="col-sm-2 col-form-label">수령인</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="recipientName" name="recipientName" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientName" class="col-sm-2 col-form-label">연락처</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="recipientHpNumber" name="recipientHpNumber" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientHpNumber2" class="col-sm-2 col-form-label">추가 연락처</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="recipientHpNumber2" name="recipientHpNumber2" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientAddr" class="col-sm-2 col-form-label">주소</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" id="recipientAddr" name="recipientAddr" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="orderRequest" class="col-sm-2 col-form-label">주문 시 요청사항</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="orderRequest" name="orderRequest" required>
						</div>
					</div>
					<div class="row">
						<label for="deliveryRequest" class="col-sm-2 col-form-label">배송 시 요청사항</label>
						<div class="col-sm-5">
							<input type="text" class="form-control" id="deliveryRequest" name="deliveryRequest" required>
						</div>
					</div>
				</div>
			</div>

			<div class="mt-4 mb-4">
				<div class="d-grid">
					<a class="btn btn-secondary btn-block" id="btn_check_out" onclick="javascript:btnCheckOutClick()">결제하기</a>
				</div>
			</div>
		</div>
	</form>
	
	
<form id="inicisSendForm" method="post">
	<input type="hidden" name="version" value="1.0">
	<input type="hidden" name="gopaymethod" value="Card">
	<input type="hidden" name="mid" value="<%=mid%>">
	<input type="hidden" name="oid" value="<%=oid%>">
	<input type="hidden" id="inicis_price" name="price" value="<%=price%>">
	<input type="hidden" name="timestamp" value="<%=timestamp%>">
	<input type="hidden" name="signature" value="<%=signature%>">
	<input type="hidden" name="mKey" value="<%=mKey%>">
	<input type="hidden" name="currency" value="WON">
	<input type="hidden" id="inicis_goodname" name="goodname">
	<input type="hidden" id="inicis_buyername" name="buyername">
	<input type="hidden" id="inicis_buyertel" name="buyertel">
	<input type="hidden" id="inicis_buyeremail" name="buyeremail">
	
	<!-- todo wonho 로컬테스트 -->
	<input type="hidden" name="returnUrl" value="http://localhost:8080/order/inicisPayReturn.do">
	<input type="hidden" name="closeUrl" value="http://localhost:8080/order/inicisPayClose.do">
	<!-- todo wonho 운영 -->
	<!-- 
	<input type="hidden" name="returnUrl" value="http://hwcommander.com/order/inicisPayReturn.do">
	<input type="hidden" name="closeUrl" value="http://hwcommander.com/order/inicisPayClose.do">
	 -->
</form>

</body>
</html>
