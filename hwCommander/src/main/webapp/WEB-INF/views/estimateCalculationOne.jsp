<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 견적산출</title>
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
    $(function() {
    });
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			
			<!-- 작업영역 -->
			<div class="" style="width: 70%!important;">
				<div class="d-flex">
					<h5>도넛</h5>
					<button style="background-color:transparent; border: none;" type="button" class="btn btn-secondary" data-bs-toggle="tooltip" data-bs-placement="right" data-bs-title="0원으로 표기 시 요구사항의 최소 견적으로 자동 산출됩니다.">
					  <svg width="40px" height="40px" viewBox="0 -0.5 21 21" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
					    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
					        <g id="Dribbble-Light-Preview" transform="translate(-139.000000, -520.000000)" fill="#000000">
					            <g id="icons" transform="translate(56.000000, 160.000000)">
					                <path d="M94.55,365.007 L94.55,372.007 C94.55,372.559 94.0796,373.007 93.5,373.007 C92.9204,373.007 92.45,372.559 92.45,372.007 L92.45,365.007 C92.45,364.455 92.9204,364.007 93.5,364.007 C94.0796,364.007 94.55,364.455 94.55,365.007 L94.55,365.007 Z M94.55,375.007 C94.55,375.559 94.0796,376.007 93.5,376.007 C92.9204,376.007 92.45,375.559 92.45,375.007 C92.45,374.455 92.9204,374.007 93.5,374.007 C94.0796,374.007 94.55,374.455 94.55,375.007 L94.55,375.007 Z M101.9,377 C101.9,377.552 101.4296,378 100.85,378 L86.15,378 C85.5704,378 85.1,377.552 85.1,377 L85.1,363 C85.1,362.448 85.5704,362 86.15,362 L100.85,362 C101.4296,362 101.9,362.448 101.9,363 L101.9,377 Z M101.9,360 L85.1,360 C83.93975,360 83,360.899 83,362.003 L83,362.007 L83,378.007 C83,379.112 83.93975,380 85.1,380 L101.9,380 C103.06025,380 104,379.108 104,378.003 L104,362.007 C104,360.902 102.95,360 101.9,360 L101.9,360 Z" id="important_message-[#1448]"></path>
					            </g>
					        </g>
					    </g>
		              </svg>
					</button>
				</div>
				<div class="container">
					<div class="w-75 margin-center">
						<div class="d-flex justify-content-end mb-3">
							<input class="form-control text-center" type="text" value="1.본체의 가용 예산 한도는 얼마입니까? (최대 500만원)" readonly aria-label="본체 예상 한도" disabled>
							</div>
						<div class="combined-input text-end d-flex flex-end justify-content-end margin-center mb-5">
							<div class="w-50"></div>
							<div class="w-25 form-control">
							  <input type="text" class="input-field text-end" placeholder="ex) 300">
							  <span class="fixed-text">만원</span>
							</div>
						</div>
						<div class="d-flex flex-end justify-content-end">
							<button type="button" class="form-control mb-3 next-btn">다음 질문</button>
						</div>
						<div class="d-flex flex-end justify-content-center submit-btn">
							<button type="button" class="form-control w-25">견적 보기</button>
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
