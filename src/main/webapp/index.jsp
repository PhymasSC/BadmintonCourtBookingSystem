<%--
    Document   : Home
    Created on : 27 May 2022, 22:46:57
    Author     : SC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="./partials/_default.jsp"%>

<%--
<c:if test="${!sessionScope.isLoggedIn}">
    <c:redirect url="${request.getContextPath()}/Login"/>
</c:if>
--%>

<body>
    <section>
        <div class="flex relative items-center w-full h-screen px-5 py-12 mx-auto md:px-12 lg:px-16 max-w-7xl lg:py-24">
            <div class="flex w-full mx-auto text-left">
                <div class="relative inline-flex items-center mx-auto align-middle">
                    <div class="text-center">
                        <h1 class="max-w-5xl text-4xl font-extrabold leading-none tracking-tighter md:text-6xl lg:text-8xl text-transparent bg-clip-text bg-gradient-to-r from-primary to-secondary-content lg:max-w-7xl">
                            Playing badminton <br class="hidden lg:block">
                            anytime, anywhere
                        </h1>
                        <p class="max-w-xl mx-auto mt-8 text-base leading-relaxed text-base-500">Want to book a badminton court? Just head on over to BadmintonPal and book your court with just a few clicks.</p>
                        <div class="flex justify-center w-full max-w-2xl gap-2 mx-auto mt-6">
                            <div class="mt-3 rounded-lg sm:mt-0">
                                <a href="./Courts" class="btn btn-primary flex gap-2">
                                    Book now
                                    <i class="ph-caret-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="py-24 bg-base-content">
        <div class="container mx-auto px-4">
            <div class="flex flex-wrap -mx-4">
                <div class="w-full md:w-1/2 lg:w-1/3 px-4 mb-12 lg:mb-0">
                    <div class="flex">
                        <span class="flex-shrink-0 mr-8">
                            <i class="ph-credit-card ph-2x mt-2" style="color:hsl(var(--pc))"></i>
                        </span>
                        <div>
                            <h3 class="mb-4 text-lg font-bold uppercase font-heading text-primary-content">Payment is easy and convenient</h3>
                            <p class="text-primary-content leading-loose">Payments are made by credit/debit card or through online banking, all in Malaysian Ringgit. Booking is done securely through our trusted payment gateway, so you need not worry about sensitive credit card information being leaked.</p>
                        </div>
                    </div>
                </div>
                <div class="w-full md:w-1/2 lg:w-1/3 px-4 mb-12 lg:mb-0">
                    <div class="flex">
                        <span class="flex-shrink-0 mr-8">
                            <i class="ph-tag ph-2x mt-2" style="color:hsl(var(--pc))"></i>
                        </span>
                        <div>
                            <h3 class="mb-4 text-lg font-bold uppercase font-heading text-primary-content">No hidden costs and no cancellation fees</h3>
                            <p class="text-primary-content leading-loose">Booking a badminton court means instant confirmation, we offer free cancellations without any penalties.</p>
                        </div>
                    </div>
                </div>
                <div class="w-full md:w-1/2 lg:w-1/3 px-4 mb-12 lg:mb-0">
                    <div class="flex">
                        <span class="flex-shrink-0 mr-8">
                            <i class="ph-headset ph-2x mt-2" style="color:hsl(var(--pc))"></i>
                        </span>
                        <div>
                            <h3 class="mb-4 text-lg font-bold uppercase font-heading text-primary-content">We're always here for you 24/7</h3>
                            <p class="text-primary-content leading-loose">If you have any questions or would like to provide feedback, please contact our customer service team - we are always happy to help!</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>