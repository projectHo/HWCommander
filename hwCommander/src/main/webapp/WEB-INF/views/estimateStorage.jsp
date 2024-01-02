<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 견적저장소</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/escaStorage.css">
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

<!-- 23.07.15 다음 카카오 map api 추가 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	$(function(){
		// 부트스트랩 툴팁
		const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
		const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
	})

	function clickEscaBtn(el) {
		var param = $(el).parent().parent().attr("param");
		sessionStorage.setItem("pay","y");
		location.href = "/ESCA/ESCA_RESULT_ver_1_0.do?resultString=" + encodeURI(param);
	}
	function clickEscaDeleteBtn(el) {
		var param = $(el).parent().parent().attr("param");
		var seq = $(el).parent().parent().find(".seq").attr("name");
		if(confirm("정말로 삭제하시겠습니까?")){
			$.ajax({
				type: "post",
				url: "/user/escaStorageDeleteLogic.do",
				data: {
					userId : "${loginUser.id}",
					seq : seq,
				},
				dataType: "json",
				success: function(response) {
					alert("삭제되었습니다");
					location.reload();
				},
				error: function() {
					alert("삭제 실패했습니다. 다시 시도해주세요");
					location.reload();
				}
			})
		}else {
			return false;
		}
	}
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start esca-storage-empty-space"></div>
			<!-- 작업영역 -->
			<div class="estimateCalc_background esca-storage-main">
				<h1 class="d-flex justify-content-center mb-2 fw-bold">견적 저장소</h1>
				<h6 class="d-flex justify-content-center mb-5">※ 저장은 총 50개까지 가능합니다.</h6>
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col" class="col-md-2 border-end">번호 / 버전</th>
							<th scope="col" class="col-md-8 border-end">견적 이름</th>
							<th scope="col" class="col-md-2">선택</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${userEscasStorageVOList}">
							<tr param="${item.escasUrlParameter}">
								<th scope="row" class="border-end pt-4 seq" name="${item.seq}">
										${item.seq} / 1.0
								</th>
								<td id="description" class="border-end" name="${item.escasStorageDescription}">
									${item.escasStorageDescription}
								</td>
								<td class="d-flex justify-content-center gap-2">
									<button class="btn btn-outline-primary esca-storage-btns" onclick="clickEscaBtn(this)">
										견적산출
									</button>
									<button class="btn btn-outline-danger esca-storage-btns" onclick="clickEscaDeleteBtn(this)">
										삭제
									</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
	 		</div>
			
			<!-- 빈 영역 -->
			<div class="justify-content-end esca-storage-empty-space"></div>
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
