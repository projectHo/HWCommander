<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>HWCommander</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- main css -->
<link rel="stylesheet" href="/resources/css/ver_02/main.css">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<!-- swiper -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- type-hangul -->
<script src="https://unpkg.com/type-hangul"></script>
<style>
</style>
<script>
	$(function() {
		swTextType1();

		const mainSwiper = new Swiper('.mySwiper', {
			direction: "vertical",
			mousewheel: true,
			parallax: true,
			speed:"600",
			on: {
				slideChange: function() {
					var activeSlide = this.slides[this.activeIndex];
				}
			},
		});
	})

	function loginCheck() {
		var check = false;
		if("${loginUser}" == "") {
			$("#alertModal").modal("show");
		}else {
			check = true;
		}
		return check;
	}

	function swTextType1(){
		$(".sw-1-type-text-2").css("opacity","0");
		$(".sw-1-type-text-3").css("opacity","0");
		TypeHangul.type(".sw-1-type-text-1",{intervalType:30,humanize:0.7});
		setTimeout(() => {
			$(".sw-1-type-text-2").css("opacity","1");
			type2();
			setTimeout(() => {
				$(".sw-1-type-text-3").css("opacity","1");
				type3()
			}, 1600);
		}, 1500);
		
	}
	function type2(){
		TypeHangul.type(".sw-1-type-text-2",{intervalType:20,humanize:0.7});
	}
	function type3(){
		TypeHangul.type(".sw-1-type-text-3",{intervalType:20,humanize:0.7});
	}
	
	function goEventMall(){
		location.href = "/userBanpumMall.do";
	}
	
	function escaSelectBtn(){
		if(loginCheck()){
			location.href = "/ESCA/ESCASelect.do";
		}
	}

	function escaStorageBtn(){
		if(loginCheck()){
			location.href = "/user/estimateStorage.do?id=${loginUser.id}";
		}
	}

	function hoverEvent(event) {
		var relX = event.pageX - $('#swThreeHoverEventImg').offset().left;
		var relY = event.pageY - $('#swThreeHoverEventImg').offset().top;
		$('#swThreeHoverEventImg').css('--x', relX + 'px');
		$('#swThreeHoverEventImg').css('--y', relY + 'px');
	}

	function loginBtn(){
		location.href = "/user/login.do";
	}
	function logoutBtn(){
		if(confirm("로그아웃 하시겠습니까?")) {
			location.href = "/user/logoutLogic.do";
		}
	}
	function detailPage(el){
        location.href = "/userBanpumMallDetail.do?banpumMallId="+$(el).attr("item");
    }

	function myPageBtn(){
		if(loginCheck()) {
			location.href ="/user/myPage.do";
		}
	}
	function modalBtns(el){
		if($(el).attr("modal-btn-cd") == "1"){
			location.href = "/user/signUp.do";
		}else {
			location.href = "/user/login.do";
		}
	}
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>
	<div class="position-absolute end-0 bottom-0 z-2">
		<div class="d-flex flex-column">
			<div class="d-flex justify-content-center align-items-center flex-column gap-2 sw-1-boxs sw-1-boxs-1" onclick="javascript:escaSelectBtn()">
				<svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path fill-rule="evenodd" clip-rule="evenodd" d="M4.81812 4.09087C4.81812 2.96119 5.76887 2.04541 6.9417 2.04541H29.8764C31.0492 2.04541 31.9999 2.96119 31.9999 4.09086V31.909C31.9999 33.0387 31.0492 33.9545 29.8764 33.9545H6.9417C5.76888 33.9545 4.81812 33.0387 4.81812 31.909V4.09087ZM7.36641 4.49996V31.5H29.4516V4.49996H7.36641Z" fill="white"/>
					<path d="M11.5668 13.4999V8.5908H25.2514V13.4999H11.5668Z" stroke="white" stroke-width="2.45455"/>
					<path d="M10.3395 18.0001C10.3395 17.5482 10.7198 17.1819 11.1889 17.1819H12.1799C12.649 17.1819 13.0293 17.5482 13.0293 18.0001V18.491C13.0293 18.9428 12.649 19.3092 12.1799 19.3092H11.1889C10.7198 19.3092 10.3395 18.9428 10.3395 18.491V18.0001Z" fill="white"/>
					<path d="M10.3395 22.2547C10.3395 21.8028 10.7198 21.4365 11.1889 21.4365H12.1799C12.649 21.4365 13.0293 21.8028 13.0293 22.2547V22.7456C13.0293 23.1975 12.649 23.5638 12.1799 23.5638H11.1889C10.7198 23.5638 10.3395 23.1975 10.3395 22.7456V22.2547Z" fill="white"/>
					<path d="M10.3395 26.5091C10.3395 26.0572 10.7198 25.6909 11.1889 25.6909H12.1799C12.649 25.6909 13.0293 26.0572 13.0293 26.5091V27C13.0293 27.4519 12.649 27.8182 12.1799 27.8182H11.1889C10.7198 27.8182 10.3395 27.4519 10.3395 27V26.5091Z" fill="white"/>
					<path d="M14.8226 18.0001C14.8226 17.5482 15.2029 17.1819 15.6721 17.1819H16.6631C17.1322 17.1819 17.5125 17.5482 17.5125 18.0001V18.491C17.5125 18.9428 17.1322 19.3092 16.6631 19.3092H15.6721C15.2029 19.3092 14.8226 18.9428 14.8226 18.491V18.0001Z" fill="white"/>
					<path d="M14.8226 22.2547C14.8226 21.8028 15.2029 21.4365 15.6721 21.4365H16.6631C17.1322 21.4365 17.5125 21.8028 17.5125 22.2547V22.7456C17.5125 23.1975 17.1322 23.5638 16.6631 23.5638H15.6721C15.2029 23.5638 14.8226 23.1975 14.8226 22.7456V22.2547Z" fill="white"/>
					<path d="M14.8226 26.5091C14.8226 26.0572 15.2029 25.6909 15.6721 25.6909H16.6631C17.1322 25.6909 17.5125 26.0572 17.5125 26.5091V27C17.5125 27.4519 17.1322 27.8182 16.6631 27.8182H15.6721C15.2029 27.8182 14.8226 27.4519 14.8226 27V26.5091Z" fill="white"/>
					<path d="M19.3057 18.0001C19.3057 17.5482 19.686 17.1819 20.1551 17.1819H21.1461C21.6152 17.1819 21.9955 17.5482 21.9955 18.0001V18.491C21.9955 18.9428 21.6152 19.3092 21.1461 19.3092H20.1551C19.686 19.3092 19.3057 18.9428 19.3057 18.491V18.0001Z" fill="white"/>
					<path d="M19.3058 22.2547C19.3058 21.8028 19.6861 21.4365 20.1552 21.4365H21.1462C21.6153 21.4365 21.9957 21.8028 21.9957 22.2547V22.7456C21.9957 23.1975 21.6154 23.5638 21.1462 23.5638H20.1552C19.6861 23.5638 19.3058 23.1975 19.3058 22.7456V22.2547Z" fill="white"/>
					<path d="M19.3058 26.5091C19.3058 26.0572 19.6861 25.6909 20.1552 25.6909H21.1462C21.6153 25.6909 21.9957 26.0572 21.9957 26.5091V27C21.9957 27.4519 21.6154 27.8182 21.1462 27.8182H20.1552C19.6861 27.8182 19.3058 27.4519 19.3058 27V26.5091Z" fill="white"/>
					<path d="M23.7888 18.0001C23.7888 17.5482 24.1691 17.1819 24.6383 17.1819H25.6293C26.0984 17.1819 26.4787 17.5482 26.4787 18.0001V18.491C26.4787 18.9428 26.0984 19.3092 25.6293 19.3092H24.6383C24.1691 19.3092 23.7888 18.9428 23.7888 18.491V18.0001Z" fill="white"/>
					<path d="M23.7887 22.2547C23.7887 21.8028 24.169 21.4365 24.6381 21.4365H25.6291C26.0983 21.4365 26.4786 21.8028 26.4786 22.2547V22.7456C26.4786 23.1975 26.0983 23.5638 25.6291 23.5638H24.6381C24.169 23.5638 23.7887 23.1975 23.7887 22.7456V22.2547Z" fill="white"/>
					<path d="M23.7887 26.5091C23.7887 26.0572 24.169 25.6909 24.6381 25.6909H25.6291C26.0983 25.6909 26.4786 26.0572 26.4786 26.5091V27C26.4786 27.4519 26.0983 27.8182 25.6291 27.8182H24.6381C24.169 27.8182 23.7887 27.4519 23.7887 27V26.5091Z" fill="white"/>
				</svg>
				<h5 class="fw-bold">견적산출</h5>
			</div>
			<c:if test="${loginUser == null}">
				<div class="d-flex justify-content-center align-items-center flex-column gap-2 sw-1-boxs sw-1-boxs-2" onclick="javascript:loginBtn()">
					<svg width="36" height="36" viewBox="0 0 36 36" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path fill-rule="evenodd" clip-rule="evenodd" d="M18.1215 10.7509C15.6233 10.7509 13.5982 12.7761 13.5982 15.2743C13.5982 17.7725 15.6233 19.7977 18.1215 19.7977C20.6197 19.7977 22.6449 17.7725 22.6449 15.2743C22.6449 12.7761 20.6197 10.7509 18.1215 10.7509ZM11.1436 15.2743C11.1436 11.4205 14.2677 8.29639 18.1215 8.29639C21.9753 8.29639 25.0994 11.4205 25.0994 15.2743C25.0994 17.8785 23.6728 20.1495 21.5585 21.3485C25.3668 22.4501 28.4163 25.3363 29.7449 29.0403L27.4344 29.869C26.064 26.0483 22.41 23.3183 18.1216 23.3183C13.8331 23.3183 10.1792 26.0483 8.80871 29.869L6.49829 29.0403C7.82687 25.3363 10.8763 22.4501 14.6846 21.3485C12.5702 20.1495 11.1436 17.8785 11.1436 15.2743Z" fill="white"/>
						<path fill-rule="evenodd" clip-rule="evenodd" d="M18 3.68184C10.0923 3.68184 3.68184 10.0923 3.68184 18C3.68184 25.9077 10.0923 32.3182 18 32.3182C25.9077 32.3182 32.3182 25.9077 32.3182 18C32.3182 10.0923 25.9077 3.68184 18 3.68184ZM1.22729 18C1.22729 8.7367 8.7367 1.22729 18 1.22729C27.2633 1.22729 34.7728 8.7367 34.7728 18C34.7728 27.2633 27.2633 34.7728 18 34.7728C8.7367 34.7728 1.22729 27.2633 1.22729 18Z" fill="white"/>
					</svg>
					<h5 class="fw-bold">로그인</h5>
				</div>
			</c:if>
			<c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
				<div class="d-flex justify-content-center align-items-center flex-column gap-2 sw-1-boxs sw-1-boxs-2" onclick="javascript:logoutBtn()">
					<svg width="33" height="32" viewBox="0 0 33 32" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path fill-rule="evenodd" clip-rule="evenodd" d="M5.95459 2.90905C5.95459 1.3275 7.23668 0.0454102 8.81823 0.0454102H30.091C31.6725 0.0454102 32.9546 1.3275 32.9546 2.90905V28.2727C32.9546 29.8542 31.6725 31.1363 30.091 31.1363H8.81823C7.23668 31.1363 5.95459 29.8542 5.95459 28.2727V22.75C5.95459 22.0722 6.50406 21.5227 7.18186 21.5227C7.85967 21.5227 8.40914 22.0722 8.40914 22.75V28.2727C8.40914 28.4986 8.59229 28.6818 8.81823 28.6818H30.091C30.3169 28.6818 30.5 28.4986 30.5 28.2727V2.90905C30.5 2.68311 30.3169 2.49996 30.091 2.49996H8.81823C8.59229 2.49996 8.40914 2.68311 8.40914 2.90905V8.43177C8.40914 9.10958 7.85967 9.65905 7.18186 9.65905C6.50406 9.65905 5.95459 9.10958 5.95459 8.43177V2.90905Z" fill="white"/>
						<path fill-rule="evenodd" clip-rule="evenodd" d="M0.227295 15.1819C0.227295 14.5041 0.776764 13.9546 1.45457 13.9546H19.4546C20.1324 13.9546 20.6818 14.5041 20.6818 15.1819C20.6818 15.8597 20.1324 16.4091 19.4546 16.4091H1.45457C0.776764 16.4091 0.227295 15.8597 0.227295 15.1819Z" fill="white"/>
						<path fill-rule="evenodd" clip-rule="evenodd" d="M14.9049 9.40487C15.3841 8.92559 16.1612 8.92559 16.6405 9.40487L21.5496 14.314C22.0289 14.7932 22.0289 15.5703 21.5496 16.0496L16.6405 20.9587C16.1612 21.438 15.3841 21.438 14.9049 20.9587C14.4256 20.4794 14.4256 19.7023 14.9049 19.2231L18.9461 15.1818L14.9049 11.1405C14.4256 10.6612 14.4256 9.88415 14.9049 9.40487Z" fill="white"/>
					</svg>
					<h5 class="fw-bold">로그아웃</h5>
				</div>
			</c:if>
		</div>
	</div>

	<div class="swiper mySwiper">
		<!-- Additional required wrapper -->
		<div class="parallax-bg" style="background-image: url(/resources/img/ver_02/main-bgi-02.png);" data-swiper-parallax="-70%"></div>
		<div class="swiper-wrapper">
			<!-- Slides -->
			<div class="swiper-slide swiper-slide-1 position-relative">
				<div class="d-flex flex-column justify-content-center gap-3 z-1 cursor-defalt">
					<div class="d-flex justify-content-center align-items-center text-white flex-column mb-5">
						<h1 class="mb-3 fw-bold sw-1-type-text-1">"과정으로 결론을 도출한다"</h1>
						<h5 class="fw-bold sw-1-type-text-2">정확한 결과값만을 담은 데이터베이스로 AI가</h5>
						<h5 class="fw-bold sw-1-type-text-3">24시간 전문 상담사로써 개개인에게 최적의 견적을 전달드립니다.</h5>
					</div>
					<div class="container d-flex flex-column align-items-center justify-content-center">
						<div class="scroll-arrow"></div>
						<div class="scroll-arrow"></div>
						<div class="scroll-arrow mb-3"></div>
						<div class="text-white fw-bold">Scroll</div>
					</div>
				</div>
		  </div>
		  <div class="swiper-slide sw-sl-2p">
			<div class="d-flex justify-content-center align-items-center flex-column w-50 sw-2-container">
				<div class="d-flex justify-content-center align-items-center flex-column gap-3 mb-5 w-100 cursor-defalt" data-swiper-parallax="-200">
					<h6 class="title-text-color fw-bold">Estimate</h6>
					<div class="d-flex justify-content-center align-items-center flex-column gap-2">
						<h2 class="fw-bold text-white">견적산출</h2>
						<h5 class="fw-bold text-white">견적상담 AI를 통해 고객님을 위한 단 하나의 PC를 찾아드립니다.</h5>
					</div>
				</div>
				<div class="d-flex justify-content-center align-items-center gap-5 w-100 mb-3">
					<div role="button" class="sw-2-circle w-25 d-flex justify-content-center align-items-center ratio ratio-1x1" data-swiper-parallax="-150">
						<h5 class="text-white fw-bold d-flex justify-content-center align-items-center">최적화</h5>
					</div>
					<div role="button" class="sw-2-circle w-25 d-flex justify-content-center align-items-center ratio ratio-1x1" data-swiper-parallax="-150">
						<h5 class="text-white fw-bold d-flex justify-content-center align-items-center">가격</h5>
					</div>
					<div role="button" class="sw-2-circle w-25 d-flex justify-content-center align-items-center ratio ratio-1x1" data-swiper-parallax="-150">
						<h5 class="text-white fw-bold d-flex justify-content-center align-items-center">사용목적</h5>
					</div>
					<div role="button" class="sw-2-circle w-25 d-flex justify-content-center align-items-center ratio ratio-1x1" data-swiper-parallax="-150">
						<h5 class="text-white fw-bold d-flex justify-content-center align-items-center">사용자 정보</h5>
					</div>
				</div>
				<div class="d-flex justify-content-center align-items-center gap-5 w-100 mb-5">
					<div role="button" class="sw-2-circle w-25 d-flex justify-content-center align-items-center ratio ratio-1x1" data-swiper-parallax="-100">
						<h5 class="text-white fw-bold d-flex justify-content-center align-items-center">그래픽</h5>
					</div>
					<div role="button" class="sw-2-circle w-25 d-flex justify-content-center align-items-center ratio ratio-1x1" data-swiper-parallax="-100">
						<h5 class="text-white fw-bold d-flex justify-content-center align-items-center">램</h5>
					</div>
					<div role="button" class="sw-2-circle w-25 d-flex justify-content-center align-items-center ratio ratio-1x1" data-swiper-parallax="-100">
						<h5 class="text-white fw-bold d-flex justify-content-center align-items-center">용량</h5>
					</div>
					<div role="button" class="sw-2-circle w-25 d-flex justify-content-center align-items-center ratio ratio-1x1" data-swiper-parallax="-100">
						<h5 class="text-white fw-bold d-flex justify-content-center align-items-center">기타</h5>
					</div>
				</div>
				<div class="d-flex justify-content-center align-items-center w-100">
					<a class="link-secondary text-light fw-bold px-2 main-underlines" onclick="javascript:escaSelectBtn()" data-swiper-parallax="-100" >견적산출 바로가기</a>
				</div>
			</div>
		  </div>
		  <div class="swiper-slide sw-gray-bgc">
			<div class="d-flex position-relative me-5 mb-5 cursor-defalt">
				<div class="sw-3-image-container" onmousemove="javscript:hoverEvent(event)">
					<img src="/resources/img/ver_02/main-2.png" alt="계산기" class="me-5 mb-5" id="swThreeHoverEventImg">
					<div class="position-absolute d-flex flex-column gap-2 text-white text-start end-0 top-50 mt-5">
						<h6 class="fw-bold title-text-color" data-swiper-parallax="-500">ESTIMATE SAVE</h6>
						<h2 class="fw-bold" data-swiper-parallax="-500">견적저장소</h2>
						<h5 class="fw-bold" data-swiper-parallax="-400">내가 산출한 견적내용을 저장 후 원할 때 언제든</h5>
						<h5 class="fw-bold mb-4" data-swiper-parallax="-400">현재 가격으로 다시 산출할 수 있습니다.</h5>
						<h5 class="fw-bold" data-swiper-parallax="-400"><a class="link-secondary text-light fw-bold main-underlines" onclick="javascript:escaStorageBtn()">견적저장소 바로가기</a></h5>
					</div>
				</div>
			</div>
		  </div>
		  <div class="swiper-slide sw-111112-bgc d-flex flex-column">
			<div class="d-flex flex-column gap-5 justify-content-center align-items-center">
				<div class="d-flex justify-content-center align-items-center flex-column">
					<div class="d-flex justify-content-center align-items-center flex-column gap-3 mb-5 w-100 cursor-defalt">
						<h6 class="title-text-color fw-bold">EVENT MALL</h6>
						<div class="d-flex justify-content-center align-items-center flex-column gap-2">
							<h2 class="fw-bold text-white">이벤트몰</h2>
							<h5 class="fw-bold text-white">HWC에서 검수한 추천 조립 PC를 구매하실 수 있습니다.</h5>
						</div>
					</div>
				</div>
	
				<div class="swiper mySwiper2 px-5 mb-5" data-swiper-parallax="-200">
					<div class="swiper-wrapper p-1">
						<c:forEach var="item" items="${banpumMasterList}">
							<div class="swiper-slide aspect-ratio-3x4 sw-4-slides" item="${item.id}" onclick="javascript:detailPage(this)">
								<div class="d-flex flex-column gap-2 justify-content-between p-3">
									<div class="h-75">
										<c:if test='${item.banpumImage1 == ""}'>
											<div class="d-flex flex-column gap-3 justify-content-center align-items-center h-100">
												<svg fill="#000000" width="80%" height="80%" viewBox="-3.2 -3.2 38.40 38.40" id="icon" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.192"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round" stroke="#CCCCCC" stroke-width="1.7280000000000002"><defs><style>.cls-1{fill:none;}</style></defs><title>no-image</title><path d="M30,3.4141,28.5859,2,2,28.5859,3.4141,30l2-2H26a2.0027,2.0027,0,0,0,2-2V5.4141ZM26,26H7.4141l7.7929-7.793,2.3788,2.3787a2,2,0,0,0,2.8284,0L22,19l4,3.9973Zm0-5.8318-2.5858-2.5859a2,2,0,0,0-2.8284,0L19,19.1682l-2.377-2.3771L26,7.4141Z"></path><path d="M6,22V19l5-4.9966,1.3733,1.3733,1.4159-1.416-1.375-1.375a2,2,0,0,0-2.8284,0L6,16.1716V6H22V4H6A2.002,2.002,0,0,0,4,6V22Z"></path><rect id="_Transparent_Rectangle_" data-name="<Transparent Rectangle>" class="cls-1" width="32" height="32"></rect></g><g id="SVGRepo_iconCarrier"><defs><style>.cls-1{fill:none;}</style></defs><title>no-image</title><path d="M30,3.4141,28.5859,2,2,28.5859,3.4141,30l2-2H26a2.0027,2.0027,0,0,0,2-2V5.4141ZM26,26H7.4141l7.7929-7.793,2.3788,2.3787a2,2,0,0,0,2.8284,0L22,19l4,3.9973Zm0-5.8318-2.5858-2.5859a2,2,0,0,0-2.8284,0L19,19.1682l-2.377-2.3771L26,7.4141Z"></path><path d="M6,22V19l5-4.9966,1.3733,1.3733,1.4159-1.416-1.375-1.375a2,2,0,0,0-2.8284,0L6,16.1716V6H22V4H6A2.002,2.002,0,0,0,4,6V22Z"></path><rect id="_Transparent_Rectangle_" data-name="<Transparent Rectangle>" class="cls-1" width="32" height="32"></rect></g></svg>
											</div>
										</c:if>
										<c:if test='${item.banpumImage1 != ""}'>
											<img src="${item.banpumImage1}" alt="메인 이벤트몰 사진">
										</c:if>
									</div>
									<div>${item.banpumName}</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="swiper-button-next"></div>
					<div class="swiper-button-prev"></div>
				</div>
				
				<h5 class="fw-bold" data-swiper-parallax="-100"><a class="link-secondary text-light fw-bold main-underlines" href="javascript:goEventMall()" >이벤트몰 바로가기</a></h5>
			</div>
		  </div>
		  <div class="swiper-slide sw-gray-bgc">
			<div class="d-flex gap-5 justify-content-center align-items-center">
				<img data-swiper-parallax="-600" src="/resources/img/ver_02/main-3.png" alt="마이페이지">

				<div class="d-flex justify-content-center flex-column gap-3 mb-5 w-100 cursor-defalt text-start">
					<h6 class="title-text-color fw-bold" data-swiper-parallax="-500">MY PAGE</h6>
					<div class="d-flex justify-content-center flex-column gap-2 mb-5">
						<h2 class="fw-bold text-white" data-swiper-parallax="-400">마이페이지</h2>
						<h5 class="fw-bold text-white" data-swiper-parallax="-300">구매정보 및 회원정보를 확인할 수 있습니다.</h5>
					</div>
					<h5 class="fw-bold" data-swiper-parallax="-200"><a class="link-secondary text-light fw-bold main-underlines" onclick="javascript:myPageBtn()">마이페이지 바로가기</a></h5>
				</div>
			</div>
		  </div>
		  <div class="swiper-slide sw-0F0F14-bgc">
			<div class="d-flex flex-column justify-content-center align-items-center gap-5">
				<div class="d-flex justify-content-center align-items-center flex-column gap-3 w-100 cursor-defalt" data-swiper-parallax="-600">
					<h6 class="title-text-color fw-bold z-1" data-swiper-parallax="-600">Customer Service</h6>
					<div class="d-flex justify-content-center align-items-center flex-column gap-2">
						<h2 class="fw-bold text-white" data-swiper-parallax="-600">고객센터</h2>
						<h5 class="fw-bold text-white" data-swiper-parallax="-600">기타 모든 PC 문제를 HWC 고객센터에서 상담해드립니다.</h5>
					</div>
				</div>
				<div class="d-flex justify-content-center align-items-center gap-5 sw-6-boxs-container mb-5" data-swiper-parallax="-500">
					<div class="sw-6-boxs d-flex justify-content-center align-items-center gap-3 px-3" data-swiper-parallax="-500">
						<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M4.02222 8.65556C5.62222 11.8 8.2 14.3667 11.3444 15.9778L13.7889 13.5333C14.0889 13.2333 14.5333 13.1333 14.9222 13.2667C16.1667 13.6778 17.5111 13.9 18.8889 13.9C19.5 13.9 20 14.4 20 15.0111V18.8889C20 19.5 19.5 20 18.8889 20C8.45556 20 0 11.5444 0 1.11111C0 0.5 0.5 0 1.11111 0H5C5.61111 0 6.11111 0.5 6.11111 1.11111C6.11111 2.5 6.33333 3.83333 6.74444 5.07778C6.86667 5.46667 6.77778 5.9 6.46667 6.21111L4.02222 8.65556Z" fill="black"/>
						</svg>
						<div class="fw-bold">010-7625-0478</div>
					</div>
					<div class="sw-6-boxs d-flex justify-content-center align-items-center gap-3 px-3" data-swiper-parallax="-500">
						<svg width="22" height="18" viewBox="0 0 22 18" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M19.8 0H2.2C0.99 0 0.011 1.0125 0.011 2.25L0 15.75C0 16.9875 0.99 18 2.2 18H19.8C21.01 18 22 16.9875 22 15.75V2.25C22 1.0125 21.01 0 19.8 0ZM19.36 4.78125L11.583 9.75375C11.231 9.97875 10.769 9.97875 10.417 9.75375L2.64 4.78125C2.5297 4.71793 2.43311 4.63237 2.35608 4.52976C2.27904 4.42715 2.22317 4.30963 2.19183 4.18429C2.1605 4.05896 2.15435 3.92843 2.17377 3.8006C2.19319 3.67276 2.23777 3.55029 2.30481 3.44059C2.37185 3.33089 2.45996 3.23624 2.5638 3.16237C2.66764 3.0885 2.78506 3.03695 2.90895 3.01084C3.03283 2.98472 3.16061 2.98459 3.28455 3.01044C3.40849 3.0363 3.52601 3.0876 3.63 3.16125L11 7.875L18.37 3.16125C18.474 3.0876 18.5915 3.0363 18.7155 3.01044C18.8394 2.98459 18.9672 2.98472 19.0911 3.01084C19.2149 3.03695 19.3324 3.0885 19.4362 3.16237C19.54 3.23624 19.6282 3.33089 19.6952 3.44059C19.7622 3.55029 19.8068 3.67276 19.8262 3.8006C19.8456 3.92843 19.8395 4.05896 19.8082 4.18429C19.7768 4.30963 19.721 4.42715 19.6439 4.52976C19.5669 4.63237 19.4703 4.71793 19.36 4.78125Z" fill="black"/>
						</svg>
						<div class="fw-bold">hwcomputer@naver.com</div>
					</div>
					<div class="sw-6-boxs d-flex justify-content-center align-items-center gap-3 px-3" data-swiper-parallax="-500">
						<svg width="22" height="18" viewBox="0 0 22 18" fill="none" xmlns="http://www.w3.org/2000/svg">
							<path d="M19.8 0H2.2C0.99 0 0.011 1.0125 0.011 2.25L0 15.75C0 16.9875 0.99 18 2.2 18H19.8C21.01 18 22 16.9875 22 15.75V2.25C22 1.0125 21.01 0 19.8 0ZM19.36 4.78125L11.583 9.75375C11.231 9.97875 10.769 9.97875 10.417 9.75375L2.64 4.78125C2.5297 4.71793 2.43311 4.63237 2.35608 4.52976C2.27904 4.42715 2.22317 4.30963 2.19183 4.18429C2.1605 4.05896 2.15435 3.92843 2.17377 3.8006C2.19319 3.67276 2.23777 3.55029 2.30481 3.44059C2.37185 3.33089 2.45996 3.23624 2.5638 3.16237C2.66764 3.0885 2.78506 3.03695 2.90895 3.01084C3.03283 2.98472 3.16061 2.98459 3.28455 3.01044C3.40849 3.0363 3.52601 3.0876 3.63 3.16125L11 7.875L18.37 3.16125C18.474 3.0876 18.5915 3.0363 18.7155 3.01044C18.8394 2.98459 18.9672 2.98472 19.0911 3.01084C19.2149 3.03695 19.3324 3.0885 19.4362 3.16237C19.54 3.23624 19.6282 3.33089 19.6952 3.44059C19.7622 3.55029 19.8068 3.67276 19.8262 3.8006C19.8456 3.92843 19.8395 4.05896 19.8082 4.18429C19.7768 4.30963 19.721 4.42715 19.6439 4.52976C19.5669 4.63237 19.4703 4.71793 19.36 4.78125Z" fill="black"/>
						</svg>
						<div class="fw-bold">hwcomputer@gmail.com</div>
					</div>
				</div>
				<h5 class="fw-bold" data-swiper-parallax="-400"><a class="link-secondary text-light fw-bold main-underlines" data-swiper-parallax="-400" onclick="javascript:alert('준비중입니다. 전화로 문의 바랍니다.')">고객센터 바로가기</a></h5>
			</div>	
		  </div>
		  <div class="swiper-slide">
			<div class="d-flex flex-column gap-3">
				<h1 class="fw-bold text-white" data-swiper-parallax="-200">지금 바로 최고의 견적을 받아보세요</h1>
				<h3 class="fw-bold text-white mb-5" data-swiper-parallax="-150">24시간 AI가 제공하는 개인 맞춤 견적 산출기</h3>
				<button type="button" class="btn btn-lg sw-7-btn text-white mx-auto fw-bold" data-swiper-parallax="-100" onclick="javascript:escaSelectBtn()">견적 산출하기</button>
			</div>
		  </div>
		  <div class="swiper-slide">
			<div class="d-flex flex-column gap-5 container">
				<div class="d-flex justify-content-between align-items-center mb-5">
					<img src="/resources/img/ver_02/footer-logo.png" alt="회사로고_푸터" class="w-fit">
					<div class="d-flex gap-5">
						<div class="d-flex flex-column gap-4 text-start">
							<h4 class="fw-bold text-white">SHOPPING INFO</h4>
							<div class="d-flex flex-column gap-2">
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/aboutUs.do'">회사소개</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/termsOfService.do'">이용약관</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/personalInformationProcessingPolicy.do'">개인정보처리방침</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" href="https://www.kca.go.kr/" target="_blank">소비자보호원</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" href="https://usr.ecmc.or.kr/main.do" target="_blank">전자거래분쟁조정위원회</a></h6>
							</div>
						</div>
						<div class="d-flex flex-column gap-4 text-start">
							<h4 class="fw-bold text-white">QUICK MENU</h4>
							<div class="d-flex flex-column gap-2">
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:alert('고객센터 전화를 통해 문의해주시기 바랍니다.\n\n전화번호 : 010-7625-0478')">1:1문의</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:alert('고객센터 전화를 통해 문의해주시기 바랍니다.\n\n전화번호 : 010-7625-0478')">A/S안내</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:myPageBtn()">주문조회</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:myPageBtn()">배송안내</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:alert('준비중')">컴퓨터 자가진단</a></h6>
							</div>
						</div>
						<div class="d-flex flex-column gap-4 text-start">
							<h4 class="fw-bold text-white">ALL MENU</h4>
							<div class="d-flex flex-column gap-2">
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/userBanpumMall.do'">이벤트몰</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:location.href = '/aboutUs.do'">회사소개</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:myPageBtn()">마이페이지</a></h6>
								<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:alert('고객센터 전화를 통해 문의해주시기 바랍니다.\n\n전화번호 : 010-7625-0478');">고객센터</a></h6>
								<c:if test="${loginUser == null}">
									<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:loginBtn()">로그인</a></h6>
								</c:if>
								<c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
									<h6 class="fw-bold text-white"><a class="text-reset text-decoration-none" onclick="javascript:logoutBtn()">로그아웃</a></h6>
								</c:if>
							</div>
						</div>
					</div>
				</div>

				<div class="d-flex justify-content-between align-items-center mt-5">
					<div class="d-flex flex-column gap-4">
						<h6 class="fw-semibold text-white">통신판매업 신고번호 : 2023-서울용산-1054 호</h6>
						<h6 class="fw-semibold text-white">@ Copyright HW Commander 2019 - 2023</h6>
					</div>
					<div class="d-flex flex-column gap-4">
						<h6 class="fw-semibold text-white">E-mail : pcvirusson@hanmail.net</h6>
						<h6 class="fw-semibold text-white">대표 : 이해창 | tel. 010-7625-0478</h6>
					</div>
					<div class="d-flex flex-column gap-4 text-end">
						<h6 class="fw-semibold text-white">사업자등록번호: 829-36-00813</h6>
						<h6 class="fw-semibold text-white">서울특별시 영등포구 경인로112길 4-2, 1004호(영등포동1가, 엘스페이스 여의도)</h6>
					</div>
				</div>
			</div>
		  </div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-element-bundle.min.js"></script>

	<script>
		var swiper = new Swiper(".mySwiper2", {
			cssMode: true,
			slidesPerView: 4,
      		spaceBetween: 20,
			navigation: {
				nextEl: ".swiper-button-next",
				prevEl: ".swiper-button-prev",
			},
    	});
	</script>

	<div class="modal fade" id="alertModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content p-3">
				<div class="modal-body">
					<div class="d-flex flex-column gap-2 justify-content-center align-items-center">
						<span class="fs-6">로그인 후 이용해주세요</span>
					</div>
				</div>
				<div class="modal-footer border-0 d-flex justify-content-between align-items-center gap-3 px-4">
					<button type="button" class="btn py-2 btn-outline-light flex-1 text-dark border-1 border border-dark" onclick="javascript:modalBtns(this)" modal-btn-cd="1">회원가입</button>
					<button type="button" class="btn py-2 btn-dark flex-1" onclick="javascript:modalBtns(this)" modal-btn-cd="2">로그인</button>
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
