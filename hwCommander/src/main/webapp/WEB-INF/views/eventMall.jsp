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
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="/resources/css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<div class="" style="width: 70%!important;">
				<div class="w-100 row align-items-center mt-4 mb-4">
					<table>
	                    <thead>
	                        <tr>
	                            <th>제품이미지</th>
	                            <th>정보</th>
	                        </tr>
	                    </thead>
	                    <tbody>
							<tr>
								<td rowspan="3">이미지입니다만</td>
								<td>갸각</td>
							</tr>
							<tr>
								<td>갸가각</td>
							</tr>
							<tr>
								<td>갸가가각</td>
							</tr>
	                    </tbody>
					</table>
					
					<table id="datatablesSimple">
					    <thead>
					        <tr>
					            <th>제품이미지</th>
					            <th>정보</th>
					        </tr>
					    </thead>
					    <tfoot>
					        <tr>
					            <th>제품이미지</th>
					            <th>정보</th>
					        </tr>
					    </tfoot>
					    <tbody>
							<tr>
								<td rowspan="3">이미지입니다만</td>
								<td>갸각</td>
							</tr>
							<tr>
								<td>갸가각</td>
							</tr>
							<tr>
								<td>갸가가각</td>
							</tr>
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
	
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="/resources/js/datatables-simple-demo.js"></script>
        <script src="/resources/js/scripts.js"></script>

</body>
</html>
