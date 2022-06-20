<%--
    Document   : CourtSearching
    Created on : Jun 13, 2022, 2:42:53 PM
    Author     : garyl
--%>

<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page language="java"%>
<%@include file="./../partials/_db_connection.jsp"%>


<sql:query dataSource="${database}" var="courts">
    SELECT * FROM court c
    JOIN court_availability ca
    ON c.id = ca.court_id
    JOIN court_image ci
    ON ci.court_id = c.id
    WHERE
    <c:if test="${!param.court_location.equals('all')}">
        city = ?
        AND
        <sql:param value="${param.court_location}"/>
    </c:if>
    available_day = DAYNAME(?)
    AND opening_hour < ?
    AND closed_hour > ADDTIME(?, ?)
    GROUP BY (c.id)
    <sql:param value="${param.book_date}"/>
    <sql:param value="${param.book_time}"/>
    <sql:param value="${param.book_time}"/>
    <sql:param value="${param.book_duration}"/>
</sql:query>

<c:redirect url="${request.getContextPath()}/Courts">
    <c:set scope="application" var="courts_list" value="${courts}"/>
    <c:set scope="session" var="book_date" value="${param.book_date}"/>
    <c:set scope="session" var="book_time" value="${param.book_time}"/>
    <c:set scope="session" var="book_duration" value="${param.book_duration}"/>
</c:redirect>