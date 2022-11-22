<%@page import="com.ebutler.swp.dto.CustomerDTO"%>
<%@page import="com.ebutler.swp.dto.UserDTO"%>
<%@page import="com.ebutler.swp.dto.ServiceCategoryDTO"%>
<%@page import="com.ebutler.swp.dto.ProductCategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.ebutler.swp.dto.ProductDTO"%>
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
    </head>
     <c:if test="${sessionScope.LOGIN_USER == null || sessionScope.LOGIN_USER.getRole_id() != 'CUS'}">
        <c:redirect url="guest_loginPage.jsp"></c:redirect>
    </c:if>

    <body>
        <%
            List<ProductCategoryDTO> productCategorylist = (List<ProductCategoryDTO>) session.getAttribute("PRODUCT_CATEGORY_BY_PLACE_LIST");
            List<ServiceCategoryDTO> serviceCategoryList = (List<ServiceCategoryDTO>) session.getAttribute("SERVICE_CATEGORY_BY_PLACE_LIST");
            CustomerDTO customer = (CustomerDTO) session.getAttribute("CURRENT_CUSTOMER");
            customer = (customer == null) ? new CustomerDTO() : customer;
            UserDTO login_user = (UserDTO) session.getAttribute("LOGIN_USER");
            login_user = (login_user == null ) ? new UserDTO() : login_user;
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
                            <a href="LoadingProductAndServiceCategory" class="nav-item nav-link active navigator">Home</a>
                            <a href="#product" class="nav-item nav-link navigator">Product</a>
                            <div class="nav-item dropdown">
                                <a href="#service" class="nav-link navigator">Service</a>
                            </div>
                            <a href="#help" class="nav-item nav-link navigator">Help</a>
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
                                        <%   if (customer.getAvatar().isEmpty()) {
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
                                    <div class="border-bot">
                                        <div style="justify-content: flex-start; cursor: pointer;" class="dropdown-item pad-0">
                                            <i class="fa-solid fa-user"></i>
                                            <a href="MainController?action=GoToUserProfile&current_form=account"><%= login_user.getUsername() %></a>
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
                            <a class="nav-item nav-link search-open "><i class="fa-solid fa-magnifying-glass"></i></a>
                            <a href="MainController?action=MoveToCart" class="nav-item nav-link"><i class="fa-solid fa-cart-shopping"></i></a>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Navbar End -->

            <!-- Slider Start -->
            <div class="grid">
                <div class="relative">
                    <div class="slider__img">
                        <img src="img/Cleaning-Service-Business1--1-.jpeg" style="width:100%">
                    </div>
                    <div class="slider__img">
                        <img src="https://img.freepik.com/free-vector/template-banner-online-store-with-shopping-cart-with-purchases-boxes-delivery-from-supermarket-vector-illustration_548887-104.jpg?w=2000" style="width:100%">
                    </div>
                    <div class="slider__img">
                        <img src="https://262781-1079102-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/slider1/ro-site-banner-3.jpeg" style="width:100%">
                    </div>
                    

                    <a class="prev left" onclick="plusSlides(-1)">&#10094;</a>
                    <a class="next right" onclick="plusSlides(1)">&#10095;</a>
                </div>
                <br>

                <div class="flex-center">
                    <span class="dot" onclick="currentSlide(1)"></span>
                    <span class="dot" onclick="currentSlide(2)"></span>
                    <span class="dot" onclick="currentSlide(3)"></span>
                </div>
            </div>
            <!-- Slider End -->


            <!-- Product List Start -->

            <div id="product"  class="grid m-y-1">
                <div class="grid wide">
                    <div class="m-y-1">
                        <h1 class="head-txt bold text-center my-24">Product</h1>
                        <h2 class="text text-center">Good things are waiting for you</h2>
                    </div>
                </div>

                <div class="row m-y-1">
                    <div class="col l-12">
                        <div class="grid slider-main">
                            <span class="direction text-md font-medium direct-product-prev left center">
                                <i class="fa-solid fa-angle-left"></i>
                            </span>

                            <span class="direction text-md font-medium direct-product-next right center">
                                <i class="fa-solid fa-angle-right"></i>
                            </span>


                            <div class="row slider-card slider-product m-y-1">
                                <!-- Edit start -->
                                <%
                                    for (ProductCategoryDTO category : productCategorylist) {
                                %>
                                <div class="col l-5 m-7 s-12 card-item">
                                    <form action="MainController">
                                        <div class="card">
                                            <div class="row card-detail product-card">
                                                <div class="col l-o-1 m-o-1 s-o-1">
                                                    <div class="pad-y-1 flex-col flex-between full-h">
                                                        <div>
                                                            <p class="m-y-0">Explore new arrivals</p>
                                                            <h5 class="m-y-0">Shop the latest for </h5>
                                                            <h4 class="m-y-0"><%=category.getName()%></h4>
                                                        </div>

                                                        <div>
                                                            <button class="my-btn txt-lg bold" name="action" value="GoToProductPageByPlace">Show All</button>
                                                            <input type="hidden" name="category_ID" value="<%=category.getCategory_ID()%>"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col l-6 full-h full-w">
                                                    <div class="img pad-1">
                                                        <img style="object-fit: contain;" src="<%=category.getImage()%>"
                                                             alt="">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <%
                                    }
                                %>

                                <!-- Edit end -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Product List End -->

            <!-- Slider Start -->
            <div class="grid">
                <div class="relative">

                    <div class="slider__img--2">
                        <img src="img/29296.jpg" style="width:100%">
                    </div>
                    <div class="slider__img--2">
                        <img src="https://cf.shopee.vn/file/e7133b9860bc43cd37e2141c1fb9437a_xxhdpi" style="width:100%">
                    </div>
                    <div class="slider__img--2">
                        <img src="https://cf.shopee.vn/file/95734f87b93157e5c85bc332f69ea39f_xxhdpi" style="width:100%">             

                    </div>
                    <div id="service" ></div>   
                </div >

                <br>
            </div>
            <!-- Slider End -->

            <!-- Service List Start -->
            <div id="service"  class="grid m-y-1">
                <div class="grid wide">
                    <div class="m-y-1">
                        <h1 class="head-txt bold text-center my-24">Service</h1>
                        <h2 class="text text-center">Good services are waiting for you</h2>
                    </div>
                </div>

                <div class="row m-y-1">
                    <div class="col l-12">
                        <div class="grid slider-main">

                            <span class="direction text-md font-medium direct-service-prev left center">
                                <i class="fa-solid fa-angle-left"></i>
                            </span>

                            <span class="direction text-md font-medium direct-service-next right center">
                                <i class="fa-solid fa-angle-right"></i>
                            </span>

                            <div class="row slider-card slider-service m-y-1">

                                <!-- Edit start-->
                                <%
                                    for (ServiceCategoryDTO category : serviceCategoryList) {
                                %>
                                <div class="col l-5 m-7 s-12 card-item">
                                    <form action="MainController">
                                        <div class="card">
                                            <div class="row card-detail service-card">
                                                <div class="col l-o-1 m-o-1 s-o-1">
                                                    <div class="pad-y-1 flex-col flex-between full-h">
                                                        <div>
                                                            <p class="m-y-0">Explore new arrivals</p>
                                                            <h5 class="m-y-0">Shop the latest for </h5>
                                                            <h4 class="m-y-0"><%=category.getName()%></h4>
                                                        </div>

                                                        <div>
                                                            <button class="my-btn txt-lg bold" name="action" value="GoToServicePageByPlace">Show all</button>
                                                            <input type="hidden" name="category_ID" value="<%=category.getCategory_ID()%>"/>
                                                            <input type="hidden" name="category_name" value="<%=category.getName()%>"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col l-6 full-h full-w">
                                                    <div class="img pad-1">
                                                        <img style="object-fit: contain;" src="<%=category.getImage()%>"
                                                             alt="">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <%
                                    }
                                %>
                                <!-- Edit end-->

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Service List End -->

            <!-- Purchasing help Start-->
            <div id="help" class="grid wide m-y-1 pad-y-1 border-bot border-top">
                <div class="row help-block__list m-y-2">
                    <div class="col l-3 m-6 s-12">
                        <div class="help-block__item pad-y-1 pad-x-1">
                            <div class="help-block__img">
                                <img src="https://chisnghiax.com/ciseco/static/media/HIW1img.0a618bef4b830b5c682b.png"
                                     alt="">
                            </div>
                            <div class="help-block__text pad-y-1">
                                <p style="background-color: var(--red-bg); color: var(--red-txt)" class="txt-border">Step 1
                                </p>
                                <h6 class="m-y-1">Filter & Discover</h6>
                                <p class="text">Smart filtering and suggestions make it easy to find</p>
                            </div>
                        </div>
                    </div>
                    <div class="col l-3 m-6 s-12">
                        <div class="help-block__item  pad-y-1 pad-x-1">
                            <div class="help-block__img">
                                <img src="https://chisnghiax.com/ciseco/static/media/HIW2img.3d1e1bf2693a9272e96a.png"
                                     alt="">
                            </div>
                            <div class="help-block__text pad-y-1">
                                <p style="background-color: var(--blue-bg); color: var(--blue-txt)" class="txt-border">Step
                                    2</p>
                                <h6 class="m-y-1">Add to bag</h6>
                                <p class="text">Easily select the correct items and add them to the cart</p>
                            </div>
                        </div>
                    </div>
                    <div class="col l-3 m-6 s-12">
                        <div class="help-block__item  pad-y-1 pad-x-1">
                            <div class="help-block__img">
                                <img src="https://chisnghiax.com/ciseco/static/media/HIW3img.8b344c9a046e6b85a9ab.png"
                                     alt="">
                            </div>
                            <div class="help-block__text pad-y-1">
                                <p style="background-color: var(--yellow-bg); color: var(--yellow-txt)" class="txt-border">
                                    Step 3</p>
                                <h6 class="m-y-1">Fast shipping</h6>
                                <p class="text">The carrier will confirm and ship quickly to you</p>
                            </div>
                        </div>
                    </div>
                    <div class="col l-3 m-6 s-12">
                        <div class="help-block__item  pad-y-1 pad-x-1">
                            <div class="help-block__img">
                                <img src="https://chisnghiax.com/ciseco/static/media/HIW4img.c6a12d19e09f27d32678.png"
                                     alt="">
                            </div>
                            <div class="help-block__text pad-y-1">
                                <p style="background-color: var(--purple-bg); color: var(--purple-txt)" class="txt-border">
                                    Step 4</p>
                                <h6 class="m-y-1">Enjoy the product</h6>
                                <p class="text">Have fun and enjoy your 5-star quality products</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Purchasing help End -->

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

            <!-- Footer End -->
        </div>



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
    <script src="js/customer_homePage.js"></script>
    <script src="js/mySlider.js"></script>

</body>

</html>