<%--
    Document   : _navbar
    Created on : 27 May 2022, 23:21:05
    Author     : SC
--%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.nio.charset.StandardCharsets"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="imageString" value="${sessionScope.user.profile_pic }"/>

<%
    if (pageContext.getAttribute("imageString") != null) {
        byte[] content = (byte[]) pageContext.getAttribute("imageString");
        String base64Encoded = new String(Base64.encodeBase64(content), "UTF-8");
        request.setAttribute("imageBt", base64Encoded);
    }
%>
<div class="z-50 navbar fixed top-0 bg-opacity-50 backdrop-filter backdrop-blur-md">
    <div class="flex-1">
        <a href="<%= request.getContextPath()%>/" class="btn btn-ghost normal-case text-primary text-xl !font-bold hidden md:flex">&#127992;BadmintonPal</a>
        <a href="<%= request.getContextPath()%>/" class="btn btn-ghost normal-case text-primary text-xl !font-bold md:hidden">&#127992;BP</a>
    </div>
    <div class="flex-none gap-2">
        <%
            if (request.getSession().getAttribute("isLoggedIn") != null && request.getSession().getAttribute("isLoggedIn").toString().equals("true")) {
        %>
        <div class="form-control">
            <div class="input-group">
                <input type="text" placeholder="Search" class="input input-bordered" />
                <button class="btn btn-square">
                    <i class="ph-magnifying-glass"></i>
                </button>
            </div>
        </div>
        <%
            }
        %>
        <label class="swap swap-rotate mx-4">

            <!-- this hidden checkbox controls the state -->
            <input type="checkbox" />

            <!-- sun icon -->
            <span class="ph-sun-bold swap-on fill-current text-[1.5em]" onclick="swapTheme()"></span>

            <!-- moon icon -->
            <span class="ph-moon-bold swap-off fill-current text-[1.5em]" onclick="swapTheme()"></span>


        </label>
        <div class="dropdown dropdown-end">
            <%
                if (request.getSession().getAttribute("isLoggedIn") == null || request.getSession().getAttribute("isLoggedIn").toString().equals("false")) {
            %>
            <label tabindex="0" class="btn btn-ghost rounded-btn">Get Started</label>
            <ul tabindex="0" class="menu dropdown-content p-2 shadow bg-base-100 rounded-box w-52 mt-4">
                <li><a href="<%= request.getContextPath()%>/Login">Log in</a></li>
                <li><a href="<%= request.getContextPath()%>/Register">Register</a></li>
            </ul>
            <%
            } else {
            %>

            <label tabindex="0" class="w-10 h-10 avatar placeholder">
                <c:choose>
                    <c:when test="${requestScope['imageBt'] != null}">
                        <img class="avatar rounded-full cursor-pointer" src="data:image/png;base64,${requestScope['imageBt']}"/>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-neutral-focus text-neutral-content rounded-full w-10 cursor-pointer ml-4">
                            <span class="text-xs"><c:out value="${sessionScope.user.first_name }"/></span>
                        </div>
                    </c:otherwise>
                </c:choose>
            </label>

            <ul tabindex="0" class="menu menu-compact dropdown-content mt-3 p-2 shadow bg-base-100 rounded-box w-52">

                <li><a href="<%=request.getContextPath()%>/User/<c:out value="${sessionScope.user.id}"/>">Profile</a></li>
                <li><a href="<%=request.getContextPath()%>/User/<c:out value="${sessionScope.user.id}"/>?logout">Logout</a></li>
            </ul>
            <%
                }
            %>
        </div>
    </div>
</div>

<script>
    const htmlDOM = document.querySelector("html");
    let currentTheme = localStorage.getItem("theme") || "dracula";
    let sun = document.querySelector(".ph-sun-bold");
    let moon = document.querySelector(".ph-moon-bold");

    function swapTheme() {
        const newTheme = htmlDOM.getAttribute("data-theme") === "light" ? "dracula" : "light";
        htmlDOM.setAttribute("data-theme", newTheme);
        localStorage.setItem("theme", newTheme)
    }

    if (currentTheme === "dracula") {
        sun.classList.add("swap-off");
        sun.classList.remove("swap-on");
        moon.classList.add("swap-on");
        moon.classList.remove("swap-off");
        swapTheme();
    }
</script>
