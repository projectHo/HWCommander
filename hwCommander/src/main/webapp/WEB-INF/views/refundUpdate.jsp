<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - Refund Update</title>
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
        $('#btn_refund_update').on("click", function () {
        	if(!validationCheck()) {
        		return false;
        	}
        	
        	if(confirm("수정 하시겠습니까?")) {
        		refundUpdateLogic();
        	}
        });
    });
    
function dataSetting() {
	$("#viewId").val("${selectRefundInfoData.id}");
	$("#orderId").val("${selectRefundInfoData.orderId}");
	$("#orderSeq").val("${selectRefundInfoData.orderSeq}");
	$("#productId").val("${selectRefundInfoData.productId}");
	$("#productPrice").val("${selectRefundInfoData.productPrice}");
	$("#refundQty").val("${selectRefundInfoData.refundQty}");
	$("#totRefundPrice").val("${selectRefundInfoData.totRefundPrice}");
	$("#refundStateCd").val("${selectRefundInfoData.refundStateCd}");
	$("#refundReasonCd").val("${selectRefundInfoData.refundReasonCd}");
	$("#refundReasonUserWrite").val("${selectRefundInfoData.refundReasonUserWrite}");
	
	var refundContentStr = "${selectRefundInfoData.refundContentStr}";
	var replace_result = refundContentStr.replace(/(<br>|<br\/>|<br \/>)/g, '\r\n');
	$("#refundContent").val(replace_result);
	
	$("#refundRemarks").val("${selectRefundInfoData.refundRemarks}");
	
	$("#id").val("${selectRefundInfoData.id}");
}

function validationCheck() {
	
	if($('#totRefundPrice').val() == "" || $('#totRefundPrice').val() == null) {
		alert("총 환불금액을 입력하세요.");
		$('#totRefundPrice').focus();
		return false;
	}
	
	if($('#refundStateCd').val() == "00" || $('#refundStateCd').val() == null) {
		alert("환불상태를 선택하세요.");
		$('#refundStateCd').focus();
		return false;
	}
	
	return true;
}

function refundUpdateLogic() {
    var form = $("#refund_update_form").serialize();
    
    $.ajax({
        type: "post",
        url: "/admin/refundUpdateLogic.do",
        data: form,
        dataType: 'json',
        success: function (data) {
        	if(data == 1) {
        		alert("수정완료");
        	}else {
        		alert("수정실패");
        	}
        	window.location = "orderDetail.do?id=${selectRefundInfoData.orderId}";
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
                        <h1 class="mt-4">Refund Update</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="main.do">Admin Page</a></li>
                            <li class="breadcrumb-item"><a href="orderManagement.do">Order</a></li>
                            <li class="breadcrumb-item"><a href="orderDetail.do?id=${selectRefundInfoData.orderId}">Order Detail</a></li>
                            <li class="breadcrumb-item active">Refund Update</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                                Refund Update
                            </div>
                        </div>
                        <form id="refund_update_form">
                        	<input type="hidden" id="id" name="id">
                        	<div class="card mb-4">
                               <div class="card-body">
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="viewId" name="viewId" type="text" placeholder="Enter viewId" disabled/>
                                               <label for="viewId">환불ID</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="orderId" name="orderId" type="text" placeholder="Enter orderId" disabled/>
                                               <label for="orderId">주문ID</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="orderSeq" name="orderSeq" type="text" placeholder="Enter orderSeq" disabled/>
                                               <label for="orderSeq">주문ID - seq</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="productId" name="productId" type="text" placeholder="Enter productId" disabled/>
                                               <label for="productId">제품ID</label>
                                           </div>
                                       </div>

                                   </div>
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="productPrice" name="productPrice" type="text" placeholder="Enter productPrice" disabled/>
                                               <label for="productPrice">제품가격</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="refundQty" name="refundQty" type="text" placeholder="Enter refundQty" disabled/>
                                               <label for="refundQty">환불수량</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
                                               <input class="form-control" id="totRefundPrice" name="totRefundPrice" type="text" placeholder="Enter totRefundPrice"/>
                                               <label for="totRefundPrice">총 환불금액</label>
                                           </div>
                                       </div>
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="refundStateCd" name="refundStateCd">
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${refund_state_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="refundStateCd">환불상태</label>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="row mb-3">
                                       <div class="col-md-3">
                                           <div class="form-floating">
												<select class="form-select pt-4" id="refundReasonCd" name="refundReasonCd" disabled>
												  <option value="00" selected>-선택-</option>
												  <c:forEach var="item" items="${refund_reason_cd}">
													  <option value="${item.cd}">${item.nm}</option>
												  </c:forEach>
												</select>
												<label for="refundReasonCd">환불사유</label>
                                           </div>
                                       </div>
                                       <div class="col-md-9">
                                           <div class="form-floating">
                                               <input class="form-control" id="refundReasonUserWrite" name="refundReasonUserWrite" type="text" placeholder="Enter refundReasonUserWrite" disabled/>
                                               <label for="refundReasonUserWrite">환불사유 구매자 직접입력</label>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="input-group mb-3">
                                       <span class="input-group-text">환불내용</span>
                                       <textarea class="form-control" id="refundContent" name="refundContent" style="height: 200px;"></textarea>
                                   </div>
                                   <div class="row mb-3">
                                       <div class="col-md-12">
                                           <div class="form-floating">
                                               <input class="form-control" id="refundRemarks" name="refundRemarks" type="text" placeholder="Enter refundRemarks"/>
                                               <label for="refundRemarks">환불비고</label>
                                           </div>
                                       </div>
                                   </div>
                                   <div class="mt-4 mb-0">
                                       <div class="d-grid"><a class="btn btn-secondary btn-block" id="btn_refund_update">Update</a></div>
                                   </div>
                               </div>
                        	</div>

                        </form>
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
