<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 이벤트몰</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap & jquery -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<link rel="stylesheet" href="/resources/css/ver_02/banpummall.css">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script>
    $(function() {
    });
    function goDetailPage(el){
        location.href = "/userBanpumMallDetail.do?banpumMallId="+$(el).attr("item");
    }
</script>
</head>
<body>

	<%@ include file="./common/header.jsp" %>
    <div class="w-100" style="background-color: #0F0F14;">
        <div class="container banpum-mall-container px-5 py-5">
            <div class="d-flex flex-column gap-4">

                <c:forEach var="i" begin="0" end="${fn:length(banpumMasterList)-1}" step="2">
                    <div class="d-flex gap-4">
                        <c:forEach var="j" begin="${i}" end="${i+1}">
                            <div class="d-flex flex-column gap-3 w-50">
                                
                                <div class="banpummall-item-boxs aspect-ratio-3x4" item="${banpumMasterList[j].id}" onclick="javascript:goDetailPage(this)">
                                    <c:if test='${banpumMasterList[j].banpumImage1 == ""}'>
                                        <div class="d-flex flex-column gap-3 justify-content-center align-items-center">
                                            <svg fill="#000000" width="100px" height="100px" viewBox="-3.2 -3.2 38.40 38.40" id="icon" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.192"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#CCCCCC" stroke-width="1.7280000000000002"><defs><style>.cls-1{fill:none;}</style></defs><title>no-image</title><path d="M30,3.4141,28.5859,2,2,28.5859,3.4141,30l2-2H26a2.0027,2.0027,0,0,0,2-2V5.4141ZM26,26H7.4141l7.7929-7.793,2.3788,2.3787a2,2,0,0,0,2.8284,0L22,19l4,3.9973Zm0-5.8318-2.5858-2.5859a2,2,0,0,0-2.8284,0L19,19.1682l-2.377-2.3771L26,7.4141Z"></path><path d="M6,22V19l5-4.9966,1.3733,1.3733,1.4159-1.416-1.375-1.375a2,2,0,0,0-2.8284,0L6,16.1716V6H22V4H6A2.002,2.002,0,0,0,4,6V22Z"></path><rect id="_Transparent_Rectangle_" data-name="<Transparent Rectangle>" class="cls-1" width="32" height="32"></rect></g><g id="SVGRepo_iconCarrier"><defs><style>.cls-1{fill:none;}</style></defs><title>no-image</title><path d="M30,3.4141,28.5859,2,2,28.5859,3.4141,30l2-2H26a2.0027,2.0027,0,0,0,2-2V5.4141ZM26,26H7.4141l7.7929-7.793,2.3788,2.3787a2,2,0,0,0,2.8284,0L22,19l4,3.9973Zm0-5.8318-2.5858-2.5859a2,2,0,0,0-2.8284,0L19,19.1682l-2.377-2.3771L26,7.4141Z"></path><path d="M6,22V19l5-4.9966,1.3733,1.3733,1.4159-1.416-1.375-1.375a2,2,0,0,0-2.8284,0L6,16.1716V6H22V4H6A2.002,2.002,0,0,0,4,6V22Z"></path><rect id="_Transparent_Rectangle_" data-name="<Transparent Rectangle>" class="cls-1" width="32" height="32"></rect></g></svg>
                                            <p class="fw-bold text-light">등록된 이미지가 없습니다</p>
                                        </div>
                                    </c:if>
                                    <c:if test='${banpumMasterList[j].banpumImage1 != ""}'>
                                        <div style="background-image: url(${banpumMasterList[j].banpumImage1}); background-position: center; background-size: inherit; background-repeat: no-repeat;"></div>
                                    </c:if>
                                </div>
                                <div class="banpummall-text-boxs d-flex flex-column gap-2 text-light">
                                    <h5 class="fw-semibold d-flex">
                                        <span>이름 :&nbsp;</span>
                                        <span>${banpumMasterList[j].banpumName}</span>
                                    </h5>
                                    <h5 class="fw-semibold d-flex">
                                        <span>가격 :&nbsp;</span>
                                        <span>${banpumMasterList[j].banpumPriceStr}</span>
                                    </h5>
                                    <h5 class="fw-semibold d-flex">
                                        <span class="text-nowrap">설명 :&nbsp;</span>
                                        <span class="line-clamp-2">${banpumMasterList[j].banpumDescription}</span>
                                    </h5>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:forEach>

            </div>
        </div>

    </div>

	<%@ include file="./common/footer.jsp" %>
	
</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>
