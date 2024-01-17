<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.File" %>
<%
    String filePath = application.getRealPath("/") + "style.css";
    File file = new File(filePath);
    long lastModified = file.lastModified();
%>
<!DOCTYPE html>
<html lang="kr">

<head>
  <meta charset="utf-8" />
  <title>현우의 컴퓨터 공방 - PC가 어려운 당신을 위한 현명한 구매</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
  <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

  <!-- Link Swiper's CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />

  
  <!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="/resources/css/main-banner.css?<%=lastModified%>">
  <!-- Initialize Swiper -->
  <script>
    function videoReplay(el){
      $(el).trigger("play");
    }

    function resetVideos() {
      var videos = document.getElementsByClassName('swiper-video');
      for (var i = 0; i < videos.length; i++) {
        videos[i].currentTime = 0;
      }
    }
    function resetBtns(){
      var btns = $("button");
      btns.removeClass("show").css("display","none");
    }
    function goEscaBtn(){
      if(loginCheck()) {
        location.href = "/ESCA/ESCASelect.do";
      }
    }
    function goEventMallBtn(){
      location.href = "/userBanpumMall.do";
    }
    function goMyPageBtn(){
      if(loginCheck()) {
        location.href ="/user/myPage.do";
      }
    }
    function goStorageBtn(){
      if(loginCheck()) {
        location.href = "/user/estimateStorage.do?id=" + "${loginUser.id}";
      }
    }
    function goServiceBtn(){
      if(loginCheck()) {
        alert("준비중");
      }
    }
    function goLogin(){
      location.href = "/user/login.do";
    }
    function goSignUp(){
      location.href = "/user/signUp.do";
    }
    function goAdminBtn() {
      if(loginCheck()) {
        location.href = "/admin/main.do";
      }
    }
    function goAboutUs() {
      location.href = "/aboutUs.do";
    }
    function logout() {
      if(confirm("로그아웃 하시겠습니까?")) {
        location.href = "/user/logoutLogic.do";
      }
    }
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
    function stopVideo(el){
      $(el).pause();
    }
    function mypagePartVideoPlay (){
      let video = $(".my-page-video-monitor");
      video.css("opacity","1");
      video.trigger("play");
    }

    // esca mobile
    function escaMobileReset(){
      $('.header-a').css("display","none");
      $('.header-b').css("display","none");
      $('.body-a').css("display","none");
      $('.body-b').css("display","none");
      $('.body-c').css("display","none");
      $('.body-d').css("display","none");
      $('.body-e').css("display","none");
      $('.body-f').css("display","none");
      $('.body-g').css("display","none");
      $('.footer-a').css("display","none");
      $('.footer-b').css("display","none");
    }
    function escaMobileHeaderA(){
      $('.header-a').css("display","block");
      var text = $('.header-a').text();
      var newText = '';

      for (var i = 0; i < text.length; i++) {
          var char = text[i];
          if (char === ' ') {
              char = '&nbsp;';
          }
          newText += '<span style="animation-delay:' + (i * 0.03) + 's;">' + text[i] + '</span>';
      }
      $('.header-a').html(newText);
      setTimeout(() => {
        escaMobileHeaderB();
      }, 400);
    }
    function escaMobileHeaderB(){
      $('.header-b').css("display","block");
      setTimeout(() => {
        escaMobileBodyA();
      }, 600);
    }
    function escaMobileBodyA(){
      $('.body-a').css("display","block");
      setTimeout(() => {
        escaMobileBodyB();
      }, 300);
    }
    function escaMobileBodyB(){
      $('.body-b').css("display","block");
      setTimeout(() => {
        escaMobileBodyC();
      }, 300);
    }
    function escaMobileBodyC(){
      $('.body-c').css("display","block");
      setTimeout(() => {
        escaMobileBodyD();
      }, 300);
    }
    function escaMobileBodyD(){
      $('.body-d').css("display","block");
      setTimeout(() => {
        escaMobileBodyE();
      }, 300);
    }
    function escaMobileBodyE(){
      $('.body-e').css("display","block");
      setTimeout(() => {
        escaMobileBodyF();
      }, 300);
    }
    function escaMobileBodyF(){
      $('.body-f').css("display","block");
      setTimeout(() => {
        escaMobileBodyG();
      }, 300);
    }
    function escaMobileBodyG(){
      $('.body-g').css("display","block");
      setTimeout(() => {
        escaMobileFooterA();
      }, 600);
    }
    function escaMobileFooterA(){
      $('.footer-a').css("display","block");
      setTimeout(() => {
        escaMobileFooterB();
      }, 600);
    }
    function escaMobileFooterB(){
      $('.footer-b').css("display","block");
    }
    // banpum mobile
    function banpumMobileReset(){
      $('.banpum-header-a').css("display","none");
      $('.banpum-mall-body-a').css("display","none");
      $('.banpum-mall-body-b').css("display","none");
      $('.banpum-mall-body-c').css("display","none");
      $('.banpum-mall-body-d').css("display","none");
      $('.banpum-mall-body-e').css("display","none");
      $('.banpum-mall-body-f').css("display","none");
    }
    function banpumMobileHeaderA(){
      $('.banpum-header-a').css("display","block");
      var text = $('.banpum-header-a').text();
      var newText = '';

      for (var i = 0; i < text.length; i++) {
          var char = text[i];
          if (char === ' ') {
              char = '&nbsp;';
          }
          newText += '<span style="animation-delay:' + (i * 0.1) + 's;">' + text[i] + '</span>';
      }
      $('.banpum-header-a').html(newText);
      setTimeout(() => {
        banpumMobileBodyA();
      }, 1000);
    }
    function banpumMobileBodyA(){
      $('.banpum-mall-body-a').css("display","block");
      var text = $('.banpum-mall-body-a').text();
      var newText = '';

      for (var i = 0; i < text.length; i++) {
          var char = text[i];
          if (char === ' ') {
              char = '&nbsp;';
          }
          newText += '<span style="animation-delay:' + (i * 0.03) + 's;">' + text[i] + '</span>';
      }
      $('.banpum-mall-body-a').html(newText);
      setTimeout(() => {
        banpumMobileBodyB();
      }, 300);
    }
    function banpumMobileBodyB(){
      $('.banpum-mall-body-b').css("display","block");
      var text = $('.banpum-mall-body-b').text();
      var newText = '';

      for (var i = 0; i < text.length; i++) {
          var char = text[i];
          if (char === ' ') {
              char = '&nbsp;';
          }
          newText += '<span style="animation-delay:' + (i * 0.03) + 's;">' + text[i] + '</span>';
      }
      $('.banpum-mall-body-b').html(newText);
      setTimeout(() => {
        banpumMobileBodyC();
      }, 300);
    }
    function banpumMobileBodyC(){
      $('.banpum-mall-body-c').css("display","block");
      var text = $('.banpum-mall-body-c').text();
      var newText = '';

      for (var i = 0; i < text.length; i++) {
          var char = text[i];
          if (char === ' ') {
              char = '&nbsp;';
          }
          newText += '<span style="animation-delay:' + (i * 0.03) + 's;">' + text[i] + '</span>';
      }
      $('.banpum-mall-body-c').html(newText);
      setTimeout(() => {
        banpumMobileBodyD();
      }, 300);
    }
    function banpumMobileBodyD(){
      $('.banpum-mall-body-d').css("display","block");
      var text = $('.banpum-mall-body-d').text();
      var newText = '';

      for (var i = 0; i < text.length; i++) {
          var char = text[i];
          if (char === ' ') {
              char = '&nbsp;';
          }
          newText += '<span style="animation-delay:' + (i * 0.03) + 's;">' + text[i] + '</span>';
      }
      $('.banpum-mall-body-d').html(newText);
      setTimeout(() => {
        banpumMobileBodyE();
      }, 300);
    }
    function banpumMobileBodyE(){
      $('.banpum-mall-body-e').css("display","block");
      var text = $('.banpum-mall-body-e').text();
      var newText = '';

      for (var i = 0; i < text.length; i++) {
          var char = text[i];
          if (char === ' ') {
              char = '&nbsp;';
          }
          newText += '<span style="animation-delay:' + (i * 0.03) + 's;">' + text[i] + '</span>';
      }
      $('.banpum-mall-body-e').html(newText);
      setTimeout(() => {
        banpumMobileBodyF();
      }, 300);
    }
    function banpumMobileBodyF(){
      $('.banpum-mall-body-f').css("display","block");
      var text = $('.banpum-mall-body-f').text();
      var newText = '';

      for (var i = 0; i < text.length; i++) {
          var char = text[i];
          if (char === ' ') {
              char = '&nbsp;';
          }
          newText += '<span style="animation-delay:' + (i * 0.03) + 's;">' + text[i] + '</span>';
      }
      $('.banpum-mall-body-f').html(newText);
    }
    // my page mobile
    function myPageMobileReset(){
      $('.my-page-header-a').css("display","none");
      $('.my-page-body-a').css("display","none");
      $('.my-page-body-b').css("display","none");
      $('.my-page-body-c').css("display","none");
      $('.my-page-body-d').css("display","none");
      $('.my-page-body-e').css("display","none");
      $('.my-page-body-f').css("display","none");
      $('.my-page-body-g').css("display","none");
    }
    function myPageMobileHeaderA(){
      $('.my-page-header-a').css("display","block");
      setTimeout(() => {
        myPageMobileBodyA();
      }, 600);
    }
    function myPageMobileBodyA(){
      $('.my-page-body-a').css("display","block");
      setTimeout(() => {
        myPageMobileBodyB();
      }, 300);
    }
    function myPageMobileBodyB(){
      $('.my-page-body-b').css("display","block");
      setTimeout(() => {
        myPageMobileBodyC();
      }, 300);
    }
    function myPageMobileBodyC(){
      $('.my-page-body-c').css("display","block");
      setTimeout(() => {
        myPageMobileBodyD();
      }, 800);
    }
    function myPageMobileBodyD(){
      $('.my-page-body-d').css("display","block");
      setTimeout(() => {
        myPageMobileBodyE();
      }, 300);
    }
    function myPageMobileBodyE(){
      $('.my-page-body-E').css("display","block");
      setTimeout(() => {
        myPageMobileBodyF();
      }, 300);
    }
    function myPageMobileBodyF(){
      $('.my-page-body-f').css("display","block");
      setTimeout(() => {
        myPageMobileBodyG();
      }, 300);
    }
    function myPageMobileBodyG(){
      $('.my-page-body-g').css("display","block");
      setTimeout(() => {
        myPageMobileBodyH();
      }, 300);
    }
    // esca storage mobile
    function escaStorageMobileReset(){
      $('.esca-storage-header-a').css("display","none");
      $('.esca-storage-body-a').css("display","none");
      $('.esca-storage-body-b').css("display","none");
      $('.esca-storage-body-c').css("display","none");
      $('.esca-storage-body-d').css("display","none");
    }
    function escaStorageMobileHeaderA(){
      $('.esca-storage-header-a').css("display","block");
      setTimeout(() => {
        escaStorageMobileBodyA();
      }, 800);
    }
    function escaStorageMobileBodyA(){
      $('.esca-storage-body-a').css("display","block");
      setTimeout(() => {
        escaStorageMobileBodyB();
      }, 600);
    }
    function escaStorageMobileBodyB(){
      $('.esca-storage-body-b').css("display","block");
      setTimeout(() => {
        escaStorageMobileBodyC();
      }, 400);
    }
    function escaStorageMobileBodyC(){
      $('.esca-storage-body-c').css("display","block");
      setTimeout(() => {
        escaStorageMobileBodyD();
      }, 400);
    }
    function escaStorageMobileBodyD(){
      $('.esca-storage-body-d').css("display","block");
    }
    // costomer service mobile
    function costomerServiceMobileReset(){
      $('.costomer-service-header-a').css("display","none");
      $('.costomer-service-body-a').css("display","none");
      $('.costomer-service-body-b').css("display","none");
      $('.costomer-service-body-c').css("display","none");
      $('.costomer-service-body-d').css("display","none");
      $('.costomer-service-body-e').css("display","none");
      $('.costomer-service-body-f').css("display","none");
    }
    function costomerServiceMobileHeaderA(){
      $('.costomer-service-header-a').css("display","block");
      setTimeout(() => {
        costomerServiceMobileBodyA();
      }, 800);
    }
    function costomerServiceMobileBodyA(){
      $('.costomer-service-body-a').css("display","block");
      setTimeout(() => {
        costomerServiceMobileBodyB();
      }, 400);
    }
    function costomerServiceMobileBodyB(){
      $('.costomer-service-body-b').css("display","block");
      setTimeout(() => {
        costomerServiceMobileBodyC();
      }, 400);
    }
    function costomerServiceMobileBodyC(){
      $('.costomer-service-body-c').css("display","block");
      setTimeout(() => {
        costomerServiceMobileBodyD();
      }, 400);
    }
    function costomerServiceMobileBodyD(){
      $('.costomer-service-body-d').css("display","block");
      setTimeout(() => {
        costomerServiceMobileBodyE();
      }, 400);
    }
    function costomerServiceMobileBodyE(){
      $('.costomer-service-body-e').css("display","block");
      setTimeout(() => {
        costomerServiceMobileBodyF();
      }, 400);
    }
    function costomerServiceMobileBodyF(){
      $('.costomer-service-body-f').css("display","block");
    }
    $(function(){
      var menuButton = $('.menu-button');
      var openMenu = function () {
        swiper.slidePrev();
      };
      var swiper = new Swiper(".mySwiper", {
        slidesPerView: "auto",
        initialSlide: 1,
        resistanceRatio: 0,
        slideToClickedSlide: true,
        on: {
          slideChangeTransitionStart: function () {
            var slider = this;
            if (slider.activeIndex === 0) {
              menuButton.addClass('cross');
              // required because of slideToClickedSlide
              menuButton.off('click', openMenu);
            } else {
              menuButton.removeClass('cross');
            }
          },
          slideChangeTransitionEnd: function () {
            var slider = this;
            if (slider.activeIndex === 1) {
              menuButton.on('click', openMenu);
            }
          },
        },
      });
      let swiperTooltips = ["메인" , "견적산출" , "이벤트몰" , "마이페이지" , "견적저장소" , "고객센터" , "이용약관"];
      var mainSwiper = new Swiper(".main-swiper", {
        direction: "vertical",
        slidesPerView: 1,
        spaceBetween: 0,
        mousewheel: true,
        pagination: {
          el: ".swiper-pagination",
          clickable: true,
          renderBullet: function (index, className) {
            return '<span class="' + className + '" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-title="' + swiperTooltips[index] + '"></span>';
          },
        },
        on: {
          init : function (){
            var btnElement = $(this.slides[0]).find('button')[0];
            if (btnElement){
              setTimeout(() => {
                btnElement.classList.add("show");
              }, 1000);
            };
            const tooltipTriggerList = $('[data-bs-toggle="tooltip"]');
            const tooltipList = tooltipTriggerList.map(function() {
              return new bootstrap.Tooltip($(this)[0]);
            }).get();
          },
          slideChange: function () {
              var windowWidth = window.outerWidth;
              var activeIndex = this.activeIndex;
              if(windowWidth >= 718){
                resetVideos();
                resetBtns();
                var activeSlide = this.slides[this.activeIndex];
                var videoElement = $(activeSlide).find('video')[0];
                var btnElement = $(activeSlide).find('button')[0];
                var monitorVideo = $(".my-page-video-monitor");
                $(".my-page-video-monitor").css("opacity","0").trigger("pause");
                monitorVideo.get(0).currentTime = 0;
                if (videoElement) {
                    videoElement.play();
                }
                if (btnElement){
                  btnElement.style.display = "block";
                  setTimeout(() => {
                    btnElement.classList.add("show");
                  }, 1000);
                }
                if(this.activeIndex == 6){
                  menuButton.trigger("click");
                }
              }else if(windowWidth < 718){
                if(activeIndex == 0){
                  escaMobileReset();
                  escaStorageMobileReset();
                  banpumMobileReset();
                  myPageMobileReset();
                  costomerServiceMobileReset();
                  setTimeout(() => {
                    escaMobileReset();
                    escaStorageMobileReset();
                    banpumMobileReset();
                    myPageMobileReset();
                    costomerServiceMobileReset();
                  }, 800);
                  resetVideos();
                  resetBtns();
                  var activeSlide = this.slides[this.activeIndex];
                  var videoElement = $(activeSlide).find('video')[0];
                  var btnElement = $(activeSlide).find('button')[0];
                  if (videoElement) {
                      videoElement.play();
                  }
                  if (btnElement){
                    btnElement.style.display = "block";
                    setTimeout(() => {
                      btnElement.classList.add("show");
                    }, 1000);
                  }
                }else {
                  escaMobileReset();
                  escaStorageMobileReset();
                  banpumMobileReset();
                  myPageMobileReset();
                  costomerServiceMobileReset();
                  var activeSlide = this.slides[this.activeIndex];
                  var btnElement = $(activeSlide).find('button')[0];
                  if (btnElement){
                    btnElement.style.display = "block";
                    setTimeout(() => {
                      btnElement.classList.add("show");
                    }, 1000);
                  }
                  if(this.activeIndex == 6){
                    menuButton.trigger("click");
                  }
                  if(activeIndex == 1){
                    setTimeout(() => {
                      escaMobileHeaderA();
                    }, 500);
                  }else if(activeIndex == 2){
                    setTimeout(() => {
                      banpumMobileHeaderA();
                    }, 500);
                  }else if(activeIndex == 3){
                    setTimeout(() => {
                      myPageMobileHeaderA();
                    }, 500);
                  }else if(activeIndex == 4){
                    setTimeout(() => {
                      escaStorageMobileHeaderA();
                    }, 500);
                  }else if (activeIndex == 5){
                    setTimeout(() => {
                      costomerServiceMobileHeaderA();
                    }, 500);
                  }
                }
              }
            }
          }
      })

      var windowWidth = window.outerWidth;

      if(windowWidth > 1920){
        $(".slide-btns").addClass("fs-3");
      }
      $(window).on("resize",function(){
        windowWidth = window.outerWidth;
        if(windowWidth < 1921){
          $(".slide-btns").removeClass("fs-3");
        }
        if(windowWidth > 1920){
          $(".slide-btns").addClass("fs-3");
        }
      })
    });
    </script>
