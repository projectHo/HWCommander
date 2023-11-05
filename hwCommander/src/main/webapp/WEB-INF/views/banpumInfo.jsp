<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - Banpum Info</title>
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
    	// disalbed 처리부
    	$("#banpumName").attr("disabled", true);
    	$("#banpumPrice").attr("disabled", true);
    	$("#banpumQty").attr("disabled", true);
    	$("#exposureYn").attr("disabled", true);
    	$("#banpumDescription").attr("disabled", true);
    	
    	dataSetting();
        $('#btn_go_update').on("click", function () {
        	if("0" != "${orderCnt}") {
            	if(confirm("이 제품은 주문건에 포함된 내역이 존재합니다.\n수정 시 소비자에게 혼란을 야기할 수 있습니다.\n그래도 수정 하시겠습니까?")) {
            		location.href = "banpumUpdate.do?banpumId="+"${selectMasterData.id}";
            	}
        	}else {
        		// "0" == "${orderCnt}"
        		location.href = "banpumUpdate.do?banpumId="+"${selectMasterData.id}";
        	}
        });
        
        $('#btn_delete').on("click", function () {
        	if("0" != "${orderCnt}") {
        		alert("이 제품은 주문건에 포함된 내역이 존재하여 삭제할 수 없습니다.");
        	}else {
        		// "0" == "${orderCnt}"
				if(confirm("정말 삭제하시겠습니까?")) {
					banpumDeleteLogic();
            	}
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

function banpumDeleteLogic() {
	var ajaxData = {
		id : "${selectMasterData.id}"
	};
	
    $.ajax({
        type: "post",
        url: "/admin/banpumDeleteLogic.do",
        data: ajaxData,
        dataType: 'json',
        success: function (data) {
        	if(data == 1) {
        		alert("삭제완료");
        	}else {
        		alert("삭제실패");
        	}
        	window.location = "banpumManagement.do";
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
                        <h1 class="mt-4">Banpum Info</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="banpumManagement.do">Banpum</a></li>
                            <li class="breadcrumb-item active">Banpum Info</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                Banpum Info를 확인합니다.
                            </div>
                        </div>
                        <div class="card mb-4">
							<div class="card-body">
                               <form id="banpum_info_form">
                                   <input type="hidden" id="id" name="id">
                                   <input type="hidden" id="banpumImage1" name="banpumImage1"/>
                                   <input type="hidden" id="banpumImage2" name="banpumImage2"/>
                                   <input type="hidden" id="banpumImage3" name="banpumImage3"/>
                                   <input type="hidden" id="banpumImage4" name="banpumImage4"/>
                                   <input type="hidden" id="banpumImage5" name="banpumImage5"/>
                                   <input type="hidden" id="banpumImage6" name="banpumImage6"/>
                                   <input type="hidden" id="banpumImage7" name="banpumImage7"/>
                                   <input type="hidden" id="banpumImage8" name="banpumImage8"/>
                                   <input type="hidden" id="banpumImage9" name="banpumImage9"/>
                                   <input type="hidden" id="banpumImage10" name="banpumImage10"/>
                                   <input type="hidden" id="banpumImage11" name="banpumImage11"/>
                                   <input type="hidden" id="banpumImage12" name="banpumImage12"/>
                                   <input type="hidden" id="banpumImage13" name="banpumImage13"/>
                                   <input type="hidden" id="banpumImage14" name="banpumImage14"/>
                                   <input type="hidden" id="banpumImage15" name="banpumImage15"/>
                                   
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
                                   
									<!-- Gallery -->
									<div class="row mb-4">
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage1">banpumImage1</label>
									    <img
									      src="${selectMasterData.banpumImage1}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage1"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage1">banpumImage2</label>
									    <img
									      src="${selectMasterData.banpumImage2}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage2"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage3">banpumImage3</label>
									    <img
									      src="${selectMasterData.banpumImage3}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage3"
									    />
									  </div>
									</div>
									
									<div class="row mb-4">
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage4">banpumImage4</label>
									    <img
									      src="${selectMasterData.banpumImage4}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage4"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage5">banpumImage5</label>
									    <img
									      src="${selectMasterData.banpumImage5}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage5"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage6">banpumImage6</label>
									    <img
									      src="${selectMasterData.banpumImage6}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage6"
									    />
									  </div>
									</div>
									
									<div class="row mb-4">
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage7">banpumImage7</label>
									    <img
									      src="${selectMasterData.banpumImage7}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage7"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage8">banpumImage8</label>
									    <img
									      src="${selectMasterData.banpumImage8}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage8"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage9">banpumImage9</label>
									    <img
									      src="${selectMasterData.banpumImage9}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage9"
									    />
									  </div>
									</div>
									
									<div class="row mb-4">
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage10">banpumImage10</label>
									    <img
									      src="${selectMasterData.banpumImage10}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage10"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage11">banpumImage11</label>
									    <img
									      src="${selectMasterData.banpumImage11}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage11"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage12">banpumImage12</label>
									    <img
									      src="${selectMasterData.banpumImage12}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage12"
									    />
									  </div>
									</div>
									
									<div class="row mb-4">
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage13">banpumImage13</label>
									    <img
									      src="${selectMasterData.banpumImage13}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage13"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage14">banpumImage14</label>
									    <img
									      src="${selectMasterData.banpumImage14}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage14"
									    />
									  </div>
									  <div class="col-lg-4 col-md-4">
									  	<label for="banpumImage15">banpumImage15</label>
									    <img
									      src="${selectMasterData.banpumImage15}"
									      class="w-100 shadow-1-strong rounded"
									      alt="banpumImage15"
									    />
									  </div>
									</div>
									<!-- Gallery -->
                                   
                                   <div class="mt-4 mb-0">
                                       <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_go_update">Update 화면으로 이동</a></div>
                                   </div>
                                   
                                   <div class="mt-4 mb-0">
                                       <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_delete">Delete</a></div>
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
