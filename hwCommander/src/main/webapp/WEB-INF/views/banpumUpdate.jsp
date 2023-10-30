<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - Banpum Update</title>
<!-- Required meta tags -->
<meta charset="utf-8">

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<link href="/resources/css/main.css" rel="stylesheet" >
<link href="/resources/css/sbAdmin-styles.css" rel="stylesheet" />

<!-- dataTables CDN -->
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>

<script type="text/javascript">

    $(function() {
    	dataSetting();
        $('#btn_banpum_update').on("click", function () {
        	if(!validationCheck()) {
        		return false;
        	}
        	
        	if(confirm("수정 하시겠습니까?")) {
        		goBanpumUpdate();
        	}
        });
    });
    
    function dataSetting() {
    	$("#banpumName").val("${selectMasterData.banpumName}");
    	$("#banpumPrice").val("${selectMasterData.banpumPrice}");
    	$("#banpumQty").val("${selectMasterData.banpumQty}");
    	$("#exposureYn").val("${selectMasterData.exposureYn}");
    	
    	var banpumDescriptionStr = "${selectMasterData.banpumDescriptionStr}";
    	var replace_result = banpumDescriptionStr.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
    	$("#banpumDescription").val(replace_result);
    	
    	$("#banpumImage1").val("${selectMasterData.banpumImage1}");
    	$("#banpumImage2").val("${selectMasterData.banpumImage2}");
    	$("#banpumImage3").val("${selectMasterData.banpumImage3}");
    	$("#banpumImage4").val("${selectMasterData.banpumImage4}");
    	$("#banpumImage5").val("${selectMasterData.banpumImage5}");
    	$("#banpumImage6").val("${selectMasterData.banpumImage6}");
    	$("#banpumImage7").val("${selectMasterData.banpumImage7}");
    	$("#banpumImage8").val("${selectMasterData.banpumImage8}");
    	$("#banpumImage9").val("${selectMasterData.banpumImage9}");
    	$("#banpumImage10").val("${selectMasterData.banpumImage10}");
    	$("#banpumImage11").val("${selectMasterData.banpumImage11}");
    	$("#banpumImage12").val("${selectMasterData.banpumImage12}");
    	$("#banpumImage13").val("${selectMasterData.banpumImage13}");
    	$("#banpumImage14").val("${selectMasterData.banpumImage14}");
    	$("#banpumImage15").val("${selectMasterData.banpumImage15}");
    	
    	$("#id").val("${selectMasterData.id}");
    }
    
function goBanpumUpdate() {
	
	var form = $("#banpum_update_form").serialize();
		 
    $.ajax({
        type: "post",
        url: "/admin/banpumUpdateLogic.do",
        data: form,
        dataType: 'json',
        success: function (data) {
        	if(data == 1) {
        		alert("수정완료");
        	}else {
        		alert("수정실패");
        	}
        	window.location = "banpumInfo.do?banpumId=${selectMasterData.id}";
        }
    });
}

