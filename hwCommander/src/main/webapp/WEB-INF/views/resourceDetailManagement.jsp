<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - Resource Data(Detail)</title>
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

<!-- dataTables CDN -->
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>

<!-- cookie js -->
<script src="/resources/js/getSetCookie.js"></script>

<script>
    $(function() {
    	$("#detailListTable").DataTable({
    		displayLength : setDisplayLength()
    	    , bAutoWidth : false
    	    , columnDefs : [
	    	    {targets : 0, width : "10%"}
	    	    , {targets : 1, width : "5%"}
	    	    , {targets : 2, width : "10%"}
	    	    , {targets : 3, width : "15%"}
	    	    , {targets : 4, width : "15%"}
	    	    , {targets : 5, width : "15%"}
	    	    , {targets : 6, width : "15%"}
	    	    , {targets : 7, width : "15%"}
    	    ]
    	});
    	
    	$("#detailListTable").on('click', 'tbody tr', function () {
    		var row = $("#detailListTable").DataTable().row($(this)).data();
    		var id = row[0];
    		var seq = row[1];
    		location.href = "resourceDetailUpdate.do?id="+id+"&seq="+seq;
    	});
    	
        window.addEventListener('unload', function() {
        	setCookie('displayLength', $("select[name=detailListTable_length]").val(), {'max-age': 1800});
       	});
    });
    
function goRegist() {
	if("" == $('#registTargetId').val().trim() || null == $('#registTargetId').val().trim()) {
		alert("Resource Data를 등록할 대상 Id를 입력하세요.");
		$('#registTargetId').focus();
		return false;
	}
	
	location.href="resourceDetailRegist.do?id="+$('#registTargetId').val().trim();
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
                        <h1 class="mt-4">Resource Data(Detail)</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item active">Resource Data(Detail)</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                Resource Data(Detail)를 관리합니다. 조회, 추가, 수정 작업을 할 수 있습니다.
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
								<div class="d-flex">
								  <div class="me-auto d-flex align-items-center">Search Resource Data(Detail)</div>
                                  <div class="me-3">
	                                  <input class="form-control form-control-sm" id="registTargetId" name="registTargetId" type="text" placeholder="Enter Regist Target Id" />
                                  </div>
								  <div>
								  	<a class="btn btn-secondary btn-sm" href="javascript:goRegist()">등록</a>
								  </div>
								</div>
                            </div>
                            <div class="card-body">
                                <table id="detailListTable" class="table">
                                    <thead>
                                        <tr>
                                            <th>Id</th>
                                            <th>Seq</th>
                                            <th>Type Code</th>
                                            <th>Process Name</th>
                                            <th>Variable Check Name</th>
                                            <th>Resource Name</th>
                                            <th>Resource Mapping Value</th>
                                            <th>Resource Score</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										<c:forEach var="item" items="${resourceDetailList}">
											<tr>
	                                            <td>${item.id}</td>
	                                            <td>${item.seq}</td>
	                                            <td>${item.processTypeExclusiveCd}</td>
	                                            <td>${item.processName}</td>
	                                            <td>${item.variableChkNm}</td>
	                                            <td>${item.resourceName}</td>
	                                            <td>${item.resourceMappingValue}</td>
	                                            <td>${item.resourceScore}</td>
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
