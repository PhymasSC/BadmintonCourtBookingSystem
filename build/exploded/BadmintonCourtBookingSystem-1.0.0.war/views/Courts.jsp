<%--
    Document   : Courts
    Created on : Jun 13, 2022, 9:15:00 PM
    Author     : garyl
--%>

<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@include file="./../partials/_default.jsp"%>
<%@include file="./../partials/_db_connection.jsp"%>
<sql:query dataSource="${database}" var="cities">
    SELECT DISTINCT city FROM court;
</sql:query>



<script>
    const MONTH_NAMES = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    const DAYS = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    function app() {
        return {

            showDatepicker: false,
            datepickerValue: '',
            month: '',
            year: '',
            no_of_days: [],
            blankdays: [],
            days: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
            initDate() {
                let today = new Date();
                this.month = today.getMonth();
                this.year = today.getFullYear();
                this.datepickerValue = new Date(this.year, this.month, today.getDate()).toDateString();
                this.$refs.date.value = today.getFullYear() + "-" + ('0' + (today.getMonth() + 1)).slice(-2) + "-" + ('0' + today.getDate()).slice(-2);
            },
            isCurrentDate(date) {
                const d = new Date(this.year, this.month, date);
                return this.datepickerValue === d.toDateString() ? true : false;
            },
            isValidDate(date) {
                return new Date(this.year, this.month, date) >= new Date().setHours(0);
            },
            getDateValue(date) {
                let selectedDate = new Date(this.year, this.month, date);
                this.datepickerValue = selectedDate.toDateString();
                this.$refs.date.value = selectedDate.getFullYear() + "-" + ('0' + (selectedDate.getMonth() + 1)).slice(-2) + "-" + ('0' + selectedDate.getDate()).slice(-2);
                this.$refs.date.required = true;
                this.showDatepicker = false;
            },
            getNoOfDays() {
                let daysInMonth = new Date(this.year, this.month + 1, 0).getDate();
                // find where to start calendar day of week
                let dayOfWeek = new Date(this.year, this.month).getDay();
                let blankdaysArray = [];
                for (var i = 1; i <= dayOfWeek; i++) {
                    blankdaysArray.push(i);
                }

                let daysArray = [];
                for (var i = 1; i <= daysInMonth; i++) {
                    daysArray.push(i);
                }

                this.blankdays = blankdaysArray;
                this.no_of_days = daysArray;
            }
        }
    }
</script>

