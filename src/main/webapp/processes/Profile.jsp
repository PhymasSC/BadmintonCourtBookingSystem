<%--
    Document   : Profile
    Created on : Jun 10, 2022, 3:59:08 PM
    Author     : garyl
--%>

<%@page import="java.io.InputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="at.favre.lib.crypto.bcrypt.BCrypt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file="./../partials/_db_connection.jsp"%>

<sql:query dataSource="${database}" var="users">
    SELECT * FROM client WHERE id = ?;
    <sql:param value="${sessionScope.user.id}"/>
</sql:query>

<%
    if (request.getPart("profile_pic") != null && request.getPart("profile_pic").getSize() > 0) {
        Part filePart = request.getPart("profile_pic");
        InputStream image = filePart.getInputStream();

        request.setAttribute("profilePicture", image);
    }
    if (request.getPart("cover_photo") != null && request.getPart("cover_photo").getSize() > 0) {
        Part filePart = request.getPart("cover_photo");
        InputStream image = filePart.getInputStream();

        request.setAttribute("coverPhoto", image);
    }
%>


<c:choose>
    <c:when test="${users.rowCount == 0}">
        <c:redirect url="${request.getContextPath()}/User/${sessionScope.user.id}">
            <c:param name="errMsg" value="There are some problems with the updation. Please try again."/>
        </c:redirect>
    </c:when>
    <c:otherwise>
        <sql:update dataSource="${database}" var="user">
            UPDATE client
            SET first_name = "<%= request.getParameter("firstName")%>",
            last_name = "<%= request.getParameter("lastName")%>",
            username = "<%= request.getParameter("username")%>",
            phone_number = "<%= request.getParameter("phoneNo")%>",
            email_address = "<%= request.getParameter("email")%>"
            <c:if test="${!param.newPass.equals('')}">
                ,
                password = "<%= BCrypt.withDefaults().hashToString(12, request.getParameter("newPass").toCharArray())%>"
            </c:if>
            <c:if test="${ profilePicture != null }">
                ,
                profile_pic = ?
                <sql:param value="${profilePicture}"/>
            </c:if>
            <c:if test="${ coverPhoto != null }">
                ,
                cover_photo = ?
                <sql:param value="${coverPhoto}"/>
            </c:if>

            WHERE id = "${sessionScope.user.id}"
        </sql:update>

        <sql:query dataSource="${database}" var="result">
            SELECT * FROM client WHERE id = "${sessionScope.user.id}";
        </sql:query>

        <c:redirect url="${request.getContextPath()}/User/${sessionScope.user.id}">
            <c:set scope="session" var="user" value="${result.rows[0]}"/>
            <c:param name="successMsg" value="Information has been updated!"/>
        </c:redirect>
    </c:otherwise>
</c:choose>
