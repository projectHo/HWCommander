<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<head>
<title>현우의 컴퓨터 공방 - 견적산출</title>
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
<link rel="stylesheet" href="/resources/css/mypage.css">
<script>
	// 주문 현황
	let objectNum;
	let objStateCd;
	function goOrderListDetailPage(){
		let aa = "${orderMasterVOList}";
		let bb = "${loginUser}";
		if(objStateCd > 6){
			alert("상태가 배송단계로 넘어갔을 경우 배송지 변경은 불가합니다!");
		}
		location.href = "/user/orderListDetail.do?id=" + objectNum;
	}	
	function clickOrderList(el){
		objStateCd = $(el).find(".item-cd").attr("cd");
		let orderNumber = $(el).find(".item-id").html();
		objectNum = encodeURIComponent(orderNumber);
		goOrderListDetailPage();
	}
	function clickOrderDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-order-detail").css("display","block");
		setTimeout(() => {
			$(".card-order-detail").addClass("show");
		}, 100);
	}

	// 환불 내역
	function clickRefundList(el){
	}
	function clickRefundDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-refund-detail").css("display","block")
		setTimeout(() => {
			$(".card-refund-detail").addClass("show");
		}, 100);;
	}
	$(function(){
		$(".card-list").removeClass("show").css("display","none");
	})
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<!-- 작업영역 -->
			<div class="estimateCalc_background p-2 pt-5 pb-5" style="width: 70%!important; height: 600px;">
				<div class="row h-100">
					<div class="col-2 ps-4 pe-0">
						<div class="accordion accordion-flush" id="accordionFlushExample">
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingOne">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false">
										구매 정보
									</button>
								</h2>
								<div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
									<div class="accordion-body">
										<div class="list-group list-group-flush">
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickOrderDetail()">
												주문 현황
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickRefundDetail()">
												환불 내역
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:alert('준비중입니다.')">
												배송지 관리(주소록)
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action">
												사업장 관리
											</a>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingTwo">
									<button class="accordion-button accordion-button-single collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false">
										혜택 정보
									</button>
								</h2>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingThree">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false">
										내 글 관리
									</button>
								</h2>
								<div id="flush-collapseThree" class="accordion-collapse collapse" aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
									<div class="accordion-body">
										<div class="list-group list-group-flush">
											<a href="javascript:void(0)" class="list-group-item list-group-item-action">
												문의 사항
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action">
												리뷰 관리
											</a>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingOne">
									<button class="accordion-button accordion-button-single collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFour" aria-expanded="false">
										장바구니
									</button>
								</h2>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingOne">
									<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFive" aria-expanded="false">
										회원 정보
									</button>
								</h2>
								<div id="flush-collapseFive" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
									<div class="accordion-body">
										<div class="list-group list-group-flush">
											<a href="javascript:void(0)" class="list-group-item list-group-item-action">
												내 정보
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action">
												회원 탈퇴
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-10">
						<div class="card h-100">
						<!-- 주문 현황 -->
							<div class="card-body fade card-list card-order-detail">
								<h2 class="card-title">Hwcommander</h2>
								<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님의 주문내역</h6>
								<p class="card-text order-tbody">
									<table class="table table-hover table-light">
										<thead>
											<tr>
												<th scope="col">주문날짜</th>
												<th scope="col">상품명</th>
												<th scope="col">주문번호</th>
												<th scope="col">주문금액</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="item" items="${orderMasterVOList}">
												<c:choose>
        											<c:when test="${item.orderStateCd < 09}">
														<tr style="cursor: pointer;" onclick="javascript:clickOrderList(this)">
															<a href="javascript:goOrderListDetailPage()">
																<td scope="row">${item.orderDateStr}</td>
																<td>${item.orderName}</td>
																<td class="item-id">${item.id}</td>
																<td>${item.totOrderPriceStr}</td>
																<td class="item-cd" cd="${item.orderStateCd}">${item.orderStateCdNm}</td>
															</a>
														</tr>
													</c:when>
												</c:choose>
											</c:forEach>
										</tbody>
									</table>
								</p>
							</div>
						<!-- 진행 현황 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						<!-- 환불 내역 -->
						<div class="card-body fade card-list card-refund-detail">
							<h2 class="card-title">Hwcommander</h2>
							<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님의 환불내역</h6>
							<p class="card-text order-tbody">
								<table class="table table-hover table-light">
									<thead>
										<tr>
											<th scope="col">주문날짜</th>
											<th scope="col">상품명</th>
											<th scope="col">주문번호</th>
											<th scope="col">주문금액</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="item" items="${orderMasterVOList}">
											<c:choose>
												<c:when test="${item.orderStateCd >= 09}">
													<tr style="cursor: pointer;" onclick="javascript:clickRefundList(this)">
														<a href="javascript:goOrderListDetailPage()">
															<td scope="row">${item.orderDateStr}</td>
															<td>${item.orderName}</td>
															<td class="item-id">${item.id}</td>
															<td>${item.totOrderPriceStr}</td>
															<td class="item-cd" cd="${item.orderStateCd}">${item.orderStateCdNm}</td>
														</a>
													</tr>
												</c:when>
											</c:choose>
										</c:forEach>
									</tbody>
								</table>
							</p>
						</div>
						<!-- 배송지 관리 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						<!-- 사업장 관리 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						

						<!-- 문의 사항 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						<!-- 리뷰 관리 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						

						<!-- 내 정보 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						<!-- 회원 탈퇴 -->
							<div class="card-body fade card-list">
								<h5 class="card-title">Card title</h5>
								<h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
								<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
								<a href="#" class="card-link">Card link</a>
								<a href="#" class="card-link">Another link</a>
							</div>
						</div>
					</div>
				</div>
				
				
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
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
</body>
</html>