<%@page import="com.ebutler.swp.dto.CustomerDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.ebutler.swp.dto.ReviewDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ebutler.swp.dto.UserDTO"%>
<%@page import="com.ebutler.swp.dto.ProductDetailDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="css/toast.css">

    </head>
    <c:if test="${sessionScope.LOGIN_USER == null || sessionScope.LOGIN_USER.getRole_id() != 'CUS'}">
        <c:redirect url="guest_loginPage.jsp"></c:redirect>
    </c:if>

    <body>
        <%

            //List<ProductDetailDTO> productList = (List<ProductDetailDTO>) session.getAttribute("PRODUCT_DETAIL_BY_TYPE");
            String product_id = (String) session.getAttribute("PRODUCT_ID");
            CustomerDTO customer = (CustomerDTO) session.getAttribute("CURRENT_CUSTOMER");
            customer = (customer == null) ? new CustomerDTO() : customer;
            product_id = (product_id == null) ? "" : product_id;

            UserDTO login_user = (UserDTO) session.getAttribute("LOGIN_USER");

            String messageSuccess = (String) request.getAttribute("ADD_SUCCESS");
            String messageError = (String) request.getAttribute("ADD_FAIL");

            messageSuccess = (messageSuccess == null) ? "" : messageSuccess;
            messageError = (messageError == null) ? "" : messageError;
        %>

        <%
            List<ProductDetailDTO> productList = (List<ProductDetailDTO>) session.getAttribute("PRODUCT_DETAIL_BY_TYPE");
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
                            <a href="LoadingProductAndServiceCategory#product" class="nav-item nav-link navigator active">Product</a>
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
                                    <div style="width: 1.5rem;" class="img rounded-f">
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


            <!-- Slider Start -->
            <div class="grid relative">
                <div class="col l-9 s-12 m-12 absolute abs-center left">
                    <h1 class="my-24">Product</h1>
                    <span class="text-s">We not only help you design exceptional products, but also make it easy for you
                        to share your designs with more like-minded people.</span>
                </div>
                <div style="background-color: var(--blue-bg);" class="row">
                    <img src="https://chisnghiax.com/ciseco/static/media/Moon.bf27dc577d1acccaba48430d353dbbe0.svg">
                </div>
            </div>
            <!-- Slider End -->

            <!-- Product List Start -->
            <div id="content" style="max-height: var(--list-h);" class="grid wide border-bot border-top">
                <div class="grid">
                    <div class="row m-y-2">
                        <form style="padding: 0;" class="col l-10 s-8" action="MainController?action=SearchProductDetailByType" method="POST">

                            <div style="min-width: 100%;" class="flex-center sort-btn">
                                <a><i class="fa-solid fa-magnifying-glass"></i></a>
                                <input
                                    style="flex: 1; background-color: transparent;"
                                    type="text" placeholder="Type and press enter" class="border-no m-x-1" name="searchProductDetail">
                                <a class="opacity"><i class="fa-solid fa-xmark"></i></a>
                            </div>

                        </form>

                        <form style="padding: 0;" class="col l-2 s-4 flex-end" action="MainController" method="POST">
                            <div class="sort-btn">
                                <i class="fa-solid fa-sort"></i>
                                <select name="action" style="text-align: center;" class="border-no select" name="" id="" onChange="this.form.submit()">
                                    <option value="">Sort order</option>
                                    <option value="PriceDetailUp">Price up</option>
                                    <option value="PriceDetailDown">Price down</option>
                                    <option value="WordDetailUp">Word up</option>
                                    <option value="WordDetailDown">Word down</option>
                                </select>
                            </div>
                        </form>
                    </div>

                    <div class="mx-5 mt-3">
                        <nav aria-label="breadcrumb m-5">
                            <ol class="breadcrumb breadcrumb-style1">
                                <li class="breadcrumb-item">
                                    <a href="LoadingProductAndServiceCategory">Home</a>
                                </li>
                                <li class="breadcrumb-item">
                                    <a href="MainController?action=GoToProductPageByPlace&category_ID=<%=session.getAttribute("CATEGORYID")%>">Product Category</a>
                                </li>
                                <li class="breadcrumb-item active">Products</li>
                            </ol>
                        </nav>
                    </div>

                    <div class="row m-y-1">

                        <!-- product item -->

                        <%
                            ArrayList<ProductDetailDTO> product_list = (ArrayList<ProductDetailDTO>) session.getAttribute("PRODUCT_DETAIL_BY_TYPE");

                            for (ProductDetailDTO product : product_list) {
                        %>
                        <div id="<%= product.getId()%>" class="col l-3 s-6 m-y-1">
                            <div class="block__item flex-between">
                                <div style="max-height: 15rem; min-height: 15rem;" class="block__img flex-center relative">
                                    <img src="<%= product.getImage()%>"
                                         alt="">
                                    <a href="MainController?action=AddToCart&quantity=1&product_ID=<%= product.getId()%>#<%= product.getId()%>"
                                       style="background-color: black; color: white; right: 52%;"
                                       class="txt-border link absolute card-extend bot">
                                        <i class="fa-solid fa-bag-shopping"></i>
                                        Add to cart
                                    </a>
                                    <a style="background-color: white; color: black; left: 52%;"
                                       class="txt-border link absolute card-extend bot quick-view">
                                        <i class="fa-solid fa-expand"></i>
                                        Quick view
                                    </a>
                                </div>
                                <div class="block__text pad-y-1 flex-col flex-between full-h">
                                    <div class="flex-col">
                                        <h5 style="text-align: start;" class="m-y-0 product-name"><%= product.getName()%></h5>
                                        <div class="ellipsis txt-sm m-y-0">
                                            <p style="text-align: start;">
                                                <%= product.getDescription()%>
                                            </p>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col l-6 m-y-0">
                                            <div style="color: #4ADE80; border: 2px solid #4ADE80; width: fit-content; --rounded: 0.5rem; padding: .2rem;"
                                                 class="txt-sm rounded bold">
                                                <p>
                                                    $ <%= product.getPrice()%>
                                                </p>
                                            </div>
                                        </div>
                                        <div class="col l-o-1 l-5 flex-center">
                                            <%
                                                ArrayList<ReviewDTO> review_list = product.getReview_list();

                                                float average_rating = 0.0f;

                                                for (ReviewDTO review : review_list) {
                                                    average_rating += (float) review.getRating() / (review_list.size());
                                                }

                                                DecimalFormat df = new DecimalFormat("#.##");

                                            %>
                                            <div style="color: #F2B737;">
                                                <i class="fa-solid fa-star"></i>
                                                <span
                                                    style="color: var(--text-color); line-height: 100%; margin: auto;"><%=df.format(average_rating)%></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%
                            String current_form = (String) request.getParameter("current_form");
                            String product_detail_id = (String) request.getParameter("product_id");

                            current_form = (current_form == null) ? "" : current_form;
                            product_detail_id = (product_detail_id == null) ? "" : product_detail_id;
                        %>

                        <div id="quickview" class="overlay fixed top bot left right flex-center <%if (!current_form.equals("quickview_product") || !(product.getId().equals(product_detail_id))) {%>hide<%}%>">
                            <div class="popup relative pad-2 row">
                                <div style="margin: -1.5rem 1rem; width: fit-content;" class="absolute p-0 right text-md opacity popup-close">
                                    <i class="fa-solid fa-xmark"></i>
                                </div>

                                <div style="background-color: #F8F8F8; border-radius: .5rem;"
                                     class="col l-4 flex-center full-h">
                                    <div style="height: 95%;" class="flex-col flex-vertical-center flex-around">
                                        <div style="width: 10rem; height: 10rem" class="img">
                                            <img src="<%= product.getImage()%>"
                                                 alt="">
                                        </div>

                                        <div class="flex flex-col flex-center full-w">
                                            <span class="txt-md bold"><%= product.getName()%></span>
                                            <span class="txt-sm"><%= product.getProvider_ID()%></span>
                                        </div>

                                        <form action="MainController" class="flex-col flex-vertical-center">
                                            <input type="hidden" name="action" value="AddToCart">
                                            <input type="hidden" name="product_ID" value="<%= product.getId()%>">

                                            <div style="width: 50%" class="flex-center">
                                                <button type="button" style="width: 2rem; height: 2rem;"
                                                        class="btn-circle flex-center txt-xs"
                                                        onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                                                    <i class="fas fa-minus"></i>
                                                </button>

                                                <div class="">
                                                    <input
                                                        style="text-align: center; outline: none; font-weight: bold; border: none;"
                                                        min="1" value="1" name="quantity" type="number" class="form-control" />
                                                </div>

                                                <button type="button" style="width: 2rem; height: 2rem;"
                                                        class=" btn-circle flex-center txt-xs"
                                                        onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
                                                    <i class="fas fa-plus"></i>
                                                </button>
                                            </div>

                                            <div class="m-y-0">
                                                <input type="hidden" name="quickview" value="true" />
                                                <button type="submit" style="padding: .4rem 4rem; border-radius: .5rem;"
                                                        class="btn-md bold">Buy</button>
                                            </div>
                                        </form>

                                        <div class="flex-between">
                                            <div class="txt-sm bold col l-2 flex-center flex-col">
                                                <div class="order-price flex">
                                                    <span>
                                                        $<%= product.getPrice()%>
                                                    </span>
                                                </div>
                                                <span class="txt-sm m-y-0">Price</span>
                                            </div>

                                            <div style="margin: 0; height: 4rem;" class="separate"></div>

                                            <div class="txt-sm bold col l-2 flex-center flex-col">
                                                <div style="color: #F2B737; border: none;" class="order-price">
                                                    <span class="flex-center">
                                                        <%= df.format(average_rating)%> <i class="fa-solid fa-star"></i>
                                                    </span>
                                                </div>
                                                <span class="txt-sm m-y-0">Average</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div style="height: 80vh;" class="col l-8 scrollable-y">
                                    <div class="full-h">
                                        <div style="background-color: #F8F8F8; border-radius: .5rem;">
                                            <div class="pad-1 border-bot">
                                                <span style="color: #1D1D1F;" class="txt-md bold">Description</span>
                                            </div>

                                            <div class="pad-1 txt-sm">
                                                <%= product.getDescription()%>
                                            </div>
                                        </div>

                                        <div style="background-color: #F8F8F8; border-radius: .5rem;" class="m-y-2">
                                            <div class="pad-1 border-bot">
                                                <span style="color: #1D1D1F;" class="txt-md bold">Ratings and reviews</span>
                                            </div>

                                            <div class="pad-1">
                                                <div class="flex flex-col border-bottom">
                                                    <form action="MainController">
                                                        <input type="hidden" name="action" value="AddReview">
                                                        <input type="hidden" name="product_id" value="<%=product.getId()%>">
                                                        <input type="hidden" name="current_form" value="quickview_product">

                                                        <div class="flex">
                                                            <div class="l-4">
                                                                <h1><%=df.format(average_rating)%></h1>
                                                                <h6 style="margin: 0 auto;" class="txt-sm">out of 5</h6>
                                                            </div>
                                                            <div style="justify-content: flex-end" class="l-8 flex-horizon-center flex-col">
                                                                <div class="flex-vertical-center flex-end txt-xl full-h">
                                                                    <span class="flex-center rating">
                                                                        <input style="width: 0.075rem;"  type="radio" name="rating" id="star1-<%=product.getId()%>"
                                                                               value="5" required=""><label for="star1-<%=product.getId()%>"><i class="fa-solid fa-star"></i></label>
                                                                        <input type="radio" name="rating" id="star2-<%=product.getId()%>"
                                                                               value="4" required=""><label for="star2-<%=product.getId()%>"><i class="fa-solid fa-star"></i></label>
                                                                        <input type="radio" name="rating" id="star3-<%=product.getId()%>"
                                                                               value="3" required=""><label for="star3-<%=product.getId()%>"><i class="fa-solid fa-star"></i></label>
                                                                        <input type="radio" name="rating" id="star4-<%=product.getId()%>"
                                                                               value="2" required=""><label for="star4-<%=product.getId()%>"><i class="fa-solid fa-star"></i></label>
                                                                        <input type="radio" name="rating" id="star5-<%=product.getId()%>"
                                                                               value="1" required=""><label for="star5-<%=product.getId()%>"><i class="fa-solid fa-star"></i></label>
                                                                    </span>
                                                                </div>
                                                                <h4 class="txt-xs flex-end">Click me!</h4>
                                                            </div>
                                                        </div>

                                                        <%
                                                            String reviewError = (String) request.getAttribute("REVIEW_ERROR");

                                                            reviewError = (reviewError == null) ? "" : reviewError;
                                                        %>

                                                        <div class="full-w m-y-0">
                                                            <span class="txt-sm bold">Comment</span>
                                                            <textarea name="comment" id="" rows="2" value="" class="full-w pad-0 txt-sm"></textarea>
                                                            <%
                                                                if (!reviewError.isEmpty()) {
                                                            %>
                                                            <span class="auth-form__notify txt-xs bold">
                                                                <i class="fa-solid fa-triangle-exclamation"></i>
                                                                <p><%=reviewError%></p>
                                                            </span> 
                                                            <%
                                                                }
                                                            %>
                                                            <div class="flex-end full-w">
                                                                <button style="padding: .2rem 2rem; border-radius: .5rem;"
                                                                        class="btn-md bold">Submit</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>

                                                <div>
                                                    <!-- Comment item -->
                                                    <%
                                                        for (ReviewDTO review : review_list) {
                                                    %>
                                                    <div class="border-bot">
                                                        <div class="flex-col m-y-1">
                                                            <div class="flex-vertical-center flex-between">
                                                                <div class="txt-lg bold "><%=review.getUsername()%></div>
                                                                <div class="flex-vertical-center m-y-0 txt-xs">
                                                                    <span class="flex-center rating">
                                                                        <input type="radio" id="<%=review.getId()%>"
                                                                               value="1" <%if (review.getRating() == 5) {%>checked<%}%>><label for=""><i class="fa-solid fa-star"></i></label>
                                                                        <input type="radio" id="<%=review.getId()%>"
                                                                               value="2" <%if (review.getRating() == 4) {%>checked<%}%>><label for=""><i class="fa-solid fa-star"></i></label>
                                                                        <input type="radio" id="<%=review.getId()%>"
                                                                               value="3" <%if (review.getRating() == 3) {%>checked<%}%>><label for=""><i class="fa-solid fa-star"></i></label>
                                                                        <input type="radio" id="<%=review.getId()%>"
                                                                               value="4" <%if (review.getRating() == 2) {%>checked<%}%>><label for=""><i class="fa-solid fa-star"></i></label>
                                                                        <input type="radio" id="<%=review.getId()%>"
                                                                               value="5" <%if (review.getRating() == 1) {%>checked<%}%>><label for=""><i class="fa-solid fa-star"></i></label>
                                                                    </span>
                                                                </div>
                                                            </div>
                                                            <div class="m-y-0 txt-sm"><%=review.getComment()%></div>
                                                        </div>
                                                    </div>
                                                    <%
                                                        }
                                                    %>

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

                    <div class="row m-y-1">
                        <div class="row">
                            <div class="col l-6">
                                <ul class="row pad-1">
                                    <c:forEach begin="1" end="${sessionScope.NUMBER_PAGE_PRODUCT_DETAIL}" var="i">
                                        <li class="bold text-circle mx-1">
                                            <a href="MainController?action=GoToProductDetailByType&index=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <!--                                    <li class="bold text-circle mx-1">1</li>
                                                                        <li class="bold text-circle mx-1">2</li>
                                                                        <li class="bold text-circle mx-1">3</li>
                                                                        <li class="bold text-circle mx-1">4</li>-->
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Product List End -->

        </div>
        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-white-50 footer pt-5  wow fadeIn m-y-2" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Get In Touch</h5>
                        <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>E2a-7, D1 Street, Long Thanh
                            My, Thu Duc District, Ho Chi Minh City</p>
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

        <%
            if (!messageSuccess.isEmpty()) {
        %>
        <div id="toast"></div>
        <%
            }
        %>   

        <!-- Footer End -->


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
    <script src="js/customer_productPage.js"></script>

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