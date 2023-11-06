<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<head>
<title>현우의 컴퓨터 공방 - 마이페이지</title>
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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 주문 현황
	let objectNum;
	let objStateCd;
	function goOrderListDetailPage(){
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
		if(loginCheck()) {
			location.href = "/user/refundInfo.do?id=" + $(el).find(".item-id").attr("name");
		}
	}
	function clickRefundDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-refund-detail").css("display","block")
		setTimeout(() => {
			$(".card-refund-detail").addClass("show");
		}, 100);;
	}
	
	// 문의 내역
	function clickInquiryDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-inquiry-detail").css("display","block")
		setTimeout(() => {
			$(".card-inquiry-detail").addClass("show");
		}, 100);;
	}

	
	// 견적저장소
	function clickEstimateStorageDetail(){
		if(loginCheck()) {
			location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
		}
	}
	// 내 정보
	function clickUserInfoDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-user-info-detail").css("display","block")
		setTimeout(() => {
			$(".card-user-info-detail").addClass("show");
		}, 100);
	}
	function infoCheckHp(){
		const numberCheck = /^[0-9]+$/;	
		if ($('.recipient-next-hp').val().length>=1 && !numberCheck.test($('.recipient-next-hp').val())) {
			alert("휴대폰번호는 숫자만 입력 가능합니다.");
			$('.recipient-next-hp').val("");
			$('.recipient-next-hp').focus();
		}
	}
	function infoSaveAddrBtn(){
		if($(".recipient-detail-addr").val() === ""){
			alert("상세 주소를 입력해주세요!");
			$(".recipient-detail-addr").focus();
		}else{
			$.ajax({
				type: "post",
				url: "/user/orderUpdateAddrsLogic.do",
				data: {
					id: $(".order-num").html(),
					recipientJibunAddr: $(".recipient-jibun-addr").val(),
					recipientRoadAddr: $(".recipient-road-addr").val(),
					recipientDetailAddr: $(".recipient-detail-addr").val(),
					recipientZipcode: $(".recipient-zip-code").val()
				},
				dataType: "json",
				success: function(response) {
					alert("정상적으로 수정됐습니다!");
				},
				error: function(xhr, status, error) {
					alert("수정에 실패했습니다.. 다시 입력해주세요!");
				}
			});
		}
	}
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
	function editAddrBtn(){
		findDaumAddr();
	}
	// 회원 탈퇴
	function clickSecessionDetail(){
		$(".card-list").removeClass("show").css("display","none");
		$(".card-secession-detail").css("display","block")
		setTimeout(() => {
			$(".card-secession-detail").addClass("show");
		}, 100);
	}

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
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:alert('준비중입니다.')">
												사업장 관리
											</a>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingTwo">
									<button class="accordion-button accordion-button-single collapsed" onclick="javascript:alert('준비중입니다.')">
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
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickInquiryDetail()">
												문의 사항
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:alert('준비중입니다.')">
												리뷰 관리
											</a>
										</div>
									</div>
								</div>
							</div>
							<div class="accordion-item">
								<h2 class="accordion-header" id="flush-headingOne">
									<button class="accordion-button accordion-button-single collapsed" type="button" onclick="javascript:clickEstimateStorageDetail()">
										견적 저장소
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
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickUserInfoDetail()">
												내 정보
											</a>
											<a href="javascript:void(0)" class="list-group-item list-group-item-action" onclick="javascript:clickSecessionDetail()">
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
										<c:forEach var="item" items="${refundInfoVOList}">
											<tr style="cursor: pointer;" onclick="javascript:clickRefundList(this)">
												<a href="javascript:goOrderListDetailPage()">
													<c:forEach var="orderItem" items="${orderMasterVOList}">
														<c:if test="${orderItem.id == item.orderId}">
															<td scope="row">${orderItem.orderDateStr}</td>
															<td>${orderItem.orderName}</td>
														</c:if>
													</c:forEach>
													<td class="item-id" name="${item.id}">${item.orderId}</td>
													<td>${item.totRefundPrice}원</td>
													<td class="item-cd" cd="${item.refundStateCd}">${item.refundStateCdNm}</td>
												</a>
											</tr>
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
							<div class="card-body fade card-list card-inquiry-detail">
								<h2 class="card-title">Hwcommander</h2>
								<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님의 문의사항</h6>
								<p class="card-text">고객센터 전화를 통해 문의해주시기 바랍니다.</p>
								<a href="tel:010-7625-0478" class="card-link">010-7625-0478</a>
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
							<div class="card-body fade card-list card-user-info-detail">
								<h2 class="card-title">Hwcommander</h2>
								<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님의 회원정보</h6>
								<p class="card-text order-tbody">
									<table class="table table-light" style="border-collapse: separate;">
										<thead>
											<tr>
												<th scope="col" style="width: 20%;">이름</th>
												<th scope="col" style="font-weight: 400;">${loginUser.name}</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row">생년월일</th>
												<td>${loginUser.birth}</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">휴대폰 번호</th>
												<td>
													<div class="input-group">
														<input maxlength="11" type="text" class="form-control recipient-next-hp" aria-label="Recipient's another hpNumber" aria-describedby="button-addon" onclick="javascript:infoCheckHp()" value="${loginUser.hpNumber}">
														<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon">휴대폰 인증</button>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">주소</th>
												<td>
													<div class="input-group">
														<input type="text" class="form-control recipient-zip-code" aria-label="Recipient's addr" aria-describedby="button-addon2" readonly="readonly" value="${loginUser.zipcode}">
														<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon2" onclick="javascript:editAddrBtn()">찾기</button>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">지번주소</th>
												<td>
													<input type="text" class="form-control recipient-jibun-addr" aria-label="Recipient's Ji addr" readonly="readonly" value="${loginUser.jibunAddr}">
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">도로명주소</th>
												<td>
													<input type="text" class="form-control recipient-road-addr" aria-label="Recipient's Road addr" readonly="readonly" value="${loginUser.roadAddr}">
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">상세주소</th>
												<td>
													<div class="input-group">
														<input type="text" class="form-control recipient-detail-addr" aria-label="Recipient's Detail addr" aria-describedby="button-addon3" value="${loginUser.detailAddr}">
														<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon3" onclick="javascript:infoSaveAddrBtn()">저장</button>
													</div>
												</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">가입일</th>
												<td>${loginUser.regDtm}</td>
											</tr>
											<tr>
												<th scope="row" class="align-middle">E-mail</th>
												<td>
													<div class="input-group">
														<input type="text" class="form-control" aria-label="Recipient's delivery required" aria-describedby="button-addon5" value="${loginUser.mail}">
														<button class="btn btn-outline-secondary btn-s" type="button" id="button-addon5" onclick="javascript:editDeliveryReqBtn()">저장</button>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</p>
							</div>
						<!-- 회원 탈퇴 -->
							<div class="card-body fade card-list card-secession-detail">
								<h2 class="card-title">Hwcommander</h2>
								<h6 class="card-subtitle mb-2 text-muted">${loginUser.name}님</h6>
								<p class="card-text">
									<div class="form-floating mb-3 col-6 mx-auto mt-5">
										<input type="text" class="form-control" id="id">
										<label for="floatingInput">ID</label>
									</div>
									<div class="form-floating mb-5 col-6 mx-auto">
										<input type="password" class="form-control" id="pw">
										<label for="floatingPassword">Password</label>
									</div>
									<div class="d-flex justify-content-center">
										<button type="button" class="btn btn-outline-secondary">회원 탈퇴</button>
									</div>
								</p>
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