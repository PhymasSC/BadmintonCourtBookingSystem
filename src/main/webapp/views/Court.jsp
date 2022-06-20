<%--
    Document   : Court
    Created on : Jun 13, 2022, 4:24:29 PM
    Author     : garyl
--%>

<%@page import="javax.servlet.jsp.PageContext"%>
<%@page import="java.util.Enumeration"%>
<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@include file="./../../partials/_default.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="./../partials/_db_connection.jsp"%>

<sql:query dataSource="${database}" var="court_images">
    SELECT img
    FROM court_image
    WHERE court_id= ?
    <sql:param value="${ sessionScope.book_location }"/>
</sql:query>

<sql:query dataSource="${database}" var="court_availability">
    SELECT available_day,
    LOWER(TIME_FORMAT(opening_hour, "%r")) opening_hour,
    LOWER(TIME_FORMAT(closed_hour, "%r")) closed_hour,
    price_in_cent_per_hour / 100 AS price
    FROM court_availability
    WHERE court_id = ?;
    <sql:param value="${ sessionScope.book_location }"/>
</sql:query>

<c:set var="latitude" value="${applicationScope.court_detail.rows[0].latitude}"/>
<c:set var="longitude" value="${applicationScope.court_detail.rows[0].longitude}"/>

<fmt:setLocale value="en_MY"/>

<main>
    <section class="flex flex-col justify-center items-center h-screen bg-base-200">

        <div class="flex justify-center w-[80%] h-[80%] swiper mySwiper">
            <div class="swiper-wrapper">
                <c:forEach var="__images__" items="${court_images.rows}" varStatus="loop">
                    <c:set var="__current_image__" value="${__images__.img}"/>
                    <%    String courtImage = null;
                        if (pageContext.getAttribute("court_images") != null) {
                            byte[] content = (byte[]) pageContext.getAttribute("__current_image__");
                            String base64Encoded = new String(Base64.encodeBase64(content), "UTF-8");
                            request.setAttribute("coverImg", base64Encoded);
                        }
                    %>
                    <div class="swiper-slide">
                        <img src="data:image/png;base64,${requestScope['coverImg']}" alt="${__details__.court_name}" class="w-full rounded-xl" />
                    </div>
                </c:forEach>
            </div>
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-pagination"></div>
        </div>

    </section>

    <section class=" stats shadow flex flex-col justify-center items-center h-screen bg-base-200">
        <div class="w-[80%] bg-base-100 rounded-xl p-10">

            <div class="stat">
                <div class="stat-title">Name</div>
                <div class="stat-value text-primary"><c:out value="${applicationScope.court_detail.rows[0].name}"/></div>
            </div>

            <div class="stat">
                <div class="stat-figure text-primary">
                    <i class="ph-clock-clockwise ph-2x"></i>
                </div>
                <div class="stat-title">Opening Hours: Pricing</div>
                <c:forEach var="__availability__" items="${court_availability.rows}" varStatus="loop">
                    <div class="stat-value text-primary"><c:out value="${__availability__.available_day}: ${__availability__.opening_hour} - ${__availability__.closed_hour}"/>: <fmt:formatNumber value="${__availability__.price}" type="currency"/></div>
                </c:forEach>
            </div>

    </section>

    <section class="flex justify-center items-center h-screen bg-base-200">
        <div class="w-[80%] h-[80%] text-center">
            <h1 class="text-5xl font-bold">Location</h1>
            <div class="mt-6 w-full h-full flex justify-center items-center">
                <div id="map" class="rounded-lg mapboxgl-map" style="width: 100vw;height:70vh;"></div>
            </div>
        </div>

        <script>
            const ACCESS_TOKEN = 'pk.eyJ1Ijoia29ob2dhIiwiYSI6ImNsNGNldGtiNDF2OHEzZHIzaThld3ZuZDMifQ.eOcNdv6tvk1Qy-Z4D0BwNA';
            mapboxgl.accessToken = ACCESS_TOKEN;
            var map = new mapboxgl.Map({
                container: 'map',
                style: 'mapbox://styles/mapbox/satellite-streets-v11',
                center: [<%= pageContext.getAttribute("latitude")%>, <%= pageContext.getAttribute("longitude")%>],
                zoom: 15
            });

            const nav = new mapboxgl.NavigationControl();
            map.addControl(nav);

            const marker = new mapboxgl.Marker()
                    .setLngLat([<%= pageContext.getAttribute("latitude")%>, <%= pageContext.getAttribute("longitude")%>])
                    .addTo(map);


            <%-- Initialize Swiper --%>
            var swiper = new Swiper(".mySwiper", {
                spaceBetween: 30,
                centeredSlides: true,
                autoplay: {
                    delay: 2500,
                    disableOnInteraction: false
                },
                pagination: {
                    el: ".swiper-pagination",
                    clickable: true
                },
                navigation: {
                    nextEl: ".swiper-button-next",
                    prevEl: ".swiper-button-prev"
                }
            });
        </script>
    </section>
</main>

