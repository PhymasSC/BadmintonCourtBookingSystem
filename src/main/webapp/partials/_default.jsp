<%--
    Document   : _default
    Created on : 27 May 2022, 23:06:57
    Author     : SC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:if test="${sessionScope.user != null}">
    <c:set value="${sessionScope.user.username}" var="user_name"/>
</c:if>

<%
    // Configure title of each sites
    String __pathName = request.getRequestURL().toString();
    String __restURL = __pathName.substring(0, __pathName.lastIndexOf("/"));
    String __domain, __fileName = "";
    if (__restURL.substring(__restURL.lastIndexOf("/") + 1).contains(".")) {
        __restURL = __restURL.substring(0, __restURL.lastIndexOf("/"));
    }
    __domain = "BadmintonPal";
    if (__pathName.substring(__pathName.lastIndexOf("/") + 1) != "" || __pathName.substring(__pathName.lastIndexOf("/") + 1) != null) {
        __fileName = __pathName.substring(__pathName.lastIndexOf("/") + 1);
    }

    String __title = (__domain.equals("User")
            ? pageContext.getAttribute("user_name").toString()
            : __fileName == ""
                    ? __domain
                    : __fileName) + " | " + __domain;
%>


<!DOCTYPE html>
<html data-theme="light" class="scroll-smooth transition-all duration-100">
    <head>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@2.15.1/dist/full.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.tailwindcss.com" defer></script>
        <script src="https://unpkg.com/phosphor-icons" defer></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/6.4.4/css/flag-icons.min.css" integrity="sha512-uvXdJud8WaOlQFjlz9B15Yy2Au/bMAvz79F7Xa6OakCl2jvQPdHD0hb3dEqZRdSwG4/sknePXlE7GiarwA/9Wg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>
        <title>
            <%= __title%>
        </title>
        <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 120 100%22><text y=%22.9em%22 font-size=%2290%22>&#127992;</text></svg>">
        <script src='https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.js'></script>
        <link href='https://api.mapbox.com/mapbox-gl-js/v2.8.1/mapbox-gl.css' rel='stylesheet' />
        <link
            rel="stylesheet"
            href="https://unpkg.com/swiper@8/swiper-bundle.min.css"
            />
        <script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>

        <style>
            .swiper {
                width: 100%;
                height: 100%;
            }

            .swiper-slide {
                text-align: center;
                font-size: 18px;
                background: #fff;

                /* Center slide text vertically */
                display: -webkit-box;
                display: -ms-flexbox;
                display: -webkit-flex;
                display: flex;
                -webkit-box-pack: center;
                -ms-flex-pack: center;
                -webkit-justify-content: center;
                justify-content: center;
                -webkit-box-align: center;
                -ms-flex-align: center;
                -webkit-align-items: center;
                align-items: center;
            }

            .swiper-slide img {
                display: block;
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <%@include file="./_navbar.jsp"%>
    </body>

    <script>
        const submit = (element) => {
            document.querySelector(element || "#submitBtn").submit();
        };
    </script>
</html>
