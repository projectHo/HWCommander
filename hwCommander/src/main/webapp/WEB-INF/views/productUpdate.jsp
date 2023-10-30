<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - Product Update</title>
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
    	
        $('#btn_product_update').on("click", function () {
    		if("${selectMasterData.orderDetailCnt}" > 0) {
    			alert("본 제품은 주문된 내역 존재하여 수정할 수 없습니다.");
    			return false;
    		}
    		
        	if(!validationCheck()) {
        		return false;
        	}
        	
        	if(confirm("수정 하시겠습니까?")) {

        		goProductUpdate();
        	}
        });
        
        // dataTable 적용
        $("#datatablesSimple_01").DataTable();
        $("#datatablesSimple_02").DataTable();
        $("#datatablesSimple_03").DataTable();
        $("#datatablesSimple_04").DataTable();
        $("#datatablesSimple_05").DataTable();
        $("#datatablesSimple_06").DataTable();
        $("#datatablesSimple_07").DataTable();
        $("#datatablesSimple_08").DataTable();
        $("#datatablesSimple_09").DataTable();
        $("#datatablesSimple_10").DataTable();
    });
    
function dataSetting() {
	$("#productName").val("${selectMasterData.productName}");
	
	var productDescriptionStr = "${selectMasterData.productDescriptionStr}";
	var replace_result = productDescriptionStr.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
	$("#productDescription").val(replace_result);
	
	$("#productPrice").val("${selectMasterData.productPrice}");
	$("#productQty").val("${selectMasterData.productQty}");
	
	$("#id").val("${selectMasterData.id}");
	$("#productImage").val("${selectMasterData.productImage}");
	
	var selectDetailDataList = ${selectDetailDataJson};
	 
	 for(var i = 0; i < selectDetailDataList.length; i++) {
		 partsAdd();
		 
		 var inputIndex = i+1;
		 
		 $("#partsId_"+inputIndex).val(selectDetailDataList[i].partsId);
		 $("#partsName_"+inputIndex).val(selectDetailDataList[i].partsName);
		 $("#partsTypeCd_"+inputIndex).val(selectDetailDataList[i].partsTypeCd);
		 $("#partsQty_"+inputIndex).val(selectDetailDataList[i].partsQty);
		 $("#partsPrice_"+inputIndex).val(selectDetailDataList[i].partsPrice);
		 $("#partsTotalPrice_"+inputIndex).val(selectDetailDataList[i].partsTotalPrice);
		 $("#partsImage_"+inputIndex).val(selectDetailDataList[i].partsImage);
		 $("#partsHistorySeq_"+inputIndex).val(selectDetailDataList[i].partsHistorySeq);
	 }
}

function goProductUpdate() {
    var partsUpdateFormArray = [];
	
	$('#parts_update_table tr').each(function (index) {
		if(0 != index) {
			var item = {
				partsId : $(this).find('input[name=partsId]').val(),
				partsName : $(this).find('input[name=partsName]').val(),
				partsTypeCd : $(this).find('select[name=partsTypeCd]').val(),
				partsQty : $(this).find('input[name=partsQty]').val(),
				partsPrice : $(this).find('input[name=partsPrice]').val(),
				partsTotalPrice : $(this).find('input[name=partsTotalPrice]').val(),
				partsImage : $(this).find('input[name=partsImage]').val(),
				partsHistorySeq : $(this).find('input[name=partsHistorySeq]').val()
			};
			partsUpdateFormArray.push(item);
		}
	});
	
	var productMasterVO = {
		id : $("#id").val(),
		productName : $("#productName").val(),
		productDescription : $("#productDescription").val(),
		productPrice : $("#productPrice").val(),
		productQty : $("#productQty").val()
	};
	
	var ajaxData = {
			productMasterVO : JSON.stringify(productMasterVO),
			productDetailVOList : JSON.stringify(partsUpdateFormArray)
	};
		 
    $.ajax({
        type: "post",
        url: "/admin/productUpdateLogic.do",
        data: ajaxData,
        dataType: 'json',
        success: function (data) {
        	if(data == 1) {
        		alert("수정완료");
        	}else {
        		alert("수정실패");
        	}
        	window.location = "productManagement.do";
            console.log(data);
        }
    });
}

