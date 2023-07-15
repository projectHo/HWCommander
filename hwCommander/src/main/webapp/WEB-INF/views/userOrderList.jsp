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
	function goOrderListDetailPage(){
		if(loginCheck()){
			location.href = "/user/orderListDetail.do?id=" + objectNum;
		}
	}
	let objectNum
	function clickOrderList(el){
		let orderNumber = $(el).find(".item-id").html();
		objectNum = orderNumber;
		goOrderListDetailPage();
	}
	

	$(function(){
		
	})
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
				<h2 class="mb-3">
					<span class="user-name"></span>
					<b>님의 주문내역</b>
				</h2>
				<div class="container">
					<table id="userOrderListTable" class="table" style="border-collapse: separate; border-spacing: 0; border: 1px solid black; border-radius: 14px 0 14px 0;">
						<thead>
							<tr>
								<th scope="col">주문일시</th>
								<th scope="col">상품명</th>
								<th scope="col">주문번호</th>
								<th scope="col">주문금액</th>
								<th scope="col">상태</th>
							</tr>
						</thead>
						<tbody class="table-group-divider">
							<c:forEach var="item" items="${orderMasterVOList}">
								<tr style="border-color: transparent; cursor: pointer;" onclick="javascript:clickOrderList(this)">
									<a href="javascript:goOrderListDetailPage()">
										<td scope="row">
											<script>
												var dateString = "${item.orderDate}";
												var parts = dateString.split(" ");
												var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
												var month = monthNames.indexOf(parts[1]) + 1;
												var formattedDate = parts[5] + "-" + ("0" + month).slice(-2) + "-" + parts[2];
												document.write(formattedDate);
											</script>
										</td>
										<td>${item.orderName}</td>
										<td class="item-id">${item.id}</td>
										<td>${item.totOrderPrice}</td>
										<td>${item.orderStateCdNm}</td>
									</a>
								</tr>
							</c:forEach>
						</tbody>
					</table>
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
	
	<%@ include file="./common/footer.jsp" %>
</body>
</html>
