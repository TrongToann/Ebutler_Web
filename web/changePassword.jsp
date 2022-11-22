<%-- 
    Document   : changePassword
    Created on : Oct 12, 2022, 10:50:02 PM
    Author     : DELL
--%>

<%@page import="com.ebutler.swp.dto.ProviderDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>E-Butler | Change Password</title>
  <link rel="icon" type="image/x-icon" href="https://scontent.fsgn2-4.fna.fbcdn.net/v/t1.15752-9/307058616_802160467603859_5558839303148788245_n.png?stp=dst-png_p1080x2048&_nc_cat=109&ccb=1-7&_nc_sid=ae9488&_nc_ohc=vGhbAQumiiwAX8TbYC2&tn=nHI45FEgylR7fWDG&_nc_ht=scontent.fsgn2-4.fna&oh=03_AVJuwn5Dqs20uZj9NKDP_eqwggpHhYGN5cC90Kw1btakKQ&oe=6363B3B1">
  <!-- <link href="../css/provider.css" rel="stylesheet"> -->
  <link href="./css/bootstrap.min.css" rel="stylesheet">
  <link href="./css/style.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

  <!-- Core CSS -->
  <link rel="stylesheet" href="./vendor/css/core.css" class="template-customizer-core-css" />
  <link rel="stylesheet" href="./vendor/css/theme-default.css" class="template-customizer-theme-css" />
  <link rel="stylesheet" href="./css/demo.css" />
  <link rel="icon" type="image/x-icon" href="./img/favicon/favicon.ico" />
  <link rel="stylesheet" href="./vendor/fonts/boxicons.css" />
  <!-- Fonts -->
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
    rel="stylesheet" />
</head>