<main>
    <c:choose>
        <c:when test="${applicationScope.courts_list == null}">
        </c:when>
        <c:when test="${applicationScope.courts_list.rowCount == 0}">
            <c:out value="No results found"/>
        </c:when>
        <c:otherwise>
            <section class="hero min-h-screen bg-base-200">
                <div class="hero-content text-center flex-col">
                    <h1 class="text-5xl font-bold">Top Courts</h1>
                    <div id="courts_list" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-12">
                        <c:forEach var="__court__" items="${applicationScope.courts_list.rows}">
                            <c:set var="__current_image__" value="${__court__.img}"/>
                            <%    String courtImage = null;
                                if (application.getAttribute("courts_list") != null) {
                                    byte[] content = (byte[]) pageContext.getAttribute("__current_image__");
                                    String base64Encoded = new String(Base64.encodeBase64(content), "UTF-8");
                                    request.setAttribute("coverImg", base64Encoded);
                                }
                            %>
                            <div class="card w-96 bg-base-100 shadow-xl">
                                <figure class="px-10 pt-10">
                                    <img src="data:image/png;base64,${requestScope['coverImg']}" alt="${__court__.name}" class="rounded-xl" />
                                </figure>
                                <div class="card-body items-center text-center">
                                    <h2 class="card-title"><c:out value="${__court__.name}"/></h2>
                                    <p class="text-gray-500"><c:out value="${__court__.state} - ${__court__.city}"/></p>
                                    <div class="card-actions">
                                        <a href="./CourtProcess?id=${__court__.court_id}" target="_blank" class="btn btn-primary">Details</a>
                                        <a href="./BookingProcess?id=${__court__.court_id}&price=${__court__.price_in_cent_per_hour}" class="btn btn-secondary">Book</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <a href="#new_booking">
                        <i class="ph-caret-circle-down animate-bounce ph-2x"></i>
                    </a>
                </div>

            </section>
        </c:otherwise>
    </c:choose>


    <section id="new_booking" class="hero min-h-screen bg-base-200">
        <div class="hero-content text-center flex-col">
            <h1 class="text-5xl font-bold">Make a booking</h1>
            <form class="flex flex-col lg:flex-row justify-center items-center p-24 w-full gap-4" action="./CourtSearching" method="POST">
                <label class="input-group input-group-vertical">
                    <span class="p-4 flex justify-center">Location</span>
                    <select name="court_location" class="h-[8.5rem] select select-bordered w-full text-center" required>
                        <option disabled selected>Select a location</option>
                        <option value="all">All</option>
                        <c:forEach var="ct" items="${cities.rows}">
                            <c:out value="${ct}"/>
                            <option value="${ct.city}">${ct.city}</option>
                        </c:forEach>
                    </select>
                </label>

                <%-- Custom Calendar --%>
                <div class="flex items-center justify-center w-full">
                    <div class="antialiased sans-serif w-full">
                        <div x-data="app()" x-init="[initDate(), getNoOfDays()]" x-cloak>
                            <div class="relative">
                                <input type="hidden" name="book_date" x-ref="date" required>
                                <label class="input-group input-group-vertical">
                                    <span class="p-4 flex justify-center">Date</span>
                                    <input type="text" readonly x-model="datepickerValue" @click="showDatepicker = !showDatepicker" @keydown.escape="showDatepicker = false" class="h-[8.5rem] input input-bordered w-full text-center" placeholder="Select a date">
                                </label>


                                <div class="bg-base-content mt-20 w-[17rem] rounded-lg shadow p-4 absolute top-0 left-0" x-show.transition="showDatepicker" @click.away="showDatepicker = false">
                                    <div class="flex justify-between items-center mb-2">
                                        <div>
                                            <span x-text="MONTH_NAMES[month]" class="text-lg font-bold text-primary"></span>
                                            <span x-text="year" class="ml-1 text-lg text-primary-content font-bold"></span>
                                        </div>
                                        <div>
                                            <button type="button" class="text-primary transition ease-in-out duration-100 inline-flex cursor-pointer hover:bg-base-200 p-1 rounded-full" @click="if(month == 0) {month=11;  year--} else {month--}; getNoOfDays()">
                                                <i class="ph-caret-left"></i>
                                            </button>
                                            <button type="button" class="text-primary transition ease-in-out duration-100 inline-flex cursor-pointer hover:bg-base-200 p-1 rounded-full" @click="if (month == 11) {month=0; year++} else {month++}; getNoOfDays()">
                                                <i class="ph-caret-right"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="flex flex-wrap mb-3 -mx-1">
                                        <template x-for="(day, index) in DAYS" :key="index">
                                            <div style="width: 14.26%" class="px-1">
                                                <div x-text="day" class="text-primary-content font-medium text-center text-xs"></div>
                                            </div>
                                        </template>
                                    </div>

                                    <div class="flex flex-wrap -mx-1">
                                        <template x-for="blankday in blankdays">
                                            <div style="width: 14.28%" class="text-center border p-1 border-transparent text-sm"></div>
                                        </template>
                                        <template x-for="(date, dateIndex) in no_of_days" :key="dateIndex">
                                            <div style="width: 14.28%" class="px-1 mb-1">
                                                <div @click="isValidDate(date) && getDateValue(date)"
                                                      x-text="date"
                                                      class="cursor-pointer text-center text-sm leading-none rounded-full leading-loose transition ease-in-out duration-100"
                                                      :class="{
                                                      'bg-primary-content text-primary': isCurrentDate(date) && isValidDate(date),
                                                      'text-primary-content hover:bg-base-200 hover:text-primary': !isCurrentDate(date) && isValidDate(date),
                                                      'text-gray-400': !isValidDate(date)
                                                      }
                                                      "></div>
                                            </div>
                                        </template>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <label class="input-group input-group-vertical">
                    <span class="p-4 flex justify-center">Time</span>
                    <select name="book_time" class="h-[8.5rem] select select-bordered w-full text-center" required>
                        <option class="text-lg leading-6" disabled selected>Select a time</option>
                        <c:forEach begin="0" end="47" var="hour">
                            <%                        // Iterate to list every 30 minutes throughout a day
                                Date loopDate = new Date();
                                boolean isHalf = 30 * ((int) pageContext.getAttribute("hour") % 2) != 0;
                                int hour = ((int) pageContext.getAttribute("hour")) / 2;

                                loopDate.setHours(hour);
                                loopDate.setMinutes(isHalf ? 30 : 0);
                            %>
                            <option class="text-lg leading-6" value="<fmt:formatDate value="<%= loopDate%>" type="time" pattern="HH:mm"/>">
                                <fmt:formatDate value="<%= loopDate%>" type="time" pattern="hh:mm a"/>
                            </option>
                        </c:forEach>
                    </select>
                </label>

                <label class="input-group input-group-vertical">
                    <span class="p-4 flex justify-center">Duration</span>
                    <select name="book_duration" class="h-[8.5rem] select select-bordered w-full text-center" required>
                        <option disabled selected>Select a duration</option>
                        <c:forEach begin="0" end="9" var="duration" varStatus="durationStatus">
                            <%                        // Iterate duration of every 30 minutes start from 1 hour
                                Date loopDuration = new Date();
                                boolean _isHalf = 30 * ((int) pageContext.getAttribute("duration") % 2) != 0;
                                int _hour = ((int) pageContext.getAttribute("duration")) / 2;

                                loopDuration.setHours(_hour + 1);
                                loopDuration.setMinutes(_isHalf ? 30 : 0);
                            %>
                            <option class="text-lg leading-6" value="<fmt:formatDate value="<%= loopDuration%>" type="time" pattern="HH:mm"/>">

                                <c:out value="${ 1 + ( durationStatus.index * 0.5) }"/> hours
                            </option>
                        </c:forEach>
                    </select>
                </label>

                <button class="btn gap-2">
                    <i class="ph-magnifying-glass"></i>
                    Search
                </button>

            </form>
        </div>
    </section>
</main>
