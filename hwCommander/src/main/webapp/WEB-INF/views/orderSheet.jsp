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
<link rel="stylesheet" href="/resources/css/users.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>

<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>

<!-- 23.07.08 다음 카카오 주소 api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 이니시스js -->
<!--테스트 JS-->

<!-- 
<script language="javascript" type="text/javascript" src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
 -->

<!--운영 JS -->
<script language="javascript" type="text/javascript" src="https://stdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>

<%

/* 
	String mid					= "INIpayTest";		                    // 상점아이디					
	String signKey			    = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS";	// 웹 결제 signkey
	 */
	 
	 String mid					= "hwmander66";		                    // 상점아이디					
	String signKey			    = "dTh3MWdEYUJ6ZFhSbEZ1dnNjbzJYZz09";	// 웹 결제 signkey
		
	String mKey = SignatureUtil.hash(signKey, "SHA-256");

	String timestamp			= SignatureUtil.getTimestamp();			// util에 의해서 자동생성
	//String oid			= "TESTORD0000001";	// 가맹점 주문번호(가맹점에서 직접 설정)
	String oid			= String.valueOf(request.getAttribute("orderId"));	// 가맹점 주문번호(가맹점에서 직접 설정)
	
	
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
    	$("#recipientName").val("${loginUser.name}");
    	$("#recipientHpNumber").val("${loginUser.hpNumber}");
    	
    	$("#recipientZipcode").val("${loginUser.zipcode}");
    	$("#recipientJibunAddr").val("${loginUser.jibunAddr}");
    	$("#recipientRoadAddr").val("${loginUser.roadAddr}");
    	$("#recipientDetailAddr").val("${loginUser.detailAddr}");
    	
        // 주소찾기
        $('#btn_addr_search').on("click", function () {
        	findDaumAddr();
        });
		// 08.26 상품들 아래 테두리
		for(let i = 1 ; i <= $(".order-items").length; i++){
			if(i === $(".order-items").length){
				$(".order-items").eq(i-1).children("td").addClass("border-bottom-0");
			}
		}
    });
    
