<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>HWCommander - 견적산출</title>
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

<!-- 08.31 url 파라메터 함수 js파일 분리 -->
<script src="/resources/js/escaSendData.js"></script>
<script>
	
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<!-- 작업영역 -->
			<div class="estimateCalc_background p-2" style="width: 70% !important">
				<div class="w-75 container">
					<div class="row mt-4 pb-4">
						<div class="col-2 text-center">
							<div class="donut-container margin-center">
								<div class="donut-fill">1</div>
							</div>
						</div>
						<div class="col-8 d-flex p-2">
							<input id="typingInput" class="form-control text-center pt-3 fs-5" type="text" readonly aria-label="사용 용도" disabled />
						</div>
						<div class="col-2 d-flex flex-column-reverse">
							<img src="/resources/img/important-message.svg" class="important-img mb-2 ms-4 pe-2" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="목록 중 기타 항목 선택시 장르의 평균적인 PC로 구성됩니다!" style="cursor:pointer">
						</div>
					</div>
					<div class="row pb-2">
						<div class="col">
							<div class="list-group mb-1 w-75 text-center">
							<button type="button" class="list-group-item list-group-item-action mb-3 bgc-disabled" disabled aria-current="true"><p class="pt-2 m-0">게임</p></button>
							</div>
							<div class="list-group mb-3 w-75 text-center list-game"></div>
						</div>
						<div class="col">
							<div class="list-group mb-1 w-75 text-center margin-center">
							<button type="button" class="list-group-item list-group-item-action mb-3 bgc-disabled" disabled aria-current="true"><p class="pt-2 m-0">작업</p></button>
							</div>
							<div class="list-group mb-3 w-75 text-center margin-center list-work"></div>
						</div>
						<div class="col d-flex justify-content-end">
							<div class="list-group mb-1 w-75 text-center">
							<input type="checkbox" class="btn-check" id="work-surf" autocomplete="off">
							<label class="btn btn-outline-secondary surf-btn" for="work-surf" onclick="javascript:clickSurfBtn()"><p class="pt-2 m-0">서핑</p></label>
							</div>
						</div>
					</div>
						<div class="row table-style p-1 mb-3 table-container" style="display: none;">
							<div class="container">
								<table class="table table-submit">
									<thead>
										<tr>
											<th scope="col" class="text-center" style="width: 15%;">장르</th>
											<th scope="col" class="submit-name ps-4">목록</th>
											<th scope="col" style="width:20%">비중</th>
											<th scope="col" style="width:10%"></th>
										</tr>
									</thead>
									<tbody class="table-body"></tbody>
								</table>
							</div>
						</div>
						<div class="row mb-4">
							<div class="col">
								<button type="button" class="form-control marin-center w-50 pre-button" onclick="javascript:clickReturnBtn()"><p class="pt-2 m-0">이전 질문</p></button>
							</div>
							<div class="col">
								<button type="button" class="form-control calc-two-final margin-center" onclick="javascript:clickEstimateBtn(this)"><p class="pt-2 m-0">견적 보기</p></button>
								<button class="btn btn-primary margin-center loading-prog w-100" type="button" disabled style="display: none;">
									<span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
									Loading...
								</button>
								<div class="invalid-feedback fs-5 calc-two-final-text text-center" style="display: none; font-weight: bold;">2페이지 까지는 필수 질문입니다!</div>
								<div class="invalid-feedback fs-5 calc-two-final-text-use text-center" style="display: none; font-weight: bold;">사용 용도를 선택해주세요!</div>
								<div class="invalid-feedback fs-5 calc-two-final-text-rating text-center" style="display: none; font-weight: bold;">비중을 100%로 맞춰주세요!</div>
							</div>
							<div class="col">
								<button type="button" class="form-control w-50 margin-left-auto next-two-btn" onclick="javascript:clickNextBtn()"><p class="pt-2 m-0">다음 질문</p></button>
							</div>
						</div>
					<div class="modal fade" id="use-collector" tabindex="-1" aria-labelledby="collecter" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h1 class="modal-title fs-5 collector-name"></h1>
								</div>
								<div class="modal-body">
									<div class="container">
									<table class="table">
										<thead>
										<tr>
											<form class="form-inline">
												<input type="text" class="form-control" id="search-input" placeholder="검색어를 입력하세요">
											</form>
										</tr>
										<tr>
											<th scope="col">이름</th>
										</tr>
										</thead>
										<tbody id="label-table"></tbody>
									</table>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-secondary modal-btn" data-bs-dismiss="modal" onclick="javascript:modalCancel()">취소</button>
									<button type="button" class="btn btn-primary modal-btn modal-submit-btn" onclick="javascript:modalSubmit()">저장</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 15%!important;"></div>
		
		
		<!-- 2022.11.16 디자인이미지 추가 -->
		<div class="mt-5 mx-5" style="height: 15%!important;">
			<img class="img-fluid float-end" src="/resources/img/layer-34-1200x107.png" alt="">
		</div>
		<div class="mt-2 mx-5" style="height: 15%!important;">
			<img class="img-fluid" src="/resources/img/layer-26.png" alt="">
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
