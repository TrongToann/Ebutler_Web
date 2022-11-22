<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>E-Butler</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">
        <link rel="icon" type="image/png" href="img/logo-bulldog.png">
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
    </head>

    <body>
        <div class="container-xxl bg-white p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->

            <!-- Navbar Start -->
            <div style="z-index: 9999;" class="container-fluid nav-bar bg-transparent">
                <nav class="navbar navbar-expand-lg bg-white navbar-light py-0 px-4">
                    <a href="MainController?action=E-Butler" class="navbar-brand d-flex align-items-center text-center">
                        <div class="p-2 me-2">
                            <img class="img-fluid" src="img/logo.png" alt="Icon" style="width: 40px; height: 40px;">
                        </div>
                        <h1 class="m-0 text-primary">E-Butler</h1>
                    </a>
                    <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav ms-auto">
                            <a href="#" class="nav-item nav-link active">Home</a>
                            <a href="#about_us" class="nav-item nav-link">About Us</a>
                            <div class="nav-item dropdown">
                                <a href="#how_it_works" class="nav-link">How it works</a>

                            </div>
                            <a href="#contact_us" class="nav-item nav-link">Contact</a>
                            <div class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" disabled>Join</a>
                                <div method="POST" class="dropdown-menu rounded-0 m-12">
                                    <form action="MainController" method="POST">
                                        <button type="submit" class="dropdown-item login--link">Login</button>
                                        <input value="Login" name="action" type="hidden">
                                        <input value="false" name="isLogin" type="hidden">
                                    </form>
                                    <form action="MainController" method="POST">
                                        <button type="submit" class="dropdown-item login--link">Register</button>
                                        <input value="Register" name="action" type="hidden">
                                        <input value="false" name="isRegister" type="hidden">
                                    </form>
                                </div>
                            </div>                   
                        </div>
                    </div>
                </nav>
            </div>
            <!-- Navbar End -->

            <!-- Header Start -->
            <div class="container-fluid header bg-white p-0">
                <div class="row g-0 align-items-center flex-column-reverse flex-md-row">
                    <div class="col-md-8 p-5 mt-lg-5 mb">
                        <h1 class="display-5 animated fadeIn mb-4">Find A <span class="text-primary">Perfect Assistance</span> To Manage Your Home Work</h1>
                        <p class="animated fadeIn mb-4 pb-2">Website provide the best services...</p>
                        <a href="" class="btn btn-primary py-3 px-5 me-3 animated fadeIn btn-s">Get Started</a>
                    </div>
                    <div class="col-md-4 animated fadeIn">
                        <img class="slider-img hide-mb" src="https://www.e-butler.com/wp-content/uploads/2022/01/14-1.png" alt="">
                    </div>
                </div>
            </div>
            <!-- Header End -->

            <!-- About Start -->
            <div id="about_us" class="container-xxl py-5 mb">
                <div class="container">
                    <div class="row g-5 align-items-center">
                        <div class="col-lg-6 col-md-0 col-sm-0 wow fadeIn hide-tb-mb" data-wow-delay="0.1s">
                            <div class="about-img position-relative overflow-hidden p-5 pe-0">
                                <img class="img-fluid w-100" src="img/about_us.png">
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-12 col-sm-12 wow fadeIn" data-wow-delay="0.5s">
                            <h1 class="mb-4"># Place To Find The Perfect Assistance</h1>
                            <p class="mb-4">Tempor erat elitr rebum at clita. Diam dolor diam ipsum sit. Aliqu diam amet diam et eos. Clita erat ipsum et lorem et sit, sed stet lorem sit clita duo justo magna dolore erat amet</p>
                            <p><i class="fa fa-check text-primary me-3"></i>Tempor erat elitr rebum at clita</p>
                            <p><i class="fa fa-check text-primary me-3"></i>Aliqu diam amet diam et eos</p>
                            <p><i class="fa fa-check text-primary me-3"></i>Clita duo justo magna dolore erat amet</p>
                            <a class="btn btn-primary py-3 px-5 mt-3 btn-s" href="">Read More</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- About End -->

            <!-- How It Works Start -->
            <div id="how_it_works" class="container-xxl py-5 mb">
                <div class="instruction__container flex-md-row container">
                    <div class="instruction col-lg-8 col-md-12 col-sm-12">
                        <div class="instruction__header">
                            <p class="instruction__header-title">How Does It Work</p>
                            <h3>It's as simple as asking a question!</h3>
                        </div>
                        <div class="instruction__detail scrollable-y">
                            <div class="instruction__item">
                                <div class="instruction__item-icon hide-mb">
                                    <img src="https://www.e-butler.com/wp-content/uploads/2022/02/LOGO-01-250-e1644138867670.png" alt="">
                                </div>
                                <div class="instruction__item-description">
                                    <h5 class="instruction__item-description-header">Sign Up!</h5>
                                    <p class="instruction__item-description-content">Answering a couple of questions will allow us to know you better!</p>
                                </div>
                            </div>
                            <div class="instruction__item">
                                <div class="instruction__item-icon hide-mb">
                                    <img src="https://www.e-butler.com/wp-content/uploads/2022/02/LOGO-01-250-e1644138867670.png" alt="">
                                </div>
                                <div class="instruction__item-description">
                                    <h5 class="instruction__item-description-header">Search for a Service</h5>
                                    <p class="instruction__item-description-content">What do you need? Just browse the available categories (covering 300+ services) and take your pick!</p>
                                </div>
                            </div>
                            <div class="instruction__item">
                                <div class="instruction__item-icon hide-mb">
                                    <img src="https://www.e-butler.com/wp-content/uploads/2022/02/LOGO-01-250-e1644138867670.png" alt="">
                                </div>
                                <div class="instruction__item-description">
                                    <h5 class="instruction__item-description-header">Or Book Through Chat!</h5>
                                    <p class="instruction__item-description-content">Our lifestyle managers are always ready to listen and take over the booking when necessary.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center;" class="instruction__logo col-md-4 wow fadeIn hide-tb-mb">
                        <img style="border-radius: 20px;" class="img-fluid w-50" src="img/how_it_works.png" alt="">
                    </div>
                </div>
            </div>
            <!-- How It Works End -->


            <!-- Contact Us Start-->
            <div id="contact_us" class="container-xxl py-5 mb">
                <div class="container">
                    <div class="bg-light rounded p-3">
                        <div class="bg-white rounded p-4" style="border: 1px dashed rgba(0, 185, 142, .3)">
                            <div class="row g-5 align-items-center">
                                <div style="text-align: center;" class="col-lg-4 wow fadeIn hide-tb-mb" data-wow-delay="0.1s">
                                    <img class="img-fluid w-50" src="img/contact.png" alt="">
                                </div>
                                <div class="col-lg-8 wow fadeIn" data-wow-delay="0.5s">
                                    <div class="mb-4">
                                        <h1 class="mb-3">Contact With Our Certified Agent</h1>
                                        <p>Eirmod sed ipsum dolor sit rebum magna erat. Tempor lorem kasd vero ipsum sit sit diam justo sed vero dolor duo.</p>
                                    </div>
                                    <a href="#!" style="margin: 4px 0;" class="btn btn-primary py-3 px-4 me-2 btn-s"><i class="fa fa-phone-alt me-2"></i>Make A Call</a>
                                    <a href="#!" style="margin: 4px 0;" class="btn btn-dark py-3 px-4 btn-s"><i class="fa fa-calendar-alt me-2"></i>Get Appoinment</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Contact Us End-->

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

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>

    </body>

</html>