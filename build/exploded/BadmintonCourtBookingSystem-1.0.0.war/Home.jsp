<%-- 
    Document   : Home
    Created on : 27 May 2022, 22:46:57
    Author     : SC
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<%@include file="./partials/_default.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<main>
    <%@include file="./partials/_navbar.jsp"%>
    <p class="text-[99em]">
        <%                int[] a = {1, 2, 3, 4};

            for (int val : a) {
                out.println(val);
            }
        %>
    </p>
</main>