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
	let aa = "${orderMasterVOList}";
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
	function cancleOrderBtn(el){
		if(loginCheck()){
			if(confirm("정말 취소 하시겠습니까?")){
				$.ajax({
					type: "post",
					url: "/order/orderDeleteLogic.do",
					data: {
						id: $(el).attr("val")
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
	}
	function goRefundM(el){
		if(loginCheck()){
			location.href = "/user/refundM.do?id=" + $(el).attr("refund-id");
		}
	}
	$(function(){
		
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
				<h1 class="pt-2 ps-2">${loginUser.name}님의 주문 내역</h1>
				<c:forEach items="${orderMasterVOList}" var="item">
					<c:if test="${item.orderStateCd < 09 || item.orderStateCd == 11}">
						<div class="cards mb-2 p-2">
							<h3 class="pt-1 mb-0">${item.orderDateStr}</h3>
							<div class="goods-box p-3 pb-2">
								<div class="goods-header">
									<div class="goods-name">상품명 : ${item.orderName}</div>
								</div>
								<div class="goods-body pb-2">
									<div class="goods-state">배송현황 : <small>${item.orderStateCdNm}</small></div>
									<div class="goods-num">주문번호 :${item.id}</div>
									<div class="goods-price">금액 : ${item.totOrderPriceStr}원</div>
								</div>
								<div class="goods-button d-flex justify-content-between">
									<c:if test="${item.orderStateCd == 1}">
										<button class="btn btn-outline-secondary" val="${item.id}" onclick="javascript:cancleOrderBtn(this)">주문취소</button>
									</c:if>
									<c:if test="${item.orderStateCd > 1 && item.orderStateCd != 11}">
										<button class="btn btn-outline-secondary" refund-id="${item.id}" onclick="javascript:goRefundM(this)">환불요청</button>
									</c:if>
									<button class="btn btn-outline-primary">상세보기</button>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
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