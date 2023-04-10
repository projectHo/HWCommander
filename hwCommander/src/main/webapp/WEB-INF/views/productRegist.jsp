<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - Product Regist</title>
<!-- Required meta tags -->
<meta charset="utf-8">

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href="/resources/css/main.css" rel="stylesheet" >
<link href="/resources/css/styles.css" rel="stylesheet" />

<script type="text/javascript">

    $(function(){
        $('#btn_product_regist').on("click", function () {
        	if(!validationCheck()) {
        		return false;
        	}
        	goProductRegist();
        });
        
        // dataTable 적용
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_01'));
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_02'));
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_03'));
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_04'));
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_05'));
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_06'));
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_07'));
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_08'));
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_09'));
        new simpleDatatables.DataTable(document.getElementById('datatablesSimple_10'));
    });
    
function goProductRegist() {
    var partsRegistFormArray = [];
	
	$('#parts_regist_table tr').each(function (index) {
		if(0 != index) {
			var item = {
				partsId : $(this).find('input[name=partsId]').val(),
				partsTypeCd : $(this).find('select[name=partsTypeCd]').val(),
				qty : $(this).find('input[name=qty]').val(),
				partsPrice : $(this).find('input[name=partsPrice]').val(),
				partsTotalPrice : $(this).find('input[name=partsTotalPrice]').val(),
			};
			partsRegistFormArray.push(item);
		}
	});
	
	var productMasterVO = {
		productName : $("#productName").val(),
		productDescription : $("#productDescription").val(),
		productPrice : $("#productPrice").val()
	};
	
	var ajaxData = {
			productMasterVO : JSON.stringify(productMasterVO),
			productDetailVOList : JSON.stringify(partsRegistFormArray)
	};
		 
    $.ajax({
        type: "post",
        url: "/admin/productRegistLogic.do",
        data: ajaxData,
        dataType: 'json',
        success: function (data) {
        	if(data == 1) {
        		alert("등록완료");
        	}else {
        		alert("등록실패");
        	}
        	window.location = "productManagement.do";
            console.log(data);
        }
    });
}

function validationCheck() {
	
	if($('#productName').val().trim() == "" || $('#productName').val().trim() == null) {
		alert("제품명을 입력하세요");
		return false;
	}
	
	if($('#productDescription').val().trim() == "" || $('#productDescription').val().trim() == "") {
		alert("제품설명을 입력하세요");
		return false;
	}
	
	if(1 == $('#parts_regist_table tr').length) {
		alert("추가 된 부품이 없습니다");
		return false;
	}
	
	return true;
}


var index = 0;
function partsAdd() {
	//var addIndex = $('#parts_regist_table tr').length;
	++index;
	var addIndex = index;
	
	var innerHtml = "";
	innerHtml += '<tr id="parts_regist_table_tr_'+addIndex+'">';
	innerHtml += '	<td>';
	innerHtml += '		<input class="form-check-input" type="checkbox" value="" name="rowCheck" id="rowCheck_'+addIndex+'">';
	innerHtml += '	</td>';
	innerHtml += '	<td>';
	innerHtml += '		<select class="form-select form-select-sm" name="partsTypeCd" onchange="partsTypeCdOnchange('+addIndex+')">';
	innerHtml += '			<option value="null" selected>-선택-</option>';
	innerHtml += '			<c:forEach var="item" items="${parts_type_cd}">';
	innerHtml += '				<option value="${item.cd}">${item.nm}</option>';
	innerHtml += '			</c:forEach>';
	innerHtml += '		</select>';
	innerHtml += '	</td>';
	innerHtml +='	<td>';
	innerHtml +='		<div class="input-group">';
	innerHtml +='			<input type="text" class="form-control form-control-sm" id="partsName_'+addIndex+'" disabled>';
	innerHtml +='			<a class="btn btn-outline-secondary btn-sm" type="button" href="javascript:partsSelect('+addIndex+')">선택</a>';
	innerHtml +='			<input name="partsId" id="partsId_'+addIndex+'" type="hidden"/>';
	innerHtml +='			<input name="partsTotalPrice" type="hidden"/>';
	innerHtml +='		</div>';
	innerHtml +='	</td>';
	innerHtml += '	<td>';
	innerHtml += '		<input class="form-control form-control-sm" name="qty" id="qty_'+addIndex+'" type="number" onchange="productPriceCalculate()" disabled/>';
	innerHtml += '	</td>';
	innerHtml += '	<td>';
	innerHtml += '		<input class="form-control form-control-sm" name="partsPrice" id="partsPrice_'+addIndex+'" type="number" onchange="productPriceCalculate()"/>';
	innerHtml += '	</td>';
	innerHtml += '</tr>';
	
	$('#parts_regist_table > tbody:last').append(innerHtml);
}

