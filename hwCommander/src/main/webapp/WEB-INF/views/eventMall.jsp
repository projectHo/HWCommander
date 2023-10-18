<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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

<script>
    $(function() {
    	$('#eventMallListTable').DataTable({ 
    	    bAutoWidth: false,
    	    columnDefs: [
    	    { width: "30%", targets : 0 },
    	    { width: "70%", targets: 1 }
    	    ]
    	 });
    	
    	/* 
    	$("#eventMallListTable").on('click', 'tbody tr', function () {
    	    var row = $("#eventMallListTable").DataTable().row($(this)).data();
    	    console.log(row);
    	});
    	 */
    	 
    	$("#eventMallListTable").on('click', 'tbody tr img', function () {
    		var productId = $(this).attr("name");
    		location.href = "/eventMallDetail.do?productId="+productId;
    	});
    	
    	
    	/* 
    	$("#example").DataTable({
    		// 표시 건수기능 숨기기
    		lengthChange: true,
    		// 검색 기능 숨기기
    		searching: true,
    		// 정렬 기능 숨기기
    		ordering: true,
    		// 정보 표시 숨기기
    		info: true,
    		// 페이징 기능 숨기기
    		paging: true
    	});
    	 */
    	
    });
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<div class="" style="width: 70%!important;">
				<div class="w-100 row align-items-center mt-4 mb-4">
					<div class="card mb-4">
                    	<div class="card-header">
							<div class="d-flex">
								<div class="me-auto d-flex align-items-center">이벤트 몰</div>
							</div>
						</div>
						<div class="card-body">
							<table id="eventMallListTable" class="table">
								<thead>
									<tr>
										<th>상품이미지</th>
										<th>상품정보</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${eventMallList}">
										<tr>
                                            <td>
                                            	<%-- 임시 몰루이미지 
                                            	<img class="img-fluid rounded mx-auto d-block" src="/resources/img/tempImage_200x200.png" alt="" style="cursor:pointer;" name="${item.id}">
                                            	 --%>
                                            	<img class="img-fluid rounded mx-auto d-block" src="${item.productImage}" alt="" style="cursor:pointer; width:350px; height:350px; object-fit:contain;" name="${item.id}">
                                            </td>
                                            <td>${item.eventMallInfo}</td>
                                       	</tr>
									</c:forEach>
								</tbody>
							</table>
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
	
	<%@ include file="./common/footer.jsp" %>
	
</body>
</html>
