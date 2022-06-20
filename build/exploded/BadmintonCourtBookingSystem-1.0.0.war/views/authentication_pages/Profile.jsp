<%--
    Document   : Profile
    Created on : 28 May 2022, 01:08:13
    Author     : SC
--%>

<%@page import="org.apache.commons.codec.binary.Base64"%>
<%
    String pathName = request.getRequestURI();
    String userIdFromPath = pathName.substring(pathName.lastIndexOf('/') + 1);
    request.setAttribute("userIdFromPath", userIdFromPath);
%>


<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="./../../partials/_default.jsp"%>
<%@ page errorPage="${request.getContextPath()}/Error-403.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="./../../partials/_db_connection.jsp"%>

<c:set var="imageString" value="${sessionScope.user.profile_pic }"/>
<c:set var="coverPhotoString" value="${sessionScope.user.cover_photo }"/>

<fmt:setLocale value="en_MY"/>
<%    String coverImageBt = null;
    if (pageContext.getAttribute("imageString") != null) {
        byte[] content = (byte[]) pageContext.getAttribute("imageString");
        String base64Encoded = new String(Base64.encodeBase64(content), "UTF-8");
        request.setAttribute("imageBt", base64Encoded);
    }
    if (pageContext.getAttribute("coverPhotoString") != null) {
        byte[] content = (byte[]) pageContext.getAttribute("coverPhotoString");
        String base64Encoded = new String(Base64.encodeBase64(content), "UTF-8");
        request.setAttribute("coverImageBt", base64Encoded);
        coverImageBt = base64Encoded;
    }
%>

<c:choose>
    <c:when test="${param.logout != null}">
        <% session.invalidate(); %>
        <c:redirect url="${request.getContextPath()}/Login"/>
    </c:when>
    <c:when test="${!sessionScope.isLoggedIn}">
        <c:redirect url="${request.getContextPath()}/Login"/>
    </c:when>
    <c:when test="${!sessionScope.user.id.equals(userIdFromPath)}">
        <% response.sendError(403);%>
    </c:when>
</c:choose>

<sql:query dataSource="${database}" var="booking_history">
    SELECT
    b.id id,
    c.name name,
    img,
    price_in_cents / 100 price,
    date,
    LOWER(TIME_FORMAT(time, "%r")) time,
    LOWER(TIME_FORMAT(duration, "%h.%i hours")) duration,
    state,
    city
    FROM booking b
    JOIN booking_details bd
    ON bd.booking_id = b.id
    JOIN court_image ci
    ON b.court_id =  ci.court_id
    JOIN court c
    ON c.id = b.court_id
    WHERE client_id = ?
    GROUP BY b.id;
    <sql:param value="${ sessionScope.user.id }"/>
</sql:query>

<head>
    <script src="<%=request.getContextPath()%>/utility/PhoneFormatter.js" defer></script>
</head>

