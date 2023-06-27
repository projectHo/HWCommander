
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - MB Regist</title>
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

<link href="/resources/css/sbAdmin-styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        
<script>

    $(function(){
        $('#btn_mb_regist').on("click", function () {
        	if(!validationCheck()) {
        		return false;
        	}
        	
        	if(confirm("등록 하시겠습니까?")) {
        		goMbRegist();
        	}
        });
    });
    
function goMbRegist() {
    var form = $("#mb_regist_form").serialize();
    
    $.ajax({
        type: "post",
        url: "/admin/mbRegistLogic.do",
        data: form,
        dataType: 'json',
        success: function (data) {
        	if(data == 1) {
        		alert("등록완료");
        	}else {
        		alert("등록실패");
        	}
        	window.location = "mbManagement.do";
            console.log(data);
        }
    });
}

function validationCheck() {
	/*
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
	*/
	
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
                            <div class="sb-sidenav-menu-heading">Process Resource</div>
                            <a class="nav-link" href="resourceTypeCodeManagement.do">
								Type Code
                            </a>
                            <a class="nav-link" href="resourceMasterManagement.do">
								Category(Master)
                            </a>
                            <a class="nav-link" href="resourceDetailManagement.do">
								Resource Data(Detail)
                            </a>
                            <div class="sb-sidenav-menu-heading">주문관리</div>
                            <a class="nav-link" href="orderManagement.do">
								Order
                            </a>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">With Bootstrap5</div>
                        Made from WonHo
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
				<main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">MB Regist</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="mbManagement.do">MB</a></li>
                            <li class="breadcrumb-item active">MB Regist</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                MB를  등록합니다.
                            </div>
                        </div>
                        <div class="card mb-4">
							<div class="card-body">
                               <form id="mb_regist_form">
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="partsName" name="partsName" type="text" placeholder="Enter partsName"/>
                                       <label for="partsName">parts Name</label>
                                   </div>
                                   
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="partsPrice" name="partsPrice" type="text" placeholder="Enter partsPrice" />
                                               <label for="partsPrice">parts Price</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="mledCd" name="mledCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${mled_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="mledCd">MLED</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="mmcCd" name="mmcCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${mmc_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="mmcCd">MMC</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="mscCd" name="mscCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${msc_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="mscCd">MSC</label>
                                           </div>
                                       </div>
                                   </div>
                                   
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="mbasCd" name="mbasCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${mbas_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="mbasCd">MBAS</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="port" name="port" type="text" placeholder="Enter port" />
                                               <label for="port">PORT</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="scal" name="scal" type="text" placeholder="Enter scal" />
                                               <label for="scal">SCAL</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="bios" name="bios" type="text" placeholder="Enter bios" />
                                               <label for="bios">BIOS</label>
                                           </div>
                                       </div>
                                   </div>
                                   
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="cpuSocCd" name="cpuSocCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${cpu_soc_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="cpuSocCd">CPU SOC</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="vrmRange" name="vrmRange" type="text" placeholder="Enter vrmRange" />
                                               <label for="vrmRange">VRM Range</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="memSocCd" name="memSocCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${mem_soc_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="memSocCd">MEM SOC</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="scsCd" name="scsCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${scs_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="scsCd">SCS</label>
                                           </div>
                                       </div>
                                   </div>
                                   
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="ff" name="ff" type="text" placeholder="Enter ff" />
                                               <label for="ff">FF</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="pl" name="pl" type="text" placeholder="Enter pl" />
                                               <label for="pl">PL</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="sata" name="sata" type="text" placeholder="Enter sata" />
                                               <label for="sata">SATA</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="multiBulk" name="multiBulk" type="text" placeholder="Enter multiBulk" />
                                               <label for="multiBulk">멀티팩 벌크</label>
                                           </div>
                                       </div>
                                   </div>
                                   
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="wifi" name="wifi" type="text" placeholder="Enter wifi" />
                                               <label for="wifi">WIFI</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="mc" name="mc" type="text" placeholder="Enter mc" />
                                               <label for="mc">MC</label>
                                           </div>
                                       </div>
                                   </div>
                                   
                                   <div class="mt-4 mb-0">
                                       <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_mb_regist">Regist</a></div>
                                   </div>
                               </form>
                           </div>
                        </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; HW Commander 2023</div>
                            <div>
                                <a>Dream</a>
                                &middot;
                                <a>Desire</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        
        
        <script src="/resources/js/sbAdmin-sidebar-script.js"></script>
    </body>
</html>
