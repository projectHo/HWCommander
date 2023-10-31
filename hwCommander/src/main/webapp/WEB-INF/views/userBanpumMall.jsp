<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

<link rel="stylesheet" href="/resources/css/banpumMall.css">
<script>
    $(function() {
        $('#banpunMallListTable').DataTable({ 
    	    bAutoWidth: false,
    	    columnDefs: [
                { width: "30%", targets : 0 },
                { width: "70%", targets: 1 }
    	    ],
            lengthChange: false,
            info: false,
    		ordering: false,
    		paging: true,
            pageLength : 5,
            language : {
                "search" : "검색 : ",
                "paginate" : {
                    "previous" : "이전",
                    "next" : "다음"
                }
            },
    	 });
    	$("#banpunMallListTable").on('click', 'tbody tr', function () {
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
			<div class="event-mall-background rounded p-5" style="width: 70%!important;" id="banpumMallTop">
                <div class="p-5">
                    <table id="banpunMallListTable" class="table table-hover" style="width:100%">
                        <thead>
                            <tr>
                                <th style="width: 30%;">상품이미지</th>
                                <th style="width: 70%;">상품정보</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${banpumMasterList}">
                                <tr name="${item.id}">
                                    <td>
                                        <div id="banpumMallIndicators${item.id}" class="carousel carousel-dark slide w-100" data-bs-ride="true">
                                            <div class="carousel-indicators">
                                                <button type="button" data-bs-target="#banpumMallIndicators${item.id}" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                                                <c:forEach var="i" begin="2" end="15">
                                                    <c:set var="key" value="banpumImage${i}" />
                                                    <c:if test="${not empty item[key]}">
                                                        <button type="button" data-bs-target="#banpumMallIndicators${item.id}" data-bs-slide-to="${i-1}" aria-label="Slide ${i}"></button>
                                                    </c:if>
                                                </c:forEach>
                                            </div>    
                                            <div class="carousel-inner">
                                                <div class="carousel-item active">
                                                    <img src="${item.banpumImage1}" class="d-block w-100 h-100" alt="...">
                                                </div>
                                                <c:forEach var="i" begin="2" end="15">
                                                    <c:set var="key" value="banpumImage${i}" />
                                                    <c:if test="${not empty item[key]}">
                                                        <div class="carousel-item">
                                                            <img src="${item[key]}" class="d-block w-100 h-100" alt="...">
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="td-caption">
                                        <p>이름 : ${item.banpumName}</p>
                                        <p>가격 : ${item.banpumPriceStr}</p>
                                        <p>설명 : ${item.banpumDescription}</p>
                                    </td>
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