<body>
  <div class="container-xxl">
    <div class="container-fluid nav-bar bg-white px-0">

      <form action="MainController" method="post">
                    <nav class="navbar navbar-expand-lg  navbar-light py-0 px-5">
                        <a class="navbar-brand d-flex align-items-center text-center">
                            <div class="icon p-2 me-2">
                                <img class="img-fluid"
                                     src="https://scontent.fsgn2-4.fna.fbcdn.net/v/t1.15752-9/307058616_802160467603859_5558839303148788245_n.png?stp=dst-png_p1080x2048&_nc_cat=109&ccb=1-7&_nc_sid=ae9488&_nc_ohc=vGhbAQumiiwAX8TbYC2&tn=nHI45FEgylR7fWDG&_nc_ht=scontent.fsgn2-4.fna&oh=03_AVJuwn5Dqs20uZj9NKDP_eqwggpHhYGN5cC90Kw1btakKQ&oe=6363B3B1"
                                     alt="Icon" style="width: 30px; height: 30px;">
                            </div>
                            <h1 class="m-0 " style="color:#273A89 ;">E-Butler</h1>
                        </a>
                        <button type="button" class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                            <span class="navbar-toggler-icon"></span>
                        </button>



                        <div class="collapse navbar-collapse" id="navbarCollapse">
                            <div class="navbar-nav ms-auto">
                                <button style="font-weight: bold;" name="action" value="ProviderProduct" class="nav-item nav-link " id="product"
                                        onclick="activeProduct()">Product</button> 
                                <button style="font-weight: bold;" name="action" value="ProviderService"  class="nav-item nav-link" id="service"
                                        onclick="activeService()">Service</button>
                                <button style="font-weight: bold;" name="action" value="ProviderOrder"  class="nav-item nav-link" id="order"
                                        onclick="activeOrder()">Orders</button>
                                <button style="font-weight: bold;" name="action" value="ProviderStaff" class="nav-item nav-link" id="staff"
                                        onclick="activeStaff()">Staff</button>
                            </div>   
                        </div>





                        <!-- On hover dropdown button -->

                        <!-- <a href="" class="btn btn-primary px-3 d-none d-lg-flex">Add Property</a> -->
                        <div class="btn-group me-3">

                            <img class="avatar avatar-md rounded-circle "
                                 src="https://i.bloganchoi.com/bloganchoi.com/wp-content/uploads/2021/07/avatar-doi-ban-than-2021-21-696x696.jpeg?fit=700%2C20000&quality=95&ssl=1"
                                 id="dropdownMenuButton" data-bs-toggle="dropdown" data-bs-display="static">

                            </img>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-start">
                                <li><a data-bs-target="#basicModal1" data-bs-toggle="modal" class="dropdown-item" href="javascript:void(0);"><i class="bx bx-user m-2"></i>My Profile</a></li>
                                <li><a class="dropdown-item" href="changePassword.jsp"><i class="bx bx-lock m-2"></i>Change Password</a>
                                </li>
                                <!-- <li><a class="dropdown-item" href="javascript:void(0);">Something else here</a></li> -->
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li>
                                    <button class="dropdown-item"  name="action" value="LogoutProvider" ><i class="bx bx-log-out m-2"></i>Logout</button>
                                </li>
                            </ul>
                        </div>

                    </nav>
      </form>
    </div>
      <form action="MainController" method="POST"> 
    <div class="container-xxl d-flex justify-content-center py-5">
      <div style="width:600px" class="card ms-5">
        <div class="card-body">
          <div>
            <h4 class="mb-2">Change Your Password </h4>
            <p>Your new password must be different from the old password</p>
          </div>

          <div class="mb-3 form-password-toggle">
            <label class="form-label" for="password">Old Password</label>
            <div style="width:400px" class="input-group input-group-merge">
              <input type="password" id="password" class="form-control" name="OldPassword" placeholder="············"
                aria-describedby="password">
              <span class="input-group-text cursor-pointer"><i class="bx bx-show"></i></span>
            </div>
          </div>
          <div style="width:400px" class="mb-3 form-password-toggle">
            <label class="form-label" for="password">New Password</label>
            <div class="input-group input-group-merge">
              <input type="password" id="password" class="form-control" name="NewPassword" placeholder="············"
                aria-describedby="password">
              <span class="input-group-text cursor-pointer"><i class="bx bx-show"></i></span>
            </div>
          </div>
           <div style="width:400px" class="mb-3 form-password-toggle">
            <label class="form-label" for="password">Confirm Password</label>
            <div class="input-group input-group-merge">
              <input type="password" id="password" class="form-control" name="ConfirmPassword" placeholder="············"
                aria-describedby="password">
              <span class="input-group-text cursor-pointer"><i class="bx bx-show"></i></span>
            </div>
          </div>


          <div class="d-flex justify-content-end">
            <button class="btn btn-outline-danger ms-1">Cancel</button>
            <button name="action" value="ChangePasswordProvider" class="btn btn-primary ms-1">Confirm</button>
          </div>

        </div>


      </div>
    </div>
    </form>      
      <%
          String message = (String) request.getAttribute("MESSAGE") ; 
          if (message == null) {
          message = "" ; 
          } 
      %> 
      <h3 style="padding: 20px 20px ; text-align: center ; color: white "><%= message %></h3>

  </div>
  <!-- Modal -->
                    <%
                      ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER") ;  
                      
                    %>
                    <div class="modal js-modal-create " id="basicModal1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="nav-header">Profile Details</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body pt-1">

                                    <!-- Account -->
                                    <div class="card-body">
                                        <div class="d-flex align-items-start align-items-sm-center gap-4">
                                            <img  style="border-radius: 20%;"
                                                  src="https://i.bloganchoi.com/bloganchoi.com/wp-content/uploads/2021/07/avatar-doi-ban-than-2021-21-696x696.jpeg?fit=700%2C20000&quality=95&ssl=1"
                                                  alt="user-avatar" class="d-block rounded w-50 avatar avatar-xl h-50" id="uploadedAvatar">
                                            <div class="button-wrapper">
                                                <label for="upload" class="btn btn-primary me-2 mb-4" tabindex="0">
                                                    <span class="d-none d-sm-block">Upload new photo</span>
                                                    <i class="bx bx-upload d-block d-sm-none"></i>
                                                    <input type="file" id="upload" class="account-file-input" hidden="" accept="image/png, image/jpeg">
                                                </label>

                                                <p style="font-size:10px ;" class="text-muted mb-0">Allowed JPG or PNG.</p>
                                            </div>
                                        </div>
                                    </div>
                                    <hr class="my-0">
                                    <div class="card-body">
                                        <form action="MainController"  method="POST" >
                                            <div class="row">
                                                <div class="mb-3 col-md-6">
                                                    <label for="firstName" class="form-label">UserName: </label>
                                                     <input class="form-control" type="text"  name="firstName" value="<%= provider.getUsername() %>" readonly="" > 
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label for="lastName" class="form-label">Provider Full Name: </label>
                                                    <input class="form-control" type="text" name="lastName" value="" placeholder="<%= provider.getName() %>" >
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label for="email" class="form-label">E-mail</label>
                                                    <input class="form-control" type="text" name="email" value="" placeholder="<%= provider.getEmail() %>"> 
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label" for="phoneNumber">Phone Number</label>
                                                    <div class="input-group input-group-merge">
                                                        <span class="input-group-text">VN (+84)</span>
                                                        <input type="text" name="phoneNumber" class="form-control"
                                                               placeholder="<%= provider.getPhone() %> ">
                                                    </div>
                                                </div>
                                                <div class="mb-3 col-md-12">
                                                    <label for="address" class="form-label">Address</label>
                                                    <input type="text" class="form-control"  name="address" placeholder="Address">
                                                </div>

                                            </div>
                                            <div class="mt-2">
                                                <button name="action" value="UpdateProfileProvider" type="submit" class="btn btn-primary me-2">Save changes</button>
                                                <button type="reset" class="btn btn-outline-secondary">Cancel</button>
                                            </div>
                                        </form>
                                    </div>
                                    <!-- /Account -->



                                </div>
                            </div>
                        </div>
                    </div>



                </div>
  <!-- Footer Start -->
  <div class="container-xxl">
    <div class="container-fluid bg-dark text-white-50 footer pt-5  wow fadeIn" data-wow-delay="0.1s">
      <div class="container py-5">
        <div class="row g-5">
          <div class="col-lg-3 col-md-6">
            <h5 class="text-white mb-4">Get In Touch</h5>
            <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>Lô E2a-7, Đường D1, Đ. D1, Long Thạnh Mỹ, Thành Phố
              Thủ Đức, Thành phố Hồ Chí Minh</p>
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
              <input class="form-control bg-transparent w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
              <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  

  </div>










  <!-- Footer End -->
  <!-- Core JS -->
  <!-- build:js assets/vendor/js/core.js -->
  <script src="./vendor/libs/jquery/jquery.js"></script>
  <script src="./vendor/libs/popper/popper.js"></script>
  <script src="./vendor/js/bootstrap.js"></script>
  <script src="./vendor/js/helpers.js"></script>
  <script src="./vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

  <script src="./vendor/js/menu.js"></script>
  <!-- endbuild -->

  <!-- Vendors JS -->
  <script src="./vendor/libs/apex-charts/apexcharts.js"></script>

  <!-- Main JS -->
  <script src="./js/main.js"></script>

  <!-- Page JS -->
  <script src="./js/dashboards-analytics.js"></script>

  <!-- Place this tag in your head or just before your close body tag. -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
</body>

</html>
