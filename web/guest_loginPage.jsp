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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"/>

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap" rel="stylesheet">

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
        <link rel="stylesheet" href="css/guestPage.css">
        <link rel="stylesheet" href="css/base.css">

        <style>
            /* toast */
            #toast {
                position: fixed;
                top: 32px;
                right: 32px;
                z-index: 999999;
            }

            .toast {
                display: flex;
                align-items: center;
                background-color: #fff;
                border-radius: 2px;
                padding: 20px 0;
                min-width: 400px;
                max-width: 450px;
                border-left: 4px solid;
                box-shadow: 0 5px 8px rgba(0, 0, 0, 0.08);
                transition: all linear 0.3s;
            }

            .toast--success {
                border-color: #47d864;
            }

            .toast--success .toast__icon {
                color: #47d864;
            }

            .toast--info {
                border-color: #2f86eb;
            }

            .toast--info .toast__icon {
                color: #2f86eb;
            }

            .toast--warning {
                border-color: #ffc021;
            }

            .toast--warning .toast__icon {
                color: #ffc021;
            }

            .toast--error {
                border-color: #ff623d;
            }

            .toast--error .toast__icon {
                color: #ff623d;
            }

            .toast+.toast {
                margin-top: 24px;
            }

            .toast__icon {
                font-size: 24px;
            }

            .toast__icon,
            .toast__close {
                padding: 0 16px;
            }

            .toast__body {
                flex-grow: 1;
            }

            .toast__title {
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }

            .toast__msg {
                font-size: 14px;
                color: #888;
                margin-top: 6px;
                line-height: 1.5;
            }

            .toast__close {
                font-size: 20px;
                color: rgba(0, 0, 0, 0.3);
                cursor: pointer;
            }

            /* animation */
            @keyframes slideInLeft {
                from {
                    opacity: 0;
                    transform: translateX(calc(100% + 32px));
                }

                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            @keyframes fadeOut {
                to {
                    opacity: 0;
                }
            }
        </style>
    </head>

    <body>
        <%
            String login_error = (String) request.getAttribute("LOGIN_ERROR");

            login_error = (login_error == null) ? "" : login_error;

            String message = (String) request.getAttribute("REGIST_SUCCESS");

            message = (message == null) ? "" : message;
        %>
        <div class="container-xxl bg-white p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->


            <!-- Navbar Start -->
            <div class="container-fluid nav-bar bg-transparent">
                <nav style="justify-content: center" class="navbar navbar-expand-lg bg-white navbar-light py-0 px-4">
                    <a href="guest_landingPage.jsp" class="navbar-brand d-flex align-items-center text-center">
                        <div class="p-2 me-2">
                            <img class="img-fluid" src="img/logo.png" alt="Icon" style="width: 40px; height: 40px;">
                        </div>
                        <h1 class="m-0 text-primary">E-Butler</h1>
                    </a>
                </nav>
            </div>
            <!-- Navbar End -->


            <!-- Header Start -->
            <div class="container-fluid bg-white p-0">
                <div class="slider row g-0 align-items-center flex-column-reverse flex-md-row">

                    <div class="col-md-0 col-lg-1 col-sm-0 animated fadeIn"></div>

                    <div class="col-md-4 col-lg-4 col-sm-0 animated fadeIn website-logo">
                        <img style="transform: scaleX(-1)" class="slider-img" src="https://www.e-butler.com/wp-content/uploads/2022/01/14-1.png" alt="">
                    </div>

                    <div class="col-md-1 col-lg-1 col-sm-0 animated fadeIn"></div>

                    <div class="col-lg-6 col-md-10 col-sm-12 animated fadeInUp">
                        <!-- Login Form Start -->
                        <div id="login-form" class="auth-form">
                            <div class="auth-form__header">
                                <h3 class="auth-form__heading">Not a member?</h3>
                                <form action="MainController" method="POST">
                                    <button type="submit" class="dropdown-item login--link auth-form__heading auth-form__switch-btn">Register</button>
                                    <input value="Register" name="action" type="hidden">
                                </form>
                            </div>

                            <div class="auth-form__body">
                                <form action="MainController" method="POST" id="form">
                                    <div class="auth-form__form">
                                        <div class="auth-form__title">
                                            <p>Connect to E-Butler</p>
                                        </div>

                                        <div class="auth-form__social-connection">
                                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/EButler_swp391/MainController?action=LoginWithGoogle&response_type=code
                                               &client_id=1081251047556-e4afc0d4vf6ud95n2faf0dufevp65fj5.apps.googleusercontent.com&approval_prompt=force" class="btn btn--with-icon--google social-connection__item">
                                                <i class="fa-brands fa-google"></i>
                                                <span class="auth-form__social-connection__title">
                                                    Login with Google
                                                </span> 
                                            </a>

                                        </div>

                                        <input type="text" name="username" class="auth-form__input border-bottom m-y-1 pad-x-0" required="" placeholder="Username">

                                        <input type="password" name="password" class="auth-form__input border-bottom m-y-1 pad-x-0" required="" placeholder="Password">

                                        <!-- Recapcha -->
                                        <div class="g-recaptcha" data-sitekey="6LcR5ZUiAAAAAJEVFWk0F2s2WVeoFhAnRHQDaCGW"></div>
                                        <div id="error"></div>
                                        <!-- Recapcha -->

                                    </div>

                                    <div class="auth-form__help flex-between">
                                        <div class="auth-form__aside">
                                            <%
                                                if (!login_error.isEmpty()) {
                                            %>

                                            <span class="auth-form__notify">
                                                <i class="fa-solid fa-triangle-exclamation"></i>
                                                <p><%=login_error%></p>
                                            </span> 

                                            <%
                                                }
                                            %>
                                        </div>
                                        <a id="forgot-password-link" class="auth-form__help-forgot">Forgot password?</a>
                                    </div>

                                    <div class="auth-form__controls m-y-2">
                                        <button type="submit" name="action" value="Login" id="btn-login" class="btn btn-size-s btn-primary px-5 py-2">Login</button>
                                        <input type="hidden" name="isLogin" value="true">
                                        <input type="hidden" name="action" value="Login">
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!-- Login Form End -->

                        <!-- Forgot password Start -->
                        <div id="forgot-password-form" class="auth-form hide">
                            <div class="auth-form__header">
                                <form action="MainController" method="POST">
                                    <button type="submit" class="dropdown-item login--link auth-form__heading auth-form__switch-btn">Register</button>
                                    <input value="Register" name="action" type="hidden">
                                </form>
                                <span>/</span>
                                <form action="MainController" method="POST">
                                    <button type="submit" class="dropdown-item login--link auth-form__heading auth-form__switch-btn">Login</button>
                                    <input value="Login" name="action" type="hidden">
                                    <input value="false" name="isLogin" type="hidden">
                                </form>                     
                            </div>

                            <div class="forgot-password-form-container">

                                <img style="width: 160px; height: 160px" src="https://scontent.fsgn16-1.fna.fbcdn.net/v/t1.15752-9/306726020_513456713943336_4656678356879644206_n.png?_nc_cat=111&ccb=1-7&_nc_sid=ae9488&_nc_ohc=uxAtFMpSQXcAX-Wzu8F&_nc_ht=scontent.fsgn16-1.fna&oh=03_AVKUncPUZhez3W-9IlAzLja65ocWn5f4EZlifA9Glk3_-A&oe=635385F9" alt="">
                                <h1>FORGOT PASSWORD?</h1>
                                <h5>Don't worry! Enter your email below and we'll email you with instruction on how to reset your password.</h5>
                                <input type="text" placeholder="ENTER YOUR EMAIL...">
                                <a href="" class="btn btn-primary px-4 py-2"> SEND </a>
                            </div>
                        </div>
                        <!-- Forgot password End -->
                    </div>
                </div>



            </div>
            <!-- Header End -->

            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-white-50 footer pt-5  wow fadeIn" data-wow-delay="0.1s">
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


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>

        <%
            if (!message.isEmpty()) {
        %>
        <div id="toast"></div>
        <%
            }
        %>  

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
        <script src="js/login.js"></script>

        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script>
            window.onload = function () {
                let isValid = false;
                const form = document.getElementById("form");
                const error = document.getElementById("error");

                form.addEventListener("submit", function (e) {
                    e.preventDefault();
                    const response = grecaptcha.getResponse();
                    console.log(response);
                    if (response) {
                        form.submit();
                    } else {
                        error.innerHTML = "Please check";
                    }
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
                if (!message.isEmpty()) {
            %>
                toast.classList.add("toast", `toast--success`, 'showing');
                toast.style.animation = `slideInLeft ease .3s, fadeOut linear 1s 1.5s forwards`;
                toast.innerHTML =
                        `<div class="toast__icon">
            <i class="fas fa-check-circle"></i>
            </div>
            <div class="toast__body">
            <h3 class="toast__title">Success</h3>
                <p class="toast__msg"><%=message%></p>
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