<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - PC가 어려운 당신을 위한 현명한 구매</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<div class="" style="width: 70%!important;">
				<div class="w-100 row align-items-center mt-4 mb-4">
					<div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
					    <div class="hovereffect">
					        <img class="img-fluid" src="/resources/img/pc-1-800x1407.png" alt="">
					        <div class="overlay">
					           <h2>공식 유튜브</h2>
					           <a class="info" href="javascript:alert('준비중')">link here</a>
					        </div>
					    </div>
					</div>
					<div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
					    <div class="hovereffect">
					        <img class="img-fluid" src="/resources/img/laptop-1-400x704.png" alt="">
					        <div class="overlay">
					           <h2>견적산출</h2>
					           <a class="info" href="javascript:alert('준비중')">link here</a>
					        </div>
					    </div>
					</div>
					<div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
					    <div class="hovereffect">
					        <img class="img-fluid" src="/resources/img/headset-400x704.png" alt="">
					        <div class="overlay">
					           <h2>기획상품</h2>
					           <a class="info" href="javascript:alert('준비중')">link here</a>
					        </div>
					    </div>
					</div>
					<div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
					    <div class="hovereffect">
					        <img class="img-fluid" src="/resources/img/mouse-400x704.png" alt="">
					        <div class="overlay">
					           <h2>MOUSE</h2>
					           <a class="info" href="javascript:alert('준비중')">link here</a>
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
	
	<%@ include file="./common/footer.jsp" %>

</body>
</html>
