<%--
    Document   : Booking
    Created on : Jun 13, 2022, 10:57:56 AM
    Author     : garyl
--%>

<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file="./../partials/_db_connection.jsp"%>

<sql:update dataSource="${database}" var="court_detail">
    INSERT booking(client_id, court_id) VALUES(?, ?);
    <sql:param value="${sessionScope.user.id}"/>
    <sql:param value="${param.id}"/>
</sql:update>

<sql:query dataSource="${database}" var="new_booking_id">
    SELECT id FROM booking
    WHERE client_id = ? AND court_id = ?;
    <sql:param value="${sessionScope.user.id}"/>
    <sql:param value="${param.id}"/>
</sql:query>

<sql:update dataSource="${database}" var="court_detail">
    INSERT booking_details(date, time, duration, booking_id, price_in_cents)
    VALUES (?, ?, ?, ?, ?);
    <sql:param value="${sessionScope.book_date}"/>
    <sql:param value="${sessionScope.book_time}"/>
    <sql:param value="${sessionScope.book_duration}"/>
    <sql:param value="${new_booking_id.rows[0].id}"/>
    <sql:param value="${param.price}"/>
</sql:update>

<c:redirect url="${request.getContextPath()}/Courts"/>