<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - MAKER Update</title>
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
var firstForm = null;
    $(function() {
    	dataSetting();
        $('#btn_maker_update').on("click", function () {
        	if(!validationCheck()) {
        		return false;
        	}
        	
        	if(confirm("수정 하시겠습니까?")) {
        		goMakerUpdate();
        	}
        });
    });
    
function dataSetting() {
	$("#makerName").val("${selectData.makerName}");
	$("#asScore").val("${selectData.asScore}");
	
	$("#id").val("${selectData.id}");
	
	firstForm = $("#maker_update_form").serialize();
}
    
function goMakerUpdate() {
    var form = $("#maker_update_form").serialize();
    
    if(firstForm == form) {
    	alert("변경된 내용이 없습니다.");
    	return false;
    }
    
    $.ajax({
        type: "post",
        url: "/admin/makerUpdateLogic.do",
        data: form,
        dataType: 'json',
        success: function (data) {
        	if(data == 2) {
        		alert("수정완료");
        	}else {
        		alert("수정실패");
        	}
        	window.location = "makerManagement.do";
            console.log(data);
        }
    });
}

function validationCheck() {
	if("" == $('#makerName').val().trim() || null == $('#makerName').val().trim()) {
		alert("Maker Name을 입력하세요.");
		$('#makerName').focus();
		return false;
	}
	
	if("" == $('#asScore').val().trim() || null == $('#asScore').val().trim()) {
		alert("AS Score를 입력하세요.");
		$('#asScore').focus();
		return false;
	}
	
	
	var asScore = parseInt($('#asScore').val().trim());
	if(isNaN(asScore)) {
		alert("AS Score는 문자열을 포함할 수 없습니다.");
		$('#asScore').focus();
		return false;
	}
	
	if(asScore > 999) {
		alert("AS Score는 999 미만의 수여야 합니다.");
		$('#asScore').focus();
		return false;
	}
	
	if(asScore != parseFloat($('#asScore').val().trim())) {
		alert("AS Score는 정수여야 합니다.");
		$('#asScore').focus();
		return false;
	}
	
	return true;
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
                            <a class="nav-link" href="makerManagement.do">MAKER</a>
                            <div class="sb-sidenav-menu-heading">완본체관리</div>
                            <a class="nav-link" href="productManagement.do">Product(폐기예정)</a>
                            <a class="nav-link" href="banpumManagement.do">Banpum</a>
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
                        <h1 class="mt-4">MAKER Update</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="makerManagement.do">MAKER</a></li>
                            <li class="breadcrumb-item active">MAKER Update</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                MAKER를  수정합니다.
                            </div>
                        </div>
                        <div class="card mb-4">
							<div class="card-body">
                               <form id="maker_update_form">
                                   <input type="hidden" id="id" name="id">
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="makerName" name="makerName" type="text" placeholder="Enter makerName" />
                                               <label for="makerName">Maker Name</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="asScore" name="asScore" type="text" placeholder="Enter asScore" />
                                               <label for="asScore">AS Score</label>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="mt-4 mb-0">
                                       <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_maker_update">Update</a></div>
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
