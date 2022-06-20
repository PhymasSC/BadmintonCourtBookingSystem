<%--
    Document   : Court
    Created on : Jun 18, 2022, 5:59:37 PM
    Author     : garyl
--%>

<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page language="java"%>
<%@include file="./../partials/_db_connection.jsp"%>

<sql:query dataSource="${database}" var="court_detail">
    SELECT c.id court_id, name, state, city, latitude, longitude, opening_hour, closed_hour, price_in_cent_per_hour FROM court c
    JOIN court_availability ca
    ON c.id = ca.court_id
    JOIN court_image ci
    ON ci.court_id = c.id
    WHERE c.id= ?
    GROUP BY available_day;
    <sql:param value="${param.id}"/>
</sql:query>

<c:redirect url="${request.getContextPath()}/Court/${param.id}">
    <c:set scope="application" var="court_detail" value="${court_detail}"/>
    <c:set scope="session" var="book_location" value="${param.id}"/>
</c:redirect>
