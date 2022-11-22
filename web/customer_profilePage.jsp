

<%@page import="com.ebutler.swp.dto.ServiceOrderedHistoryDTO"%>
<%@page import="com.ebutler.swp.dto.ProductOrderHistoryDTO"%>
<%@page import="com.ebutler.swp.dto.AddressDTO"%>
<%@page import="com.ebutler.swp.dto.CityDTO"%>
<%@page import="com.ebutler.swp.dto.ProvinceDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ebutler.swp.dto.UserDTO"%>
<%@page import="com.ebutler.swp.dto.CustomerDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>E-Butler</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">
        <link rel="icon" type="image/png" href="img/logo-bulldog.png">
        <!-- Icon FontAwesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap"
              rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">



        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="css/grid.css">
        <link rel="stylesheet" href="css/base.css">

        <!-- My Stylesheet -->
        <link rel="stylesheet" href="css/guestPage.css">
        <link rel="stylesheet" href="css/customerPage.css">
        <link rel="stylesheet" href="css/customer_profilePage.css">
        <link rel="stylesheet" href="css/toast.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    </head>
    <c:if test="${sessionScope.LOGIN_USER == null || sessionScope.LOGIN_USER.getRole_id() != 'CUS'}">
        <c:redirect url="guest_loginPage.jsp"></c:redirect>
    </c:if>

    <body>
        <%
            CustomerDTO customer = (CustomerDTO) session.getAttribute("CURRENT_CUSTOMER");
            String emptyInfo = (String) request.getAttribute("EMPTY_INFO_ERROR");
            String emailWrongFormat = (String) request.getAttribute("EMAIL_WRONG_FORMAT");
            String updateSuccess = (String) request.getAttribute("UPDATE_SUCESSFULLY");
            String phoneWrongFormat = (String) request.getAttribute("PHONE_WRONG_LENGTH");
            String wrongDob = (String) request.getAttribute("WRONG_DOB");
            String current_form = (String) request.getAttribute("CURRENT_FORM");
            String action_type = (String) request.getAttribute("ACTION_TYPE");

            String address_id = (String) request.getAttribute("ADDRESS_ID");

            if (emptyInfo == null) {
                emptyInfo = "";
            }
            if (emailWrongFormat == null) {
                emailWrongFormat = "";
            }
            if (updateSuccess == null) {
                updateSuccess = "";
            }
            if (phoneWrongFormat == null) {
                phoneWrongFormat = "";
            }
            if (wrongDob == null) {
                wrongDob = "";
            }

            UserDTO login_user = (UserDTO) session.getAttribute("LOGIN_USER");
            customer = (customer == null) ? new CustomerDTO() : customer;

            current_form = (current_form == null) ? "" : current_form;
            action_type = (action_type == null) ? "" : action_type;
            address_id = (address_id == null) ? "" : address_id;

            String messageSuccess = (String) request.getAttribute("MESSAGE_SUCCESS");
            String messageError = (String) request.getAttribute("MESSAGE_FAIL");

            messageSuccess = (messageSuccess == null) ? "" : messageSuccess;
            messageError = (messageError == null) ? "" : messageError;
        %>
        <div class="container-xxl bg-white p-0">
            <!-- Spinner Start -->
            <div id="spinner"
                 class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->

            <!-- Navbar Start -->
            <div class="container-fluid nav-bar bg-transparent">
                <nav class="navbar navbar-expand-lg bg-white navbar-light py-0 px-4 relative">
                    <a href="LoadingProductAndServiceCategory" class="navbar-brand d-flex align-items-center text-center">
                        <div class="p-2 me-2">
                            <img class="img-fluid" src="img/logo.png" alt="Icon" style="width: 40px; height: 40px;">
                        </div>
                        <h1 class="text-primary">E-Butler</h1>
                    </a>
                    <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto">
                            <a href="LoadingProductAndServiceCategory" class="nav-item nav-link navigator">Home</a>
                            <a href="LoadingProductAndServiceCategory#product" class="nav-item nav-link navigator">Product</a>
                            <div class="nav-item dropdown">
                                <a href="LoadingProductAndServiceCategory#service" class="nav-link navigator">Service</a>
                            </div>
                            <a href="LoadingProductAndServiceCategory#help" class="nav-item nav-link navigator">Help</a>
                            <a href="customer_contactPage.jsp" class="nav-item nav-link navigator">Contact</a>
                            <div class="search absolute hide">
                                <a><i class="fa-solid fa-magnifying-glass"></i></a>
                                <input
                                    style="flex: 1; background-color: transparent; border: none; outline: none; margin: 0 20px;"
                                    type="text" placeholder="Type and press enter">
                                <a class="search-close opacity"><i class="fa-solid fa-xmark"></i></a>
                            </div>
                            <div class="nav-item dropdown">
                                <div class="nav-link">
                                    <div style="width: 1.5rem; height: 1.5rem;" class="img rounded-f">
                                        <%
                                            if (customer.getAvatar().isEmpty()) {
                                        %>
                                        <img src="img/default-avatar.jpg" alt="">
                                        <%
                                        } else {
                                        %>
                                        <img src="img/<%= customer.getAvatar()%>" alt="">
                                        <%
                                            }
                                        %>
                                    </div>
                                </div>
                                <div class="dropdown-menu rounded-0 flex-col">
                                    <div class="border-bottom">
                                        <div style="justify-content: flex-start; cursor: pointer;" class="dropdown-item pad-0">
                                            <i class="fa-solid fa-user"></i>
                                            <a href="MainController?action=GoToUserProfile&current_form=account"><%=login_user.getUsername()%></a>
                                        </div>
                                        <div style="cursor: pointer;" class="dropdown-item pad-0">
                                            <i class="fa-solid fa-lock"></i>
                                            <a href="MainController?action=GoToUserProfile&current_form=change_password">Change password</a>
                                        </div>
                                        <div style="justify-content: flex-start; cursor: pointer;" class="dropdown-item pad-0">
                                            <i class="fa-solid fa-wallet"></i>
                                            <a href="#!"><%=customer.getPoint()%> $</a>
                                        </div>
                                    </div>
                                    <div style="cursor: pointer;" class="dropdown-item pad-0">
                                        <i style="transform: scale(-1, 1);" class="fa-solid fa-right-from-bracket"></i>
                                        <a href="MainController?action=Logout">Logout</a>
                                    </div>
                                </div>
                            </div>
                            <a class="nav-item nav-link search-open"><i class="fa-solid fa-magnifying-glass"></i></a>
                            <a href="MainController?action=MoveToCart" class="nav-item nav-link"><i class="fa-solid fa-cart-shopping"></i></a>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Navbar End -->

            <!-- Header Start -->
            <div class="grid">
                <div class="grid wide">
                    <div style="margin-top: 64px;" class="flex-horizon-center flex-col m-y-32">
                        <h1 class="txt-xl">Account</h1>
                        <div>
                            <span class="txt-lg bold"><%=customer.getName()%>, </span>
                            <span class="txt-lg"><%=customer.getEmail()%>, </span>
                            <span class="txt-lg"><%=customer.getPhone()%></span>
                        </div>
                    </div>
                    <div style="border-top: 2px solid #E2E8F0; border-bottom: 2px solid #E2E8F0"
                         class="flex-vertical-center m-y-32">
                        <a class="relative txt-lg pad-y-32 navi--link account <%if (current_form.equals("account")) {%>bold<%}%>">Account info</a>
                        <a href="MainController?action=ShowListAddress&current_form=address" class="relative txt-lg pad-y-32 navi--link address <%if (current_form.equals("address")) {%>bold<%}%>">My address</a>
                        <a class="relative txt-lg pad-y-32 navi--link password <%if (current_form.equals("change_password")) {%>bold<%}%>">Change password</a>
                        <a class="relative txt-lg pad-y-32 navi--link order-product-his <%if (current_form.equals("order_product_history")) {%>bold<%}%>">My product order</a>
                        <a class="relative txt-lg pad-y-32 navi--link order-service-his <%if (current_form.equals("order_service_history")) {%>bold<%}%>">My service order</a>
                        <a class="relative txt-lg pad-y-32 navi--link order-pending <%if (current_form.equals("order_pending")) {%>bold<%}%>">Pending</a>
                        <a class="relative txt-lg pad-y-32 navi--link order-canceled <%if (current_form.equals("order_canceled")) {%>bold<%}%>">Canceled</a>
                    </div>
                </div>
            </div>
            <!-- Header End -->

            <!-- Account information start-->
            <div class="grid wide form account-form <%if (!current_form.equals("account")) {%>hide<%}%>">
                <div class="flex-vertical-center m-y-32">
                    <h1 class="txt-xl">Account information</h1>
                </div>

                <div class="row m-y-32">
                    <div class="col l-3">
                        <!--<form action="MainController">-->
                        <div style="width: 200px; height: 200px;" class="image m-y-12">
                            <%   if (customer.getAvatar().isEmpty()) {
                            %>
                            <img style="height: 100%; object-fit: cover;" src="https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg" alt="">
                            <%
                            } else {
                            %>
                            <img style="height: 100%; object-fit: cover;" src="img/<%= customer.getAvatar()%>" alt="">
                            <%
                                }
                            %>

                        </div>
                        <form method="POST" action="UploadPhotoController" enctype="multipart/form-data" >
                            <input type="file" name="file"/>
                            <input type="submit" name="action" value="Upload Photo"/>
                        </form>
                    </div>

                    <div class="col l-9">

                        <form action="MainController">
                            <div class="flex-horizon-center flex-col m-y-12">
                                <%= updateSuccess%>
                                <%= emptyInfo%>
                                <span class="txt-lg bold m-y-12">Full name</span>
                                <input name="name" value="<%= customer.getName()%>"style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                       class="input txt-sm" type="text" placeholder="<%= customer.getName()%>">
                            </div>
                            <div class="flex-horizon-center flex-col relative m-y-12">
                                <%= emailWrongFormat%>
                                <span class="txt-lg bold m-y-12">Email</span>
                                <div class="flex-horizon-center">
                                    <span class="txt-lg input-icon flex-center">
                                        <i class="fa-solid fa-envelope"></i>
                                    </span>
                                    <input class="input txt-sm" type="email" name="email" value="<%= customer.getEmail()%>"placeholder="<%= customer.getEmail()%>">
                                    <input type="hidden" name="avatar" value="<%= customer.getAvatar()%>"/>
                                </div>
                            </div>
                            <div class="flex-horizon-center flex-col relative m-y-12">

                                <span class="txt-lg bold m-y-12">Date of birth</span>
                                <%= wrongDob%>
                                <div class="flex-horizon-center">

                                    <span class="txt-lg input-icon flex-center">
                                        <i class="fa-solid fa-calendar"></i>
                                    </span>

                                    <input class="input txt-sm" type="date" name="dob" value="<%= customer.getDob()%>">
                                </div>
                            </div>
                            <div class="flex-horizon-center flex-col relative m-y-12">
                                <span class="txt-lg bold m-y-12">Default Address</span>

                                <div class="flex-horizon-center">
                                    <span class="txt-lg input-icon flex-center">
                                        <i class="fa-solid fa-location-dot"></i>
                                    </span>
                                    <input class="input txt-sm" type="text" readonly="" value="<%
                                        for (AddressDTO address : customer.getAddress_list()) {
                                            if (address.getStatus() != 1)
                                                continue;
                                           %><%= address.getStreet()%>, Thành phố <%=address.getDistrict_name()%>, Tỉnh <%=address.getProvince_name()%>
                                           <%
                                               }
                                           %>
                                           ">
                                </div>
                            </div>
                            <div class="flex-horizon-center flex-col relative m-y-12">
                                <span class="txt-lg bold m-y-12">Gender</span>
                                <div class="flex-vertical-center">
                                    <select style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem; flex: 0.5;"
                                            class="input txt-sm" name="gender" id="" value="<%= customer.getGender()%>">
                                        <option value="1" <%if (customer.getGender() == 1) {%>selected<%}%>>Male</option>
                                        <option value="2" <%if (customer.getGender() == 2) {%>selected<%}%>>Female</option>
                                        <option value="3" <%if (customer.getGender() == 3) {%>selected<%}%>>Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="flex-horizon-center flex-col relative m-y-12">
                                <%= phoneWrongFormat%>
                                <span class="txt-lg bold m-y-12">Phone number</span>
                                <div class="flex-horizon-center">
                                    <span class="txt-lg input-icon flex-center">
                                        <i class="fa-solid fa-phone-volume"></i>
                                    </span>
                                    <input class="input txt-sm" name="phone" value="<%= customer.getPhone()%>"type="text" placeholder="<%= customer.getPhone()%>">
                                </div>
                            </div>

                            <button name="action" value="UpdateCustomerInfo"class="btn-lg txt-lg bold m-y-32">Update Account</button>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Account information end -->

            <!-- Order product start -->
            <div class="grid form order-product-his-form <%if (!current_form.equals("order_product_history")) {%>hide<%}%>">
                <div class="grid wide">
                    <div class="flex-vertical-center m-y-32">
                        <h1 class="txt-xl">Order Product History</h1>
                    </div>

                    <div class="row m-y-32">
                        <%
                            ArrayList<ProductOrderHistoryDTO> product_history_list = (ArrayList<ProductOrderHistoryDTO>) session.getAttribute("ORDERED_PRODUCT_LIST_DELIVERED");
                            product_history_list = (product_history_list == null) ? new ArrayList<ProductOrderHistoryDTO>() : product_history_list;

