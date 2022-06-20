<%--
    Document   : Login
    Created on : 29 May 2022, 11:40:42 pm
    Author     : ASUS
--%>

<%@include file="./../../partials/_default.jsp"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${sessionScope.isLoggedIn}">
    <c:redirect url="${request.getContextPath()}/Home"/>
</c:if>

<body>
    <div class="hero min-h-screen bg-base-200 ">
        <div class="hero-content flex-col w-[80%] lg:flex-row-reverse">
            <div class="flex flex-col justify-center items-center gap-10 text-center lg:text-left lg:items-start lg:ml-4">
                <%                if (request.getParameter("errMsg") != null) {
                %>
                <div class="alert alert-error shadow-lg relative top-0 w-2/3 md:w-full">
                    <div>
                        <i class="ph-warning-bold"></i>
                        <span><%= request.getParameter("errMsg")%></span>
                    </div>
                </div>
                <%}%>
                <div>
                    <h1 class="text-5xl font-bold">Sign in</h1>
                </div>
            </div>
            <form action="<%= request.getContextPath()%>/LoginProcess" method="POST" class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
                <%                Map<String, Map<String, String>> formContent = new LinkedHashMap<>();
                    formContent.put("Email", new HashMap() {
                        {
                            put("name", "email");
                            put("type", "email");
                            put("placeholder", "Email");
                            put("class", "input input-bordered");
                            put("required", "");
                        }
                    });
                    formContent.put("Password", new HashMap() {
                        {
                            put("name", "password");
                            put("type", "password");
                            put("placeholder", "Password");
                            put("class", "input input-bordered");
                            put("required", "");
                        }
                    });
                %>
                <div class="card-body">
                    <%                    for (Map.Entry<String, Map<String, String>> content
                                : formContent.entrySet()) {
                    %>
                    <label class="label">
                        <span class="label-text">
                            <%= content.getKey()%>
                        </span>
                    </label>
                    <input
                        <%
                            for (Map.Entry<String, String> types : content.getValue().entrySet()) {

                        %>
                        <%= types.getKey() + "='" + types.getValue() + "' "%>
                        <%
                            }
                        %>
                        required>
                    <%
                        }
                    %>
                    <div class="form-control mt-6">
                        <button class="btn btn-primary mt-4">Login</button>
                        <input type="hidden" name="command" value="RETRIEVE"/>
                    </div>
                    <span class="mx-auto mt-6">Don't have an account? <a class='link' href='<%=request.getContextPath()%>/Register'>Create</a></span>
                </div>
            </form>
        </div>
    </div>
</body>
