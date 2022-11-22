<%-- 
    Document   : StaffProvider
    Created on : Oct 9, 2022, 10:58:21 PM
    Author     : DELL
--%>

<%@page import="com.ebutler.swp.dto.ProviderServiceDTO1"%>
<%@page import="com.ebutler.swp.dto.ProviderDTO"%>
<%@page import="com.ebutler.swp.dto.ProviderDTO"%>
<%@page import="com.ebutler.swp.dto.ProviderStaffDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>E-Butler | Staff</title>
        <link rel="icon" type="image/x-icon" href="https://scontent.fsgn2-4.fna.fbcdn.net/v/t1.15752-9/307058616_802160467603859_5558839303148788245_n.png?stp=dst-png_p1080x2048&_nc_cat=109&ccb=1-7&_nc_sid=ae9488&_nc_ohc=vGhbAQumiiwAX8TbYC2&tn=nHI45FEgylR7fWDG&_nc_ht=scontent.fsgn2-4.fna&oh=03_AVJuwn5Dqs20uZj9NKDP_eqwggpHhYGN5cC90Kw1btakKQ&oe=6363B3B1">

        <!-- <link href="../css/provider.css" rel="stylesheet"> -->
        <link href="./css/bootstrap1.min.css" rel="stylesheet">
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
        <link rel="stylesheet" href="./css/base.css" />
        <link rel="stylesheet" href="./css/guestPage.css" />
    </head>
    <c:if test="${sessionScope.LOGIN_USER == null || sessionScope.LOGIN_USER.getRole_id() != 'PRO'}">
        <c:redirect url="guest_loginPage.jsp"></c:redirect>
    </c:if>
    <body>
        <%
            ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER");
        %>
        <div class="container-xxl">
            <div class="container-fluid nav-bar bg-white px-0">

                <form action="MainController" method="post">
                    <nav class="navbar navbar-expand-lg  navbar-light py-0 px-5">
                        <a class="navbar-brand d-flex align-items-center text-center">
                            <div class="icon p-2 me-2">
                                <img class="img-fluid"
                                     src="img/logo.png"
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

                            <%
                                if (provider.getLogo().contains("https")) {
                            %>
                            <img class="avatar avatar-md rounded-circle "
                                 src="<%= provider.getLogo()%>"
                                 id="dropdownMenuButton" data-bs-toggle="dropdown" data-bs-display="static"/>
                            <%
                            } else if (provider.getLogo().isEmpty()) {
                            %>
                            <img class="avatar avatar-md rounded-circle "
                                 src="img/default-avatar.jpg"
                                 id="dropdownMenuButton" data-bs-toggle="dropdown" data-bs-display="static"/>
                            <%
                            } else {
                            %>
                            <img class="avatar avatar-md rounded-circle "
                                 src="img/<%= provider.getLogo()%>"
                                 id="dropdownMenuButton" data-bs-toggle="dropdown" data-bs-display="static"/>
                            <%
                                }
                            %>
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
                <div class="mx-5 mt-3">
                    <nav aria-label="breadcrumb m-5">
                        <ol class="breadcrumb breadcrumb-style1">
                            <li class="breadcrumb-item">
                                <a href="#">Home</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="#">Staff</a>
                            </li>
                            <li class="breadcrumb-item active">Staff List</li>
                        </ol>
                    </nav>
                </div>
                <div class="mt-3 ms-5 d-flex justify-content-start ">
                    <div>
                        <h2 style="font-weight:600 ;" class="">Staff List</h2>
                    </div>
                </div>
                <!-- MODAL PROFILE -->

                <div class="modal js-modal-create " id="basicModal1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="nav-header">Profile Details</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body pt-1">


                                <div class="card-body">
                                    <div class="d-flex align-items-start align-items-sm-center gap-4">
                                        <%
                                            if (provider.getLogo().contains("https")) {
                                        %>
                                        <img alt="user-avatar"
                                             src="<%= provider.getLogo()%>"
                                             class="d-block rounded w-50 avatar avatar-xl h-50" id="uploadedAvatar"/>
                                        <%
                                        } else if (provider.getLogo().isEmpty()) {
                                        %>
                                        <img alt="user-avatar"
                                             src="img/default-avatar.jpg"
                                             class="d-block rounded w-50 avatar avatar-xl h-50" id="uploadedAvatar"/>
                                        <%
                                        } else {
                                        %>
                                        <img  alt="user-avatar"
                                              src="img/<%= provider.getLogo()%>"
                                              class="d-block rounded w-50 avatar avatar-xl h-50" id="uploadedAvatar">
                                        <%
                                            }
                                        %>
                                        <div class="button-wrapper">
                                            <form method="POST" action="UploadPhotoController" enctype="multipart/form-data" >
                                                <input type="file" name="file"/>
                                                <input type="hidden" name="role" value="provider"/>
                                                <input type="submit" name="action" value="Upload Photo"/>
                                            </form>

                                            <p style="font-size:10px ;" class="text-muted mb-0">Allowed JPG or PNG.</p>
                                        </div>
                                    </div>
                                </div>
                                <hr class="my-0">
                                <div class="card-body">
                                    <form action="MainController" id="formAccountSettings" method="POST" onsubmit="return false">
                                        <div class="row">
                                            <div class="mb-3 col-md-6">
                                                <label for="firstName" class="form-label">UserName: </label>
                                                <input class="form-control" type="text" id="firstName" name="firstName" value="<%= provider.getUsername()%>" readonly="" > 
                                            </div>
                                            <div class="mb-3 col-md-6">
                                                <label for="lastName" class="form-label">Provider Full Name: </label>
                                                <input class="form-control" type="text" name="lastName" id="lastName" value="" placeholder="<%= provider.getName()%>" >
                                            </div>
                                            <div class="mb-3 col-md-6">
                                                <label for="email" class="form-label">E-mail</label>
                                                <input class="form-control" type="text" id="email" name="email" value="" placeholder="<%= provider.getEmail()%>"> 
                                            </div>
                                            <div class="mb-3 col-md-6">
                                                <label class="form-label" for="phoneNumber">Phone Number</label>
                                                <div class="input-group input-group-merge">
                                                    <span class="input-group-text">VN (+84)</span>
                                                    <input type="text" id="phoneNumber" name="phoneNumber" class="form-control"
                                                           placeholder="<%= provider.getPhone()%> ">
                                                </div>
                                            </div>
                                            <div class="mb-3 col-md-12">
                                                <label for="address" class="form-label">Address</label>
                                                <input type="text" class="form-control" id="address" name="address" placeholder="Address">
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

                <!--END MODAL PROFILE -->
                <!-- MODAL EDIT -->
                <div class="modal js-modal-confirm" id="modalToggle" aria-hidden="true">
                    <div class="modal-dialog  modal-dialog-centered">
                        <div class="modal-content ">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalToggleLabel">Edit Product</h5>
                                <button type="button" data-bs-dismiss="modal" class="btn-close js-modal-close-1"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="row">
                                        <div class="col mb-3">
                                            <label for="productname" class="form-label">Product Name</label>
                                            <input type="text" id="username" class="form-control" placeholder="Enter Username">
                                        </div>
                                        <div class="col mb-3">
                                            <label class="form-label">Status</label>
                                            <select class="form-select " aria-label="Default select example">
                                                <option selected>Choose status</option>
                                                <option value="1">Active</option>
                                                <option value="2">Inactive</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col mb-3">
                                            <label for="productname" class="form-label">Quantity</label>
                                            <input type="text" id="username" class="form-control" placeholder="1">
                                        </div>
                                        <div class="col mb-3">
                                            <label for="productname" class="form-label">Price</label>
                                            <input type="text" id="username" class="form-control" placeholder="1">
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Image</label>
                                        <input type="file" class="form-control">
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">

                                <button type="button" class="btn btn-danger js-modal-close-3" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">Save changes</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!--END MODAL EDIT -->
                <div class="container-fluid d-flex flex-column pb-5">
                    <div class="bg-white container-fluid d-flex justify-content-between border-bottom  "
                         style="border-radius:5px ;">
                        <div class="me-5 mb-3 d-flex">
                            <%
                                String search = (String) request.getAttribute("search");
                                if (search == null) {
                                    search = "";
                                }
                            %>
                            <form class="d-flex" action="MainController" method="post">
                                <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name="SearchProviderStaff" value="<%= search%>" >
                                <button class="btn btn-primary" name="action" value="SearchProviderStaff" type="submit">Search</button>
                            </form>

                            <form action="MainController" method="post">
                                <div class="btn-group ms-2">
                                    <button type="button" class="btn btn-primary btn-icon rounded-pill dropdown-toggle hide-arrow"
                                            data-bs-toggle="dropdown">
                                        <i class="bx bx-sort"></i>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><button type="submit" name="action" value="Staff_sortByName" class="dropdown-item" ><i class="bx bx-sort-a-z m-1"></i>Sort by
                                                name</button>
                                        </li>
                                        <li><button type="submit" name="action" value="Staff_sortByPedding" class="dropdown-item" ><i class="bx bx-sort-a-z m-1"></i>List Of Pending</button>
                                        </li>

                                    </ul>
                                </div>
                            </form>
                        </div>

                        <div class="add-item">
                            <a class="btn btn-primary">+
                                Add Staff</a>
                        </div>

                    </div>
                    <%
                        List<ProviderStaffDTO> staffList = new ArrayList();
                        staffList = (List<ProviderStaffDTO>) session.getAttribute("Provider_ListStaff");
                        String error = (String) session.getAttribute("ERROR");
                        if (error == null) {
                            error = "";
                        }
                        if (staffList != null) {
                    %>
                    <div class="layout-container-fluid   " style="border-radius:5px ;">
                        <div class="table-responsive bg-white " style="border-radius:5px ;">
                            <table class="table ">
                                <thead>
                                    <tr>
                                        <th>Staff ID</th>
                                        <th>Service Name</th>
                                        <th>Staff Name</th>
                                        <th>ID Card</th>
                                        <th>Avatar</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (ProviderStaffDTO staff : staffList) {
                                    %>
                                <form action="MainController" method="post" >
                                    <tr>
                                        <td> <input class="form-control me-2 shortID" type="text" name="StaffID" value="<%= staff.getStaffID()%>" readonly="" /></td>
                                        <td><input class="form-control me-2 shortTitle" type="text" name="StaffServiceName" value="<%= staff.getServiceName()%>" readonly="" /></td>
                                        <td><input class="form-control me-2 " type="text" name="StaffName" value="<%= staff.getStaff_Name()%>" /></td>
                                        <td><input class="form-control me-2 shortTitle" type="text" name="StaffIDCard" value="<%= staff.getStaff_IDCard()%>" /></td>
                                            <%
                                                if (staff.getImage().contains("https")) {
                                            %>
                                        <td>
                                            <img class="avatar avatar-lg rounded"
                                                 src="<%= staff.getImage()%>"
                                                 alt=""/></td>
                                            <%
                                            } else {
                                            %>
                                        <td><img class="avatar avatar-lg rounded"
                                                 src="img/<%= staff.getImage()%>"
                                                 alt=""/></td>
                                            <%
                                                }
                                            %>
                                        <td>
                                            <div class="flexStatus">
                                                <div>
                                                    <%
                                                        int status = staff.getStatus();
                                                        if (status == 1) {
                                                    %>
                                                    <span class="badge bg-label-success me-1 changeStatus">In Work</span>
                                                    <%
                                                    } else if (status == 2) {

                                                    %>
                                                    <span class="badge bg-label-danger me-1 changeStatus">In Active</span>

                                                    <%                                                    } else if (status == 3) {
                                                    %>
                                                    <span class="badge bg-label-warning me-1 changeStatus">Pending</span>

                                                    <%
                                                    } else if (status == -1) {
                                                    %>
                                                    <span style="color: #F68B52" class="label txt-xs danger">
                                                        Busy
                                                    </span>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                                <div>
                                                    <select class="form-select " name="StaffStatus" aria-label="Default select example">
                                                        <option selected>Choose status</option>
                                                        <option value="1">In Work</option>
                                                        <option value="2">In Active</option>              
                                                        <option value="3">Pending</option>
                                                        <option value="-1">Busy</option>
                                                    </select>
                                                    <input type="hidden" name="oldStatus" value="<%= staff.getStatus()%>" />  
                                                </div>  
                                            </div>
                                        </td>

                                        <td>
                                            <div>
                                                <!--                                                 <a data-bs-target="#modalToggle" data-bs-toggle="modal" href="javascript:void(0);"><i
                                                                                                        class="bx bx-edit-alt me-1"></i>Edit</a>-->
                                                <button name="action" value="ProviderStaffEdit" ><i 
                                                        class="bx bx-edit-alt me-1"></i>Edit</button>

                                            </div> 
                                        </td>     
                                        <td>
                                            <div>
                                                <button name="action" value="ProviderDeleteStaff" href="javascript:void(0);"><i class="bx bx-trash me-1"></i>Delete</button> 
                                                <input type="hidden" name="Provider_StaffID" value="<%= staff.getStaffID()%>" />
                                            </div>
                                        </td>
                                    </tr>
                                </form>
                                <%
                                    }
                                %>
                                </tbody>
                            </table>
                        </div>

                    </div>
                    <%                        }
                    %>

                    <%
                        String cur_form = request.getParameter("cur_form");
                        cur_form = (cur_form == null) ? "" : cur_form;
                    %>

                    <div style="z-index: 999999;" class="add-modal overlay fixed top left right bot <%if (!cur_form.equals("add-modal")) {%>hide<%}%>"> 
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" >Add Staff</h5>
                                    <button type="button" class="btn-close close-modal"></button>
                                </div>

                                <div class="modal-body">
                                    <form action="MainController" method="POST" id="form3"> 
                                        <input type="hidden" name="cur_form" value="add-modal"/>
                                        <div class="row">
                                            <div class="col mb-3">
                                                <label for="category" class="form-label ">Category</label> 
                                                <%
                                                    List<ProviderServiceDTO1> listCategory = (List<ProviderServiceDTO1>) session.getAttribute("Providder_ListServiceCategory");
                                                    String categoryName = (String) request.getAttribute("choose");

                                                    if (categoryName == null) {
                                                        categoryName = "";
                                                    }

                                                %>
                                                <select class="form-select "  name="serviceID_ADD" onchange='this.form.submit()'> 
                                                    <option style="color:blue;" >

                                                        <%= categoryName%>

                                                    </option>
                                                    <%
                                                        for (ProviderServiceDTO1 category : listCategory) {
                                                    %>  

                                                    <option value="<%= category.getServiceName()%> " 
                                                            <% if (categoryName.equals(category.getServiceName())) {
                                                            %>selected<%
                                                                }%>    

                                                            > <%= category.getServiceName()%> </option> 

                                                    <%
                                                        }
                                                    %>
                                                    <input type="hidden" name="action" value="ChooseFromCategory_Staff" />
                                                </select>
                                            </div>
                                    </form>    

                                    <div class="col mb-3">
                                        <form action="Add_NewStaff_Controller" method="POST" id="form4" enctype="multipart/form-data">   
                                            <label for="nameBasic" class="form-label type">Service Type</label>
                                            <%
                                                List<ProviderServiceDTO1> listCategoryChoose = (List<ProviderServiceDTO1>) session.getAttribute("Providder_ListServiceCategoryChoose");

                                            %>
                                            <select class="form-select type " name="IDService" >  
                                                <%                                                    for (int i = 0; i < listCategoryChoose.size(); i++) {
                                                %>  
                                                <option value="<%= listCategoryChoose.get(i).getServiceID()%> "><%= listCategoryChoose.get(i).getServiceName()%>

                                                </option>  

                                                <%                                                    }
                                                %>

                                            </select>

                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col mb-3">
                                        <label for="nameBasic"  class="form-label">Provider Owner Staff</label>
                                        <input type="text" class="form-control" value="<%= provider.getName()%>" readonly=""> 
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col mb-3">
                                        <label for="nameBasic"  class="form-label">Staff Name</label>
                                        <input type="text" name="staffName" class="form-control" placeholder="Enter Staff Name" > 
                                    </div>
                                </div>
                                <div class="col mb-3">
                                    <label for="img" class="form-label">Avatar</label>
                                    <input type="file" name="img" class="form-control" >
                                </div>

                                <div class="col mb-3">
                                    <label for="Description" class="form-label">ID Card</label>
                                    <input type="text" name="idCard" class="form-control" placeholder="Enter ID Card">
                                </div>



                            </div>
                            <input type="hidden" name="action" value="AddNewStaff" />  
                            </form>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-label-secondary">Close</button>
                                <button type="button" onclick="submitForms2()"  class="btn btn-primary">Save changes</button> 
                            </div> 
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Footer Start -->
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










    <!-- Footer End -->
    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="./vendor/libs/jquery/jquery.js"></script>
    <script src="./vendor/libs/popper/popper.js"></script>
    <script src="./vendor/js/bootstrap.js"></script>
    <script src="./vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="./vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->
    <script src="./vendor/libs/apex-charts/apexcharts.js"></script>

    <!-- Main JS -->
    <script src="./js/providerMain.js"></script>

    <!-- Page JS -->
    <script src="./js/dashboards-analytics.js"></script>

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>

    <script src="./js/provider.js"></script>
</body>

</html>
