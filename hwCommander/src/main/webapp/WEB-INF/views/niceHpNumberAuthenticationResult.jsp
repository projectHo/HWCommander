<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
<title>현우의 컴퓨터 공방 - nice aip 결과</title>
<!-- Required meta tags -->
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<script>
$(function() {
	if("0000" == "${resultcode}") {
		/* 
		$("#name", opener.document).val("${name}");
		$("#name", opener.document).prop('readonly', true);
		 */
		 
		$("#birth", opener.document).val("${birthdate}");
		$("#birth", opener.document).prop('readonly', true);
		 
		if("1" == "${gender}") {
			$("#sexCd1", opener.document).prop("checked", true);
		}else {
			$("#sexCd2", opener.document).prop("checked", true);
		}
		
		$("#sexCd1", opener.document).attr("onclick", "return false;");
		$("#sexCd2", opener.document).attr("onclick", "return false;");
		
		$("#hpNumber", opener.document).val("${mobileno}");
		$("#hpNumber", opener.document).prop('readonly', true);
		
		$("#di", opener.document).val("${di}");
		
		alert("정상인증되어 회원가입 정보에 반영합니다. \n반영된 정보는 수정할 수 없습니다.");
		parent.close();
	}else {
		alert("인증오류입니다. \n관리자에게 문의하세요.");
		parent.close();
	}
});
</script>
</head>
<body>
</body>
</html>
