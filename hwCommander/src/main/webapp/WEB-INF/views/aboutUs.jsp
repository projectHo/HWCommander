<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>소개글 - 현우의 컴퓨터 공방</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<style>
	.content {
		background-color: rgba(224,34,238,0.05);;
		border-radius: 14px;
		border: 2px solid rgba(224,34,238,0.1);
	}
	.about-divider {
		border: 1px solid black;
		width: 100%;
		margin: 0 auto;
	}
</style>
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	<!-- 2022.12.06 basic 배경 -> image 변경 -->
	<!-- <div class="basic_background w-100"> -->
	<div class="termsOfService_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<div class="content pt-5 px-5 mx-5" style="width: 70%!important;">
				<h1><b>현우의 컴퓨터 공방</b></h1>

				<!-- 01.15 소개글 수정 -->
				<div class="about-us-container mt-5 p-4">
					<h2 class="mb-5"><b>원칙과 철학</b></h2>
					<h4 class="mb-3"><b>"공학자의 기원은 과학자이며, 과학자는 결과로 원인을 만들지 않는다."</b></h4>
					<p>연구의 과정이 결과를 만들어내는 구조를 위해<br>우리는 적당한 결과에 타협하지 않는다.</p>
					<p>공방 알고리즘의 뿌리가 되는 연구팀의 슬로건으로<br>이를 어기지 않기 위해 객관성의 유지에 몰두합니다.</p>
					<p>주관적 가치에 의해 차등될 데이터를 막기 위해<br>1명의 지식인이 래퍼런스를 모두 구축하고, 해당 래퍼런스를 기반으로<br>여러 연구원이 실험을 통해 증명하거나, 데이터를 가공한 뒤 대조합니다.</p>
					<p>이런 외골수적인 면모가 수치화했을 때<br>어긋나는 평가기준을 정형화하고 가장 이상적인 구조의<br>알고리즘으로 집도해왔습니다.</p>
					<p>때문에 저희 업체에서 제품을 구매하지 않아 가격이 상이하여<br>다른 업체에선 최적의 견적이 되지 않을 지라도, 그 구성 자체는 해당 예산에서<br>가장 균형잡힌 견적에 가깝다고 소개할 수 있습니다.</p>
					<p>호환성 뿐만 아니라 용도별 부품 적합성 그리고<br>소비자가 책정할 수 있는 좋은 상품의 기준 등을 토대로<br>작성된 저희의 알고리즘은 최종적으로 "자신의 컴퓨터를<br>어떤 기준으로 맞출지 구상을 마친 그 소비자가 만약 컴퓨터시장을<br>완벽하게 이해하고 있었다면 어떤 견적으로 구성할까?"를 지표로 삼고 있습니다.</p>
					<p>때문에 모든 사용자가 그 용도와 가치에 대해 다르게<br>생각했을 때 나오는 모든 경우의 수가 저희가 낼 수 있는<br>견적의 종류가 됩니다.<br></p>
					<p>우리 현우의 컴퓨터 공방에서는 수십억 가지의 경우의 수 중<br>당신에게 가장 적합한 단 한가지 견적을 알려드립니다.</p>
				</div>
				<div class="about-divider"></div>
				<div class="about-us-container mt-5 p-4 text-end">
					<h2 class="mb-5"><b>투명성과 데이터베이스</b></h2>
					<h4 class="mb-3"><b>"소비자의 선택이 아닌 생산자의 담합이 시장 구조를 통제한다면 독점이 된다.<br>우리는 일한 만큼만 벌고, 변하지 않는다."</b></h4>
					<p>더 좋은 제품이 더 저렴하게 나온다면 우선순위로 노출되는<br>자연한 구조를 통해 시장은 자연히 회복한다.</p>
					<p>저희는 모든 제품과 공임의 마진율을 동일하게 책정하여 특정 상품<br>혹은 브랜드가 부당한 처사를 받는 것을 방지하고 있습니다.</p>
					<p>동시에 지금 사시는 것과 다음 달에 사시는 것이 공방의 정책상 손익이 발생하지<br>않도록 그 수준에 변동을 주지 않으며, 주문량을 노동 가용 할당량으로 제한하여 받고 있습니다.</p>
					<p>때문에 보상금으로 지급하는 포인트를 제외하곤 공방에서 단순히 특정 상품에<br>특가 혹은 기획전을 열 생각이 없으며, 쿠폰 시스템 또한 존재하지 않습니다.</p>
					<p>유통사에서 기획전을 추진한다면 공지되지 않으며, 그 기간동안 절감되는 유통가만큼이<br>데이터베이스에 올라가 노출도가 올라가는 구조로 동작하게 됩니다.</p>
					<p>하지만 이 노출도는 영구적이지 않으며, 기획전이 종료되어<br>가격이 원복될 때 자연히 순위권에서 내려가게 되며, 소비자의 부담이 줄어들게끔 단가의 절감<br>혹은 동급 제품 대비 높은 성능을 위한 연구 경쟁을 추진하도록 유도합니다.</p>
					<p>해당 구조의 투명성을 위해 저희는 모든 데이터베이스 이력을 보존하며<br>과거 이력을 조회하여 견적을 추출할 수 있는 이전버전 로직 시스템까지 구축을 마친 상태입니다.</p>
				</div>
				<div class="about-divider"></div>
				<div class="about-us-container mt-5 p-4">
					<h2 class="mb-5"><b>신뢰, 그에 맞는 품질</b></h2>
					<p>저희가 원하는 이상적인 구조의 공방을 세우기 위해서는<br>저희 업체가 정상궤도에 돌아야 하며, 성장력을 깎더라도 안정성을 중시해야 합니다.</p>
					<p>인력에 빗댄다면 저희의 평균 주문 소요인력이 30명이 필요하다 한들 저희는 15인으로 고수해야 합니다.</p>
					<p>피치못할 변수에 의해 주문이 급감하는 날엔 일하지 못하는 직원들의 급여는<br>회사가 감당하나, 회사의 타격은 고스란히 돌고돌아 클라이언트에게 영향이 갈 수밖에 없습니다.</p>
					<p>때문에 이 구조를 정직하게 유지하기 위해서 다소 불편함을 감수하면서도<br>더딘 확장과 소비자가 충족하지 못할 느린 건의사항 대처 등이 답답하게 느껴지실 수 있습니다.</p>
					<p>그럼에도 이 모든 것들이 신념을 속이고 행동하는 것보다 옳다 여기는 업체의<br>경영이념에 비롯된 근거있는 행동임을 믿어주신다면 구매하지 않더라도 저희 업체를 꾸준히 이용해주십시오.</p>
					<p>많이 남는 제품보다 좋은 제품을 연구하는 회사와 돈보다<br>신뢰를 남기는 정직하게 유통하는 판매자와 시장구조를 온전히 믿고 사용하는<br>소비자들의 무궁한 번영과 발전을 기원합니다.</p>
					<h3><b>감사합니다.</b></h3>
				</div>

				<!-- <h2><b>현우의 컴퓨터 공방이란?</b></h2>
				<p class="mt-5"></p>

				<p>가격을 보니 조립식이 좋고, 맡기자니 ‘호구’가 될까봐 두렵고<br>
				일체형은 또 너무 비싸고… 컴퓨터를 새로 사려니 머리가 아파오는 당신!</p>
				<p>우리 현우의 컴퓨터 공방은 컴퓨터 덕후 현우를 필두로<br>
				이 세가지의 장점을 모두 잡기 위해 노력하는 업체입니다.</p>
				<p>기업의 AS수준, 구매는 편리하게, 사용할 때에는 쾌적하게!</p>
				<p>AS수준을 지속적으로 향상시키기 위한 자체적으로 수리 커뮤니티를 구성하고<br>
				알고리즘에 따른 자동 견적추천 프로그램을 사용한 간편한 구매</p>
				<p>그리고 ‘새 것’이지만 받자마자 ‘내 것’처럼 쓸 수 있는.<br>
				저희는 이런 PC가 만들고 싶은 친구들입니다!</p>
				
				<p class="mt-5"></p>
				<img class="mx-5 mb-2" width="120" height="120" src="/resources/img/quality-free-img.png">
				<p class="mt-2"></p>
				<h5><b>최고의 상태</b></h5>
				<p class="mt-4"></p>
				<p>만들어지는 순간부터 도착하는 시간까지<br>
				최상의 상태를 유지할 수 있는</p>
				
				<p class="mt-5"></p>
				<img class="mx-5 mb-2" width="120" height="120" src="/resources/img/tag-free-img.png">
				<p class="mt-2"></p>
				<h5><b>최상의 효율</b></h5>
				<p class="mt-4"></p>
				<p>더도 말고 덜도 말고<br>
				나에게 딱 필요하고 알맞는 상품을</p>
				
				<p class="mt-5"></p>
				<img class="mx-5 mb-2" width="120" height="120" src="/resources/img/lock-free-img.png">
				<p class="mt-2"></p>
				<h5><b>안전배송</b></h5>
				<p class="mt-4"></p>
				<p>고객분이 집에서 만나볼 수 있을 그때까지<br>
				튼튼하고 안전하게 배송해드립니다.</p> -->
				
				<p class="mt-5"></p>
				
			
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 15%!important;"></div>
		</div>
	</div>
	<%@ include file="./common/footer.jsp" %>
</body>
</html>