function validationCheck() {
	
	if($('#banpumName').val().trim() == "" || $('#banpumName').val().trim() == null) {
		alert("제품명을 입력하세요");
		$('#banpumName').focus();
		return false;
	}
	
	if($('#banpumPrice').val().trim() == "" || $('#banpumPrice').val().trim() == null) {
		alert("가격을 입력하세요");
		$('#banpumPrice').focus();
		return false;
	}
	
	if($('#banpumQty').val().trim() == "" || $('#banpumQty').val().trim() == null) {
		alert("수량을 입력하세요");
		$('#banpumQty').focus();
		return false;
	}
	
	if($('#banpumDescription').val().trim() == "" || $('#banpumDescription').val().trim() == "") {
		alert("제품설명을 입력하세요");
		$('#banpumDescription').focus();
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
                <a class="btn btn-dark" href="/mainInfo.do">Main</a>
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
                        <h1 class="mt-4">Banpum Update</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="banpumManagement.do">Banpum</a></li>
                            <li class="breadcrumb-item"><a href="banpumInfo.do?banpumId=${selectMasterData.id}">Banpum Info</a></li>
                            <li class="breadcrumb-item active">Banpum Update</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                            	<p class="mb-0">Banpum을  수정합니다.</p>
                            	<p class="mb-0">banpumImage1~15는 자체 클라우드 외부참조링크를 입력하세요.</p>
                            </div>
                        </div>
                        <div class="card mb-4">
							<div class="card-body">
                               <form id="banpum_update_form">
                                   <input type="hidden" id="id" name="id">
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumName" name="banpumName" type="text" placeholder="Enter banpumName"/>
                                       <label for="banpumName">banpum Name</label>
                                   </div>
                                   
                                   <div class="row mb-3">
                                       <div class="col-md-4">
                                           <div class="form-floating mb-3 mb-md-0">
                                               <input class="form-control" id="banpumPrice" name="banpumPrice" type="number" placeholder="Enter banpumPrice" />
                                               <label for="banpumPrice">banpum Price</label>
                                           </div>
                                       </div>
                                       <div class="col-md-4">
                                           <div class="form-floating">
		                                       <input class="form-control" id="banpumQty" name="banpumQty" type="number" placeholder="Enter banpumQty" />
		                                       <label for="banpumQty">banpum Qty</label>
                                           </div>
                                       </div>
                                       <div class="col-md-4">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="exposureYn" name="exposureYn">
												  <option value="Y">Y</option>
												  <option value="N">N</option>
												</select>
												<label for="exposureYn">노출여부</label>
                                           </div>
                                       </div>
                                   </div>
                                   
                                   <div class="input-group mb-3">
                                       <span class="input-group-text">banpum Description</span>
                                       <textarea class="form-control" id="banpumDescription" name="banpumDescription" style="height: 200px;"></textarea>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage1" name="banpumImage1" type="text" placeholder="Enter banpumImage1"/>
                                       <label for="banpumImage1">banpumImage1</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage2" name="banpumImage2" type="text" placeholder="Enter banpumImage2"/>
                                       <label for="banpumImage2">banpumImage2</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage3" name="banpumImage3" type="text" placeholder="Enter banpumImage3"/>
                                       <label for="banpumImage3">banpumImage3</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage4" name="banpumImage4" type="text" placeholder="Enter banpumImage4"/>
                                       <label for="banpumImage4">banpumImage4</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage5" name="banpumImage5" type="text" placeholder="Enter banpumImage5"/>
                                       <label for="banpumImage5">banpumImage5</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage6" name="banpumImage6" type="text" placeholder="Enter banpumImage6"/>
                                       <label for="banpumImage6">banpumImage6</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage7" name="banpumImage7" type="text" placeholder="Enter banpumImage7"/>
                                       <label for="banpumImage7">banpumImage7</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage8" name="banpumImage8" type="text" placeholder="Enter banpumImage8"/>
                                       <label for="banpumImage8">banpumImage8</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage9" name="banpumImage9" type="text" placeholder="Enter banpumImage9"/>
                                       <label for="banpumImage9">banpumImage9</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage10" name="banpumImage10" type="text" placeholder="Enter banpumImage10"/>
                                       <label for="banpumImage10">banpumImage10</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage11" name="banpumImage11" type="text" placeholder="Enter banpumImage11"/>
                                       <label for="banpumImage11">banpumImage11</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage12" name="banpumImage12" type="text" placeholder="Enter banpumImage12"/>
                                       <label for="banpumImage12">banpumImage12</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage13" name="banpumImage13" type="text" placeholder="Enter banpumImage13"/>
                                       <label for="banpumImage13">banpumImage13</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage14" name="banpumImage14" type="text" placeholder="Enter banpumImage14"/>
                                       <label for="banpumImage14">banpumImage14</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="banpumImage15" name="banpumImage15" type="text" placeholder="Enter banpumImage15"/>
                                       <label for="banpumImage15">banpumImage15</label>
                                   </div>
                                   
                                   <div class="mt-4 mb-0">
                                       <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_banpum_update">Update</a></div>
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
