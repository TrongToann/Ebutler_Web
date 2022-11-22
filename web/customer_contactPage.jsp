<%-- 
    Document   : customer_confirmation.jsp
    Created on : Oct 6, 2022, 10:28:49 PM
    Author     : thekh
--%>

<%@page import="com.ebutler.swp.dto.CustomerDTO"%>
<%@page import="com.ebutler.swp.dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

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
        <link rel="stylesheet" href="css/contact_base.css">

        <!-- My Stylesheet -->
        <link rel="stylesheet" href="css/customer_profilePage.css">
        <link rel="stylesheet" href="css/customerPage.css">
        <link rel="stylesheet" href="css/contact.css">
    </head>
    <c:if test="${sessionScope.LOGIN_USER == null || sessionScope.LOGIN_USER.getRole_id() != 'CUS'}">
        <c:redirect url="guest_loginPage.jsp"></c:redirect>
    </c:if>

    <body>
        <div class="container-xxl bg-white p-0">
            <!-- Spinner Start -->
            <div id="spinner"
                 class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->
            <%
                UserDTO login_user = (UserDTO) session.getAttribute("LOGIN_USER");
                CustomerDTO customer = (CustomerDTO) session.getAttribute("CURRENT_CUSTOMER");
                customer = (customer == null) ? new CustomerDTO() : customer;
            %>
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
                            <a class="nav-item nav-link search-open "><i class="fa-solid fa-magnifying-glass"></i></a>
                            <a href="MainController?action=MoveToCart" class="nav-item nav-link"><i class="fa-solid fa-cart-shopping"></i></a>
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Navbar End -->

            <div class="slider">
                <div class="slider__main">
                    <h1>CONTACT</h1>
                </div>
                <div class="slider__main-title">
                    <a href="">
                        <i class="fa-solid fa-house"></i>
                        <i class="fa-solid fa-angle-right"></i>
                        Contact
                    </a>
                </div>
            </div>

            <div class="body__container grid">
                <div class="form__heading-info">
                    <p style="font-size: 1.6rem;"><span style="color: var(--primary-color);" class="txt-xl bold">E-butler</span> always wants to receive valuable feedback from customers to have the opportunity to improve products and services even more. Your contributions are always invaluable to us</p>
                </div>

                <div class="flex-center">
                    <div style="width: 80%;" class="flex-around flex-vertical-center">
                        <div style="font-size: 1.8rem; font-weight: 700;" class="flex">
                            <div style="margin-right: 1rem; color: #ea4335;">
                                <i class="fa-regular fa-envelope"></i>
                            </div>
                            <span style="color: #ea4335;">ebutlercomp@gmail.com</span>
                        </div>
                        <div style="font-size: 1.8rem; font-weight: 700;" class="flex">
                            <div style="margin-right: 1rem; color: #0f91f3;">
                                <i class="fa-brands fa-facebook"></i>
                            </div>
                            <a href="https://www.facebook.com/profile.php?id=100068867764033">Direct counseling</a>
                        </div>
                    </div>
                </div>

                <form action="MainController">
                    <div class="form__body-info"> 
                        <div class="form__body-issue">
                            <h1 style="color: var(--primary-color);">Feedback problem</h1>
                            <div style="font-size: 1.6rem;" class="form__body-issue-input">
                                <input type="radio" value="complain" name="issue-input" required="">
                                <label for="" value="complain">Complain</label>
                                <input type="radio" value="Praise" name="issue-input" required="">
                                <label for="" value="Praise">Praise</label>
                                <input type="radio" value="other" name="issue-input" required="">
                                <label for="" value="other">Other problem</label>
                            </div>
                        </div>
                        <textarea style="width: 100%; height: 100px; max-height: 100px; font-size: 1.4rem; font-weight: 300; padding: 8px;" name="content" id="" required=""></textarea>
                    </div>
                    <div style="border-top: 1px solid rgb(219, 219, 219); border-bottom: 1px solid rgb(219, 219, 219);"  class="pad-y-2 m-y-2">
                        <div >
                            <h1>Information confidentiality agreement</h1>
                        </div>

                        <div style="margin-left: 2rem;">
                            <ul style="list-style-type: decimal; font-size: 1.6rem">
                                <li class="m-y-0">E-butler will always keep customers' information confidential and comply with relevant information security laws.</li>
                                <li class="m-y-0">E-butler may disclose personal information for the purpose of resolving customer complaints and grievances to:</li>
                                <ul>
                                    <li class="m-y-0">- Departments under E-butler Vietnam</li>
                                    <li class="m-y-0">- An officially authorized third party from E-butler Vietnam to handle complaints and complaints of a serious nature.</li>
                                </ul>
                            </ul>
                        </div>

                        <div>
                            <h1>* Note</h1>
                        </div>

                        <div style="margin-left: 2rem;">
                            <ul style="list-style-type: decimal; font-size: 1.6rem;">
                                <li class="m-y-0">Please provide accurate personal information so that E-butler can contact to resolve customer inquiries, feedback and complaints as quickly as possible..</li>
                                <li class="m-y-0">Saturdays, Sundays, and public holidays will make the processing of your feedback slower than usual.</li>
                            </ul>
                        </div>

                        <div class="m-y-2 flex-vertical-center">
                            <div style="margin-right: 2rem;" class="flex-col">
                                <input style="width: 3rem; height: 3rem" type="checkbox" name="" class="confirmation-check">
                            </div>

                            <span style="font-size: 1.6rem; font-weight: 700;" class="auth-form__policy-text">
                                I confirm that the personal information provided above is completely accurate and agree to E-butler's use of such information for the purpose of responding to feedback.
                            </span>
                        </div>
                    </div>
                    <button id="btn-feedback" name="action" value="SendFeedBack" class="input__item--submit btn--disable" disabled>SEND FEEDBACK</button>

                </form>

            </div>



            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5  wow fadeIn" data-wow-delay="0.1s">
                <div class="container py-5">
                    <div class="row g-5">
                        <div class="col-lg-3 col-md-6">
                            <h5 class="text-white mb-4">Get In Touch</h5>
                            <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i></p>
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
    <script>
        document.querySelector('.confirmation-check').addEventListener('click', EnableButton)

        function EnableButton() {
            var btn_feedback = document.getElementById('btn-feedback');
            if (this.checked) {
                btn_feedback.classList.remove("btn--disable");
                btn_feedback.removeAttribute('disabled');
            } else {
                btn_feedback.classList.add("btn--disable");
                btn_feedback.setAttribute('disabled', 'disabled');
            }
        }
    </script>

</body>

</html>