<body>
    <form action="<%=request.getContextPath()%>/UserProcess" method="POST" enctype="multipart/form-data" x-data="{ mode: 'viewer'}">
        <div class="mt-4 flex flex-col justify-center items-center">

            <div class="indicator w-[80%]">
                <div class="indicator-item indicator-bottom" x-show="mode === 'editor'">
                    <input type="file" id="cover_photo" name="cover_photo" accept="image/*" hidden>
                    <div class="btn btn-circle btn-primary cursor-pointer" onclick="document.querySelector('#cover_photo').click()">
                        <i class="ph-pencil-simple"></i>
                    </div>
                </div>

                <%
                    if (coverImageBt != null) {
                        System.out.println("found");
                %>
                <div class="flex justify-around items-center bg-[url(data:image/png;base64,${requestScope['coverImageBt']})] gradient-to-r from-indigo-500 via-purple-500 to-pink-500 bg-center bg-cover bg-no-repeat rounded-md artboard artboard-horizontal h-[50vh]">
                    <%
                    } else {
                        System.out.println("not found");
                    %>
                    <div class="flex justify-around items-center bg-gradient-to-r from-indigo-500 via-purple-500 to-pink-500 bg-center bg-cover bg-no-repeat rounded-md artboard artboard-horizontal h-[50vh]">

                        <%
                            }
                        %>

                        <div class="flex flex-col justify-start items-center h-[80%]">
                            <div class="mt-12 flex flex-col justify-center items-center w-full relative top-[12rem]">
                                <div class="indicator">
                                    <div class="indicator-item indicator-bottom" x-show="mode === 'editor'">
                                        <input type="file" id="profile_pic" name="profile_pic" accept="image/*" hidden>
                                        <div class="btn btn-circle btn-primary cursor-pointer" onclick="document.querySelector('#profile_pic').click()">
                                            <i class="ph-pencil-simple"></i>
                                        </div>
                                    </div>
                                    <c:choose>
                                        <c:when test="${requestScope['imageBt'] != null}">
                                            <img class="w-36 h-36 avatar rounded-full" src="data:image/png;base64,${requestScope['imageBt']}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="avatar rounded-full bg-neutral-focus text-neutral-content w-36">
                                                <span class="text-3xl"><c:out value="${sessionScope.user.first_name}"/></span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex justify-center w-[80%] mt-[8rem]">
                    <div x-data="{ activeTab: 0 }" id="tab_wrapper" class="flex flex-col w-full">
                        <!-- The tabs navigation -->
                        <div class="tabs">
                            <label
                                @click="activeTab = 0"
                                class="text-lg w-1/2 tab tab-bordered"
                                :class="{ 'tab-active': activeTab === 0 }"
                                >Personal information</label>
                            <label
                                @click="activeTab = 1"
                                class="text-lg w-1/2 tab tab-bordered"
                                :class="{ 'tab-active': activeTab === 1 }"
                                >Bookings History</label>

                        </div>

                        <!-- The tabs content -->
                        <div class="stats stats-vertical shadow" >
                            <div class="stats stats-vertical shadow" x-show.transition.in.opacity.duration.600="activeTab === 0">
                                <div class="stat">
                                    <div class="stat-title">Account id</div>
                                    <!-- Viewer mode -->
                                    <div class="stat-value" x-show="mode === 'viewer'"><c:out value="${sessionScope.user.id}"/></div>
                                    <!-- Editor mode -->
                                    <div class="stat-value" x-show="mode === 'editor'">
                                        <input type="text" name="userId" placeholder="${sessionScope.user.id}" value="${sessionScope.user.id}" class="text-[2.25rem] input input-ghost w-full" disabled required/>
                                    </div>
                                </div>

                                <div class="stat">
                                    <div class="stat-title">First name</div>
                                    <!-- Viewer mode -->
                                    <div class="stat-value" x-show="mode === 'viewer'"><c:out value="${sessionScope.user.first_name}"/></div>
                                    <!-- Editor mode -->
                                    <div class="stat-value" x-show="mode === 'editor'">
                                        <input type="text" name="firstName" placeholder="First name" value="${sessionScope.user.first_name}" class="text-[2.25rem] input input-ghost w-full" required/>
                                    </div>

                                </div>

                                <div class="stat">
                                    <div class="stat-title">Last name</div>
                                    <!-- Viewer mode -->
                                    <div class="stat-value" x-show="mode === 'viewer'"><c:out value="${sessionScope.user.last_name}"/></div>
                                    <!-- Editor mode -->
                                    <div class="stat-value" x-show="mode === 'editor'">
                                        <input type="text" name="lastName" placeholder="Last name" value="${sessionScope.user.last_name}" class="text-[2.25rem] input input-ghost w-full" required/>
                                    </div>
                                </div>

                                <div class="stat">
                                    <div class="stat-title">Username</div>
                                    <!-- Viewer mode -->
                                    <div class="stat-value" x-show="mode === 'viewer'"><c:out value="${sessionScope.user.username}"/></div>
                                    <!-- Editor mode -->
                                    <div class="stat-value" x-show="mode === 'editor'">
                                        <input type="text" name="username" placeholder="Username" value="${sessionScope.user.username}" class="text-[2.25rem] input input-ghost w-full" required/>
                                    </div>
                                </div>

                                <div class="stat">
                                    <div class="stat-title">Email address</div>
                                    <!-- Viewer mode -->
                                    <div class="stat-value" x-show="mode === 'viewer'"><c:out value="${sessionScope.user.email_address}"/></div>
                                    <!-- Editor mode -->
                                    <div class="stat-value" x-show="mode === 'editor'">
                                        <input type="email" name="email" placeholder="Email address" value="${sessionScope.user.email_address}" class="text-[2.25rem] input input-ghost w-full" required/>
                                    </div>
                                </div>

                                <div class="stat">
                                    <div class="stat-title">Phone number</div>
                                    <!-- Viewer mode -->
                                    <div class="stat-value" x-show="mode === 'viewer'"><c:out value="${sessionScope.user.phone_number}"/></div>
                                    <!-- Editor mode -->
                                    <div class="stat-value" x-show="mode === 'editor'">
                                        <input type="tel" id="phone" name="phoneNo" placeholder="Phone number" value="${sessionScope.user.phone_number}" class="text-[2.25rem] input input-ghost w-full" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" required/>
                                    </div>
                                </div>

                                <%-- Only available in editor mode --%>
                                <div class="stat "x-show="mode === 'editor'">
                                    <div class="stat-title">Current password</div>
                                    <div class="stat-value">
                                        <input type="password" name="oldPass" placeholder="•••••••••" class="text-[2.25rem] input input-ghost w-full" required/>
                                    </div>
                                </div>

                                <div class="stat" x-show="mode === 'editor'">
                                    <div class="stat-title">New password (Leave blank if not changing)</div>
                                    <div class="stat-value">
                                        <input type="password" name="newPass" placeholder="•••••••••" class="text-[2.25rem] input input-ghost w-full" />
                                    </div>
                                </div>

                                <div class="stat" x-show="mode === 'editor'">
                                    <div class="stat-title">New password confirmation (Leave blank if not changing)</div>
                                    <div class="stat-value">
                                        <input type="password" name="newPassConfirm" placeholder="•••••••••" class="text-[2.25rem] input input-ghost w-full" />
                                    </div>
                                </div>
                                <%-- --------------------- --%>

                                <div class="btn flex items-center gap-2 mt-6" @click=" mode = 'editor'"  x-show="mode === 'viewer'">
                                    <i class="ph-pencil-simple"></i>
                                    Edit
                                </div>
                                <div class="flex justify-around w-full gap-6 mt-6">
                                    <button class="btn flex items-center gap-2 w-[45%]" x-show="mode === 'editor'">
                                        <i class="ph-pencil-simple"></i>
                                        Update
                                    </button>
                                    <div class="btn flex items-center gap-2 w-[45%]" @click=" mode = 'viewer'"  x-show="mode === 'editor'">
                                        <i class="ph-x"></i>
                                        Cancel
                                    </div>
                                </div>
                                </form>
                            </div>
                            <div class="stats stats-vertical shadow" x-show.transition.in.opacity.duration.600="activeTab === 1">

                                <c:choose>
                                    <c:when test="${booking_history.rowCount == 0}">
                                        <p>No booking history</p>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="__history_details__" items="${booking_history.rows}">
                                            <c:set value="${__history_details__.img}" var="current_img"/>
                                            <%
                                                String court_img = null;
                                                if (pageContext.getAttribute("current_img") != null) {
                                                    byte[] content = (byte[]) pageContext.getAttribute("current_img");
                                                    String base64Encoded = new String(Base64.encodeBase64(content), "UTF-8");
                                                    request.setAttribute("court_img", base64Encoded);
                                                }
                                            %>
                                            <div class="card lg:card-side bg-base-100 shadow-xl mt-6 h-80">
                                                <figure><img class="h-full" src="data:image/png;base64,${requestScope['court_img']}"/></figure>
                                                <div class="card-body">
                                                    <h2 class="card-title"><c:out value="${__history_details__.name}"/></h2>
                                                    <p class="card-desc"><c:out value="${__history_details__.state} - ${__history_details__.city}"/></p>
                                                    <p>Total price: <fmt:formatNumber type="currency" value="${__history_details__.price}"/></p>
                                                    <p>Date: <c:out value="${__history_details__.date}"/></p>
                                                    <p>Time: <c:out value="${__history_details__.time}"/></p>
                                                    <p>Duration: <c:out value="${__history_details__.duration}"/></p>
                                                    <div class="card-actions justify-end">
                                                        <a href="./../BookingDeletion?id=${__history_details__.id}" class="btn btn-primary">Cancel</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </body>
