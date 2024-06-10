<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
    <head>
    <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

        <link rel="stylesheet" href="/resources/css/ver_02/header.css">

        <script>
            <%-- var loginUser = '<%=(String)session.getAttribute("loginUser")%>'; --%>
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

            
            $(function() {
            });
            function goEventMall(){
                location.href = "/userBanpumMall.do";
            }
            function loginBtn(){
                location.href = "/user/login.do";
            }
            function aboutUsBtn(){
                location.href = "/aboutUs.do";
            }
            function homeBtn(){
                location.href = "/";
            }
            function escaSelectBtn(){
                if(loginCheck()){
                    location.href = "/ESCA/ESCASelect.do";
                }
            }
            function adminPageBtn() {
                if(loginCheck()) {
                    location.href = "/admin/main.do";
                }
            }
            function logoutBtn() {
                if(confirm("로그아웃 하시겠습니까?")) {
                    location.href = "/user/logoutLogic.do";
                }
            }
            function myPageBtn() {
                if(loginCheck()) {
                    location.href ="/user/myPage.do";
                }
            }
            function serviceCenterPageBtn() {
                alert("고객센터 전화를 통해 문의해주시기 바랍니다.\n\n전화번호 : 010-7625-0478");
            }
        </script>
    </head>
    <body>
        <div class="container-fluid header-container px-5">
            <div class="d-flex justify-content-between align-items-center h-100 gap-5">
                <div class="flex-1 justify-content-center d-flex"></div>
                <div class="flex-1 justify-content-center d-flex align-items-center gap-2">
                    <button type="button" class="btn btn-outline-secondary border-0 text-white fw-bold" onclick="javascript:goEventMall()">이벤트몰</button>
                    <button type="button" class="btn btn-outline-secondary border-0 text-white fw-bold" onclick="javascript:myPageBtn()">마이페이지</button>
                    <button type="button" class="btn" onclick="javascript:homeBtn()">
                        <img src="/resources/img/ver_02/logo_header.png" alt="회사로고_헤더">
                    </button>
                    <button type="button" class="btn btn-outline-secondary border-0 text-white fw-bold" onclick="javascript:aboutUsBtn()">회사소개</button>
                    <button type="button" class="btn btn-outline-secondary border-0 text-white fw-bold" onclick="javascript:serviceCenterPageBtn()">고객센터</button>
                </div>
                <div class="flex-1 justify-content-end d-flex gap-2">
                    <c:if test="${loginUser == null}">
                        <button type="button" class="header-inner-buttons btn btn-outline-secondary text-white fw-bold" onclick="javascript:loginBtn()">로그인</button>
                        <button type="button" class="header-inner-buttons btn btn-light border-0 fw-bold" onclick="javascript:escaSelectBtn()">견적산출</button>
                    </c:if>
                    <c:if test="${loginUser != null && loginUser.mailConfirm == 'Y' && loginUser.userTypeCd == '02'}">
                        <button type="button" class="header-inner-buttons btn btn-outline-secondary text-white fw-bold" onclick="javascript:logoutBtn()">로그아웃</button>
                        <button type="button" class="header-inner-buttons btn btn-light border-0 fw-bold" onclick="javascript:escaSelectBtn()">견적산출</button>
                    </c:if>
                    <c:if test="${loginUser != null && loginUser.userTypeCd == '01'}">
                        <button type="button" class="header-inner-buttons btn btn-outline-secondary text-white fw-bold" onclick="javascript:logoutBtn()">로그아웃</button>
                        <button type="button" class="header-inner-buttons btn btn-light border-0 fw-bold" onclick="javascript:adminPageBtn()">Admin</button>
                    </c:if>
                </div>
            </div>
        </div>
    </body>
</html>