function btnCheckOutClick() {
	if(!validationCheck()) {
		return false;
	}
	
	if($("#payment-method-card").prop("checked") == true){
		var orderRegistFormArray = [];
		
		var totOrderPrice = 0;
		$('#productListInfoTable tr').each(function (index) {
			if(0 != index) {
				// orderDetail Set
				var item = {
					id : $(this).find('input[name=id]').val(),
					productId : $(this).find('input[name=productId]').val(),
					productPrice : $(this).find('input[name=productPrice]').val(),
					productOrderQty : $(this).find('input[name=productOrderQty]').val()
				};
				orderRegistFormArray.push(item);
				
				//totOrderPrice set
				totOrderPrice += parseInt($(this).find('input[name=productPrice]').val());
			}
		});
		
		if(2 < $('#productListInfoTable tr').length) {
			orderName += "외 "+($('#productListInfoTable tr').length-1)+"건";
		}
		
		
		var orderMasterVO = {
			id : $('input[name=oid]').val(),
			orderName : "${orderName}",
			totOrderPrice : totOrderPrice,
			orderStateCd : "01",
			ordererUserId : "${loginUser.id}",
			ordererName : $("#ordererName").val(),
			ordererHpNumber : $("#ordererHpNumber").val(),
			ordererMail : $("#ordererMail").val(),
			recipientName : $("#recipientName").val(),
			recipientHpNumber : $("#recipientHpNumber").val(),
			recipientHpNumber2 : $("#recipientHpNumber2").val(),
			recipientJibunAddr : $("#recipientJibunAddr").val(),
			recipientRoadAddr : $("#recipientRoadAddr").val(),
			recipientDetailAddr : $("#recipientDetailAddr").val(),
			recipientZipcode : $("#recipientZipcode").val(),
			orderRequest : $("#orderRequest").val(),
			deliveryRequest : $("#deliveryRequest").val(),
			paymentMethod : "Card",
			videoRequestCd : "01"
		};
		
		var ajaxData = {
				orderMasterVO : JSON.stringify(orderMasterVO),
				orderDetailVOList : JSON.stringify(orderRegistFormArray)
		};
			
		$.ajax({
			type: "post",
			url: "/order/orderRegistLogic.do",
			data: ajaxData,
			dataType: 'json',
			success: function (data) {
				
				console.log(data);
				
				if(data == 2) {
					// ajax success 시 결제모듈 호출
					$("#inicis_goodname").val("${orderName}");
					$("#inicis_buyername").val($("#ordererName").val());
					$("#inicis_buyertel").val($("#ordererHpNumber").val());
					$("#inicis_buyeremail").val($("#ordererMail").val());
					
					INIStdPay.pay('inicisSendForm');
				}else {
					alert("주문서 작성에 오류가 발생했습니다.\n 관리자에게 문의하세요.");
				}
			}
		});
	}else if($("#payment-method-account-transfer").prop("checked") == true) {
		var orderRegistFormArray = [];
		
		var totOrderPrice = 0;
		$('#productListInfoTable tr').each(function (index) {
			if(0 != index) {
				// orderDetail Set
				var item = {
					id : $(this).find('input[name=id]').val(),
					productId : $(this).find('input[name=productId]').val(),
					productPrice : $(this).find('input[name=productPrice]').val(),
					productOrderQty : $(this).find('input[name=productOrderQty]').val()
				};
				orderRegistFormArray.push(item);
				
				//totOrderPrice set
				totOrderPrice += parseInt($(this).find('input[name=productPrice]').val());
			}
		});
		
		if(2 < $('#productListInfoTable tr').length) {
			orderName += "외 "+($('#productListInfoTable tr').length-1)+"건";
		}
		
		
		var orderMasterVO = {
			id : $('input[name=oid]').val(),
			orderName : "${orderName}",
			totOrderPrice : totOrderPrice,
			orderStateCd : "01",
			ordererUserId : "${loginUser.id}",
			ordererName : $("#ordererName").val(),
			ordererHpNumber : $("#ordererHpNumber").val(),
			ordererMail : $("#ordererMail").val(),
			recipientName : $("#recipientName").val(),
			recipientHpNumber : $("#recipientHpNumber").val(),
			recipientHpNumber2 : $("#recipientHpNumber2").val(),
			recipientJibunAddr : $("#recipientJibunAddr").val(),
			recipientRoadAddr : $("#recipientRoadAddr").val(),
			recipientDetailAddr : $("#recipientDetailAddr").val(),
			recipientZipcode : $("#recipientZipcode").val(),
			orderRequest : $("#orderRequest").val(),
			deliveryRequest : $("#deliveryRequest").val(),
			paymentMethod : "account-transfer",
			videoRequestCd : "01"
		};
		
		var ajaxData = {
				orderMasterVO : JSON.stringify(orderMasterVO),
				orderDetailVOList : JSON.stringify(orderRegistFormArray)
		};
			
		$.ajax({
			type: "post",
			url: "/order/orderRegistLogic.do",
			data: ajaxData,
			dataType: 'json',
			success: function (data) {
				
				console.log(data);
				
				if(data == 2) {
					alert("계좌로 입금해주시면 주문이 완료됩니다. \n계좌번호 : 645-910900-07207 하나은행 이해창(현우의 컴퓨터 공방) \n계좌번호는 주문내역에서 확인 가능합니다!");
					location.href = "/user/orderList.do";
				}else {
					alert("주문서 작성에 오류가 발생했습니다.\n 관리자에게 문의하세요.");
				}
			}
		});
	}
}

function findDaumAddr() {
	new daum.Postcode({
        oncomplete: function(data) {
        	console.log(data);
        	
            $("#recipientZipcode").val(data.zonecode);
            $("#recipientJibunAddr").val(data.jibunAddress);
            $("#recipientRoadAddr").val(data.roadAddress);
            $("#recipientDetailAddr").val("");
        }
    }).open();
}

