<%--
    Document   : _db_connection
    Created on : Jun 18, 2022, 10:24:40 PM
    Author     : garyl
--%>

<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="database" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3306/table" user="root" password="admin"/>