</head>

<body>
  <div class="swiper mySwiper">
    <div class="swiper-wrapper">
      <div class="swiper-slide menu">
        <!-- 비로그인 퀵메뉴 -->
        <c:if test="${loginUser == null}">
          <ul class="list-group list-group-flush bg-none quick">
            <li class="list-group-item bg-transparent p-4 pt-3 fixed-top text-start pb-1"><h2>메뉴</h2></li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goEscaBtn()">견적산출</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goEventMallBtn()">이벤트몰</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goAboutUs()">회사소개</li>
            
          </ul>
          <ul class="list-group list-group-flush flex-row bg-none fixed-bottom">
            <li class="list-group-item list-group-item-action bg-transparent p-3 border-end border-dark border-bottom-0" style="--bs-border-opacity: .2;" onclick="javascript:goLogin()">로그인</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goSignUp()">회원가입</li>
          </ul>
        </c:if>
        <!-- 고객 로그인 퀵메뉴 -->
        <c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
          <ul class="list-group list-group-flush bg-none">
            <li class="list-group-item bg-transparent p-4 pt-3 fixed-top text-start pb-1"><h2>메뉴</h2></li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goEscaBtn()">견적산출</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goStorageBtn()">견적 저장소</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goEventMallBtn()">이벤트몰</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goServiceBtn()">고객센터</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goAboutUs()">회사소개</li>
          </ul>
          <ul class="list-group list-group-flush flex-row bg-none fixed-bottom">
            <li class="list-group-item list-group-item-action bg-transparent p-3 border-end border-dark border-bottom-0" style="--bs-border-opacity: .2;" onclick="javascript:logout()">로그아웃</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goMyPageBtn()">마이페이지</li>
          </ul>
        </c:if>
        <!-- 관리자 로그인 퀵메뉴 -->
        <c:if test="${loginUser != null && loginUser.userTypeCd == '01'}">
          <ul class="list-group list-group-flush bg-none">
            <li class="list-group-item bg-transparent p-4 pt-3 fixed-top text-start pb-1"><h2>메뉴</h2></li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goAdminBtn()">AdminPage</li>
          </ul>
          <ul class="list-group list-group-flush flex-row bg-none fixed-bottom">
            <li class="list-group-item list-group-item-action bg-transparent p-3 border-end border-dark border-bottom-0" style="--bs-border-opacity: .2;" onclick="javascript:logout()">로그아웃</li>
          </ul>
        </c:if>
      </div>
      <div class="swiper-slide content">
        <div class="menu-button">
          <div class="bar"></div>
          <div class="bar"></div>
          <div class="bar"></div>
        </div>
        <div class="swiper main-swiper">
          <div class="swiper-wrapper">
            <div class="swiper-slide">
              <video autoplay muted class="swiper-video main-video-one" src="/resources/mp4/mainvideo-text.mp4" type="video/mp4"></video>
              <video muted autoplay loop class="swiper-video main-video-two" src="/resources/mp4/mainvideo-com.mp4" type="video/mp4" onended="javascript:videoReplay(this)"></video>
              <!-- 비로그인 버튼 -->
              <c:if test="${loginUser == null}">
                <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 slide-btns" onclick="javascript:goLogin()">로그인</button>
              </c:if>
              <!-- 고객 로그인 버튼 -->
              <c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
                <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 slide-btns" onclick="javascript:logout()">로그아웃</button>
              </c:if>
              <!-- 관리자 로그인 버튼 -->
              <c:if test="${loginUser != null && loginUser.userTypeCd == '01'}">
                <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 slide-btns" onclick="javascript:logout()">로그아웃</button>
              </c:if>
            </div>
            <div class="swiper-slide w-100 esca-video-slide">
              <video muted class="swiper-video w-100 esca-video" src="/resources/mp4/esca-video.mp4" type="video/mp4"></video>
              <div class="mobile-container">
                <div class="esca-mobile-header">
                  <p class="text-p header-a">고객 한 분 한분의 니즈를</p>
                  <p class="text-w header-b">
                    <span class="text-p">계산해주는</span>
                    <span class="text-w">견적 상담 AI</span>
                  </p>
                </div>
                <div class="esca-mobile-body">
                  <p class="speach-bubble-p body-a">총 예산은?</p>
                  <p class="speach-bubble-w body-b">150만원</p>
                  <p class="speach-bubble-p body-c">사용 용도는?</p>
                  <p class="speach-bubble-w body-d">게임, 디자인</p>
                  <p class="speach-bubble-p body-e">기타 희망사항은?</p>
                  <p class="speach-bubble-w body-f">발열과 소음이 적었으면...</p>
                  <p class="speach-bubble-p body-g">...</p>
                </div>
                <div class="esca-mobile-footer">
                  <p class="footer-a">
                    <span class="text-w">수천 만의 견적 중</span>
                    <span class="text-p">고객님을 위한</span>
                  </p>
                  <p class="footer-b">단 하나의 PC를 찾아드립니다!</p>
                </div>
              </div>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 pe-3 slide-btns" onclick="javascript:goEscaBtn()">견적산출<svg class="ms-2" width="32px" height="32px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#ffffff"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M7 7.13193V6.61204C7 4.46614 7 3.3932 7.6896 2.79511C8.37919 2.19703 9.44136 2.34877 11.5657 2.65224L15.8485 3.26408C18.3047 3.61495 19.5327 3.79039 20.2664 4.63628C21 5.48217 21 6.72271 21 9.20377V14.7962C21 17.2773 21 18.5178 20.2664 19.3637C19.5327 20.2096 18.3047 20.385 15.8485 20.7359L11.5657 21.3478C9.44136 21.6512 8.37919 21.803 7.6896 21.2049C7 20.6068 7 19.5339 7 17.388V17.066" stroke="#ffffff" stroke-width="2"></path> <path d="M16 12L16.7809 11.3753L17.2806 12L16.7809 12.6247L16 12ZM4 13C3.44771 13 3 12.5523 3 12C3 11.4477 3.44771 11 4 11V13ZM12.7809 6.3753L16.7809 11.3753L15.2191 12.6247L11.2191 7.6247L12.7809 6.3753ZM16.7809 12.6247L12.7809 17.6247L11.2191 16.3753L15.2191 11.3753L16.7809 12.6247ZM16 13H4V11H16V13Z" fill="#ffffff"></path> </g></svg></button>
            </div>
            <div class="swiper-slide banpum-mall-video-slide">
              <video muted autoplay class="swiper-video banpum-mall-video-one banpum-mall-video" src="/resources/mp4/banpum-text.mp4" type="video/mp4"></video>
              <video muted autoplay loop class="swiper-video banpum-mall-video w-100" src="/resources/mp4/banpum-video.mp4" type="video/mp4" onended="javascript:videoReplay(this)"></video>
              <div class="mobile-container">
                <div class="banpum-mall-header">
                  <p class="text-p banpum-header-a">이벤트몰</p>
                </div>
                <div class="banpum-mall-body">
                  <p class="banpum-mall-body-a">HWC에서는 중고 부품을</p>
                  <p class="banpum-mall-body-b">새 PC에 넣지 않습니다.</p>
                  <p class="banpum-mall-body-c">환불된 제품은</p>
                  <p class="banpum-mall-body-d">이벤트몰에 전시되어</p>
                  <p class="text-p banpum-mall-body-e">차감된 환불액만큼 감산</p>
                  <p class="banpum-mall-body-f">하여 판매됩니다.</p>
                </div>
              </div>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 pe-3 slide-btns" onclick="javascript:goEventMallBtn()">이벤트몰<svg class="ms-2" width="32px" height="32px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#ffffff"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M7 7.13193V6.61204C7 4.46614 7 3.3932 7.6896 2.79511C8.37919 2.19703 9.44136 2.34877 11.5657 2.65224L15.8485 3.26408C18.3047 3.61495 19.5327 3.79039 20.2664 4.63628C21 5.48217 21 6.72271 21 9.20377V14.7962C21 17.2773 21 18.5178 20.2664 19.3637C19.5327 20.2096 18.3047 20.385 15.8485 20.7359L11.5657 21.3478C9.44136 21.6512 8.37919 21.803 7.6896 21.2049C7 20.6068 7 19.5339 7 17.388V17.066" stroke="#ffffff" stroke-width="2"></path> <path d="M16 12L16.7809 11.3753L17.2806 12L16.7809 12.6247L16 12ZM4 13C3.44771 13 3 12.5523 3 12C3 11.4477 3.44771 11 4 11V13ZM12.7809 6.3753L16.7809 11.3753L15.2191 12.6247L11.2191 7.6247L12.7809 6.3753ZM16.7809 12.6247L12.7809 17.6247L11.2191 16.3753L15.2191 11.3753L16.7809 12.6247ZM16 13H4V11H16V13Z" fill="#ffffff"></path> </g></svg></button>
            </div>
            <div class="swiper-slide my-page-video-slide">
              <video muted autoplay class="swiper-video w-100 my-page-video" src="/resources/mp4/mypage-video.mp4" type="video/mp4" onended="javascript:mypagePartVideoPlay()"></video>
              <video muted autoplay class="swiper-video my-page-video-monitor my-page-video" src="/resources/mp4/mypage-monitor.mp4" type="video/mp4" onended="javascript:videoReplay(this)"></video>
              <div class="mobile-container">
                <div class="my-page-header">
                  <p class="text-p my-page-header-a">마이페이지</p>
                </div>
                <div class="my-page-body">
                  <p class="my-page-body-a">
                    <span class="my-page-body-num">1.</span>
                    <span>구매하신 제품 모델에 따라</span>
                  </p>
                  <p class="my-page-body-b">OS와 바이오스 및 드라이버의</p>
                  <p class="my-page-body-c">최적화 및 관리를 도와드립니다.</p>
                  <p class="my-page-body-d">
                    <span class="my-page-body-num">2.</span>
                    <span>고객님께 배달된 PC의</span>
                  </p>
                  <p class="my-page-body-e">시리얼 번호를 참조하여</p>
                  <p class="my-page-body-f">조립 과정이 담긴 영상으로</p>
                  <p class="my-page-body-g">신품임을 확인하세요.</p>
                </div>
              </div>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 pe-3 slide-btns" onclick="javascript:goMyPageBtn()">마이페이지<svg class="ms-2" width="32px" height="32px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#ffffff"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M7 7.13193V6.61204C7 4.46614 7 3.3932 7.6896 2.79511C8.37919 2.19703 9.44136 2.34877 11.5657 2.65224L15.8485 3.26408C18.3047 3.61495 19.5327 3.79039 20.2664 4.63628C21 5.48217 21 6.72271 21 9.20377V14.7962C21 17.2773 21 18.5178 20.2664 19.3637C19.5327 20.2096 18.3047 20.385 15.8485 20.7359L11.5657 21.3478C9.44136 21.6512 8.37919 21.803 7.6896 21.2049C7 20.6068 7 19.5339 7 17.388V17.066" stroke="#ffffff" stroke-width="2"></path> <path d="M16 12L16.7809 11.3753L17.2806 12L16.7809 12.6247L16 12ZM4 13C3.44771 13 3 12.5523 3 12C3 11.4477 3.44771 11 4 11V13ZM12.7809 6.3753L16.7809 11.3753L15.2191 12.6247L11.2191 7.6247L12.7809 6.3753ZM16.7809 12.6247L12.7809 17.6247L11.2191 16.3753L15.2191 11.3753L16.7809 12.6247ZM16 13H4V11H16V13Z" fill="#ffffff"></path> </g></svg></button>
            </div>
            <div class="swiper-slide esca-storage-video-slide">
              <video muted autoplay class="swiper-video w-100 esca-storage-video" src="/resources/mp4/esca-storage.mp4" type="video/mp4"></video>
              <div class="mobile-container">
                <div class="esca-storage-header">
                  <p class="text-p esca-storage-header-a">견적 저장소</p>
                </div>
                <div class="esca-storage-body">
                  <img class="esca-storage-cart esca-storage-body-a" src="/resources/img/esca-storage-cart.png">
                  <p class="esca-storage-body-b">산출한 나의 취향을 저장!</p>
                  <p class="esca-storage-body-c">본인만의 맞춤 설정을</p>
                  <p class="esca-storage-body-d">최신 제품으로 꺼내 쓰세요!</p>
                </div>
              </div>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 pe-3 slide-btns" onclick="javascript:goStorageBtn()">견적저장소<svg class="ms-2" width="32px" height="32px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#ffffff"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M7 7.13193V6.61204C7 4.46614 7 3.3932 7.6896 2.79511C8.37919 2.19703 9.44136 2.34877 11.5657 2.65224L15.8485 3.26408C18.3047 3.61495 19.5327 3.79039 20.2664 4.63628C21 5.48217 21 6.72271 21 9.20377V14.7962C21 17.2773 21 18.5178 20.2664 19.3637C19.5327 20.2096 18.3047 20.385 15.8485 20.7359L11.5657 21.3478C9.44136 21.6512 8.37919 21.803 7.6896 21.2049C7 20.6068 7 19.5339 7 17.388V17.066" stroke="#ffffff" stroke-width="2"></path> <path d="M16 12L16.7809 11.3753L17.2806 12L16.7809 12.6247L16 12ZM4 13C3.44771 13 3 12.5523 3 12C3 11.4477 3.44771 11 4 11V13ZM12.7809 6.3753L16.7809 11.3753L15.2191 12.6247L11.2191 7.6247L12.7809 6.3753ZM16.7809 12.6247L12.7809 17.6247L11.2191 16.3753L15.2191 11.3753L16.7809 12.6247ZM16 13H4V11H16V13Z" fill="#ffffff"></path> </g></svg></button>
            </div>
            <div class="swiper-slide costomer-service-video-slide">
              <video muted autoplay class="swiper-video costomer-service-video w-100" src="/resources/mp4/customer-video.mp4" type="video/mp4"></video>
              <div class="mobile-container">
                <div class="costomer-service-header">
                  <p class="text-p costomer-service-header-a">고객센터</p>
                </div>
                <div class="costomer-service-body">
                  <p class="costomer-service-body-a">사소한 잔렉 및 신호 불량부터</p>
                  <p class="costomer-service-body-b">영문을 알 수 없는 폭발까지</p>
                  <p class="costomer-service-body-c">가볍고 무거운 모든 PC 문제를</p>
                  <p class="costomer-service-body-d text-w">HWC 고객센터에서</p>
                  <p class="costomer-service-body-e">상담해 드립니다</p>
                  <img class="costomer-service-body-f" src="/resources/img/costomer-service-mark.png">
                </div>
              </div>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 pe-3 slide-btns" onclick="javascript:goServiceBtn()">고객센터<svg class="ms-2" width="32px" height="32px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#ffffff"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M7 7.13193V6.61204C7 4.46614 7 3.3932 7.6896 2.79511C8.37919 2.19703 9.44136 2.34877 11.5657 2.65224L15.8485 3.26408C18.3047 3.61495 19.5327 3.79039 20.2664 4.63628C21 5.48217 21 6.72271 21 9.20377V14.7962C21 17.2773 21 18.5178 20.2664 19.3637C19.5327 20.2096 18.3047 20.385 15.8485 20.7359L11.5657 21.3478C9.44136 21.6512 8.37919 21.803 7.6896 21.2049C7 20.6068 7 19.5339 7 17.388V17.066" stroke="#ffffff" stroke-width="2"></path> <path d="M16 12L16.7809 11.3753L17.2806 12L16.7809 12.6247L16 12ZM4 13C3.44771 13 3 12.5523 3 12C3 11.4477 3.44771 11 4 11V13ZM12.7809 6.3753L16.7809 11.3753L15.2191 12.6247L11.2191 7.6247L12.7809 6.3753ZM16.7809 12.6247L12.7809 17.6247L11.2191 16.3753L15.2191 11.3753L16.7809 12.6247ZM16 13H4V11H16V13Z" fill="#ffffff"></path> </g></svg></button>
            </div>
            <div class="swiper-slide flex-column">
              <div class="footer_background w-100 h-50 main-footer-back">
                <div class="d-flex pt-5">
                  <!-- 빈 영역 -->
                  <div class="h-25 justify-content-start main-footer-empty-space"></div>
                  <div class="main-footer-body">
                    <div class="w-100 row align-items-center mt-4 mb-4 mx-auto">
                      <div class="col-md"></div>
                      <div class="col-md"></div>
                      <div class="col">
                        <nav class="nav flex-column">
                          <h4 class="text-secondary"><b>SHOPPING INFO</b></h4>
                          <a class="nav-link text-secondary" href="/aboutUs.do">회사소개</a>
                          <a class="nav-link text-secondary" href="/termsOfService.do">이용약관</a>
                          <a class="nav-link text-secondary" href="/personalInformationProcessingPolicy.do">개인정보처리방침</a>
                          <a class="nav-link text-secondary" href="https://www.kca.go.kr/" target="_blank">소비자보호원</a>
                          <a class="nav-link text-secondary" href="https://usr.ecmc.or.kr/main.do" target="_blank">전자거래분쟁조정위원회</a>
                        </nav>
                      </div>
                      <div class="col">
                        <nav class="nav flex-column">
                          <h4 class="text-secondary"><b>QUICK MENU</b></h4>
                          <a class="nav-link text-secondary" href="javascript:alert('준비중')">1:1문의</a>
                          <a class="nav-link text-secondary" href="javascript:alert('준비중')">A/S안내</a>
                          <a class="nav-link text-secondary" href="javascript:alert('준비중')">주문조회</a>
                          <a class="nav-link text-secondary" href="javascript:alert('준비중')">배송안내</a>
                          <a class="nav-link text-secondary" href="javascript:alert('준비중')">컴퓨터 자가진단</a>
                        </nav>
                      </div>
                    </div>
                  </div>
                  <!-- 빈 영역 -->
                  <div class="justify-content-end main-footer-empty-space"></div>
                </div>
              </div>
              <div class="basic_background w-100 h-50 main-footer-back">
                <div class="d-flex pt-md-5">
                  <!-- 빈 영역 -->
                  <div class="h-25 justify-content-start main-footer-empty-space"></div>
                  <div class="main-footer-body">
                    <div class="w-100 row align-items-center mt-4 main-copyrights mx-auto">
                      <div class="col mb-2">
                        <div class="justify-content-center main-footer-mark">
                          <a href="/">
                            <img width="274" height="190" src="/resources/img/comlogo09-821x569.png">
                          </a>
                        </div>
                        <div class="d-flex justify-content-center">
                          <p class="fs-6 text-white">@ Copyright HW Commander 2019 - 2023</p>
                        </div>
                        <div class="d-md-flex flex-column justify-content-center">
                          <span class="fs-6" style="margin-bottom:0!important;">현우의 컴퓨터 공방에서 운영하는 사이트에서 판매되는</span>
                          <span class="fs-6" style="margin-bottom:0!important;">모든 상품은 현우의 컴퓨터 공방에서 책임지고 있습니다.</span>
                          <p class="fs-6" style="margin-bottom:0!important;">*민원 담당자 이해창 / 연락처 010-7625-0478</p>
                        </div>
                      </div>
                      <div class="col">
                        <nav class="nav flex-column main-footer-infos">
                          <h4><b>현우의 컴퓨터 공방</b></h4>
                          <a class="nav-link disabled text-dark" href="#">대표 : 이해창 | tel. 010-7625-0478</a>
                          <a class="nav-link disabled text-dark" href="#">사업자등록번호: 829-36-00813</a>
                          <a class="nav-link disabled text-dark" href="#">서울시 용산구 보광로 110, 2층 현우의 컴퓨터 공방</a>
                          <a class="nav-link disabled text-dark" href="#">E-mail : pcvirusson@hanmail.net</a>
                          <a class="nav-link disabled text-dark" href="#">호스팅 제공자 : (주)카페24</a>
                          <a class="nav-link disabled text-dark" href="#">통신판매업 신고번호 : 2023-서울용산-1054 호</a>
                        </nav>
                      </div>
                    </div>
                  </div>
                  <!-- 빈 영역 -->
                  <div class="justify-content-end main-footer-empty-space"></div>
                </div>
              </div>
            </div>
          </div>
          <div class="swiper-pagination me-4"></div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