function validationCheck() {
	const numberCheck = /^[0-9]+$/;
	
	if($('#ordererName').val().trim() == "" || $('#ordererName').val().trim() == null) {
		alert("주문자 이름을 입력하세요.");
		$('#ordererName').focus();
		return false;
	}
	
	if($('#ordererHpNumber').val() == "" || $('#ordererHpNumber').val() == null) {
		alert("주문자 휴대폰번호를 입력하세요.");
		$('#ordererHpNumber').focus();
		return false;
	}
	
	if (!numberCheck.test($('#ordererHpNumber').val())) {
	    alert("주문자 휴대폰번호는 숫자만 입력 가능합니다.");
	    $('#ordererHpNumber').focus();
	    return false;
	}
	
	if(11 != $('#ordererHpNumber').val().length && 10 != $('#ordererHpNumber').val().length) {
		alert("주문자 휴대폰번호는 11자리 또는 10자리여야 합니다.");
		$('#ordererHpNumber').focus();
		return false;
	}
	
	if($('#ordererMail').val().trim() == "" || $('#ordererMail').val().trim() == null) {
		alert("주문자 이메일을 입력하세요.");
		$('#ordererMail').focus();
		return false;
	}
	
	const mailCheckRegExp = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");

	if (!mailCheckRegExp.test($('#ordererMail').val())) {
		alert("올바른 주문자 이메일을 입력하세요.");
		$('#ordererMail').focus();
		return false;
	}
	
	if($('#recipientName').val().trim() == "" || $('#recipientName').val().trim() == null) {
		alert("수령인을 입력하세요.");
		$('#recipientName').focus();
		return false;
	}
	
	if($('#recipientHpNumber').val() == "" || $('#recipientHpNumber').val() == null) {
		alert("수령인 휴대폰번호를 입력하세요.");
		$('#recipientHpNumber').focus();
		return false;
	}
	
	if (!numberCheck.test($('#recipientHpNumber').val())) {
	    alert("수령인 휴대폰번호는 숫자만 입력 가능합니다.");
	    $('#recipientHpNumber').focus();
	    return false;
	}
	
	if(11 != $('#recipientHpNumber').val().length && 10 != $('#recipientHpNumber').val().length) {
		alert("수령인 휴대폰번호는 11자리 또는 10자리여야 합니다.");
		$('#recipientHpNumber').focus();
		return false;
	}
	
	if($('#recipientHpNumber2').val() != "" && $('#recipientHpNumber2').val() != null) {
		if (!numberCheck.test($('#recipientHpNumber2').val())) {
		    alert("수령인 추가 휴대폰번호는 숫자만 입력 가능합니다.");
		    $('#recipientHpNumber2').focus();
		    return false;
		}
		
		if(11 != $('#recipientHpNumber2').val().length && 10 != $('#recipientHpNumber2').val().length) {
			alert("수령인 추가 휴대폰번호는 11자리 또는 10자리여야 합니다.");
			$('#recipientHpNumber2').focus();
			return false;
		}
	}
	
	if($('#recipientZipcode').val().trim() == "" || $('#recipientZipcode').val().trim() == null) {
		alert("주소를 입력하세요.");
		$('#btn_addr_search').focus();
		return false;
	}
	
	if($('#recipientJibunAddr').val().trim() == "" || $('#recipientJibunAddr').val().trim() == null) {
		alert("주소를 입력하세요.");
		$('#btn_addr_search').focus();
		return false;
	}
	
	if($('#recipientRoadAddr').val().trim() == "" || $('#recipientRoadAddr').val().trim() == null) {
		alert("주소를 입력하세요.");
		$('#btn_addr_search').focus();
		return false;
	}
	
	if($('#recipientDetailAddr').val().trim() == "" || $('#recipientDetailAddr').val().trim() == null) {
		alert("상세주소를 입력하세요.");
		$('#recipientDetailAddr').focus();
		return false;
	}
	
	return true;
}

// 08.26 추천인 확인 기능 추가
var targetId = null;

function recDupliChk(id) {
	if(id == "") {
		alert("추천인을 입력하세요.");
		return false;
	}
	
	$.ajax({
        type: "post",
        url: "/user/idDupliChk.do",
        data: {
        	"id" : id
        },
        dataType: 'json',
        success: function (data) {
        	if(data == 0) {
				targetId = null;
				alert("아이디가 정확하지 않습니다.");
        		$("#recommander").addClass("is-invalid");
				$("#recommander").next().addClass("border-danger");
        	}else {
        		targetId = id;
        		$("#recommander").removeClass("is-invalid");
				$("#recommander").next().removeClass("border-danger");
        		alert("확인되었습니다.");
        	}
        }
    });
}

