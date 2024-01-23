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
	$(function(){
		
	})
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 0.5%;"></div>
			<!-- 작업영역 -->
			<div class="w-100 estimateCalc_background pt-5 pb-5 ps-2 pe-2" style="width: 99%;">
				<div class="card-body card-list card-user-info-detail">
                    <h2 class="card-title">
                        <b>Hwcommander</b>
                    </h2>
                    <h6 class="card-subtitle mb-2 d-flex justify-content-between">${loginUser.name}님의 회원정보</h6>
                    <p class="card-text order-tbody">
                        <table class="table table-light" style="border-collapse: separate;">
                            <thead>
                                <tr>
                                    <th scope="col" style="width: 30%;">이름</th>
                                    <th scope="col" style="font-weight: 400;">${loginUser.name}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">생년월일</th>
                                    <td>${loginUser.birth}</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span>
                                                휴대폰 번호
                                            </span>
                                        </div>
                                    </th>
                                    <td class="align-middle position-relative">
                                        <span class="base-info">
                                            ${loginUser.hpNumber}
                                            <span class="phone-container position-absolute end-0 bottom-0 me-1 mb-1">
                                                <span class="change-phone btn-first">
                                                    <button class="btn btn-outline-success btn-sm pb-0 pt-1" onclick="javascript:changePhoneInfoBtn(this)">수정</button>
                                                </span>
                                            </span>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span>
                                                주소
                                            </span>
                                        </div>
                                    </th>
                                    <td class="align-middle position-relative">
                                        <span class="base-info">
                                            ${loginUser.zipcode}
                                            <span class="addr-container position-absolute end-0 bottom-0 me-1 mb-1">
                                                <span class="change-addr btn-first">
                                                    <button class="btn btn-outline-success btn-sm pb-0 pt-1" onclick="javascript:changeAddrInfoBtn(this)">수정</button>
                                                </span>
                                            </span>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">지번주소</th>
                                    <td>
                                        <span class="base-info">
                                            ${loginUser.jibunAddr}
                                        </span>
                                        <input type="text" class="form-control recipient-jibun-addr changeable-info changeable-addr-info d-none fade" aria-label="Recipient's Ji addr" readonly="readonly" value="${loginUser.jibunAddr}">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">도로명주소</th>
                                    <td>
                                        <span class="base-info">
                                            ${loginUser.roadAddr}
                                        </span>
                                        <input type="text" class="form-control recipient-road-addr changeable-info changeable-addr-info d-none fade" aria-label="Recipient's Road addr" readonly="readonly" value="${loginUser.roadAddr}">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">상세주소</th>
                                    <td>
                                        <span class="base-info">
                                            ${loginUser.detailAddr}
                                        </span>
                                        <input type="text" class="form-control recipient-detail-addr changeable-info changeable-addr-info d-none fade" aria-label="Recipient's Detail addr" aria-describedby="button-addon3" value="${loginUser.detailAddr}">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span>
                                                E-mail
                                            </span>
                                        </div>
                                    </th>
                                    <td class="align-middle position-relative">
                                        <span class="base-info">
                                            ${loginUser.mail}
                                            <span class="email-container position-absolute end-0 bottom-0 me-1 mb-1">
                                                <span class="change-email btn-first">
                                                    <button class="btn btn-outline-success btn-sm pb-0 pt-1" onclick="javascript:changeMailInfoBtn(this)">수정</button>
                                                </span>
                                            </span>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">가입일</th>
                                    <td>${loginUser.regDtm}</td>
                                </tr>
                            </tbody>
                        </table>
                    </p>
                </div>
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 0.5%;"></div>
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