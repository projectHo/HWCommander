<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<script>
	alert("${msg}");
	location.href='<c:out value="${pageContext.request.contextPath}"/>${url}';
</script>
<head>
<title>redirect</title>
<!-- Required meta tags -->
<meta charset="utf-8">
</head>
<body>
</body>
</html>
