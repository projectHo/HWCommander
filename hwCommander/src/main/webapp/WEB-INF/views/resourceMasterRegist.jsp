<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - Category(Master) Regist</title>
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

    $(function() {
        $('#btn_master_regist').on("click", function () {
        	if(!validationCheck()) {
        		return false;
        	}
        	
        	if(confirm("등록 하시겠습니까?")) {
        		goMasterRegist();
        	}
        });
        
        // 서핑 제거
		$('#processLgCd').find('option').each(function() {
			if("03" == $(this).val()) {
				$(this).hide();
			}
  	    });
        
		processTypeExclusiveCodeInit();
        
		$('#processLgCd').change(function() {
			processLgCdChange();
		});
    });
    
function goMasterRegist() {
	$("#useYn").val("Y");
	
    var form = $("#master_regist_form").serialize();
    
    $.ajax({
        type: "post",
        url: "/admin/resourceMasterRegistLogic.do",
        data: form,
        dataType: 'json',
        success: function (data) {
        	if(data == 1) {
        		alert("등록완료");
        	}else if(data == -2) {
        		alert("이미 등록된 Process Type Exclusive Code입니다.");
        		return false;
        	}else {
        		alert("등록실패");
        	}
        	window.location = "resourceMasterManagement.do";
            console.log(data);
        }
    });
}

function validationCheck() {
	if("00" == $('#processLgCd').val()) {
		alert("Process Large Code를 선택하세요.");
		$('#processLgCd').focus();
		return false;
	}
	
	if("00" == $('#processTypeExclusiveCd').val()) {
		alert("Process Type Exclusive Code를 선택하세요.");
		$('#processTypeExclusiveCd').focus();
		return false;
	}
	
	if("" == $('#processName').val().trim() || null == $('#processName').val().trim()) {
		alert("Process Name을 입력하세요.");
		$('#processName').focus();
		return false;
	}
	
	return true;
}

function processTypeExclusiveCodeInit() {
    // 화면 로드시 초기화 Process Large Code 선택시에만 나오도록
	$('#processTypeExclusiveCd').find('option').each(function() {
		if("00" == $(this).val()) {
			$(this).show();
		}else {
			$(this).hide();
		}
    });
}

function processLgCdChange() {
	processTypeExclusiveCodeInit();
	$('#processTypeExclusiveCd').val("00");
	
	    var filter = $('#processLgCd').val();
	  	var $options = $('#processTypeExclusiveCd').find('option');
	  	
	$options.each(function() {
		if("00" == filter) {
			$(this).show();
		}
		
		if($(this).attr("plgcd") == filter) {
			$(this).show();
		}else {
			$(this).hide();
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
                        <h1 class="mt-4">Category(Master) Regist</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="resourceMasterManagement.do">Category(Master)</a></li>
                            <li class="breadcrumb-item active">Category(Master) Regist</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                Category(Master)를  등록합니다.
                            </div>
                        </div>
                        <div class="card mb-4">
							<div class="card-body">
                               <form id="master_regist_form">
                                   <input type="hidden" id="useYn" name="useYn">
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="processLgCd" name="processLgCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${process_lg_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="processLgCd">Process Large Code</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="processTypeExclusiveCd" name="processTypeExclusiveCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${resourceTypeCodeList}">
													  <option plgcd="${item.processLgCd}" value="${item.processTypeExclusiveCd}">${item.processTypeExclusiveCdNm}</option>
												  </c:forEach>
												</select>
												<label for="processTypeExclusiveCd">Process Type Exclusive Code</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="processName" name="processName" type="text" placeholder="Enter processName" maxlength="25"/>
                                               <label for="processName">Process Name</label>
                                           </div>
                                       </div>
                                   </div>
                                   
                                   <div class="mt-4 mb-0">
                                       <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_master_regist">Regist</a></div>
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
