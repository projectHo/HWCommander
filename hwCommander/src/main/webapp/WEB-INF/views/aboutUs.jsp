<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>소개글 - HWCommander</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<link rel="stylesheet" href="/resources/css/ver_02/aboutUs.css">
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="about-us-body py-5">
		<div class="d-flex flex-column gap-5 justify-content-center align-items-center mx-auto container">
			<h1 class="text-white fw-bold">회사 소개</h1>
			<div class="about-us-boxs p-5">
				<h3 class="text-white mb-5 fw-semibold"><p>원칙과 철학</p></h3>
				<h5 class="text-white">
					<p>"공학자의 기원은 과학자이며, 과학자는 결과로 원인을 만들지 않는다."</p>
					<p>연구의 과정이 결과를 만들어내는 구조를 위해 우리는 적당한 결과에 타협하지 않는다.</p>
					<p>공방 알고리즘의 뿌리가 되는 연구팀의 슬로건으로 이를 어기지 않기 위해 객관성의 유지에 몰두합니다.</p>
					<p>주관적 가치에 의해 차등될 데이터를 막기 위해 1명의 지식인이 래퍼런스를 모두 구축하고, 해당 래퍼런스를 기반으로여러 연구원이 실험을 통해 증명하거나, 데이터를 가공한 뒤 대조합니다.</p>
					<p>이런 외골수적인 면모가 수치화했을 때 어긋나는 평가기준을 정형화하고 가장 이상적인 구조의 알고리즘으로 집도해왔습니다.</p>
					<p>때문에 저희 업체에서 제품을 구매하지 않아 가격이 상이하여 다른 업체에선 최적의 견적이 되지 않을 지라도, 그 구성 자체는 해당 예산에서 가장 균형잡힌 견적에 가깝다고 소개할 수 있습니다.</p>
					<p>호환성 뿐만 아니라 용도별 부품 적합성 그리고 소비자가 책정할 수 있는 좋은 상품의 기준 등을 토대로 작성된 저희의 알고리즘은 최종적으로 "자신의 컴퓨터를 어떤 기준으로 맞출지 구상을 마친 그 소비자가 만약 컴퓨터 시장을 완벽하게 이해하고 있었다면 어떤 견적으로 구성할까?"를 지표로 삼고 있습니다.</p>
					<p>때문에 모든 사용자가 그 용도와 가치에 대해 다르게 생각했을 때 나오는 모든 경우의 수가 저희가 낼 수 있는 견적의 종류가 됩니다.</p>
					<p><br></p>
					<p>우리 HWCommander에서는 수십억 가지의 경우의 수 중 당신에게 가장 적합한 단 한가지 견적을 알려드립니다.</p>
				</h5>
			</div>
			<div class="about-us-boxs p-5">
				<h3 class="text-white mb-5 fw-semibold"><p>투명성과 데이터베이스</p></h3>
				<h5 class="text-white">
					<p>"소비자의 선택이 아닌 생산자의 담합이 시장 구조를 통제한다면 독점이 된다. 우리는 일한 만큼만 벌고, 변하지 않는다."</p>
					<p>더 좋은 제품이 더 저렴하게 나온다면 우선순위로 노출되는 자연한 구조를 통해 시장은 자연히 회복한다.</p>
					<p>저희는 모든 제품과 공임의 마진율을 동일하게 책정하여 특정 상품 혹은 브랜드가 부당한 처사를 받는 것을 방지하고 있습니다.</p>
					<p>동시에 지금 사시는 것과 다음 달에 사시는 것이 공방의 정책상 손익이 발생하지 않도록 그 수준에 변동을 주지 않으며, 주문량을 노동 가용 할당량으로 제한하여 받고 있습니다.</p>
					<p>때문에 보상금으로 지급하는 포인트를 제외하곤 공방에서 단순히 특정 상품에 특가 혹은 기획전을 열 생각이 없으며, 쿠폰 시스템 또한 존재하지 않습니다.</p>
					<p>유통사에서 기획전을 추진한다면 공지되지 않으며, 그 기간동안 절감되는 유통가만큼이데이터베이스에 올라가 노출도가 올라가는 구조로 동작하게 됩니다.</p>
					<p>하지만 이 노출도는 영구적이지 않으며, 기획전이 종료되어 가격이 원복될 때 자연히 순위권에서 내려가게 되며, 소비자의 부담이 줄어들게끔 단가의 절감 혹은 동급 제품 대비 높은 성능을 위한 연구 경쟁을 추진하도록 유도합니다.</p>
					<p>해당 구조의 투명성을 위해 저희는 모든 데이터베이스 이력을 보존하며 과거 이력을 조회하여 견적을 추출할 수 있는 이전버전 로직 시스템까지 구축을 마친 상태입니다.</p>
				</h5>
			</div>
			<div class="about-us-boxs p-5">
				<h3 class="text-white mb-5 fw-semibold"><p>신뢰, 그에 맞는 품질</p></h3>
				<h5 class="text-white">
					<p>저희가 원하는 이상적인 구조의 공방을 세우기 위해서는 저희 업체가 정상궤도에 돌아야 하며, 성장력을 깎더라도 안정성을 중시해야 합니다.</p>
					<p>인력에 빗댄다면 저희의 평균 주문 소요인력이 30명이 필요하다 한들 저희는 15인으로 고수해야 합니다.</p>
					<p>공방 알고리즘의 뿌리가 되는 연구팀의 슬로건으로 이를 어기지 않기 위해 객관성의 유지에 몰두합니다.</p>
					<p>피치못할 변수에 의해 주문이 급감하는 날엔 일하지 못하는 직원들의 급여는 회사가 감당하나, 회사의 타격은 고스란히 돌고돌아 클라이언트에게 영향이 갈 수밖에 없습니다.</p>
					<p>이런 외골수적인 면모가 수치화했을 때 어긋나는 평가기준을 정형화하고 가장 이상적인 구조의 알고리즘으로 집도해왔습니다.</p>
					<p>때문에 이 구조를 정직하게 유지하기 위해서 다소 불편함을 감수하면서도 더딘 확장과 소비자가 충족하지 못할 느린 건의사항 대처 등이 답답하게 느껴지실 수 있습니다.</p>
					<p>그럼에도 이 모든 것들이 신념을 속이고 행동하는 것보다 옳다 여기는 업체의 경영이념에 비롯된 근거있는 행동임을 믿어주신다면 구매하지 않더라도 저희 업체를 꾸준히 이용해주십시오.</p>
					<p>많이 남는 제품보다 좋은 제품을 연구하는 회사와 돈보다 신뢰를 남기는 정직하게 유통하는 판매자와 시장구조를 온전히 믿고 사용하는 소비자들의 무궁한 번영과 발전을 기원합니다.</p>
					<p><br></p>
					<p>감사합니다.</p>
				</h5>
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
