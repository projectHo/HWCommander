<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - 주문내역</title>
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

<link rel="stylesheet" href="/resources/css/refundInfo.css">
<script>
    let a = "${refundInfoVO}"
    function cancleRefundBtn(){
        if(confirm("환불요청을 취소하시겠습니까?")){
            $.ajax({
                type: "post",
                url: "/user/refundDeleteLogic.do",
                data: {
                    id: "${refundInfoVO.id}",
                    orderId: "${orderMasterVO.id}"
                },
                dataType: "json",
                success: function(response) {
                    alert("정상적으로 취소되었습니다!");
                    if(loginCheck()) {
                        location.href ="/user/myPage.do";
                    }
                },
                error: function(xhr, status, error) {
                    alert("요청 실패했습니다.. 다시 시도해주세요!");
                    console.log(error);
                    location.reload();
                }
            });
        }else {
            return false;
        }
    }
    function disAgreeTerms(){
        let refundPartialAgreeCd = "03";
        if(confirm("부분 환불에 동의하지 않으시면 추가심사가 필요합니다.")){
            $.ajax({
                type: "post",
                url: "/user/updateRefundPartialAgreeCd.do",
                data: {
                    id: "${refundInfoVO.id}",
                    refundPartialAgreeCd: refundPartialAgreeCd
                },
                dataType: "json",
                success: function() {
                    alert("처리가 완료되었습니다.");
                    if(loginCheck()) {
                        location.reload();
                    }
                },
                error: function() {
                    alert("요청 실패했습니다.. 다시 시도해주세요!");
                    location.reload();
                }
            });
        }else {
            return false;
        }
    }
    function agreeTerms(){
        let refundPartialAgreeCd = "02";
        if(confirm("동의하시면 안내드린 내용으로 환불 처리 됩니다!")){
            $.ajax({
                type: "post",
                url: "/user/updateRefundPartialAgreeCd.do",
                data: {
                    id: "${refundInfoVO.id}",
                    refundPartialAgreeCd: refundPartialAgreeCd
                },
                dataType: "json",
                success: function() {
                    alert("처리가 완료되었습니다.");
                    if(loginCheck()) {
                        location.reload();
                    }
                },
                error: function() {
                    alert("요청 실패했습니다.. 다시 시도해주세요!");
                    location.reload();
                }
            });
        }else {
            return false;
        }
    }
    let refundReasonCd;
    let refundReasonUserWriteText = null;
    function changeRefundReason(el){
        if(refundReasonCd == "99" && refundReasonUserWriteText == null){
            alert("상세사유를 입력해주세요");
            return false;
        }else {
            if(confirm("수정하시겠습니까?")){
                $.ajax({
                    type: "post",
                    url: "/user/updateRefundReasonCdAndUserWrite.do",
                    data: {
                        id: "${refundInfoVO.id}",
                        refundReasonCd: refundReasonCd,
                        refundReasonUserWrite: refundReasonUserWriteText,
                    },
                    dataType: "json",
                    success: function() {
                        alert("수정 완료되었습니다.");
                        if(loginCheck()) {
                            location.reload();
                        }
                    },
                    error: function() {
                        alert("수정 실패했습니다.. 다시 시도해주세요!");
                        location.reload();
                    }
                });
            }else {
                return false;
            }
        }
    }
    function refundReasonDropdownBtn(el){
        $(".refund-reason-title").html($(el).html());
        refundReasonCd = $(el).attr("cd");
        if($(el).attr("cd") == "99"){
            $(".reason-user-write").removeClass("d-none").addClass("show");
        }else {
            $(".reason-user-write").removeClass("show").addClass("d-none");
        }
    }
    function refundReasonUserWrite(el){
        refundReasonUserWriteText = $(el).val();
        console.log(refundReasonUserWriteText);
    }
    $(function() {
        for(let i = 1; i <= 5; i++){
            var padI = i.toString().padStart(2, '0');
            if("${refundInfoVO.refundStateCd}" == padI){
                $(".refund-state").eq(i-1).removeClass("btn-outline-dark").addClass("btn-success").attr("disabled",false);
            }
        }
        if("${refundInfoVO.refundStateCd}" == "04" || "${refundInfoVO.refundStateCd}" == "05"){
            $(".refund-state").eq(3).remove();
        }
        if("${refundInfoVO.requestRefundPrice}" != "${refundInfoVO.determinRefundPrice}" && Number("${refundInfoVO.refundStateCd}") >= Number("02")){
            $("#secondTermsModal").modal("show");
        }
    })
