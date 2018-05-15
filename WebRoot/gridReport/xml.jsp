<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file = "GenXmlData.jsp" %>
<%
System.out.println(123);
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
String QuerySQL = new String(request.getParameter("QuerySQL").getBytes("ISO-8859-1"),"UTF-8");
System.out.println(QuerySQL);
XML_GenOneRecordset(response, QuerySQL);
%>