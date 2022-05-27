<%-- 
    Document   : Profile
    Created on : 28 May 2022, 01:08:13
    Author     : SC
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <title><c:out value="${param.username}"/></title>
    </head>
    <body>
        <%@include file="./partials/_navbar.jsp"%>

    </body>
</html>