</script>
</head>
<body>
	<%@ include file="./common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 15%!important;"></div>
			<!-- 작업영역 -->
			<div class="estimateCalc_background p-5" style="width: 70% !important">
				<div class="container">
					<div class="buttons mb-3 d-flex justify-content-md-between">
						<h2 class="mb-3">
							<span>${loginUser.id}</span>
							<b>님의 환불 상세내역</b>
						</h2>
						<div class="mt-2">
                            <button class="btn btn-outline-dark h-100 refund-state" disabled type="button">문의</button>
                            <svg width="32px" height="32px" viewBox="-4.32 -4.32 32.64 32.64" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.00024000000000000003" transform="rotate(180)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M11.6149 10.1283C11.3256 10.4248 11.3315 10.8997 11.628 11.1889C11.9245 11.4782 12.3993 11.4723 12.6886 11.1758L11.6149 10.1283ZM12.3237 10.5051L12.7575 11.1169L12.7591 11.1158L12.3237 10.5051ZM16.8437 7.28307L17.2791 7.89379C17.2875 7.88781 17.2957 7.88166 17.3039 7.87534L16.8437 7.28307ZM18.17 7.0965L17.8911 7.79272L17.8911 7.79273L18.17 7.0965ZM19.0007 8.14707H19.7507C19.7507 8.10997 19.748 8.07292 19.7425 8.03623L19.0007 8.14707ZM19.0007 14.8931L19.7425 15.0039C19.748 14.9672 19.7507 14.9302 19.7507 14.8931H19.0007ZM18.17 15.9436L17.8911 15.2474L18.17 15.9436ZM16.8437 15.7571L16.3827 16.3486L16.3836 16.3493L16.8437 15.7571ZM12.3227 12.2331L12.7838 11.6415C12.7749 11.6346 12.7658 11.6278 12.7565 11.6212L12.3227 12.2331ZM12.6875 11.5623C12.3983 11.2658 11.9234 11.26 11.627 11.5493C11.3305 11.8385 11.3247 12.3134 11.6139 12.6099L12.6875 11.5623ZM11.4007 10.6521C11.4007 11.0663 11.7365 11.4021 12.1507 11.4021C12.5649 11.4021 12.9007 11.0663 12.9007 10.6521H11.4007ZM12.1507 8.14707H12.9007C12.9007 8.10997 12.898 8.07292 12.8925 8.03623L12.1507 8.14707ZM11.32 7.0965L11.0411 7.79272L11.0411 7.79273L11.32 7.0965ZM9.99373 7.28307L10.429 7.89384C10.4374 7.88784 10.4457 7.88167 10.4539 7.87534L9.99373 7.28307ZM5.47273 10.5051L5.87722 11.1366C5.88765 11.13 5.89792 11.123 5.90801 11.1158L5.47273 10.5051ZM5.47273 12.2331L5.93375 11.6415C5.91553 11.6273 5.89667 11.6139 5.87722 11.6015L5.47273 12.2331ZM9.99473 15.7571L9.53372 16.3486L9.5346 16.3493L9.99473 15.7571ZM11.321 15.9436L11.5999 16.6399L11.321 15.9436ZM12.1517 14.8931L12.8935 15.0039C12.899 14.9672 12.9017 14.9302 12.9017 14.8931H12.1517ZM12.9017 12.0861C12.9017 11.6719 12.5659 11.3361 12.1517 11.3361C11.7375 11.3361 11.4017 11.6719 11.4017 12.0861H12.9017ZM12.9017 10.6521C12.9017 10.2379 12.5659 9.90207 12.1517 9.90207C11.7375 9.90207 11.4017 10.2379 11.4017 10.6521H12.9017ZM11.4017 12.0861C11.4017 12.5003 11.7375 12.8361 12.1517 12.8361C12.5659 12.8361 12.9017 12.5003 12.9017 12.0861H11.4017ZM12.6886 11.1758C12.7097 11.1541 12.7328 11.1344 12.7574 11.1169L11.89 9.8932C11.7914 9.9631 11.6993 10.0418 11.6149 10.1283L12.6886 11.1758ZM12.7591 11.1158L17.2791 7.89379L16.4084 6.67235L11.8884 9.89435L12.7591 11.1158ZM17.3039 7.87534C17.4711 7.74545 17.6946 7.714 17.8911 7.79272L18.4489 6.40028C17.7577 6.12343 16.9716 6.23402 16.3836 6.6908L17.3039 7.87534ZM17.8911 7.79273C18.0877 7.87145 18.2277 8.04852 18.259 8.25791L19.7425 8.03623C19.6325 7.29986 19.14 6.67713 18.4489 6.40028L17.8911 7.79273ZM18.2507 8.14707V14.8931H19.7507V8.14707H18.2507ZM18.259 14.7822C18.2277 14.9916 18.0877 15.1687 17.8911 15.2474L18.4489 16.6399C19.14 16.363 19.6325 15.7403 19.7425 15.0039L18.259 14.7822ZM17.8911 15.2474C17.6946 15.3261 17.4711 15.2947 17.3039 15.1648L16.3836 16.3493C16.9716 16.8061 17.7577 16.9167 18.4489 16.6399L17.8911 15.2474ZM17.3048 15.1655L12.7838 11.6415L11.8617 12.8246L16.3827 16.3486L17.3048 15.1655ZM12.7565 11.6212C12.7318 11.6037 12.7087 11.584 12.6875 11.5623L11.6139 12.6099C11.6983 12.6963 11.7904 12.775 11.889 12.8449L12.7565 11.6212ZM12.9007 10.6521V8.14707H11.4007V10.6521H12.9007ZM12.8925 8.03623C12.7825 7.29986 12.29 6.67713 11.5989 6.40028L11.0411 7.79273C11.2377 7.87145 11.3777 8.04852 11.409 8.25791L12.8925 8.03623ZM11.5989 6.40028C10.9077 6.12343 10.1216 6.23402 9.5336 6.6908L10.4539 7.87534C10.6211 7.74545 10.8446 7.714 11.0411 7.79272L11.5989 6.40028ZM9.55846 6.6723L5.03746 9.8943L5.90801 11.1158L10.429 7.89384L9.55846 6.6723ZM5.06825 9.87349C4.55844 10.2 4.25007 10.7637 4.25007 11.3691H5.75007C5.75007 11.275 5.79799 11.1874 5.87722 11.1366L5.06825 9.87349ZM4.25007 11.3691C4.25007 11.9745 4.55844 12.5382 5.06825 12.8646L5.87722 11.6015C5.79799 11.5508 5.75007 11.4632 5.75007 11.3691H4.25007ZM5.01171 12.8246L9.53372 16.3486L10.4557 15.1655L5.93375 11.6415L5.01171 12.8246ZM9.5346 16.3493C10.1226 16.8061 10.9087 16.9167 11.5999 16.6399L11.0421 15.2474C10.8456 15.3261 10.6221 15.2947 10.4549 15.1648L9.5346 16.3493ZM11.5999 16.6399C12.291 16.363 12.7835 15.7403 12.8935 15.0039L11.41 14.7822C11.3787 14.9916 11.2387 15.1687 11.0421 15.2474L11.5999 16.6399ZM12.9017 14.8931V12.0861H11.4017V14.8931H12.9017ZM11.4017 10.6521V12.0861H12.9017V10.6521H11.4017Z" fill="#a237a9"></path> </g></svg>
                            <button class="btn btn-outline-dark h-100 refund-state" disabled type="button">답변</button>
                            <svg width="32px" height="32px" viewBox="-4.32 -4.32 32.64 32.64" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.00024000000000000003" transform="rotate(180)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M11.6149 10.1283C11.3256 10.4248 11.3315 10.8997 11.628 11.1889C11.9245 11.4782 12.3993 11.4723 12.6886 11.1758L11.6149 10.1283ZM12.3237 10.5051L12.7575 11.1169L12.7591 11.1158L12.3237 10.5051ZM16.8437 7.28307L17.2791 7.89379C17.2875 7.88781 17.2957 7.88166 17.3039 7.87534L16.8437 7.28307ZM18.17 7.0965L17.8911 7.79272L17.8911 7.79273L18.17 7.0965ZM19.0007 8.14707H19.7507C19.7507 8.10997 19.748 8.07292 19.7425 8.03623L19.0007 8.14707ZM19.0007 14.8931L19.7425 15.0039C19.748 14.9672 19.7507 14.9302 19.7507 14.8931H19.0007ZM18.17 15.9436L17.8911 15.2474L18.17 15.9436ZM16.8437 15.7571L16.3827 16.3486L16.3836 16.3493L16.8437 15.7571ZM12.3227 12.2331L12.7838 11.6415C12.7749 11.6346 12.7658 11.6278 12.7565 11.6212L12.3227 12.2331ZM12.6875 11.5623C12.3983 11.2658 11.9234 11.26 11.627 11.5493C11.3305 11.8385 11.3247 12.3134 11.6139 12.6099L12.6875 11.5623ZM11.4007 10.6521C11.4007 11.0663 11.7365 11.4021 12.1507 11.4021C12.5649 11.4021 12.9007 11.0663 12.9007 10.6521H11.4007ZM12.1507 8.14707H12.9007C12.9007 8.10997 12.898 8.07292 12.8925 8.03623L12.1507 8.14707ZM11.32 7.0965L11.0411 7.79272L11.0411 7.79273L11.32 7.0965ZM9.99373 7.28307L10.429 7.89384C10.4374 7.88784 10.4457 7.88167 10.4539 7.87534L9.99373 7.28307ZM5.47273 10.5051L5.87722 11.1366C5.88765 11.13 5.89792 11.123 5.90801 11.1158L5.47273 10.5051ZM5.47273 12.2331L5.93375 11.6415C5.91553 11.6273 5.89667 11.6139 5.87722 11.6015L5.47273 12.2331ZM9.99473 15.7571L9.53372 16.3486L9.5346 16.3493L9.99473 15.7571ZM11.321 15.9436L11.5999 16.6399L11.321 15.9436ZM12.1517 14.8931L12.8935 15.0039C12.899 14.9672 12.9017 14.9302 12.9017 14.8931H12.1517ZM12.9017 12.0861C12.9017 11.6719 12.5659 11.3361 12.1517 11.3361C11.7375 11.3361 11.4017 11.6719 11.4017 12.0861H12.9017ZM12.9017 10.6521C12.9017 10.2379 12.5659 9.90207 12.1517 9.90207C11.7375 9.90207 11.4017 10.2379 11.4017 10.6521H12.9017ZM11.4017 12.0861C11.4017 12.5003 11.7375 12.8361 12.1517 12.8361C12.5659 12.8361 12.9017 12.5003 12.9017 12.0861H11.4017ZM12.6886 11.1758C12.7097 11.1541 12.7328 11.1344 12.7574 11.1169L11.89 9.8932C11.7914 9.9631 11.6993 10.0418 11.6149 10.1283L12.6886 11.1758ZM12.7591 11.1158L17.2791 7.89379L16.4084 6.67235L11.8884 9.89435L12.7591 11.1158ZM17.3039 7.87534C17.4711 7.74545 17.6946 7.714 17.8911 7.79272L18.4489 6.40028C17.7577 6.12343 16.9716 6.23402 16.3836 6.6908L17.3039 7.87534ZM17.8911 7.79273C18.0877 7.87145 18.2277 8.04852 18.259 8.25791L19.7425 8.03623C19.6325 7.29986 19.14 6.67713 18.4489 6.40028L17.8911 7.79273ZM18.2507 8.14707V14.8931H19.7507V8.14707H18.2507ZM18.259 14.7822C18.2277 14.9916 18.0877 15.1687 17.8911 15.2474L18.4489 16.6399C19.14 16.363 19.6325 15.7403 19.7425 15.0039L18.259 14.7822ZM17.8911 15.2474C17.6946 15.3261 17.4711 15.2947 17.3039 15.1648L16.3836 16.3493C16.9716 16.8061 17.7577 16.9167 18.4489 16.6399L17.8911 15.2474ZM17.3048 15.1655L12.7838 11.6415L11.8617 12.8246L16.3827 16.3486L17.3048 15.1655ZM12.7565 11.6212C12.7318 11.6037 12.7087 11.584 12.6875 11.5623L11.6139 12.6099C11.6983 12.6963 11.7904 12.775 11.889 12.8449L12.7565 11.6212ZM12.9007 10.6521V8.14707H11.4007V10.6521H12.9007ZM12.8925 8.03623C12.7825 7.29986 12.29 6.67713 11.5989 6.40028L11.0411 7.79273C11.2377 7.87145 11.3777 8.04852 11.409 8.25791L12.8925 8.03623ZM11.5989 6.40028C10.9077 6.12343 10.1216 6.23402 9.5336 6.6908L10.4539 7.87534C10.6211 7.74545 10.8446 7.714 11.0411 7.79272L11.5989 6.40028ZM9.55846 6.6723L5.03746 9.8943L5.90801 11.1158L10.429 7.89384L9.55846 6.6723ZM5.06825 9.87349C4.55844 10.2 4.25007 10.7637 4.25007 11.3691H5.75007C5.75007 11.275 5.79799 11.1874 5.87722 11.1366L5.06825 9.87349ZM4.25007 11.3691C4.25007 11.9745 4.55844 12.5382 5.06825 12.8646L5.87722 11.6015C5.79799 11.5508 5.75007 11.4632 5.75007 11.3691H4.25007ZM5.01171 12.8246L9.53372 16.3486L10.4557 15.1655L5.93375 11.6415L5.01171 12.8246ZM9.5346 16.3493C10.1226 16.8061 10.9087 16.9167 11.5999 16.6399L11.0421 15.2474C10.8456 15.3261 10.6221 15.2947 10.4549 15.1648L9.5346 16.3493ZM11.5999 16.6399C12.291 16.363 12.7835 15.7403 12.8935 15.0039L11.41 14.7822C11.3787 14.9916 11.2387 15.1687 11.0421 15.2474L11.5999 16.6399ZM12.9017 14.8931V12.0861H11.4017V14.8931H12.9017ZM11.4017 10.6521V12.0861H12.9017V10.6521H11.4017Z" fill="#a237a9"></path> </g></svg>
                            <button class="btn btn-outline-dark h-100 refund-state" disabled type="button">환불처리<br>확정</button>
                            <svg width="32px" height="32px" viewBox="-4.32 -4.32 32.64 32.64" fill="none" xmlns="http://www.w3.org/2000/svg" stroke="#000000" stroke-width="0.00024000000000000003" transform="rotate(180)"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path d="M11.6149 10.1283C11.3256 10.4248 11.3315 10.8997 11.628 11.1889C11.9245 11.4782 12.3993 11.4723 12.6886 11.1758L11.6149 10.1283ZM12.3237 10.5051L12.7575 11.1169L12.7591 11.1158L12.3237 10.5051ZM16.8437 7.28307L17.2791 7.89379C17.2875 7.88781 17.2957 7.88166 17.3039 7.87534L16.8437 7.28307ZM18.17 7.0965L17.8911 7.79272L17.8911 7.79273L18.17 7.0965ZM19.0007 8.14707H19.7507C19.7507 8.10997 19.748 8.07292 19.7425 8.03623L19.0007 8.14707ZM19.0007 14.8931L19.7425 15.0039C19.748 14.9672 19.7507 14.9302 19.7507 14.8931H19.0007ZM18.17 15.9436L17.8911 15.2474L18.17 15.9436ZM16.8437 15.7571L16.3827 16.3486L16.3836 16.3493L16.8437 15.7571ZM12.3227 12.2331L12.7838 11.6415C12.7749 11.6346 12.7658 11.6278 12.7565 11.6212L12.3227 12.2331ZM12.6875 11.5623C12.3983 11.2658 11.9234 11.26 11.627 11.5493C11.3305 11.8385 11.3247 12.3134 11.6139 12.6099L12.6875 11.5623ZM11.4007 10.6521C11.4007 11.0663 11.7365 11.4021 12.1507 11.4021C12.5649 11.4021 12.9007 11.0663 12.9007 10.6521H11.4007ZM12.1507 8.14707H12.9007C12.9007 8.10997 12.898 8.07292 12.8925 8.03623L12.1507 8.14707ZM11.32 7.0965L11.0411 7.79272L11.0411 7.79273L11.32 7.0965ZM9.99373 7.28307L10.429 7.89384C10.4374 7.88784 10.4457 7.88167 10.4539 7.87534L9.99373 7.28307ZM5.47273 10.5051L5.87722 11.1366C5.88765 11.13 5.89792 11.123 5.90801 11.1158L5.47273 10.5051ZM5.47273 12.2331L5.93375 11.6415C5.91553 11.6273 5.89667 11.6139 5.87722 11.6015L5.47273 12.2331ZM9.99473 15.7571L9.53372 16.3486L9.5346 16.3493L9.99473 15.7571ZM11.321 15.9436L11.5999 16.6399L11.321 15.9436ZM12.1517 14.8931L12.8935 15.0039C12.899 14.9672 12.9017 14.9302 12.9017 14.8931H12.1517ZM12.9017 12.0861C12.9017 11.6719 12.5659 11.3361 12.1517 11.3361C11.7375 11.3361 11.4017 11.6719 11.4017 12.0861H12.9017ZM12.9017 10.6521C12.9017 10.2379 12.5659 9.90207 12.1517 9.90207C11.7375 9.90207 11.4017 10.2379 11.4017 10.6521H12.9017ZM11.4017 12.0861C11.4017 12.5003 11.7375 12.8361 12.1517 12.8361C12.5659 12.8361 12.9017 12.5003 12.9017 12.0861H11.4017ZM12.6886 11.1758C12.7097 11.1541 12.7328 11.1344 12.7574 11.1169L11.89 9.8932C11.7914 9.9631 11.6993 10.0418 11.6149 10.1283L12.6886 11.1758ZM12.7591 11.1158L17.2791 7.89379L16.4084 6.67235L11.8884 9.89435L12.7591 11.1158ZM17.3039 7.87534C17.4711 7.74545 17.6946 7.714 17.8911 7.79272L18.4489 6.40028C17.7577 6.12343 16.9716 6.23402 16.3836 6.6908L17.3039 7.87534ZM17.8911 7.79273C18.0877 7.87145 18.2277 8.04852 18.259 8.25791L19.7425 8.03623C19.6325 7.29986 19.14 6.67713 18.4489 6.40028L17.8911 7.79273ZM18.2507 8.14707V14.8931H19.7507V8.14707H18.2507ZM18.259 14.7822C18.2277 14.9916 18.0877 15.1687 17.8911 15.2474L18.4489 16.6399C19.14 16.363 19.6325 15.7403 19.7425 15.0039L18.259 14.7822ZM17.8911 15.2474C17.6946 15.3261 17.4711 15.2947 17.3039 15.1648L16.3836 16.3493C16.9716 16.8061 17.7577 16.9167 18.4489 16.6399L17.8911 15.2474ZM17.3048 15.1655L12.7838 11.6415L11.8617 12.8246L16.3827 16.3486L17.3048 15.1655ZM12.7565 11.6212C12.7318 11.6037 12.7087 11.584 12.6875 11.5623L11.6139 12.6099C11.6983 12.6963 11.7904 12.775 11.889 12.8449L12.7565 11.6212ZM12.9007 10.6521V8.14707H11.4007V10.6521H12.9007ZM12.8925 8.03623C12.7825 7.29986 12.29 6.67713 11.5989 6.40028L11.0411 7.79273C11.2377 7.87145 11.3777 8.04852 11.409 8.25791L12.8925 8.03623ZM11.5989 6.40028C10.9077 6.12343 10.1216 6.23402 9.5336 6.6908L10.4539 7.87534C10.6211 7.74545 10.8446 7.714 11.0411 7.79272L11.5989 6.40028ZM9.55846 6.6723L5.03746 9.8943L5.90801 11.1158L10.429 7.89384L9.55846 6.6723ZM5.06825 9.87349C4.55844 10.2 4.25007 10.7637 4.25007 11.3691H5.75007C5.75007 11.275 5.79799 11.1874 5.87722 11.1366L5.06825 9.87349ZM4.25007 11.3691C4.25007 11.9745 4.55844 12.5382 5.06825 12.8646L5.87722 11.6015C5.79799 11.5508 5.75007 11.4632 5.75007 11.3691H4.25007ZM5.01171 12.8246L9.53372 16.3486L10.4557 15.1655L5.93375 11.6415L5.01171 12.8246ZM9.5346 16.3493C10.1226 16.8061 10.9087 16.9167 11.5999 16.6399L11.0421 15.2474C10.8456 15.3261 10.6221 15.2947 10.4549 15.1648L9.5346 16.3493ZM11.5999 16.6399C12.291 16.363 12.7835 15.7403 12.8935 15.0039L11.41 14.7822C11.3787 14.9916 11.2387 15.1687 11.0421 15.2474L11.5999 16.6399ZM12.9017 14.8931V12.0861H11.4017V14.8931H12.9017ZM11.4017 10.6521V12.0861H12.9017V10.6521H11.4017Z" fill="#a237a9"></path> </g></svg>
                            <button class="btn btn-outline-dark h-100 me-5 refund-state" disabled type="button">환불 처리</button>
                            <c:if test="${refundInfoVO.refundStateCd == 4}">
                                <button class="btn btn-outline-dark h-100 me-5 refund-state" disabled type="button">환불 거절</button>
                            </c:if>
                            <c:if test="${refundInfoVO.refundStateCd == 5}">
                                <button class="btn btn-outline-dark h-100 me-5 refund-state" disabled type="button">환불금<br>입금</button>
                            </c:if>
                            <c:if test="${refundInfoVO.refundStateCd == 1}">
                                <button class="btn btn-outline-primary" type="button" onclick="javascript:cancleRefundBtn()">환불 취소</button>
                            </c:if>
						</div>
					</div>
					<table class="table table-secondary table-bordered">
						<tbody>
                            <tr>
                                <th>주문번호</th>
                                <td>${orderMasterVO.id}</td>
                            </tr>
                            <tr>
                                <th>주문날짜</th>
                                <td>${orderMasterVO.orderDateStr}</td>
                            </tr>
                            <tr>
                                <th>상품명</th>
                                <td>${orderMasterVO.orderName}</td>
                            </tr>
                            <!-- 복수 단수 -->
                            <c:if test="${refundInfoVO.refundQty != 1}">
                                <tr>
                                    <th>환불 수량</th>
                                    <td>${refundInfoVO.refundQty}개</td>
                                </tr>
                            </c:if>
                            <tr>
                                <th>환불 요청금액</th>
                                <td>${refundInfoVO.requestRefundPriceStr}원</td>
                            </tr>
                            <tr>
                                <c:if test="${refundInfoVO.refundStateCd == 1}">
                                    <th class="d-flex w-100 justify-content-between align-items-center"><span class="align-middle">환불 사유</span><button class="btn btn-outline-success btn-sm" data-bs-toggle="modal" data-bs-target="#changeRefundReasonModal">수정</button></th>
                                </c:if>
                                <c:if test="${refundInfoVO.refundStateCd != 1}">
                                    <th>환불 사유</th>
                                </c:if>
                                <td class="align-middle">${refundInfoVO.refundReasonCdNm}</td>
                            </tr>
                            <tr>
                                <th>환불 상세사유</th>
                                <td>${refundInfoVO.refundReasonUserWrite}</td>
                            </tr>
                            <tr>
                                <th>환불 결정금액</th>
                                <td>${refundInfoVO.determinRefundPriceStr}원</td>
                            </tr>
                            <tr>
                                <th>상태</th>
                                <td>${refundInfoVO.refundStateCdNm}</td>
                            </tr>
                            <!-- 결제방식 부분화 -->
                            <tr>
                                <th>결제방식</th>
                                <c:if test="${orderMasterVO.paymentMethod == 'Card'}">
                                    <td>카드결제</td>
                                </c:if>
                                <c:if test="${orderMasterVO.paymentMethod == 'account-transfer'}">
                                    <td>계좌이체</td>
                                </c:if>
                                
                            </tr>
                            <tr class="refund-min-height">
                                <th>환불 내용</th>
                                <td>
                                    <div class="refund-info-scrollable">
                                        ${refundInfoVO.refundContentStr}
                                    </div>
                                </td>
                            </tr>
                            <tr class="refund-min-height">
                                <th>비고</th>
                                <td>
                                    <div class="refund-info-scrollable">
                                        ${refundInfoVO.refundRemarksStr}
                                    </div>
                                </td>
                            </tr>
						</tbody>
					</table>
				</div>
	 		</div>
			<!-- 2차동의 모달 -->
            <div class="modal fade" id="secondTermsModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">환불심사 결과 동의서</h1>
                        </div>
                        <div class="modal-body">
                            ${refundInfoVO.refundPartialAgreeContentStr}
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="javascript:disAgreeTerms()">비동의</button>
                            <button type="button" class="btn btn-primary" onclick="javascript:agreeTerms()">동의</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 환불사유 수정모달 -->
            <div class="modal fade" id="changeRefundReasonModal" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5">환불사유 수정하기</h1>
                        </div>
                        <div class="modal-body">
                            <button class="btn btn-outline-dark dropdown-toggle refund-reason-title w-50 mb-3" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                환불 사유
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="javascript:void(0);" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">단순변심</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">개봉시 파손</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" cd="01" onclick="javascript:refundReasonDropdownBtn(this)">사용 중 문제 발생</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" cd="02" onclick="javascript:refundReasonDropdownBtn(this)">오배송</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" cd="02" onclick="javascript:refundReasonDropdownBtn(this)">구성품 누락</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" cd="03" onclick="javascript:refundReasonDropdownBtn(this)">도착 시 파손</a></li>
                                <li><a class="dropdown-item" href="javascript:void(0);" cd="99" onclick="javascript:refundReasonDropdownBtn(this)">기타</a></li>
                            </ul>
                            <div class="form-floating mb-3 fade reason-user-write d-none">
                                <input type="text" class="form-control" id="refundReason" placeholder="" autocomplete="off" oninput="javascript:refundReasonUserWrite(this)">
                                <label for="refundReason">환불 상세사유</label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                            <button type="button" class="btn btn-primary" onclick="javascript:changeRefundReason()">수정</button>
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
