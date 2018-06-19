<%@ page contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page isErrorPage="true" %>

<html>
<head>
<title>Error page</title>
<style>
    * { font-size: 12px; font-family: Verdana }
</style>
</head>
<body>
<h2>Error occured!</h2>
<% StringWriter sw = new StringWriter();
   PrintWriter pw = new PrintWriter(sw);
   exception.printStackTrace(pw);
%>
<P>Exception Name: <b><%= exception.getClass().getName() %></b></P>
<p>Error Message: <%= exception.getMessage() %></P>
<P>Developer Information: <pre> <%= sw %> </pre></P>
</body>
</html>
