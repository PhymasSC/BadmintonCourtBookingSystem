<%-- 
    Document   : _navbar
    Created on : 27 May 2022, 23:21:05
    Author     : SC
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<%@include file="./_default.jsp"%>
<!DOCTYPE html>
<html>
    <body>
        <div class="navbar bg-base-400 bg-opacity-90 backdrop-blur transition-all duration-100 sticky top-0">
            <div class="flex-1">
                <a href="/BadmintonCourtBookingSystem/Home.jsp" class="btn btn-ghost normal-case text-xl !font-bold">BCBS</a>
            </div>
            <div class="flex-none gap-2">
                <div class="form-control">
                    <input type="text" placeholder="Search" class="input input-bordered" />
                </div>
                <label class="swap swap-rotate mx-4">

                    <!-- this hidden checkbox controls the state -->
                    <input type="checkbox" />

                    <!-- sun icon -->
                    <span class="ph-sun-bold swap-on fill-current text-[1.5em]" onclick="swapTheme()"></span>

                    <!-- moon icon -->
                    <span class="ph-moon-bold swap-off fill-current text-[1.5em]" onclick="swapTheme()"></span>


                </label>
                <%
                    if (request.getParameter("user") != null) {
                %>
                <div class="dropdown dropdown-end">
                    <label tabindex="0" class="btn btn-ghost btn-circle avatar">
                        <div class="w-10 rounded-full">
                            <img src="https://api.lorem.space/image/face?hash=33791" loading="lazy"/>
                        </div>
                    </label>
                    <ul tabindex="0" class="mt-3 p-2 shadow menu menu-compact dropdown-content bg-base-100 rounded-box w-52">
                        <li>
                            <a class="justify-between">
                                Profile
                                <span class="badge">New</span>
                            </a>
                        </li>
                        <li><a>Settings</a></li>
                        <li><a>Logout</a></li>
                    </ul>
                </div>
                <%
                } else {
                %>
                <a href="/BadmintonCourtBookingSystem/Register.jsp"><button class="btn">Get Started!</button></a>
                <%
                    }
                %>
            </div>
        </div>

        <script>
            const htmlDOM = document.querySelector("html");
            let currentTheme = localStorage.getItem("theme") || "corporate";
            let sun = document.querySelector(".ph-sun-bold");
            let moon = document.querySelector(".ph-moon-bold");

            function swapTheme() {
                console.log(htmlDOM)
                const newTheme = htmlDOM.getAttribute("data-theme") == "corporate" ? "night" : "corporate";
                htmlDOM.setAttribute("data-theme", newTheme);
                localStorage.setItem("theme", newTheme)
            }

            if (currentTheme === "night") {
                sun.classList.add("swap-off");
                sun.classList.remove("swap-on");
                moon.classList.add("swap-on");
                moon.classList.remove("swap-off");
                swapTheme();
            }
        </script>
    </body>
</html>
