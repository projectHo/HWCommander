<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 반품몰</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css">
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
    let aa = "${banpumMasterList}";
    $(function() {
        $('#banpunMallListTable').DataTable({ 
    	    bAutoWidth: false,
    	    columnDefs: [
                { width: "30%", targets : 0 },
                { width: "70%", targets: 1 }
    	    ],
            lengthChange: false,
            info: false,
    		// 정렬 기능 숨기기
    		ordering: false,
    		// 페이징 기능 숨기기
    		paging: true,
            language : {
                "search" : "검색 : ",
                "paginate" : {
                    "previous" : "이전",
                    "next" : "다음"
                }
            },
    	 });
    	$("#banpunMallListTable").on('click', 'tbody tr img', function () {
    		var banpumId = $(this).attr("name");
    		location.href = "/userBanpumMallDetail.do?banpumMallId="+banpumId;
    	});
        $('#banpunMallListTable').on('page.dt', function () {
            $('html, body').animate({
                scrollTop: $("#banpumMallTop").offset().top - 100
            }, 10);
        });
    });
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<div class="estimateCalc_background rounded p-5" style="width: 70%!important;" id="banpumMallTop">
                <h2 class="mt-4 d-flex justify-content-center">반품몰</h2>
				<table id="banpunMallListTable" class="table table-hover" style="width:100%">
                    <thead>
                        <tr>
                            <th>상품이미지</th>
                            <th>상품정보</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${banpumMasterList}">
                            <tr>
                                <td>
                                    <div class="row">
                                        <div class="col">
                                            <img src="..." alt="..." style="cursor:pointer; width:100px; height:100px; object-fit:contain;" name="${item.id}">
                                        </div>
                                        <div class="col">
                                            <img src="..." alt="..." style="cursor:pointer; width:100px; height:100px; object-fit:contain;" name="${item.id}">
                                        </div>
                                        <div class="col">
                                            <img src="..." alt="..." style="cursor:pointer; width:100px; height:100px; object-fit:contain;" name="${item.id}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <img src="..." alt="..." style="cursor:pointer; width:100px; height:100px; object-fit:contain;" name="${item.id}">
                                        </div>
                                        <div class="col">
                                            <img src="..." alt="..." style="cursor:pointer; width:100px; height:100px; object-fit:contain;" name="${item.id}">
                                        </div>
                                        <div class="col">
                                            <img src="..." alt="..." style="cursor:pointer; width:100px; height:100px; object-fit:contain;" name="${item.id}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <img src="..." alt="..." style="cursor:pointer; width:100px; height:100px; object-fit:contain;" name="${item.id}">
                                        </div>
                                        <div class="col">
                                            <img src="..." alt="..." style="cursor:pointer; width:100px; height:100px; object-fit:contain;" name="${item.id}">
                                        </div>
                                        <div class="col">
                                            <img src="..." alt="..." style="cursor:pointer; width:100px; height:100px; object-fit:contain;" name="${item.id}">
                                        </div>
                                    </div>
                                </td>
                                <td>${item.banpumDescription}</td>
                            </tr>
                        </c:forEach>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
                        </tr>
                        <tr>
                            <td>123</td>
                            <td>123</td>
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