function validationCheck() {
	
	if($('#productName').val().trim() == "" || $('#productName').val().trim() == null) {
		alert("제품명을 입력하세요");
		$('#productName').focus();
		return false;
	}
	
	if($('#productDescription').val().trim() == "" || $('#productDescription').val().trim() == "") {
		alert("제품설명을 입력하세요");
		$('#productDescription').focus();
		return false;
	}
	
	if(1 == $('#parts_update_table tr').length) {
		alert("추가 된 부품이 없습니다");
		return false;
	}
	
	return true;
}


var index = 0;
function partsAdd() {
	//var addIndex = $('#parts_update_table tr').length;
	++index;
	var addIndex = index;
	
	var innerHtml = "";
	innerHtml += '<tr id="parts_update_table_tr_'+addIndex+'">';
	innerHtml += '	<td>';
	innerHtml += '		<input class="form-check-input" type="checkbox" value="" name="rowCheck" id="rowCheck_'+addIndex+'">';
	innerHtml += '	</td>';
	innerHtml += '	<td>';
	innerHtml += '		<select class="form-select form-select-sm" name="partsTypeCd" id="partsTypeCd_'+addIndex+'" onchange="partsTypeCdOnchange('+addIndex+')">';
	innerHtml += '			<option value="null" selected>-선택-</option>';
	innerHtml += '			<c:forEach var="item" items="${parts_type_cd}">';
	innerHtml += '				<option value="${item.cd}">${item.nm}</option>';
	innerHtml += '			</c:forEach>';
	innerHtml += '		</select>';
	innerHtml += '	</td>';
	innerHtml +='	<td>';
	innerHtml +='		<div class="input-group">';
	innerHtml +='			<input type="text" class="form-control form-control-sm" name="partsName" id="partsName_'+addIndex+'" disabled>';
	innerHtml +='			<a class="btn btn-outline-secondary btn-sm" type="button" href="javascript:partsSelect('+addIndex+')">선택</a>';
	innerHtml +='			<input name="partsId" id="partsId_'+addIndex+'" type="hidden"/>';
	innerHtml +='			<input name="partsImage" id="partsImage'+addIndex+'" type="hidden"/>';
	innerHtml +='			<input name="partsHistorySeq" id="partsHistorySeq_'+addIndex+'" type="hidden"/>';
	innerHtml +='			<input name="partsTotalPrice" type="hidden"/>';
	innerHtml +='		</div>';
	innerHtml +='	</td>';
	innerHtml += '	<td>';
	innerHtml += '		<input class="form-control form-control-sm" name="partsQty" id="partsQty_'+addIndex+'" type="number" onchange="productPriceCalculate()" disabled/>';
	innerHtml += '	</td>';
	innerHtml += '	<td>';
	innerHtml += '		<input class="form-control form-control-sm" name="partsPrice" id="partsPrice_'+addIndex+'" type="number" onchange="productPriceCalculate()"/>';
	innerHtml += '	</td>';
	innerHtml += '</tr>';
	
	$('#parts_update_table > tbody:last').append(innerHtml);
}

