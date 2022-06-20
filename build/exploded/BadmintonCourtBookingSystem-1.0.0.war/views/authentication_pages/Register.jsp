<%--
    Document   : Register
    Created on : 29 May 2022, 11:40:05 pm
    Author     : ASUS
--%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@include file="./../../partials/_default.jsp"%>


<c:if test="${sessionScope.isLoggedIn}">
    <c:redirect url="${request.getContextPath()}/Home"/>
</c:if>

<!-- Put this part before </body> tag -->
<%@include file="./../../partials/_terms_and_condition.jsp"%>
<head>
    <script src="<%=request.getContextPath()%>/utility/PhoneFormatter.js" defer></script>
</head>
<body>
    <form action="<%=request.getContextPath()%>/processes/Register.jsp" method="POST">
        <div class="hero min-h-screen bg-base-200">
            <div class="hero-content flex-col lg:flex-row-reverse">

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
                        <h1 class="text-5xl font-bold">Sign up now!</h1>
                        <p class="py-6">Finding a place for your badminton training? Sign up to BadmintonPal for badminton courts!</p>
                    </div>
                </div>


                <div class="class flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
                    <div class="card-body">
                        <div class="grid gap-6 lg:grid-cols-2">
                            <div class="form-control">
                                <label for="first_name" class="label">First name</label>
                                <input type="text" id="first_name" name="first_name" class="input input-bordered" placeholder="John" required>
                            </div>
                            <div class="form-control">
                                <label for="last_name" class="label">Last name</label>
                                <input type="text" id="last_name" name="last_name" class="input input-bordered" placeholder="Doe" required>
                            </div>
                        </div>
                        <div class="form-control">
                            <label for="username" class="label">Username</label>
                            <input type="text" id="username" name="username" class="input input-bordered" placeholder="Johnny" required>
                        </div>
                        <div class="form-control">
                            <label for="phone" class="label">Phone number</label>
                            <label class="input-group">
                                <span><span class="fi fi-my"></span></span>
                                <input type="tel" id="phone" name="phone" class="input input-bordered w-full" placeholder="012-345-6789" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" required >
                            </label>
                        </div>
                        <div class="form-control">
                            <label for="email" class="label">Email address</label>
                            <input type="email" id="email" name="email" class="input input-bordered" placeholder="john.doe@company.com" required>
                        </div>
                        <div class="form-control">
                            <label for="password" class="label">Password</label>
                            <input type="password" id="password" name="password" class="input input-bordered" placeholder="•••••••••" required>
                        </div>
                        <div class="form-control">
                            <label for="confirm_password" class="label">Confirm password</label>
                            <input type="password" id="confirm_password" name="password_confirmation" class="input input-bordered" placeholder="•••••••••" required>
                        </div>

                        <div class="form-control">
                            <label class="label cursor-pointer justify-start gap-4">
                                <input type="checkbox" checked="checked" class="checkbox" />
                                <span class="label-text">I agree with the <label for="terms-and-condition-modal" class="link modal-button">Terms and Condition</label>.</span>
                            </label>
                            <button class="btn btn-primary mt-4">Register</button>
                            <span class="mx-auto mt-6">Already has an account? <a class='link' href='<%=request.getContextPath()%>/Login'>Login</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

</body>