</script>
</head>
<body class="order-sheet-body">

	<form id="order_sheet_form">
		<div class="mx-auto container pt-3 pb-3">
			<div class="card mt-4">
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
								<tr class="order-items">
									<td>
										<input type="hidden" name="id" value="<%=oid%>">
										<input type="hidden" name="productId" value="${item.id}">
										<input type="hidden" name="productPrice" value="${item.productPrice}">
										<!-- todo wonho 지금은 장바구니쪽 로직이 없으므로 수량 1로 고정함. -->
										<input type="hidden" name="productOrderQty" value="1">
										
										<input type="hidden" name="productName" value="${item.productName}">
										
										
										<%-- 임시 몰루이미지 
										<img class="img-fluid rounded mx-auto d-block" src="/resources/img/tempImage_600x600.png">
										--%>
										<img class="img-fluid rounded d-block" src="${item.productImage}" alt="" style="cursor:pointer; width:200px; height:200px; object-fit:contain;">
									</td>
									<td class="align-middle">${item.productName}</td>
									<td class="align-middle">${item.productPriceStr}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="card order-sheet-card-border">
				<div class="card-header">
					<div class="d-flex">
						<div class="me-auto d-flex align-items-center">주문자 정보</div>
					</div>
				</div>
				<div class="card-body">
					<div class="mb-3 row">
						<label for="ordererName" class="col-md-2 col-form-label">주문자 이름</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="ordererName" name="ordererName" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="ordererHpNumber" class="col-md-2 col-form-label">주문자 휴대폰번호</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="ordererHpNumber" name="ordererHpNumber" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="ordererMail" class="col-md-2 col-form-label">주문자 이메일</label>
						<div class="col-md-5">
							<input type="email" class="form-control" id="ordererMail" name="ordererMail" required>
						</div>
					</div>
					<div class="row">
						<label for="recommander" class="col-md-2 col-form-label">추천인</label>
						<div class="col-md-5">
							<div class="input-group">
								<input type="text" class="form-control" id="recommander" name="recommander" required>
								<button type="button" class="btn btn-outline-secondary" maxlength="25" id="btn_rec_dupli_chk" onclick="javascript:recDupliChk($('#recommander').val().trim())">중복확인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="card mb-4">
				<div class="card-header">
					<div class="d-flex">
						<div class="me-auto d-flex align-items-center">배송지 정보</div>
					</div>
				</div>
				<div class="card-body pb-0">
					<div class="mb-3 row">
						<label for="recipientName" class="col-md-2 col-form-label">수령인</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="recipientName" name="recipientName" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientName" class="col-md-2 col-form-label">수령인 휴대폰번호</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="recipientHpNumber" name="recipientHpNumber" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientHpNumber2" class="col-md-2 col-form-label">수령인 추가 휴대폰번호</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="recipientHpNumber2" name="recipientHpNumber2" required>
						</div>
					</div>
					<div class="mb-3 row d-md-flex">
						<label for="recipientZipcode" class="col-md-2 col-form-label">우편번호</label>
						<div class="input-group order-custom-input-group col-md-5">
							<input type="text" class="form-control" id=recipientZipcode name="recipientZipcode" readonly="readonly" required>
							<button type="button" class="btn btn-secondary" id="btn_addr_search">주소찾기</button>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientJibunAddr" class="col-md-2 col-form-label">지번주소</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id=recipientJibunAddr name="recipientJibunAddr" readonly="readonly" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientRoadAddr" class="col-md-2 col-form-label">도로명주소</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id=recipientRoadAddr name="recipientRoadAddr" readonly="readonly" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="recipientDetailAddr" class="col-md-2 col-form-label">상세주소</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id=recipientDetailAddr name="recipientDetailAddr" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="orderRequest" class="col-md-2 col-form-label">주문 시 요청사항</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="orderRequest" name="orderRequest" required>
						</div>
					</div>
					<div class="mb-3 row">
						<label for="deliveryRequest" class="col-md-2 col-form-label">배송 시 요청사항</label>
						<div class="col-md-5">
							<input type="text" class="form-control" id="deliveryRequest" name="deliveryRequest" required>
						</div>
					</div>
					<div class="row">
						<label class="col-md-2 col-form-label">결제 방법</label>
						<div class="col-md-5">
							<div class="form-check form-check-inline">
								<input class="form-check-input" name="payment-method" type="radio" id="payment-method-card" value="option1">
								<label class="form-check-label pt-1" for="payment-method-card">카드</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" name="payment-method" type="radio" id="payment-method-account-transfer" value="option1">
								<label class="form-check-label pt-1" for="payment-method-account-transfer">계좌이체</label>
							</div>
						</div>
					</div>
					<div class="d-grid p-3">
						<a class="btn btn-secondary btn-block" id="btn_check_out" onclick="javascript:btnCheckOutClick()">결제하기</a>
					</div>
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
	<%-- 
	<input type="hidden" name="returnUrl" value="http://localhost:8080/order/inicisPayReturn.do">
	<input type="hidden" name="closeUrl" value="http://localhost:8080/order/inicisPayClose.do?id=<%=oid%>">
	 --%>
	<!-- todo wonho 운영 -->
	<input type="hidden" name="returnUrl" value="http://hwcommander.com/order/inicisPayReturn.do">
	<input type="hidden" name="closeUrl" value="http://hwcommander.com/order/inicisPayClose.do?id=<%=oid%>">
</form>

</body>
</html>
