<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - GPU</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/main.css">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="/resources/css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        
<script>

var targetId = null;

    $(function(){
        $('#btn_signUp').on("click", function () {
        	if(!validationCheck()) {
        		return false;
        	}
        	goSignUp();
        });
        
        // id 중복확인
        $('#btn_id_dupli_chk').on("click", function () {
        	idDupliChk($('#id').val().trim());
        });
        
        // 이메일인증
        /*
        $('#btn_email_chk').on("click", function () {
        	alert("이메일인증해~");
        	return false;
        	
        });
        */
        
        // 주소찾기
        $('#btn_addr_search').on("click", function () {
        	alert("주소찾아~");
        	return false;
        	
        });
        
        // 핸드폰인증
        $('#btn_hpNumber_chk').on("click", function () {
        	alert("핸드폰인증해");
        	return false;
        	
        });
    });
    
function goSignUp() {
    var form = $("#signUp_form").serialize();
    
    $.ajax({
        type: "post",
        url: "/user/signUpLogic.do",
        data: form,
        dataType: 'json',
        success: function (data) {
        	if(data == 1) {
        		alert("회원가입이 완료되었습니다.\n이메일 인증 후 이용해주세요.");
        	}else {
        		alert("회원가입이 정상적으로 처리되지 않았습니다.\n고객센터로 문의해주세요.");
        	}
        	window.location = "/";
            console.log(data);
        }
    });
}

function validationCheck() {
	if($('#id').val().trim() == "") {
		alert("아이디를 입력하세요");
		return false;
	}
	
	if(targetId == null || targetId != $('#id').val().trim()) {
		alert("아이디 중복확인이 되지 않았습니다.");
		return false;
	}
	
	if($('#pw').val() == "" || $('#pw').val() == null) {
		alert("비밀번호를 입력하세요.");
		return false;
	}
	
	if($('#pw').val() != $('#pwConfirm').val()) {
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	
	if($('#name').val().trim() == "" || $('#name').val().trim() == null) {
		alert("이름을 입력하세요.");
		return false;
	}
	
	if($('#birth').val() == "" || $('#birth').val() == null) {
		alert("생년월일을 입력하세요.");
		return false;
	}
	
	if($('#hpNumber').val().trim() == "" || $('#hpNumber').val().trim() == null) {
		alert("휴대폰번호를 입력하세요.");
		return false;
	}
	
	if($('#addr').val().trim() == "" || $('#addr').val().trim() == null) {
		alert("주소를 입력하세요.");
		return false;
	}
	
	if($('#mail').val().trim() == "" || $('#mail').val().trim() == null) {
		alert("이메일을 입력하세요.");
		return false;
	}
	
	//todo wonho validation check 추가해야함. maxlength 라던가 생년월일, 이메일, 주소 등 정규식코드라던가..
	
	return true;
}

function idDupliChk(id) {
	
	if(id == "") {
		alert("아이디를 입력하세요.");
		return false;
	}
	
	$.ajax({
        type: "post",
        url: "/user/idDupliChk.do",
        data: {
        	"id" : id
        },
        dataType: 'json',
        success: function (data) {
        	if(data == 0) {
        		targetId = id;
        		alert("사용가능한 ID 입니다.");
        		$("#id").removeClass("is-invalid");
        	}else {
        		targetId = null;
        		$("#id").addClass("is-invalid");
        		alert("중복된 ID 입니다.");
        	}
        }
    });
}
</script>
</head>
    <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="main.do">Admin Page</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- go main-->
            <div class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <a class="btn btn-dark" href="/">Main</a>
            </div>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <div class="sb-sidenav-menu-heading">부품관리</div>
                            <a class="nav-link" href="gpuManagement.do">
                                GPU
                            </a>
                            <a class="nav-link" href="cpuManagement.do">
                                CPU
                            </a>
                            <a class="nav-link" href="mbManagement.do">
                                MB
                            </a>
                            <a class="nav-link" href="ramManagement.do">
                                RAM
                            </a>
                            <a class="nav-link" href="psuManagement.do">
                                PSU
                            </a>
                            <a class="nav-link" href="caseManagement.do">
                                CASE
                            </a>
                            <a class="nav-link" href="coolerManagement.do">
                                Cooler
                            </a>
                            <a class="nav-link" href="hddManagement.do">
                                HDD
                            </a>
                            <a class="nav-link" href="ssdManagement.do">
                                SSD
                            </a>
                            <a class="nav-link" href="sfManagement.do">
                                SF
                            </a>
                            <div class="sb-sidenav-menu-heading">완본체관리</div>
                            <a class="nav-link" href="productManagement.do">
								Product
                            </a>
                            <div class="sb-sidenav-menu-heading">주문관리</div>
                            <a class="nav-link" href="orderManagement.do">
								Order
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Start Bootstrap
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
				<main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">GPU</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item active">GPU</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                GPU를 관리합니다. 조회, 추가, 수정 작업을 할 수 있습니다.
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
								<div class="d-flex">
								  <div class="me-auto d-flex align-items-center">Search GPU</div>
								  <div>
								  	<a class="btn btn-secondary btn-sm" href="gpuRegist.do">등록</a>
								  </div>
								</div>
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>parts name</th>
                                            <th>parts price</th>
                                            <th>LED</th>
                                            <th>GMC</th>
                                            <th>GSC</th>
                                            <th>GPUAS</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>parts name</th>
                                            <th>parts price</th>
                                            <th>LED</th>
                                            <th>GMC</th>
                                            <th>GSC</th>
                                            <th>GPUAS</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
										<c:forEach var="item" items="${gpuList}">
											<tr>
	                                            <td>${item.partsName}</td>
	                                            <td>${item.partsPrice}</td>
	                                            <td>${item.gledCdNm}</td>
	                                            <td>${item.gmcCdNm}</td>
	                                            <td>${item.gscCdNm}</td>
	                                            <td>${item.gpuasCdNm}</td>
                                        	</tr>
										</c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; HW Commander 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="/resources/js/datatables-simple-demo.js"></script>
        <script src="/resources/js/scripts.js"></script>
    </body>
</html>