function partsDel() {
	if(1 == $('#parts_regist_table tr').length) {
		alert("추가 된 부품이 없습니다");
		return false;
	}
	
	if(0 == $('input:checkbox[name=rowCheck]:checked').length) {
		alert("체크된 부품이 없습니다.");
		return false;
	}
	
	if(confirm("선택한 행을 삭제하시겠습니까?")) {
		$('input:checkbox[name=rowCheck]').each(function (index) {
			if(true == $(this).is(":checked")) {
		    	console.log($(this).closest('tr').attr('id'));
		    	$(this).closest('tr').remove();
		    }
		});
	}
}

var targetIndex = 0;
var targetModelId = "";
function partsSelect(rowNum) {
	var trId = "parts_regist_table_tr_"+rowNum;
	targetIndex = rowNum;
	
	if("null" == $('#'+trId+' select').val()) {
		alert("부품타입을 선택한 후 부품을 선택할 수 있습니다.");
		return false;
	}

	var modalId = "modal_"+$('#'+trId+' select').val();
	targetModelId = modalId;
	
    var myModal = new bootstrap.Modal(document.getElementById(modalId), {});
    myModal.show();
}

function modalPartsSelect(id, partsName, partsPrice) {
	
	$("#partsId_"+targetIndex).val(id);
	$("#partsName_"+targetIndex).val(partsName);
	$("#partsPrice_"+targetIndex).val(partsPrice);
	
	$("#"+targetModelId).modal('hide');
	
	// 재계산
	productPriceCalculate();
}

function partsTypeCdOnchange(rowNum) {
	var trId = "parts_regist_table_tr_"+rowNum;
	$('#qty_'+rowNum).val(1);
	
	if("04" == $('#'+trId+' select').val()
			|| "08" == $('#'+trId+' select').val()
			|| "09" == $('#'+trId+' select').val()
			|| "10" == $('#'+trId+' select').val()) {
		$('#qty_'+rowNum).removeAttr("disabled");
	}else {
		$('#qty_'+rowNum).attr("disabled", true);
	}
	
	// 재계산
	productPriceCalculate();
}

