<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.File" %>
<head>
<title>현우의 컴퓨터 공방 - 마이페이지</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<link rel="stylesheet" href="/resources/css/ver_02/myPage.css">
<link rel="stylesheet" href="/resources/css/ver_02/estimateStorage.css">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>


<!-- daum map api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function() {

	})
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

	function myPageBtn(){
		if(loginCheck()){
			location.href="/user/myPage.do"
		}
	}
	function escaBtn(el){
		$("#loading-modal").modal("show");
		sessionStorage.setItem("pay","y");
		location.href = "/ESCA/ESCA_RESULT_ver_1_0.do?resultString=" + encodeURI($(el).attr("param"));
	}
	function delStorageDataBtn(el){
		if(confirm("정말로 삭제하시겠습니까?")){
			$.ajax({
				type: "post",
				url: "/user/escaStorageDeleteLogic.do",
				data: {
					userId : "${loginUser.id}",
					seq : $(el).attr("seq"),
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

	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
	
	<div class="my-page-container py-5 w-100">
		<div class="container mb-5">
			<div class="my-page-box">
				<h1 class="fw-bold text-white text-center my-page-head-text pb-5 mb-0">마이페이지</h1>
				<div class="d-flex">
					<div class="d-flex flex-column gap-3 p-3 w-25 my-page-left-side">
						<div class="accordion d-flex flex-column gap-3" id="accordionExample">
							<div class="accordion-item">
							  <h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne" onclick="javascript:myPageBtn()">
								  <h5 class="fw-bold m-0">구매정보</h5>
								</button>
							  </h2>
							</div>
							<div class="accordion-item">
							  <h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" onclick="javascript:myPageBtn()">
									<h5 class="fw-bold m-0">내 글 관리</h5>
								</button>
							  </h2>
							</div>
							<div class="accordion-item">
							  <h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" onclick="javascript:myPageBtn()">
									<h5 class="fw-bold m-0">회원정보</h5>
								</button>
							  </h2>
							</div>
							<div class="accordion-item">
							  <h2 class="accordion-header">
								<button class="accordion-button no-arrow" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="true" aria-controls="collapseFour" onclick="javascript:estimateStorageBtn()">
									<h5 class="fw-bold m-0">견적저장소</h5>
								</button>
							  </h2>
							  <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
								
							  </div>
							</div>
						</div>
					</div>
					<div class="p-3 ps-4 pe-1 flex-grow-1 description-boxs estimate-storage w-75">
						<div class="d-flex flex-column gap-2 align-items-center">
							<div class="d-flex justify-content-around w-100 align-items-center gap-5">
								<div class="text-white fw-bold fs-5 flex-1 text-center">번호/버전</div>
								<div class="text-white fw-bold fs-5 w-50 text-center">견적 이름</div>
								<div class="text-white fw-bold flex-1"></div>
							</div>

							<div class="estimate-storage-divider-1 w-100 mt-2 mb-3"></div>

							<c:forEach var="item" items="${userEscasStorageVOList}">
								<div class="d-flex justify-content-around w-100 align-items-center gap-5">
									<div class="text-secondary fw-semibold fs-6 flex-1 text-center">${item.seq} / 1.0</div>
									<div class="text-secondary fw-semibold fs-6 w-50 text-center line-clamp-2">${item.escasStorageDescription}</div>
									<div class="d-flex gap-2 justify-content-around align-items-center flex-1">
										<button type="button" class="btn btn-secondary btn-sm flex-1 fw-bold" param="${item.escasUrlParameter}" onclick="javascript:escaBtn(this)">견적산출</button>
										<button type="button" class="btn btn-danger btn-sm flex-1 fw-bold" param="${item.escasUrlParameter}" seq="${item.seq}" onclick="javascript:delStorageDataBtn(this)">삭제</button>
									</div>
								</div>
								<div class="estimate-storage-divider-2 w-100 my-3"></div>
							</c:forEach>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	<div class="modal fade" id="loading-modal" aria-hidden="true" aria-labelledby="select-date" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="d-flex flex-column align-items-center p-5 gap-2 position-relative">
					<div class="fw-bold text-dark fs-5">알고리즘이 부품을 추천중입니다</div>
					<div class="text-dark fs-6">최적의 견적을 추천드리겠습니다</div>
					<div class="spinner-border text-primary mt-3" role="status">
					</div>
					<svg class="position-absolute" style="bottom: 56px;" width="16" height="16" viewBox="0 0 34 32" fill="none" xmlns="http://www.w3.org/2000/svg">
						<rect y="7" width="34" height="25" rx="4" fill="#DBDBDB"/>
						<rect x="9" y="14" width="4" height="4" rx="2" fill="#9B9B9B"/>
						<rect x="21" y="14" width="4" height="4" rx="2" fill="#9B9B9B"/>
						<rect x="9" y="21" width="16" height="4" rx="2" fill="#9B9B9B"/>
						<path d="M15 2C15 0.89543 15.8954 0 17 0C18.1046 0 19 0.895431 19 2V5C19 6.10457 18.1046 7 17 7C15.8954 7 15 6.10457 15 5V2Z" fill="#B4B4B4"/>
					</svg>
				</div>
			</div>
		</div>
	</div>
</body>
<style>
	html {
		background-color: black;
	}
</style>
</html>