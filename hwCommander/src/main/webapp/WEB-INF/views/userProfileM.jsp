<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<head>
<title>현우의 컴퓨터 공방 - 주문현황</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<link rel="stylesheet" href="/resources/css/main.css">
<link rel="stylesheet" href="/resources/css/estimateCalculationOneCss.css">

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>
<link rel="stylesheet" href="/resources/css/infoM.css">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    let a = "${loginUser}";
    function changeAddrInfoBtn(){
        new daum.Postcode({
			oncomplete: function(data) {
				$(".zip-code").html(data.zonecode);
				$(".jibun-addr").html(data.jibunAddress);
				$(".road-addr").html(data.roadAddress);
				$(".detail-addr").addClass("fade").addClass("d-none");
				$(".detail-addr-inputs").removeClass("fade").removeClass("d-none").addClass("show");
			}
		}).open();
    }
    function saveChangedAddr(){
		if(confirm("입력된 주소를 확인해주세요\n\n지번주소 : " + $(".jibun-addr").html() + "," + $(".detail-addr-input").val() + "\n도로명 주소 : " + $(".road-addr").html() + "," + $(".detail-addr-input").val() + "\n\n" + "저장 하시겠습니까?")){
			$.ajax({
				type: "post",
				url: "/user/userInfoUpdateLogic.do",
				data: {
					id: "${loginUser.id}",
					pw: "${loginUser.pw}",
					sexCd: "${loginUser.sexCd}",
					name: "${loginUser.name}",
					birth: "${loginUser.birth}",
					hpNumber: "${loginUser.hpNumber}",
					jibunAddr: $(".jibun-addr").html(),
					roadAddr: $(".road-addr").html(),
					detailAddr: $(".detail-addr-input").val(),
					zipcode: $(".zip-code").html(),
					mail: "${loginUser.mail}",
					mailKey: "${loginUser.mailKey}",
					mailConfirm: "${loginUser.mailConfirm}",
					regDtm: "${loginUser.regDtm}",
					updtDtm: "${loginUser.updtDtm}",
					di: "${loginUser.di}",
				},
				dataType: "json",
				success: function(response) {
					alert("정상적으로 수정되었습니다! 수정된 내용이 보이지 않으시면 재 로그인 해주세요!");
					location.reload();				
				},
				error: function(xhr, status, error) {
					alert("통신에 실패했습니다. 다시 시도해주세요.");
					location.reload();
				}
			});
		}else {
			return false;
		}
    }
    function changeMailAddr(){
		if($('#emailInput').val().trim() == "" || $('#emailInput').val().trim() == null) {
			alert("이메일을 입력하세요.");
			$('#emailInput').focus();
			return false;
		}
		
		const mailCheckRegExp = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");

		if (!mailCheckRegExp.test($('#emailInput').val())) {
			alert("올바른 이메일 형식을 입력해주세요");
			$('#emailInput').focus();
			return false;
		}

		if("${loginUser.mail}" == $("#emailInput").val()){
			alert("변경된 내용이 없습니다. 다시 확인해주세요");
			return false;
		}
		if(confirm("이메일을 한번 더 확인해주세요\n입력하신 이메일 : " + $('#emailInput').val() + "\n\n확인을 누르시면 로그아웃되며 이메일 인증 전 로그인 불가능합니다. 수정 하시겠습니까?")){
			$.ajax({
				type: "post",
				url: "/user/userMailInfoUpdateLogic.do",
				data: {
					id: "${loginUser.id}",
					pw: "${loginUser.pw}",
					sexCd: "${loginUser.sexCd}",
					name: "${loginUser.name}",
					birth: "${loginUser.birth}",
					hpNumber: "${loginUser.hpNumber}",
					jibunAddr: "${loginUser.jibunAddr}",
					roadAddr: "${loginUser.roadAddr}",
					detailAddr: "${loginUser.detailAddr}",
					zipcode: "${loginUser.zipcode}",
					mail: $("#emailInput").val(),
					mailKey: "${loginUser.mailKey}",
					mailConfirm: "N",
					regDtm: "${loginUser.regDtm}",
					updtDtm: "${loginUser.updtDtm}",
					di: "${loginUser.di}",
				},
				dataType: "json",
				success: function(response) {
					alert("이메일 인증 후 정상 반영됩니다! 이메일 인증 후 재로그인 해주세요!");
					location.href = "/user/logoutLogic.do";			
				},
				error: function(xhr, status, error) {
					alert("통신에 실패했습니다. 다시 시도해주세요.");
					location.reload();
				}
			});
		}else {
			return false;
		}
	}
	$(function(){
		
	})
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="basic_background w-100">
		<div class="d-flex">
			<!-- 빈 영역 -->
			<div class="h-25 justify-content-start" style="width: 0.5%;"></div>
			<!-- 작업영역 -->
			<div class="w-100 estimateCalc_background pt-5 pb-5 ps-2 pe-2" style="width: 99%;">
				<div class="card-body card-list card-user-info-detail">
                    <h2 class="card-title">
                        <b>Hwcommander</b>
                    </h2>
                    <h6 class="card-subtitle mb-2 d-flex justify-content-between">${loginUser.name}님의 회원정보</h6>
                    <p class="card-text order-tbody">
                        <table class="table table-light" style="border-collapse: separate;">
                            <thead>
                                <tr>
                                    <th scope="col" style="width: 30%;">이름</th>
                                    <th scope="col" style="font-weight: 400;">${loginUser.name}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">생년월일</th>
                                    <td>${loginUser.birth}</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span>
                                                휴대폰 번호
                                            </span>
                                        </div>
                                    </th>
                                    <td class="align-middle position-relative">
                                        <span class="base-info">
                                            ${loginUser.hpNumber}
                                            <!-- <span class="phone-container position-absolute end-0 bottom-0 me-1 mb-1">
                                                <span class="change-phone btn-first">
                                                    <button class="btn btn-outline-success btn-sm pb-0 pt-1" onclick="javascript:alert('미구현')">수정</button>
                                                </span>
                                            </span> -->
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span>
                                                주소
                                            </span>
                                        </div>
                                    </th>
                                    <td class="align-middle position-relative">
                                        <span class="base-info">
                                            <div class="zip-code">${loginUser.zipcode}</div>
                                            <span class="addr-container position-absolute end-0 bottom-0 me-1 mb-1">
                                                <span class="change-addr btn-first">
                                                    <button class="btn btn-outline-success btn-sm pb-0 pt-1" onclick="javascript:changeAddrInfoBtn()">수정</button>
                                                </span>
                                            </span>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">지번주소</th>
                                    <td>
                                        <span class="base-info jibun-addr">
                                            ${loginUser.jibunAddr}
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">도로명주소</th>
                                    <td>
                                        <span class="base-info road-addr">
                                            ${loginUser.roadAddr}
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">상세주소</th>
                                    <td>
                                        <span class="base-info detail-addr">
                                            ${loginUser.detailAddr}
                                        </span>
                                        <div class="input-group d-none fade detail-addr-inputs">
                                            <input type="text" class="form-control pb-0 pt-1 detail-addr-input" value="">
                                            <button class="btn btn-outline-secondary pb-0 pt-1" type="button" onclick="javascript:saveChangedAddr()">저장</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span>
                                                E-mail
                                            </span>
                                        </div>
                                    </th>
                                    <td class="align-middle position-relative">
                                        <span class="base-info">
                                            ${loginUser.mail}
                                            <span class="email-container position-absolute end-0 bottom-0 me-1 mb-1">
                                                <span class="change-email btn-first">
                                                    <button class="btn btn-outline-success btn-sm pb-0 pt-1" data-bs-toggle="modal" data-bs-target="#emailModal">수정</button>
                                                    <!-- 이메일 인증요청 모달 -->
                                                    <div class="modal fade" id="emailModal" tabindex="-1" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered">
                                                          <div class="modal-content">
                                                            <div class="modal-header">
                                                              <h1 class="modal-title fs-5">이메일 변경</h1>
                                                              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <p>이메일을 입력해주세요</p>
                                                                <div class="form-floating mb-4 mx-auto mt-2">
                                                                    <input type="text" class="form-control" id="emailInput" placeholder="">
                                                                    <label for="floatingInput">E-mail</label>
                                                                </div>
                                                                <p class="mb-1">인증 진행시 로그아웃되며 이메일 인증 전</p>
                                                                <p><strong class="text-danger">로그인 불가능합니다.</strong></p>
                                                                <div>
                                                                    <button type="button" class="btn btn-outline-secondary w-100" onclick="javascript:changeMailAddr()">인증하기</button>
                                                                </div>
                                                            </div>
                                                          </div>
                                                        </div>
                                                    </div>
                                                </span>
                                            </span>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row" class="align-middle">가입일</th>
                                    <td>${loginUser.regDtm}</td>
                                </tr>
                            </tbody>
                        </table>
                    </p>
                </div>
			</div>
			<!-- 빈 영역 -->
			<div class="justify-content-end" style="width: 0.5%;"></div>
		</div>
		
		<!-- 2022.11.16 디자인이미지 추가 -->
		<div class="mt-5 mx-5 mypage-bt-imgs" style="height: 15%!important;">
			<img class="img-fluid float-end" src="/resources/img/layer-34-1200x107.png" alt="">
		</div>
		<div class="mt-2 mx-5 mypage-bt-imgs" style="height: 15%!important;">
			<img class="img-fluid" src="/resources/img/layer-26.png" alt="">
		</div>
	</div>

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	
</body>
</html>