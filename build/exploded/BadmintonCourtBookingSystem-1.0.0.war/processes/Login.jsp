<%--
    Document   : login
    Created on : 29 May 2022, 11:52:54 pm
    Author     : ASUS
--%>

<%@page import="at.favre.lib.crypto.bcrypt.BCrypt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page language="java"%>
<%@include file="./../partials/_db_connection.jsp"%>

<sql:query dataSource="${database}" var="users">
    SELECT * FROM client WHERE email_address = "<%= request.getParameter("email")%>"
</sql:query>

<c:set var="hashedPasswordFromDatabase" value="${users.rows[0].password}"/>
<c:set var="passwordFromForm" value="${param.password}"/>


<c:choose>
    <c:when test="${ users.rowCount != 0 }">
        <%
            boolean isVerified = BCrypt.verifyer().verify(
                    pageContext.getAttribute("passwordFromForm").toString().toCharArray(),
                    pageContext.getAttribute("hashedPasswordFromDatabase").toString()
            ).verified;
        %>
        <c:if test="<%= isVerified%>">
            <c:redirect url="${request.getContextPath()}/">
                <c:set scope="session" var="user" value="${users.rows[0]}"/>
                <c:set scope="session" var="isLoggedIn" value="true"/>
            </c:redirect>
        </c:if>
        <c:if test="<%= !isVerified%>">
            <c:redirect url="${request.getContextPath()}/Login">
                <c:param name="errMsg" value="Invalid email or password."/>
            </c:redirect>
        </c:if>
    </c:when>
    <c:otherwise>
        <c:redirect url="${request.getContextPath()}/Login">
            <c:param name="errMsg" value="Invalid email or password."/>
        </c:redirect>
    </c:otherwise>
</c:choose>