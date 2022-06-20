<%--
    Document   : BookingDeletion
    Created on : Jun 20, 2022, 9:48:05 AM
    Author     : garyl
--%>

<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file="./../partials/_db_connection.jsp"%>

<sql:update dataSource="${database}" var="del_from_details">
    DELETE FROM booking_details WHERE booking_id = ?;
    <sql:param value="${param.id}"/>
</sql:update>

<sql:update dataSource="${database}" var="del_from_glue">
    DELETE FROM booking WHERE id = ?;
    <sql:param value="${param.id}"/>
</sql:update>

<c:redirect url="${request.getContextPath()}/User/${sessionScope.user.id}"/>

