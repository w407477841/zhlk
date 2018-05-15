<%@ page language="java" import="java.util.*" pageEncoding="utf-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
  <body>
   	<center> <h1><font color="red"> 出错啦！！！</font></h1></center>
    <c:if test="${error!=null}">
    ${error}
    </c:if>
 
  </body>
</html>