function productPriceCalculate() {
	var productPrice = 0;
	
	$('#parts_regist_table tr').each(function (index) {
		var qty = 0;
		var partsPrice = 0;
		var partsTotalPrice = 0;
		
		if(0 != index) {
			qty = $(this).find('input[name=qty]').val();
			partsPrice = $(this).find('input[name=partsPrice]').val();
			partsTotalPrice = qty * partsPrice;
			
			$(this).find('input[name=partsTotalPrice]').val(partsTotalPrice);
			productPrice += partsTotalPrice;
		}
	});
	
	$('#productPrice').val(productPrice);
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
                        <h1 class="mt-4">Product Regist</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="productManagement.do">Product</a></li>
                            <li class="breadcrumb-item active">Product Regist</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                Product를  등록합니다.
                            </div>
                        </div>
                        <div class="card mb-4">
							<div class="card-body">
                               <form id="product_regist_form">
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="productName" name="productName" type="text" placeholder="Enter productName"/>
                                       <label for="productName">product Name</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="productDescription" name="productDescription" type="text" placeholder="Enter productDescription"/>
                                       <label for="productDescription">product Description</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="productPrice" name="productPrice" type="number" placeholder="Enter productPrice" />
                                       <label for="productPrice">product Price</label>
                                   </div>
                               </form>
                           </div>
                        </div>
                        
                        <div class="card mb-4">
                            <div class="card-header">
								<div class="d-flex">
								  <div class="me-auto d-flex align-items-center">Parts List</div>
								  <div>
								  	<a class="btn btn-secondary btn-sm" id="btn_parts_add" href="javascript:partsAdd()">Add</a>
								  </div>
								  <div class="ms-2">
								  	<a class="btn btn-secondary btn-sm" id="btn_parts_del" href="javascript:partsDel()">Del</a>
								  </div>
								</div>
                            </div>
                            <div class="card-body">
                            	<form id="parts_regist_form">
									<table class="table" id="parts_regist_table">
									  <thead>
									    <tr>
									      <th scope="col">Row</th>
									      <th scope="col">부품타입</th>
									      <th scope="col">부품선택</th>
									      <th scope="col">수량</th>
									      <th scope="col">부품가격</th>
									    </tr>
									  </thead>
									  <tbody id="parts_regist_table_tbody">
									  </tbody>
									</table>
                                </form>
                                
	                            <div class="mt-4 mb-0">
	                                <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_product_regist">Regist</a></div>
	                            </div>
                            
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
        
		
		<!-- Modal -->
		<div class="modal fade" id="modal_01" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_01_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_01_label">GPU</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_01">
	                      <thead>
	                          <tr>
	                              <th>gpu name</th>
	                              <th>gpu price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>gpu name</th>
	                              <th>gpu price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${gpuList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		<!-- Modal -->
		<div class="modal fade" id="modal_02" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_02_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_02_label">CPU</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_02">
	                      <thead>
	                          <tr>
	                              <th>cpu name</th>
	                              <th>cpu price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>cpu name</th>
	                              <th>cpu price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${cpuList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="modal_03" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_03_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_03_label">MB</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_03">
	                      <thead>
	                          <tr>
	                              <th>mb name</th>
	                              <th>mb price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>mb name</th>
	                              <th>mb price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${mbList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="modal_04" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_04_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_04_label">RAM</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_04">
	                      <thead>
	                          <tr>
	                              <th>ram name</th>
	                              <th>ram price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>ram name</th>
	                              <th>ram price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${ramList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="modal_05" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_05_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_05_label">PSU</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_05">
	                      <thead>
	                          <tr>
	                              <th>psu name</th>
	                              <th>psu price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>psu name</th>
	                              <th>psu price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${psuList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="modal_06" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_06_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_06_label">CASE</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_06">
	                      <thead>
	                          <tr>
	                              <th>case name</th>
	                              <th>case price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>case name</th>
	                              <th>case price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${caseList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="modal_07" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_07_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_07_label">Cooler</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_07">
	                      <thead>
	                          <tr>
	                              <th>cooler name</th>
	                              <th>cooler price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>cooler name</th>
	                              <th>cooler price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${coolerList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="modal_08" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_08_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_08_label">HDD</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_08">
	                      <thead>
	                          <tr>
	                              <th>hdd name</th>
	                              <th>hdd price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>hdd name</th>
	                              <th>hdd price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${hddList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="modal_09" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_09_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_09_label">SSD</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_09">
	                      <thead>
	                          <tr>
	                              <th>ssd name</th>
	                              <th>ssd price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>ssd name</th>
	                              <th>ssd price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${ssdList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="modal_10" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="modal_10_label" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-lg">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modal_10_label">SF</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body">
	              <div class="card-body">
	                  <table id="datatablesSimple_10">
	                      <thead>
	                          <tr>
	                              <th>sf name</th>
	                              <th>sf price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tfoot>
	                          <tr>
	                              <th>sf name</th>
	                              <th>sf price</th>
	                              <th></th>
	                          </tr>
	                      </tfoot>
	                      <tbody>
							<c:forEach var="item" items="${sfList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}')">선택</button>
								    </td>
	                          	</tr>
							</c:forEach>
	                      </tbody>
	                  </table>
	              </div>
		      </div>
		    </div>
		  </div>
		</div>
		
		
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="/resources/js/datatables-simple-demo.js"></script>
        <script src="/resources/js/scripts.js"></script>
    </body>
</html>