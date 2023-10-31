<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - Resource Data(Detail) Regist</title>
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
    	dataSetting();
    	
    	$("#viewId").attr("disabled", true);
    	$("#processLgCd").attr("disabled", true);
    	$("#processTypeExclusiveCd").attr("disabled", true);
    	$("#processName").attr("disabled", true);
    	
        $('#btn_detail_regist').on("click", function () {
        	if(!validationCheck()) {
        		return false;
        	}
        	
        	if(confirm("등록 하시겠습니까?")) {
        		goResourceDataRegist();
        	}
        });
    });
    
function dataSetting() {
	$("#processTypeExclusiveCd").val("${selectDataMaster.processTypeExclusiveCd}");
	$("#processLgCd").val("${selectDataMaster.processLgCd}");
	$("#processName").val("${selectDataMaster.processName}");
	$("#viewId").val("${selectDataMaster.id}");

	$("#id").val("${selectDataMaster.id}");
}
    
function goResourceDataRegist() {
	
	var processResourceDetailVO = {
			id : $("#id").val(),
			resourceMappingValue : $("#resourceMappingValue").val()
		};
	
	$.ajax({
        type: "post",
        url: "/admin/resourceMappingValueDupliChk.do",
        data: {
			id : $("#id").val(),
			resourceMappingValue : $("#resourceMappingValue").val()
		},
        dataType: 'json',
        success: function (data) {
        	if(data == 0) {
        		// cnt == 0 일때 등록
        	    var form = $("#detail_regist_form").serialize();
        	    
        	    $.ajax({
        	        type: "post",
        	        url: "/admin/resourceDetailRegistLogic.do",
        	        data: form,
        	        dataType: 'json',
        	        success: function (data) {
        	        	if(data == 2) {
        	        		alert("등록완료");
        	        	}else {
        	        		alert("등록실패");
        	        	}
        	        	window.location = "resourceDetailManagement.do";
        	            console.log(data);
        	        }
        	    });
        	}else {
        		alert("["+$("#resourceMappingValue").val()+"] 는 이미 등록되어있는 Mapping Value 입니다.");
        	}
        }
    });
}

function validationCheck() {
	if("00" == $('#variableChk').val()) {
		alert("Process Variable Check를 선택하세요.");
		$('#variableChk').focus();
		return false;
	}
	
	if("" == $('#resourceName').val().trim() || null == $('#resourceName').val().trim()) {
		alert("Resource Name을 입력하세요.");
		$('#resourceName').focus();
		return false;
	}
	
	if("" == $('#resourceMappingValue').val().trim() || null == $('#resourceMappingValue').val().trim()) {
		alert("Resource Mapping Value를 입력하세요.");
		$('#resourceMappingValue').focus();
		return false;
	}
	
	if("" == $('#resourceScore').val().trim() || null == $('#resourceScore').val().trim()) {
		alert("Resource Score를 입력하세요.");
		$('#resourceScore').focus();
		return false;
	}
	
	var resourceScore = parseFloat($('#resourceScore').val().trim());
	if(isNaN(resourceScore)) {
		alert("Resource Score는 문자열을 포함할 수 없습니다.");
		$('#resourceScore').focus();
		return false;
	}
	/* 
	if(asScore > 65535) {
		alert("Resource Score는 65535 미만의 수여야 합니다.");
		return false;
	}
	 */
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
                        <h1 class="mt-4">Resource Data(Detail) Regist</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="resourceDetailManagement.do">Resource Data(Detail)</a></li>
                            <li class="breadcrumb-item active">Resource Data(Detail) Regist</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                Resource Data(Detail)를  등록합니다.
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-body">
                                <p class="mb-0">Resource Mapping Value 등록규칙</p>
                                <p class="mb-0">Process Variable Check가 "고정"인 경우 Resource Name과 Resource Mapping Value가 동일하게 등록되어야 합니다.</p>
                                <p class="mb-3">ex) Resource Name = CVU / Resource Mapping Value = CVU</p>
                                
                                <p class="mb-0">Process Variable Check가 "CPU"인 경우 Resource Mapping Value는 부품의 Id가 등록되어야 합니다.</p>
                                <p class="mb-3">ex) Resource Mapping Value = CPU000001</p>
                                
                                <p class="mb-0">Process Variable Check가 "GVA"인 경우 정수(GC)로 입력해야합니다.</p>
                                <p class="mb-3">ex) Resource Mapping Value = 371</p>
                                
                                <p class="mb-0">Process Variable Check가 "RAM(MaxRange)"인 경우 정수(ddr4_max_range or ddr5_max_range)로 입력해야 합니다.</p>
                                <p class="mb-3">ex) Resource Mapping Value = 5600</p>
                                
                                <p class="mb-0">Process Variable Check가 "RAM(Volume)"인 경우 정수(volume)로 입력해야 합니다.</p>
                                <p class="mb-0">ex) Resource Mapping Value = 16</p>
                            </div>
                        </div>
                        <div class="card mb-4">
							<div class="card-body">
                               <form id="detail_regist_form">
                                   <input type="hidden" id="id" name="id">
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="viewId" name="viewId" type="text" placeholder="Enter viewId"/>
                                               <label for="viewId">Id</label>
                                           </div>
                                       </div>
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
													  <option value="${item.processTypeExclusiveCd}">${item.processTypeExclusiveCdNm}</option>
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
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="variableChk" name="variableChk">
												  <option value="00" selected>-선택-</option>
												  <option value="F">고정</option>
												  <option value="C">CPU</option>
												  <option value="G">GVA</option>
												  <option value="RM">RAM(MaxRange)</option>
												  <option value="RV">RAM(Volume)</option>
												</select>
												<label for="variableChk">Process Variable Check</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="resourceName" name="resourceName" type="text" placeholder="Enter resourceName" />
                                               <label for="resourceName">Resource Name</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="resourceMappingValue" name="resourceMappingValue" type="text" placeholder="Enter resourceMappingValue" />
                                               <label for="resourceMappingValue">Resource Mapping Value</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="resourceScore" name="resourceScore" type="text" placeholder="Enter resourceScore" />
                                               <label for="resourceScore">Resource Score</label>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="mt-4 mb-0">
                                       <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_detail_regist">Regist</a></div>
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
