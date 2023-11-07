<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
  <link rel="stylesheet" href="/resources/css/main.css">
  <link rel="stylesheet" href="/resources/css/main-banner.css">
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
      var mainSwiper = new Swiper(".main-swiper", {
        direction: "vertical",
        slidesPerView: 1,
        spaceBetween: 0,
        mousewheel: true,
        pagination: {
          el: ".swiper-pagination",
          clickable: true,
        },
        on: {
          init : function (){
            var btnElement = $(this.slides[0]).find('button')[0];
            if (btnElement){
              setTimeout(() => {
                btnElement.classList.add("show");
              }, 1000);
            }
          },
          slideChange: function () {
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
            }
          }
      })

      var windowWidth = window.outerWidth;
      if(windowWidth > 1920){
        $(".slide-btns").addClass("fs-3");
      }
      $(window).on("resize",function(){
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
            <li class="list-group-item bg-transparent p-4 pt-3 fixed-top text-start pb-1"><h2>MENU</h2></li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goEventMallBtn()">이벤트몰</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goEscaBtn()">견적산출</li>
            
          </ul>
          <ul class="list-group list-group-flush flex-row bg-none fixed-bottom">
            <li class="list-group-item list-group-item-action bg-transparent p-3 border-end border-dark border-bottom-0" style="--bs-border-opacity: .2;" onclick="javascript:goLogin()">로그인</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goSignUp()">회원가입</li>
          </ul>
        </c:if>
        <!-- 고객 로그인 퀵메뉴 -->
        <c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
          <ul class="list-group list-group-flush bg-none">
            <li class="list-group-item bg-transparent p-4 pt-3 fixed-top text-start pb-1"><h2>MENU</h2></li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goEventMallBtn()">이벤트몰</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goEscaBtn()">견적산출</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goStorageBtn()">견적 저장소</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goServiceBtn()">고객센터</li>
          </ul>
          <ul class="list-group list-group-flush flex-row bg-none fixed-bottom">
            <li class="list-group-item list-group-item-action bg-transparent p-3 border-end border-dark border-bottom-0" style="--bs-border-opacity: .2;" onclick="javascript:logout()">로그아웃</li>
            <li class="list-group-item list-group-item-action bg-transparent p-3" onclick="javascript:goMyPageBtn()">마이페이지</li>
          </ul>
        </c:if>
        <!-- 관리자 로그인 퀵메뉴 -->
        <c:if test="${loginUser != null && loginUser.userTypeCd == '01'}">
          <ul class="list-group list-group-flush bg-none">
            <li class="list-group-item bg-transparent p-4 pt-3 fixed-top text-start pb-1"><h2>MENU</h2></li>
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
            <div class="swiper-slide w-100">
              <video muted class="swiper-video w-100 " src="/resources/mp4/esca-video.mp4" type="video/mp4"></video>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 slide-btns" onclick="javascript:goEscaBtn()">바로가기</button>
            </div>
            <div class="swiper-slide">
              <video muted autoplay class="swiper-video banpum-mall-video-one" src="/resources/mp4/banpum-text.mp4" type="video/mp4"></video>
              <video muted autoplay loop class="swiper-video banpum-mall-video w-100" src="/resources/mp4/banpum-video.mp4" type="video/mp4" onended="javascript:videoReplay(this)"></video>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 slide-btns" onclick="javascript:goEventMallBtn()">바로가기</button>
            </div>
            <div class="swiper-slide">
              <video muted autoplay class="swiper-video w-100 my-page-video" src="/resources/mp4/mypage-video.mp4" type="video/mp4" onended="javascript:mypagePartVideoPlay()"></video>
              <video muted autoplay class="swiper-video my-page-video-monitor" src="/resources/mp4/mypage-monitor.mp4" type="video/mp4" onended="javascript:videoReplay(this)"></video>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 slide-btns" onclick="javascript:goMyPageBtn()">바로가기</button>
            </div>
            <div class="swiper-slide">
              <video muted autoplay class="swiper-video w-100" src="/resources/mp4/esca-storage.mp4" type="video/mp4"></video>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 slide-btns" onclick="javascript:goStorageBtn()">바로가기</button>
            </div>
            <div class="swiper-slide">
              <video muted autoplay class="swiper-video costomer-service-vide w-100" src="/resources/mp4/customer-video.mp4" type="video/mp4"></video>
              <button class="btn btn-primary btn-lg fade p-4 pt-3 pb-2 slide-btns" onclick="javascript:goServiceBtn()">바로가기</button>
            </div>
            <div class="swiper-slide flex-column">
              <div class="footer_background w-100 h-100 p-5">
                <div class="d-flex pt-5">
                  <!-- 빈 영역 -->
                  <div class="h-25 justify-content-start" style="width: 15%!important;"></div>
                  <div class="" style="width: 70%!important;">
                    <div class="w-100 row align-items-center mt-4 mb-4">
                      <div class="col"></div>
                      <div class="col"></div>
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
                  <div class="justify-content-end" style="width: 15%!important;"></div>
                </div>
              </div>
              <div class="basic_background w-100 h-100 p-5">
                <div class="d-flex pt-5">
                  <!-- 빈 영역 -->
                  <div class="h-25 justify-content-start" style="width: 15%!important;"></div>
                  <div class="" style="width: 70%!important;">
                    <div class="w-100 row align-items-center mt-4">
                      <div class="col">
                        <div class="d-flex justify-content-center">
                          <a href="/">
                            <img width="274" height="190" src="/resources/img/comlogo09-821x569.png">
                          </a>
                        </div>
                        <div class="d-flex justify-content-center">
                          <p class="fs-6 text-white">@ Copyright HW Commander 2019 - 2023</p>
                        </div>
                        <div class="d-flex justify-content-center">
                          <p class="fs-6" style="margin-bottom:0!important;">현우의 컴퓨터 공방에서 운영하는 사이트에서 판매되는</p>
                        </div>
                        <div class="d-flex justify-content-center">
                          <p class="fs-6" style="margin-bottom:0!important;">모든 상품은 현우의 컴퓨터 공방에서 책임지고 있습니다.</p>
                        </div>
                        <div class="d-flex justify-content-center">
                          <p class="fs-6" style="margin-bottom:0!important;">*민원 담당자 강현우 / 연락처 010-7625-0478</p>
                        </div>
                      </div>
                      <div class="col">
                        <nav class="nav flex-column">
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
                  <div class="justify-content-end" style="width: 15%!important;"></div>
                </div>
              </div>
            </div>
          </div>
          <div class="swiper-pagination"></div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