//                            ArrayList<String> order_product_date = new ArrayList<>();
                            ArrayList<Integer> product_order_id = new ArrayList<>();

//                            for (ProductOrderHistoryDTO product : product_history_list) {
//                                if (order_product_date.contains(product.getOrder_Date())) {
//                                    continue;
//                                }
//
//                                order_product_date.add(product.getOrder_Date());
//                            }
                            for (ProductOrderHistoryDTO product : product_history_list) {
                                if (product_order_id.contains(product.getOrder_id())) {
                                    continue;
                                }

                                product_order_id.add(product.getOrder_id());
                            }

                        %>

                        <%                            for (int order : product_order_id) {

                        %>
                        <!-- Order item -->
                        <div class="block-border flex-col grid m-y-32">
                            <!-- Order head -->
                            <div style="background-color: #F9FAFB;" class="flex-between pad-2">
                                <div class="flex-col flex-horizon-center">
                                    <span class="txt-lg bold">#<%=order%></span>
                                    <div class="flex-center">
                                        <%
                                            for (ProductOrderHistoryDTO product : product_history_list) {
                                                if (product.getOrder_id() == order) {
                                        %>
                                        <span class="txt-md"><%=product.getOrder_Date()%></span>
                                        <span class="m-x-12">-</span>
                                        <span class="delivered">delivered</span>
                                        <%
                                                    break;
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>

                            <%
                                for (ProductOrderHistoryDTO product : product_history_list) {
                                    if (product.getOrder_id() == order) {
                            %>
                            <!-- Order detail -->
                            <div class="pad-1">
                                <div class="order-card">
                                    <div class="flex">
                                        <div class="flex-center order-img">
                                            <img style="width: 6.5rem; height: 6.5rem;" src="<%=product.getImage()%>"
                                                 alt="">
                                        </div>
                                        <div style="flex: 1; margin-left: 1rem;" class="flex-col">
                                            <div class="flex-between">
                                                <div class="flex-col flex-horizon-center">
                                                    <span class="txt-sm bold"><%=product.getProductName()%></span>
                                                    <div class="flex-horizon-center flex-center">
                                                        <span class="txt-xs">Product Category: <%=product.getProduct_category()%></span>
                                                        <span class="m-x-12">|</span>
                                                        <span class="txt-xs">Provider: <%=product.getProvider_name()%></span>
                                                    </div>
                                                </div>
                                                <div class="order-price bold">
                                                    <span>
                                                        $<%=(product.getQuantity() * product.getPrice())%>
                                                    </span>
                                                </div>
                                            </div>
                                            <div style="height: 50%;" class="flex-end flex-col">
                                                <span class="txt-sm bold">Quantity:  <%=product.getQuantity()%></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>

                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <!-- Order product end -->


            <!-- Order service start -->
            <div class="grid form order-service-his-form <%if (!current_form.equals("order_service_history")) {%>hide<%}%>">
                <div class="grid wide">
                    <div class="flex-vertical-center m-y-32">
                        <h1 class="txt-xl">Order Service History</h1>
                    </div>

                    <div class="row m-y-32">
                        <%
                            ArrayList<ServiceOrderedHistoryDTO> service_history_list = (ArrayList<ServiceOrderedHistoryDTO>) session.getAttribute("ORDERED_SERVICE_LIST_DELIVERED");
                            service_history_list = (service_history_list == null) ? new ArrayList<ServiceOrderedHistoryDTO>() : service_history_list;

//                            ArrayList<String> order_product_date = new ArrayList<>();
                            ArrayList<Integer> serevice_order_id = new ArrayList<>();

//                            for (ProductOrderHistoryDTO product : product_history_list) {
//                                if (order_product_date.contains(product.getOrder_Date())) {
//                                    continue;
//                                }
//
//                                order_product_date.add(product.getOrder_Date());
//                            }
                            for (ServiceOrderedHistoryDTO service : service_history_list) {
                                if (serevice_order_id.contains(service.getOrder_id())) {
                                    continue;
                                }

                                serevice_order_id.add(service.getOrder_id());
                            }

                        %>

                        <%                            for (int order : serevice_order_id) {

                        %>
                        <!-- Order item -->
                        <div class="block-border flex-col grid m-y-32">
                            <!-- Order head -->
                            <div style="background-color: #F9FAFB;" class="flex-between pad-2">
                                <div class="flex-col flex-horizon-center">
                                    <span class="txt-lg bold">#<%=order%></span>
                                    <div class="flex-center">
                                        <%
                                            for (ServiceOrderedHistoryDTO service : service_history_list) {
                                                if (service.getOrder_id() == order) {
                                        %>
                                        <span class="txt-md"><%=service.getOrder_Date()%></span>
                                        <span class="m-x-12">-</span>
                                        <span class="delivered">delivered</span>
                                        <%
                                                    break;
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>

                            <%
                                for (ServiceOrderedHistoryDTO service : service_history_list) {
                                    if (service.getOrder_id() == order) {
                            %>
                            <!-- Order detail -->
                            <div class="pad-1">
                                <div class="order-card">
                                    <div class="flex">
                                        <div style="width: 6.5rem; height: 6.5rem;" class="flex-center order-img">
                                            <img src="<%=service.getImage()%>"
                                                 alt="">
                                        </div>
                                        <div style="flex: 1; margin-left: 1rem;" class="flex-col">
                                            <div class="flex-between">
                                                <div class="flex-col flex-horizon-center">
                                                    <span class="txt-sm bold"><%=service.getStaff_name()%></span>
                                                    <div class="flex-horizon-center flex-center">
                                                        <span class="txt-xs"><%=service.getService_name()%></span>
                                                        <span class="m-x-12">|</span>
                                                        <span class="txt-xs">Provider: <%=service.getProvider_name()%></span>
                                                    </div>
                                                </div>
                                                <div class="order-price bold">
                                                    <span>
                                                        $<%=service.getPayment()%>
                                                    </span>
                                                </div>
                                            </div>
                                            <div style="height: 50%;" class="flex-end flex-col">
                                                <!--<span class="txt-md bold">Quantity:  </span>-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>

                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <!-- Order service end -->

            <!-- Order pending start -->
            <div class="grid form order-pending-form <%if (!current_form.equals("order_pending")) {%>hide<%}%>">
                <div class="grid wide">
                    <div class="flex-vertical-center m-y-32">
                        <h1 class="txt-xl">Order Pending</h1>
                    </div>

                    <div class="row m-y-32">
                        <!-- Order item -->
                        <div class="block-border flex-col grid m-y-32">
                            <!-- Order head -->
                            <div style="background-color: #F9FAFB;" class="flex-between pad-2">
                                <div class="flex-col flex-horizon-center">
                                    <span class="txt-lg bold">#Product</span>
                                    <div class="flex-center">

                                        <span class="txt-md">Status</span>
                                        <span class="m-x-12">-</span>
                                        <span class="pending">pending</span>

                                    </div>
                                </div>
                            </div>
                            <c:forEach items="${sessionScope.ORDERED_PRODUCT_LIST_PENDING}" var="o">
                                <!-- Order detail -->
                                <div class="pad-1">
                                    <div class="order-card">
                                        <div class="flex">
                                            <div style="width: 6.5rem; height: 6.5rem;" class="flex-center order-img">
                                                <img src="${o.image}"
                                                     alt="">
                                            </div>
                                            <div style="flex: 1; margin-left: 1rem;" class="flex-col">
                                                <div class="flex-between">
                                                    <div class="flex-col flex-horizon-center">
                                                        <span class="txt-sm bold">${o.productName}</span>
                                                        <div class="flex-horizon-center flex-center">
                                                            <span class="txt-xs">Product Category: ${o.product_category}</span>
                                                            <span class="m-x-12">|</span>
                                                            <span class="txt-xs">Provider: ${o.provider_name}</span>
                                                        </div>
                                                    </div>
                                                    <div class="order-price bold">
                                                        <span>
                                                            $${o.quantity * o.price}
                                                        </span>
                                                    </div>
                                                </div>
                                                <div style="height: 50%; align-items: flex-end;" class="flex-between">
                                                    <span class="txt-sm bold">Quantity: ${o.quantity}</span>
                                                    <a href="MainController?action=CancelOrder&current_form=order_pending&order_id=${o.order_id}&product_id=${o.id}" style="background-color: rgb( 219, 219, 219); border-radius: 0; box-shadow: none;" class="btn-sm border-no txt-md">Cancel</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Order item -->
                        <div class="block-border flex-col grid m-y-32">
                            <!-- Order head -->
                            <div style="background-color: #F9FAFB;" class="flex-between pad-2">
                                <div class="flex-col flex-horizon-center">
                                    <span class="txt-lg bold">#Service</span>
                                    <div class="flex-center">
                                        <span class="txt-md">Status</span>
                                        <span class="m-x-12">-</span>
                                        <span class="pending">pending</span>
                                    </div>
                                </div>
                            </div>
                            <c:forEach items="${sessionScope.ORDERED_SERVICE_LIST_PENDING}" var="o">
                                <!-- Order detail -->
                                <div class="pad-1">
                                    <div class="order-card">
                                        <div class="flex">
                                            <div style="width: 6.5rem; height: 6.5rem;" class="flex-center order-img">
                                                <img src="${o.image}"
                                                     alt="">
                                            </div>
                                            <div style="flex: 1; margin-left: 1rem;" class="flex-col">
                                                <div class="flex-between">
                                                    <div class="flex-col flex-horizon-center">
                                                        <span class="txt-sm bold">${o.staff_name}</span>
                                                        <div class="flex-horizon-center flex-center">
                                                            <span class="txt-xs">${o.service_name}</span>
                                                            <span class="m-x-12">|</span>
                                                            <span class="txt-xs">Provider: ${o.provider_name}</span>
                                                        </div>
                                                    </div>
                                                    <div class="order-price bold">
                                                        <span>
                                                            $${o.price}
                                                        </span>
                                                    </div>
                                                </div>
                                                <div style="height: 50%;" class="flex-end flex-col">
                                                    <!--<span class="txt-md bold">Quantity:  </span>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                    </div>
                </div>
            </div>
            <!-- Order pending end -->

            <!-- Order cancel start -->
            <div class="grid form order-canceled-form <%if (!current_form.equals("order-canceled-form")) {%>hide<%}%>">
                <div class="grid wide">
                    <div class="flex-vertical-center m-y-32">
                        <h1 class="txt-xl">Order Canceled</h1>
                    </div>

                    <div class="row m-y-32">
                        <%
                            ArrayList<ProductOrderHistoryDTO> product_cancel_list = (ArrayList<ProductOrderHistoryDTO>) session.getAttribute("ORDERED_PRODUCT_LIST_CANCELED");
                            product_cancel_list = (product_cancel_list == null) ? new ArrayList<ProductOrderHistoryDTO>() : product_cancel_list;

//                            ArrayList<String> order_product_date = new ArrayList<>();
                            ArrayList<Integer> product_order_canceled_id = new ArrayList<>();

//                            for (ProductOrderHistoryDTO product : product_history_list) {
//                                if (order_product_date.contains(product.getOrder_Date())) {
//                                    continue;
//                                }
//
//                                order_product_date.add(product.getOrder_Date());
//                            }
                            for (ProductOrderHistoryDTO product : product_cancel_list) {
                                if (product_order_canceled_id.contains(product.getOrder_id())) {
                                    continue;
                                }

                                product_order_canceled_id.add(product.getOrder_id());
                            }

                        %>

                        <%                            for (int order : product_order_canceled_id) {

                        %>
                        <!-- Order item -->
                        <div class="block-border flex-col grid m-y-32">
                            <!-- Order head -->
                            <div style="background-color: #F9FAFB;" class="flex-between pad-2">
                                <div class="flex-col flex-horizon-center">
                                    <span class="txt-lg bold">#<%=order%></span>
                                    <div class="flex-center">
                                        <%
                                            for (ProductOrderHistoryDTO product : product_cancel_list) {
                                                if (product.getOrder_id() == order) {
                                        %>
                                        <span class="txt-md"><%=product.getOrder_Date()%></span>
                                        <span class="m-x-12">-</span>
                                        <span style="color: rgb( 219, 219, 219)" class="delivered">Canceled</span>
                                        <%
                                                    break;
                                                }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>

                            <%
                                for (ProductOrderHistoryDTO product : product_cancel_list) {
                                    if (product.getOrder_id() == order) {
                            %>
                            <!-- Order detail -->
                            <div class="pad-1">
                                <div class="order-card">
                                    <div class="flex">
                                        <div class="flex-center order-img">
                                            <img style="width: 6.5rem; height: 6.5rem;" src="<%=product.getImage()%>"
                                                 alt="">
                                        </div>
                                        <div style="flex: 1; margin-left: 1rem;" class="flex-col">
                                            <div class="flex-between">
                                                <div class="flex-col flex-horizon-center">
                                                    <span class="txt-sm bold"><%=product.getProductName()%></span>
                                                    <div class="flex-horizon-center flex-center">
                                                        <span class="txt-xs">Product Category: <%=product.getProduct_category()%></span>
                                                        <span class="m-x-12">|</span>
                                                        <span class="txt-xs">Provider: <%=product.getProvider_name()%></span>
                                                    </div>
                                                </div>
                                                <div class="order-price bold">
                                                    <span>
                                                        $<%=(product.getQuantity() * product.getPrice())%>
                                                    </span>
                                                </div>
                                            </div>
                                            <div style="height: 50%;" class="flex-end flex-col">
                                                <span class="txt-sm bold">Quantity:  <%=product.getQuantity()%></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>

                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <!-- Order cancel start -->

            <!-- Change password start -->
            <div class="grid wide form password-form <%if (!current_form.equals("change_password")) {%>hide<%}%>">
                <div class="flex-vertical-center m-y-32">
                    <h1 class="txt-xl">Update Your Password</h1>
                </div>
                <%
                    String duplicatePassword = (String) request.getAttribute("DUPLICATE_NEW_PASSWORD");
                    String confirmPasswordError = (String) request.getAttribute("CONFIRM_PASSWORD_WRONG");
                    String emptyField = (String) request.getAttribute("EMPTY");
                    if (duplicatePassword == null) {
                        duplicatePassword = "";
                    }
                    if (confirmPasswordError == null) {
                        confirmPasswordError = "";
                    }
                    if (emptyField == null) {
                        emptyField = "";
                    }
                %>
                <div class="row m-y-32">
                    <div style="padding: 0;" class="col l-6">

                        <form action="MainController" method="POST">
                            <div class="flex-horizon-center flex-col m-y-12">
                                <span class="txt-lg bold m-y-12"><%= emptyField%></span>
                                <span class="txt-lg bold m-y-12">Current password</span>
                                <input name="current-password" style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                       class="input txt-sm" type="password">
                                <span class="txt-lg bold m-y-12"><%= duplicatePassword%></span>
                            </div>
                            <div class="flex-horizon-center flex-col m-y-12">
                                <span class="txt-lg bold m-y-12">New password</span>
                                <input name="new-password" style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                       class="input txt-sm" type="password">
                            </div>
                            <div class="flex-horizon-center flex-col m-y-12">
                                <span class="txt-lg bold m-y-12">Confirm password</span>
                                <input name="confirm-new-password" style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                       class="input txt-sm" type="password">
                                <span class="txt-lg bold m-y-12"><%= confirmPasswordError%></span>

                            </div>

                            <button name="action" value="ChangeCustomerPassword" class="btn-lg txt-lg bold m-y-32">Update Password</button>
                        </form>

                    </div>
                </div>
            </div>
            <!-- Change password end -->

            <!-- Update address start -->
            <div class="grid form address-form <%if (!current_form.equals("address")) {%>hide<%}%>">
                <div class="grid wide">
                    <div class="flex-vertical-center m-y-32">
                        <h1 class="txt-xl">Update Your Address</h1>
                    </div>

                    <div style="background-color: #F9FAFB;" class="pad-2">
                        <div class="flex-between flex-vertical-center">
                            <div class="flex">
                                <span class="txt-lg bold">My address</span>
                            </div>
                            <div class="flex">
                                <button type="button" style="background-color: var(--primary-color); border-radius: 0;" class="btn-lg border-no txt-md address_add">
                                    <i class="fa-solid fa-plus"></i>
                                    Add new address
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="overlay fixed top left right bot address_detail__add <%if (!action_type.equals("add_address")) {%>hide<%}%>">
                        <div class="flex-center full-h full-w">
                            <div class="relative" style="width: 50vw; height: fit-content; background-color: white;">
                                <div style="width: 100%;">
                                    <div class="pad-2">
                                        <div style="padding: 0;" class="flex-col">
                                            <form action="MainController?action=SelectProvince" method="POST">
                                                <input type="hidden" name="current_page" value="customer_profilePage.jsp">
                                                <input type="hidden" name="current_form" value="address">
                                                <input type="hidden" name="action_type" value="add_address">
                                                <div class="row">
                                                    <div class="flex-horizon-center flex-col m-y-12 col l-6">
                                                        <span class="txt-md m-y-12">Province</span>
                                                        <%
                                                            ArrayList<ProvinceDTO> province_list = (ArrayList<ProvinceDTO>) session.getAttribute("PROVINCE_LIST");
                                                            String province_id = (String) request.getAttribute("PROVINCE_ID");

                                                            province_id = (province_id == null) ? "" : province_id;
                                                            province_list = (province_list == null) ? new ArrayList<ProvinceDTO>() : province_list;
                                                        %>
                                                        <select
                                                            style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                                            class="input txt-sm" type="text" onchange="this.form.submit()" name="province_id">
                                                            <option>Select Province</option>
                                                            <%
                                                                for (ProvinceDTO province : province_list) {
                                                            %>
                                                            <option value="<%=province.getId()%>" <%if (province.getId().equals(province_id)) {%>selected<%}%>><%=province.getName()%></option>
                                                            <%
                                                                }
                                                            %>

                                                        </select>
                                                    </div>


                                                    <div class="flex-horizon-center flex-col m-y-12 col l-6">
                                                        <span class="txt-md m-y-12">City</span>

                                                        <%
                                                            ArrayList<CityDTO> city_list = (ArrayList<CityDTO>) request.getAttribute("CITY_LIST");
                                                            String city_id = (String) request.getAttribute("CITY_ID");

                                                            city_list = (city_list == null) ? new ArrayList<CityDTO>() : city_list;
                                                            city_id = (city_id == null) ? "" : city_id;
                                                        %>
                                                        <select
                                                            style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                                            class="input txt-sm" type="text" name="city_id" onchange="this.form.submit()">
                                                            <option>Select City</option>
                                                            <%
                                                                for (CityDTO city : city_list) {
                                                            %>
                                                            <option value="<%=city.getId()%>" <%if (city_id.equals(city.getId())) {%>selected<%}%>><%=city.getName()%></option>
                                                            <%
                                                                }
                                                            %>

                                                        </select>
                                                    </div>
                                                </div>
                                            </form>


                                            <form action="MainController">
                                                <input type="hidden" name="action" value="AddAddress">
                                                <input type="hidden" name="city_id" value="<%= request.getParameter("city_id")%>">
                                                <input type="hidden" name="current_form" value="address">
                                                <div class="flex-horizon-center flex-col m-y-1">
                                                    <span class="txt-md m-y-12">Address</span>
                                                    <input
                                                        style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                                        class="input txt-sm" type="text" name="street">
                                                </div>
                                                <div class="flex-vertical-center flex-end">
                                                    <button type="button" style="margin-right: 1rem; background-color: transparent; color: black; border-radius: 0;"
                                                            class="btn-lg txt-md bold m-y-32 border-no box-shadow-no close_address">Cancel</button>
                                                    <button type="submit" style="background-color: var(--primary-color); border-radius: 0;" class="btn-lg border-no txt-md">
                                                        Save
                                                    </button>
                                                </div>
                                            </form>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="pad-2 flex-col">
                        <%
                            ArrayList<AddressDTO> list_address = customer.getAddress_list();

                            for (AddressDTO address : list_address) {
                        %>

                        <div class="flex-between pad-y-1 border-bot">
                            <div class="l-5">
                                <div class="flex-col">
                                    <div class="flex">
                                        <span class="txt-md bold"><%=customer.getName()%></span>
                                        <span class="m-x-12">|</span>
                                        <span class="txt-md"><%=customer.getPhone()%></span>
                                    </div>
                                    <div>
                                        <span class="txt-md"><%=address.getStreet()%>, Thành phố <%=address.getDistrict_name()%>, Tỉnh <%=address.getProvince_name()%></span>
                                    </div>
                                    <%
                                        if (address.getStatus() == 1) {
                                    %>
                                    <div class="m-y-0">
                                        <span style="color: var(--primary-color); border-radius: 0; padding: 0 .25rem;" class="label bold txt-sm">Default</span>
                                    </div>
                                    <%
                                        }
                                    %>

                                </div>
                            </div>
                            <div class="flex-col flex-around">
                                <div class="bold flex-around txt-lg">
                                    <a href="MainController?action=DeleteAddress&current_form=address&address_id=<%=address.getId()%>" style="cursor: pointer; color: #eb3b0f"><i class="fa-solid fa-trash"></i></a>
                                </div>

                                <div style="border-radius: 0; padding: 0 .5rem;" class="label bold txt-sm m-y-0 flex-center">
                                    <a href="MainController?action=SetAddressDefault&current_form=address&address_id=<%=address.getId()%>" style="cursor: pointer;">Set default</a>
                                </div>

                            </div>

                            <div class="overlay fixed top left right bot address_detail__edit <%if (!action_type.equals("edit_address") && !((address.getId() + "").equals(address_id))) {%>hide<%}%>">
                                <div class="flex-center full-h full-w">
                                    <div class="relative" style="width: 50vw; height: fit-content; background-color: white;">
                                        <div style="width: 100%;">
                                            <div class="pad-2">
                                                <form action="MainController?action=SelectProvince" method="POST">
                                                    <div style="padding: 0;" class="flex-col">
                                                        <input type="hidden" name="current_page" value="customer_profilePage.jsp">
                                                        <input type="hidden" name="current_form" value="address">
                                                        <input type="hidden" name="action_type" value="edit_address">
                                                        <div class="row">
                                                            <div class="flex-horizon-center flex-col m-y-12 col l-6">
                                                                <span class="txt-md m-y-12">Province</span>
                                                                <%
                                                                    province_id = (province_id == null) ? "" : province_id;
                                                                    province_list = (province_list == null) ? new ArrayList<ProvinceDTO>() : province_list;
                                                                %>
                                                                <select
                                                                    style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                                                    class="input txt-sm" type="password" onchange="this.form.submit()" name="province_id">
                                                                    <option>Select Province</option>
                                                                    <%
                                                                        for (ProvinceDTO province : province_list) {
                                                                    %>
                                                                    <option value="<%=province.getId()%>" <%if (province.getId().equals(province_id)) {%>selected<%}%>><%=province.getName()%></option>
                                                                    <%
                                                                        }
                                                                    %>

                                                                </select>
                                                            </div>

                                                            <div class="flex-horizon-center flex-col m-y-12 col l-6">
                                                                <span class="txt-md m-y-12">City</span>

                                                                <%
                                                                    city_list = (city_list == null) ? new ArrayList<CityDTO>() : city_list;
                                                                %>
                                                                <select
                                                                    style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                                                    class="input txt-sm" type="password" name="city_id">
                                                                    <option>Select City</option>
                                                                    <%
                                                                        for (CityDTO city : city_list) {
                                                                    %>
                                                                    <option value="<%=city.getId()%>"><%=city.getName()%></option>
                                                                    <%
                                                                        }
                                                                    %>
                                                                </select>
                                                            </div>
                                                        </div>
                                                </form>

                                                <form action="MainController">
                                                    <input type="hidden" name="action" value="AddAddress">
                                                    <input type="hidden" name="city_id" value="<%=request.getParameter("city_id")%>">
                                                    <input type="hidden" name="current_form" value="address">
                                                    <div class="flex-horizon-center flex-col m-y-1">
                                                        <span class="txt-md m-y-12">Address</span>
                                                        <input
                                                            style="border-bottom-left-radius: 1rem; border-top-left-radius: 1rem;"
                                                            class="input txt-sm" type="text" name="street">
                                                    </div>
                                                    <div class="flex-vertical-center flex-end">
                                                        <button type="button" style="margin-right: 1rem; background-color: transparent; color: black; border-radius: 0;"
                                                                class="btn-lg txt-md bold m-y-32 border-no box-shadow-no close_edit_address">Cancel</button>
                                                        <button type="submit" style="background-color: var(--primary-color); border-radius: 0;" class="btn-lg border-no txt-md">
                                                            Save
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> 
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <!-- Update adddress end -->


        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-white-50 footer pt-5  wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Get In Touch</h5>
                        <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>Lô E2a-7, Đường D1, Đ. D1, Long Thạnh
                            Mỹ, Thành Phố Thủ Đức, Thành phố Hồ Chí Minh</p>
                        <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                        <p class="mb-2"><i class="fa fa-envelope me-3"></i>SE1111@e-butler.com</p>
                        <div class="d-flex pt-2">
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Quick Links</h5>
                        <a class="btn btn-link text-white-50" href="">About Us</a>
                        <a class="btn btn-link text-white-50" href="">Contact Us</a>
                        <a class="btn btn-link text-white-50" href="">Our Services</a>
                        <a class="btn btn-link text-white-50" href="">Privacy Policy</a>
                        <a class="btn btn-link text-white-50" href="">Terms & Condition</a>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Photo Gallery</h5>
                        <div class="row g-2 pt-2">
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1"
                                     src="https://cf.shopee.vn/file/d4bbea4570b93bfd5fc652ca82a262a8" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1"
                                     src="https://cf.shopee.vn/file/a0a9062ebe19b45c1ae0506f16af5c16" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1"
                                     src="https://cf.shopee.vn/file/38fd98e55806c3b2e4535c4e4a6c4c08" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1"
                                     src="https://cf.shopee.vn/file/2c46b83d84111ddc32cfd3b5995d9281" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1"
                                     src="https://cf.shopee.vn/file/77bf96a871418fbc21cc63dd39fb5f15" alt="">
                            </div>
                            <div class="col-4">
                                <img class="img-fluid rounded bg-light p-1"
                                     src="https://cf.shopee.vn/file/3900aefbf52b1c180ba66e5ec91190e5" alt="">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Newsletter</h5>
                        <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                        <div class="position-relative mx-auto" style="max-width: 400px;">
                            <input class="form-control bg-transparent w-100 py-3 ps-4 pe-5" type="text"
                                   placeholder="Your email">
                            <button type="button"
                                    class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->
    </div>

    <%
        if (!messageSuccess.isEmpty()) {
    %>
    <div id="toast"></div>
    <%
        }
    %>  

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
</div>

<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/wow/wow.min.js"></script>
<script src="lib/easing/easing.min.js"></script>
<script src="lib/waypoints/waypoints.min.js"></script>
<script src="lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="js/main.js"></script>

<!-- javascript -->
<script src="js/customer_profilePage.js"></script>
<script
    src="https://code.jquery.com/jquery-3.6.0.min.js"
    integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
    crossorigin="anonymous"
></script>
<script>
                                                                        var selDiv = "";
                                                                        var storedFiles = [];
                                                                        $(document).ready(function () {
                                                                            $("#img").on("change", handleFileSelect);
                                                                            selDiv = $("#selectedBanner");
                                                                        });

                                                                        function handleFileSelect(e) {
                                                                            var files = e.target.files;
                                                                            var filesArr = Array.prototype.slice.call(files);
                                                                            filesArr.forEach(function (f) {
                                                                                if (!f.type.match("image.*")) {
                                                                                    return;
                                                                                }
                                                                                storedFiles.push(f);

                                                                                var reader = new FileReader();
                                                                                reader.onload = function (e) {
                                                                                    var html =
                                                                                            '<img src="' +
                                                                                            e.target.result +
                                                                                            "\" data-file='" +
                                                                                            f.name +
                                                                                            "alt='Category Image' height='200px' width='200px'>";
                                                                                    selDiv.html(html);
                                                                                };
                                                                                reader.readAsDataURL(f);
                                                                            });
                                                                        }
</script>
<script language="javascript">
    const main = document.getElementById("toast");
    if (main) {
        const duration = 2000;
        const toast = document.createElement("div");
        // Auto remove toast
        const autoRemoveId = setTimeout(function () {
            main.removeChild(toast);
        }, duration + 1000);
        // Remove toast when clicked
        toast.onclick = function (e) {
            if (e.target.closest(".toast__close")) {
                main.removeChild(toast);
                clearTimeout(autoRemoveId);
            }
        };

    <%
        if (messageError.isEmpty() && !messageSuccess.isEmpty()) {
    %>
        toast.classList.add("toast", `toast--success`, "showing");

        toast.style.animation = `slideInLeft ease .3s, fadeOut linear 1s 1.5s forwards`;

        toast.innerHTML =
                `<div class="toast__icon">
            <i class="fas fa-check-circle"></i>
            </div>
            <div class="toast__body">
            <h3 class="toast__title">SUCCESS</h3>
                <p class="toast__msg"><%=messageSuccess%></p>
                </div>
            <div class="toast__close">
            <i class="fas fa-times"></i>
            </div>
                    `;

    <%
        }
    %>

    <%
        if (!messageError.isEmpty() && messageSuccess.isEmpty()) {
    %>
        toast.classList.add("toast", `toast--error`);
        toast.style.animation = `slideInLeft ease .3s, fadeOut linear 1s 1.5s forwards`;
        toast.innerHTML =
                `<div class="toast__icon">
            <i class="fas fa-check-circle"></i>
            </div>
            <div class="toast__body">
            <h3 class="toast__title">ERROR</h3>
                <p class="toast__msg"><%=messageError%></p>
                </div>
            <div class="toast__close">
            <i class="fas fa-times"></i>
            </div>
            `;
    <%
        }
    %>
        main.appendChild(toast);
    }
</script>
</body>

</html>
