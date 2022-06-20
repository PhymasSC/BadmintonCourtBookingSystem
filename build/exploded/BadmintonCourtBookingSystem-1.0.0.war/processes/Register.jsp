<%--
    Document   : Register
    Created on : 29 May 2022, 11:48:49 pm
    Author     : ASUS
--%>

<%@page import="at.favre.lib.crypto.bcrypt.BCrypt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java"%>
<%@include file="./../partials/_db_connection.jsp"%>


<sql:query dataSource="${database}" var="users">
    SELECT * FROM client WHERE email_address = "<%= request.getParameter("email")%>";
</sql:query>

<c:choose>
    <c:when test="${users.rowCount != 0}">
        <c:redirect url="${request.getContextPath()}/Register">
            <c:param value="Email address already registered!" name="errMsg"/>
        </c:redirect>
    </c:when>
    <c:otherwise>
        <sql:update var="user" dataSource="${database}">

            INSERT INTO client (first_name, last_name, username, phone_number, email_address, password)
            VALUES (
            "<%= request.getParameter("first_name")%>",
            "<%= request.getParameter("last_name")%>",
            "<%= request.getParameter("username")%>",
            "<%= request.getParameter("phone")%>",
            "<%= request.getParameter("email")%>",
            "<%= BCrypt.withDefaults().hashToString(12, request.getParameter("password").toCharArray())%>"
            )
        </sql:update>

        <c:redirect url="${request.getContextPath()}/Login" />
    </c:otherwise>
</c:choose>