<%--
    Document   : Error-404
    Created on : Jun 10, 2022, 2:18:42 AM
    Author     : garyl
--%>

<%@include file="./../../partials/_default.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isErrorPage="true" %>

<section class="relative py-24 overflow-hidden">
    <div class="container px-4 mx-auto relative">
        <div class="max-w-sm md:max-w-xl mx-auto relative z-10">
            <h3 class="text-4xl lg:text-5xl font-heading mb-12 text-indigo-200">Error 404</h3>
            <h4 class="text-4xl lg:text-5xl font-heading mb-12">Sorry, we can&apos;t find that page or something has gone wrong...</h4>
            <a class="btn" href="<%= request.getContextPath()%>/Home">Go back to Homepage</a>
        </div>
    </div>
</section>