function partsDel() {
	if(1 == $('#parts_update_table tr').length) {
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
	var trId = "parts_update_table_tr_"+rowNum;
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

function modalPartsSelect(id, partsName, partsPrice, partsImage, partsHistorySeq) {
	
	$("#partsId_"+targetIndex).val(id);
	$("#partsName_"+targetIndex).val(partsName);
	$("#partsPrice_"+targetIndex).val(partsPrice);
	$("#partsImage_"+targetIndex).val(partsImage);
	$("#partsHistorySeq_"+targetIndex).val(partsHistorySeq);
	
	$("#"+targetModelId).modal('hide');
	
	// 재계산
	productPriceCalculate();
}

function partsTypeCdOnchange(rowNum) {
	var trId = "parts_update_table_tr_"+rowNum;
	$('#partsQty_'+rowNum).val(1);
	
	if("04" == $('#'+trId+' select').val()
			|| "08" == $('#'+trId+' select').val()
			|| "09" == $('#'+trId+' select').val()
			|| "10" == $('#'+trId+' select').val()) {
		$('#partsQty_'+rowNum).removeAttr("disabled");
	}else {
		$('#partsQty_'+rowNum).attr("disabled", true);
	}
	
	// 재계산
	productPriceCalculate();
}

function productPriceCalculate() {
	var productPrice = 0;
	
	$('#parts_update_table tr').each(function (index) {
		var partsQty = 0;
		var partsPrice = 0;
		var partsTotalPrice = 0;
		
		if(0 != index) {
			partsQty = $(this).find('input[name=partsQty]').val();
			partsPrice = $(this).find('input[name=partsPrice]').val();
			partsTotalPrice = partsQty * partsPrice;
			
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
                            <a class="nav-link" href="resourceDetailDataManagement.do">
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
                        <h1 class="mt-4">Product Update</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="productManagement.do">Product</a></li>
                            <li class="breadcrumb-item active">Product Update</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                Product를  수정합니다.
                            </div>
                        </div>
                        <div class="card mb-4">
							<div class="card-body">
                               <form id="product_update_form">
                                   <input type="hidden" id="id" name="id">
                                   <input type="hidden" id="productImage" name="productImage">
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="productName" name="productName" type="text" placeholder="Enter productName"/>
                                       <label for="productName">product Name</label>
                                   </div>
                                   
                                   <!-- 2023.04.25 input -> textarea 변경
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="productDescription" name="productDescription" type="text" placeholder="Enter productDescription"/>
                                       <label for="productDescription">product Description</label>
                                   </div>
                                    -->
                                   
                                   <div class="input-group mb-3">
                                       <span class="input-group-text">product Description</span>
                                       <textarea class="form-control" id="productDescription" name="productDescription"></textarea>
                                   </div>
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="productPrice" name="productPrice" type="number" placeholder="Enter productPrice" />
                                       <label for="productPrice">product Price</label>
                                   </div>
                                   
                                   <div class="form-floating mb-3">
                                       <input class="form-control" id="productQty" name="productQty" type="number" placeholder="Enter productQty" />
                                       <label for="productQty">product Qty</label>
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
                            	<form id="parts_update_form">
									<table class="table" id="parts_update_table">
									  <thead>
									    <tr>
									      <th scope="col">Row</th>
									      <th scope="col">부품타입</th>
									      <th scope="col">부품선택</th>
									      <th scope="col">수량</th>
									      <th scope="col">부품가격</th>
									    </tr>
									  </thead>
									  <tbody id="parts_update_table_tbody">
									  </tbody>
									</table>
                                </form>
                                
	                            <div class="mt-4 mb-0">
	                                <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_product_update">Update</a></div>
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
                                <a>Dream</a>
                                &middot;
                                <a>Desire</a>
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
	                  <table id="datatablesSimple_01" class="table">
	                      <thead>
	                          <tr>
	                              <th>gpu name</th>
	                              <th>gpu price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${gpuList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
	                  <table id="datatablesSimple_02" class="table">
	                      <thead>
	                          <tr>
	                              <th>cpu name</th>
	                              <th>cpu price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${cpuList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
	                  <table id="datatablesSimple_03" class="table">
	                      <thead>
	                          <tr>
	                              <th>mb name</th>
	                              <th>mb price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${mbList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
	                  <table id="datatablesSimple_04" class="table">
	                      <thead>
	                          <tr>
	                              <th>ram name</th>
	                              <th>ram price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${ramList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
	                  <table id="datatablesSimple_05" class="table">
	                      <thead>
	                          <tr>
	                              <th>psu name</th>
	                              <th>psu price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${psuList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
	                  <table id="datatablesSimple_06" class="table">
	                      <thead>
	                          <tr>
	                              <th>case name</th>
	                              <th>case price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${caseList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
	                  <table id="datatablesSimple_07" class="table">
	                      <thead>
	                          <tr>
	                              <th>cooler name</th>
	                              <th>cooler price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${coolerList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
	                  <table id="datatablesSimple_08" class="table">
	                      <thead>
	                          <tr>
	                              <th>hdd name</th>
	                              <th>hdd price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${hddList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
	                  <table id="datatablesSimple_09" class="table">
	                      <thead>
	                          <tr>
	                              <th>ssd name</th>
	                              <th>ssd price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${ssdList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
	                  <table id="datatablesSimple_10" class="table">
	                      <thead>
	                          <tr>
	                              <th>sf name</th>
	                              <th>sf price</th>
	                              <th></th>
	                          </tr>
	                      </thead>
	                      <tbody>
							<c:forEach var="item" items="${sfList}">
								<tr>
									<td>${item.partsName}</td>
									<td>${item.partsPrice}</td>
								    <td>
								      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="javascript:modalPartsSelect('${item.id}', '${item.partsName}', '${item.partsPrice}', '${item.partsImage}', '${item.partsHistorySeq}')">선택</button>
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
        
        <script src="/resources/js/sbAdmin-sidebar-script.js"></script>
    </body>
</html>
