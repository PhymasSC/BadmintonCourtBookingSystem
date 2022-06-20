<%--
    Document   : Error-403
    Created on : Jun 10, 2022, 2:28:50 AM
    Author     : garyl
--%>

<%@include file="./../../partials/_default.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isErrorPage="true" %>

<section class="relative py-24 overflow-hidden">
    <div class="container px-4 mx-auto relative">
        <div class="max-w-sm md:max-w-xl mx-auto relative z-10">
            <h3 class="text-4xl lg:text-5xl font-heading mb-12 text-indigo-200">Error 403</h3>
            <h4 class="text-4xl lg:text-5xl font-heading mb-12">We are sorry, but you do not have permission to access to this page or resource.</h4>
            <a class="btn" href="<%= request.getContextPath()%>/Home">Go back to Homepage</a>
        </div>
    </div>
</section>
