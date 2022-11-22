/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class MainController extends HttpServlet {

//    Error Page
    private final String ERROR = "errorPage.jsp";

//    Register
    private final String REGISTER = "Register";
    private final String REGISTER_CONTROLLER = "RegisterController";

//    Login
    private final String LOGIN = "Login";
    private final String LOGIN_CONTROLLER = "LoginController";

//    Login with google
    private final String LOGIN_WITH_GOOGLE = "LoginWithGoogle";
    private final String LOGIN_WITH_GOOGLE_CONTROLLER = "LoginWithGoogleController";

//    Logout
    private final String LOGOUT = "Logout";
    private final String LOGOUT_CONTROLLER = "LogoutController";

//    Product Page
    private final String GO_TO_PRODUCT_PAGE = "GoToProductPageByPlace";
    private final String PRODUCT_PAGE_CONTROLLER = "ProductPageController";

//    Service Page
    private final String GO_TO_SERVICE_PAGE = "GoToServicePageByPlace";
    private final String SERVICE_PAGE_CONTROLLER = "ServicePageController";

//    Product Detail
    private final String GO_TO_PRODUCT_DETAIL_BY_TYPE_PAGE = "GoToProductDetailByType";
    private final String PRODUCT_DETAIL_BY_TYPE_CONTROLLER = "ProductDetailByTypeController";
    
    private final String PRODUCT_DETAIL_BY_TYPE_PAGING_CONTROLLER = "PagingProductDetailController";

//    Service Detail
    private final String GO_TO_SERVICE_DETAIL_BY_TYPE_PAGE = "GoToServiceDetailByType";
    private final String SERVICE_DETAIL_BY_TYPE_CONTROLLER = "ServiceDetailByTypeController";

//    Search
    private final String SEARCH_PRODUCT = "SearchProduct";
    private final String SEARCH_PRODUCT_CONTROLLER = "SearchProductController";

//    User profile Page
    private final String GO_TO_USER_PROFILE = "GoToUserProfile";
    private final String GO_TO_USER_PROFILE_CONTROLLER = "GoToUserProfileController";

//    Update profile
    private final String UPDATE_USER_PROFILE = "UpdateCustomerInfo";
    private final String UPDATE_USER_PROFILE_CONTROLLER = "UpdateCustomerInfoController";

//    Sort
    private final String SORT_PRODUCT_DETAIL_PRICE_UP = "PriceDetailUp";
    private final String SORT_PRODUCT_DETAIL_PRICE_UP_CONTROLLER = "SortProductDetailPriceUpController";

    private final String SORT_PRODUCT_DETAIL_PRICE_DOWN = "PriceDetailDown";
    private final String SORT_PRODUCT_PRICE_DOWN_CONTROLLER = "SortProductPriceDownController";

    private final String SORT_PRODUCT_DETAIL_WORD_DOWN = "WordDetailDown";
    private final String SORT_PRODUCT_DETAIL_WORD_DOWN_CONTROLLER = "WordDetailDownController";

    private final String SORT_PRODUCT_DETAIL_WORD_UP = "WordDetailUp";
    private final String SORT_PRODUCT_DETAIL_WORD_UP_CONTROLLER = "WordDetailUpController";

    private final String SORT_PRODUCT_CATEGORY_WORD_UP = "WordProductCategoryUp";
    private final String SORT_PRODUCT_CATEGORY_WORD_UP_CONTROLLER = "WordProductCategoryUpController";

    private final String SORT_PRODUCT_CATEGORY_WORD_DOWN = "WordProductCategoryDown";
    private final String SORT_PRODUCT_CATEGORY_WORD_DOWN_CONTROLLER = "WordProductCategoryDownController";

    private final String SORT_SERVICE_CATEGORY_WORD_UP = "WordServiceCategoryUp";
    private final String SORT_SERVICE_CATEGORY_WORD_UP_CONTROLLER = "WordServiceCategoryUpController";
    private final String SORT_SERVICE_CATEGORY_WORD_DOWN = "WordServiceCategoryDown";
    private final String SORT_SERVICE_CATEGORY_WORD_DOWN_CONTROLLER = "WordServiceCategoryDownController";

    private final String SORT_SERVICE_DETAIL_PRICE_UP = "ServicePriceDetailUp";
    private final String SORT_SERVICE_DETAIL_PRICE_UP_CONTROLLER = "ServicePriceDetailUpController";
    private final String SORT_SERVICE_DETAIL_PRICE_DOWN = "ServicePriceDetailDown";
    private final String SORT_SERVICE_PRICE_DOWN_CONTROLLER = "ServicePriceDetailDownController";
    private final String SORT_SERVICE_DETAIL_WORD_DOWN = "ServiceWordDetailDown";
    private final String SORT_SERVICE_DETAIL_WORD_DOWN_CONTROLLER = "ServiceWordDetailDownController";
    private final String SORT_SERVICE_DETAIL_WORD_UP = "ServiceWordDetailUp";
    private final String SORT_SERVICE_DETAIL_WORD_UP_CONTROLLER = "ServiceWordDetailUpController";

    //Search    
    private final String SEARCH_PRODUCT_DETAIL_BY_TYPE = "SearchProductDetailByType";
    private final String SEARCH_PRODUCT_DETAIL_BY_TYPE_CONTROLLER = "SearchProductDetailByTypeController";

    private final String SEARCH_PRODUCT_CATEGORY = "SearchProductCategory";
    private final String SEARCH_PRODUCT_CATEGORY_CONTROLLER = "SearchProductCategoryController";

    private final String SEARCH_SERVICE_CATEGORY = "SearchServiceCategory";
    private final String SEARCH_SERVICE_CATEGORY_CONTROLLER = "SearchServiceCategoryController";

    private final String SEARCH_SERVICE_DETAIL_BY_TYPE = "SearchServiceDetailByType";
    private final String SEARCH_SERVICE_DETAIL_BY_TYPE_CONTROLLER = "SearchServiceDetailByTypeController";

//    Change password
    private final String CHANGE_CUSTOMER_PASSWORD = "ChangeCustomerPassword";
    private final String CHANGE_CUSTOMER_PASSWORD_CONTROLLER = "ChangeCustomerPasswordController";

//    Shopping cart
    private final String ADD_TO_CART = "AddToCart";
    private final String ADD_TO_CART_CONTROLLER = "AddToCartController";
    private final String DELETE_CART = "DeleteCart";
    private final String DELETE_CART_CONTROLLER = "DeleteCartController";
    private final String CHECKOUT = "Checkout";
    private final String CHECKOUT_CONTROLLER = "CheckoutController";
    private final String AUTHORIZE_PAYMENT_CONTROLLER = "AuthorizePaymentController";
    private final String EXECUTE_PAYMENT = "ExecutePayment";
    private final String EXECUTE_PAYMENT_CONTROLLER = "ExecutePaymentController";
    private final String LOAD_CART_DATA = "LoadCartData";
    private final String LOAD_CART_DATA_CONTROLLER = "LoadCartDataController";
    private final String MOVE_TO_CART = "MoveToCart";
    private final String MOVE_TO_CART_CONTROLLER = "MoveToCartController";
    private final String EDIT_QUANTITY = "EditQuantity";
    private final String EDIT_QUANTITY_CONTROLLER = "EditQuantityController";
    private final String ADD_SERVICE_TO_CART = "AddServiceToCart";
    private final String ADD_SERVICE_TO_CART_CONTROLLER = "AddServiceToCartController";
    // -----PROVIDER-----   
    //UPDATE PROFILE
    private final String PROVIDER_UPDATE_PROFILE = "UpdateProfileProvider";
    private final String PROVIDER_UPDATE_PROFILE_CONTROLLER = "Update_Profile_ProviderController";
    //1.PRODUCT PROVIDER
        //1.Load List
    private final String PROVIDER_PRODUCT = "ProviderProduct";
    private final String PROVIDER_PRODUCT_CONTROLLER = "Provider_ProductController";
    private final String PRODUCT_CATEGORY_CHOOSE = "ChooseFromCategory_Product";
    private final String PRODUCT_CATEGORY_CHOOSE_CONTROLLER = "Provider_ProductController";
        //2.Search        
    private final String SEARCH_PROVIDER_PRODUCT = "SearchProviderProduct";
    private final String SEARCH_PPROVIDER_PRODUCT_CONTROLLER = "Search_Provider_ProductController";

        //3.Filter List
    private final String FILTER_PRODUCT_NAME = "Pro_sortByName";
    private final String FILTER_PRODUCT_PRICE_UP = "Pro_sortByPriceUp";
    private final String FILTER_PRODUCT_PRICE_DOWN = "Pro_sortByPriceDown";
    private final String FILTER_PRODUCT_CONTROLLER = "Provider_Filter_ProductController";
        //4.Edit Product
    private final String PROVIDER_EDIT_PRODUCT = "ProviderEditProduct";
    private final String PROVIDER_EDIT_PRODUCT_CONTROLLER = "Provider_Edit_ProductController";
        //5.Delete Product
    private final String PROVIDER_DELETE_PRODUCT = "ProviderDeleteProduct";
    private final String PROVIDER_DELETE_PRODUCT_CONTROLLER = "Provider_Delete_ProductController";
        //6.Logout
    private final String LOGOUT_PROVIDER = "LogoutProvider";
    private final String LOGOUT_PROVIDER_CONTROLLER = "LogoutController";
        //7.Add Product
    private final String PROVIDER_ADD_PRODUCT = "AddNewProduct";
    private final String PROVIDER_ADD_PRODUCT_CONTROLLER = "Add_NewProduct_Controller";
        //CHANGE PASSWORD
    private final String CHANGEPASSWORD_PROVIDER = "ChangePasswordProvider";
    private final String CHANGEPASSWORD_PROVIDER_CONTROLLER = "Provider_ChangePasswordController";

    //2.SERVICE PROVIDER
        //1.Load List    
    private final String PROVIDER_SERVICE = "ProviderService";
    private final String PROVIDER_SERVICE_CONTROLLER = "Provider_ServiceController";
    private final String SERVICE_CATEGORY_CHOOSE = "ChooseFromCategory_Service";
    private final String SERVICE_CATEGORY_CHOOSE_CONTROLLER = "Provider_ServiceController";
        //2.Search
    private final String SEARCH_PROVIDER_SERVICE = "SearchProviderService";
    private final String SEARCH_PPROVIDER_SERVICE_CONTROLLER = "Search_Provider_ServiceController";
        //3.Filter List
    private final String FILTER_SERVICE_NAME = "Ser_sortByName";
    private final String FILTER_SERVICE_PRICE_UP = "Ser_sortByPriceUp";
    private final String FILTER_SERVICE_PRICE_DOWN = "Ser_sortByPriceDown";
    private final String FILTER_SERVICE_CONTROLLER = "Provider_Filter_ServiceController";
        //4.Edit Service 
    private final String PROVIDER_EDIT_SERVICE = "ProviderEditService";
    private final String PROVIDER_EDIT_SERVICE_CONTROLLER = "Provider_Edit_ServiceController";
        //5.Delete Service
    private final String PROVIDER_SERVICE_PRODUCT = "ProviderDeleteService";
    private final String PROVIDER_DELETE_SERVICE_CONTROLLER = "Provider_Delete_ServiceController";
        //7.Add Service
    private final String PROVIDER_ADD_SERVICE = "AddNewService";
    private final String PROVIDER_ADD_SERVICE_CONTROLLER = "Add_NewService_Controller";
    //3.ORDER PROVIDER
        //1.Load List  
    private final String PROVIDER_ORDER = "ProviderOrder";
    private final String PROVIDER_ORDER_CONTROLLER = "Provider_OrderController";
        //2.Load list Order Deatil
    private final String PROVIDER_ORDER_DETAIL = "ProviderOrderDetail" ; 
    private final String PROVIDER_ORDER_DETAIL_CONTROLLER = "Provider_Order_DetailController" ;  
        //3.Delete Order
    private final String PROVIDER_DELETE_ORDER = "ProviderDeleteOrder" ;
    private final String PROVIDER_DELETE_ORDER_CONTROLLER = "Provider_Delete_OrderController" ;

    //4.STAFF PROVIDER
        //1.Load List  
    private final String PROVIDER_STAFF = "ProviderStaff";
    private final String PROVIDER_STAFF_CONTROLLER = "Provider_StaffController";
    private final String STAFF_CATEGORY_CHOOSE = "ChooseFromCategory_Staff";
    private final String STAFF_CATEGORY_CHOOSE_CONTROLLER = "Provider_StaffController";
        //2.Search
    private final String SEARCH_PROVIDER_STAFF = "SearchProviderStaff";
    private final String SEARCH_PPROVIDER_STAFF_CONTROLLER = "Search_Provider_StaffController";
        //3.Filter List
    private final String FILTER_STAFF_NAME = "Staff_sortByName";
    private final String FILTER_STAFF_CONTROLLER = "Provider_Filter_StaffController";
    private final String FILTER_STAFF_PENDING = "Staff_sortByPedding";
    private final String FILTER_STAFF_PENDING_CONTROLLER = "Provider_Filter_StaffController";
        //4.Edit Service 
    private final String PROVIDER_EDIT_STAFF = "ProviderStaffEdit";
    private final String PROVIDER_EDIT_STAFF_CONTROLLER = "Provider_Edit_StaffController";
        //5.Delete Service
    private final String PROVIDER_DELETE_STAFF = "ProviderDeleteStaff";
    private final String PROVIDER_DELETE_STAFF_CONTROLLER = "Provider_Delete_StaffController";
        //6.Add Staff
    private final String PROVIDER_ADD_STAFF = "AddNewStaff";
    private final String PROVIDER_ADD_STAFF_CONTROLLER = "Add_NewStaff_Controller";

//    Select province
    private final String SELECT_PROVICE = "SelectProvince";
    private final String SELECT_PROVICE_CONTROLLER = "SelectProvinceController";

//    Add address
    private final String ADD_ADDRESS = "AddAddress";
    private final String ADD_ADDRESS_CONTROLLER = "AddAddressController";
    
//    Show address
    private final String SHOW_LIST_ADDRESS = "ShowListAddress";
    private final String SHOW_LIST_ADDRESS_CONTROLLER = "ShowListAddressController";
    
//    Delete address
    private final String DELETE_ADDRESS = "DeleteAddress";
    private final String DELETE_ADDRESS_CONTROLLER = "DeleteAddressController";
    
//    Set address default
    private final String SET_ADDRESS_DEFAULT = "SetAddressDefault";
    private final String SET_ADDRESS_DEFAULT_CONTROLLER = "SetAddressDefaultController";
    
//    Update address
    private final String UPDATE_ADDRESS = "UpdateAddress";
    private final String UPDATE_ADDRESS_CONTROLLER = "UpdateAddressController";
    
//    Paging
    private final String PAGING_PRODUCT_DETAIL = "pagingProductDetail";
    private final String PAGING_PRODUCT_DETAIL_CONTROLLER = "PagingProductDetailController";

    // ------------DELIVERY--------------------
    //1.LoadlistDetail 
    private final String DELIVERY_LOAD_DETAIL = "DeliveryOrderDetail" ; 
    private final String DELIVERY_LOAD_DETAIL_CONTROLLER = "Delivery_Order_DetailController" ; 
    //2.UpdateDelivery
    private final String UPDATE_DELIVERY = "Update_Delivery" ; 
    private final String UPDATE_DELIVERY_CONTROLLER = "Update_Delivery_StatusController" ;  
    //3.Assign Delivery 
    private final String ASSIGN_NOW ="AssignDelivery" ; 
    private final String ASSIGN_NOW_CONTROLLER ="Assign_DeliveryController" ; 
    // ------------DELIVERY--------------------

//    Add review
    private final String ADD_REVIEW = "AddReview";
    private final String ADD_REVIEW_CONTROLLER = "AddReviewController";
    
//    Load review
    private final String LOAD_REVIEW = "LoadReview";
    private final String LOAD_REVIEW_CONTROLLER = "LoadingReviewController";
    
//    Create shippingn address
    private final String CREATE_SHIPPING_ADDRESS = "CreateShippingAddress";
    private final String CREATE_SHIPPING_ADDRESS_CONTROLLER = "CreateShippingAddressController";
    
//    Cancel order
    private final String CANCEL_ORDER = "CancelOrder";
    private final String CANCEL_ORDER_CONTROLLER = "CancelOrderController";
    
    private final String CONTACT = "SendFeedBack" ; 
    private final String CONTACT_CONTROLLER = "Customer_ContactController" ; 
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = ERROR;

        try {
            String action = request.getParameter("action");
            String payment = request.getParameter("payment");
            if (action.equals(REGISTER)) {
                url = REGISTER_CONTROLLER;
            } else if (action.equals(LOGIN)) {
                url = LOGIN_CONTROLLER;
            } else if (action.equals(LOGIN_WITH_GOOGLE)) {
                url = LOGIN_WITH_GOOGLE_CONTROLLER;
            } else if (action.equals(LOGOUT)) {
                url = LOGOUT_CONTROLLER;
            } else if (action.equals(GO_TO_PRODUCT_PAGE)) {
                url = PRODUCT_PAGE_CONTROLLER;
            } else if (action.equals(GO_TO_PRODUCT_DETAIL_BY_TYPE_PAGE)) {
                url = PRODUCT_DETAIL_BY_TYPE_CONTROLLER;
//                   url = PRODUCT_DETAIL_BY_TYPE_PAGING_CONTROLLER;
            } else if (action.equals(GO_TO_USER_PROFILE)) {
                url = GO_TO_USER_PROFILE_CONTROLLER;
            } else if (action.equals(SEARCH_PRODUCT_DETAIL_BY_TYPE)) {
                url = SEARCH_PRODUCT_DETAIL_BY_TYPE_CONTROLLER;
            } else if (action.equals(SEARCH_PRODUCT_CATEGORY)) {
                url = SEARCH_PRODUCT_CATEGORY_CONTROLLER;
            } else if (action.equals(SORT_PRODUCT_DETAIL_PRICE_UP)) {
                url = SORT_PRODUCT_DETAIL_PRICE_UP_CONTROLLER;
            } else if (action.equals(CHANGE_CUSTOMER_PASSWORD)) {
                url = CHANGE_CUSTOMER_PASSWORD_CONTROLLER;
            } else if (action.equals(GO_TO_SERVICE_PAGE)) {
                url = SERVICE_PAGE_CONTROLLER;
            } else if (action.equals(SORT_PRODUCT_CATEGORY_WORD_UP)) {
                url = SORT_PRODUCT_CATEGORY_WORD_UP_CONTROLLER;
            } else if (action.equals(SORT_PRODUCT_CATEGORY_WORD_DOWN)) {
                url = SORT_PRODUCT_CATEGORY_WORD_DOWN_CONTROLLER;
            } else if (action.equals(SORT_PRODUCT_DETAIL_PRICE_DOWN)) {
                url = SORT_PRODUCT_PRICE_DOWN_CONTROLLER;
            } else if (action.equals(SORT_PRODUCT_DETAIL_WORD_DOWN)) {
                url = SORT_PRODUCT_DETAIL_WORD_DOWN_CONTROLLER;
            } else if (action.equals(SORT_PRODUCT_DETAIL_WORD_UP)) {
                url = SORT_PRODUCT_DETAIL_WORD_UP_CONTROLLER;
            } else if (action.equals(SEARCH_SERVICE_CATEGORY)) {
                url = SEARCH_SERVICE_CATEGORY_CONTROLLER;
            } else if (action.equals(SORT_SERVICE_CATEGORY_WORD_UP)) {
                url = SORT_SERVICE_CATEGORY_WORD_UP_CONTROLLER;
            } else if (action.equals(SORT_SERVICE_CATEGORY_WORD_DOWN)) {
                url = SORT_SERVICE_CATEGORY_WORD_DOWN_CONTROLLER;
            } else if (action.equals(GO_TO_SERVICE_DETAIL_BY_TYPE_PAGE)) {
                url = SERVICE_DETAIL_BY_TYPE_CONTROLLER;
            } else if (action.equals(ADD_TO_CART)) {
                url = ADD_TO_CART_CONTROLLER;
            } else if (action.equals(DELETE_CART)) {
                url = DELETE_CART_CONTROLLER;
            } else if (action.equals(LOAD_CART_DATA)) {
                url = LOAD_CART_DATA_CONTROLLER;
            } else if (action.equals(CHECKOUT) && payment.equals("COD")) {
                url = CHECKOUT_CONTROLLER;
            } else if (action.equals(CHECKOUT) && payment.equals("PayPal")) {
                url = AUTHORIZE_PAYMENT_CONTROLLER;
            } else if (action.equals(EXECUTE_PAYMENT)) {
                url = EXECUTE_PAYMENT_CONTROLLER;
            } else if (action.equals(MOVE_TO_CART)) {
                url = MOVE_TO_CART_CONTROLLER;
            } else if (action.equals(EDIT_QUANTITY)) {
                url = EDIT_QUANTITY_CONTROLLER;
            } else if (action.equals(ADD_SERVICE_TO_CART)) {
                url = ADD_SERVICE_TO_CART_CONTROLLER;
            } else if (action.equals(UPDATE_USER_PROFILE)) {
                url = UPDATE_USER_PROFILE_CONTROLLER;
            } else if (action.equals(PROVIDER_SERVICE)) {
                url = PROVIDER_SERVICE_CONTROLLER;
            } else if (action.equals(PROVIDER_PRODUCT)) {
                url = PROVIDER_PRODUCT_CONTROLLER;
            } else if (action.equals(SEARCH_PROVIDER_PRODUCT)) {
                url = SEARCH_PPROVIDER_PRODUCT_CONTROLLER;
            } else if (action.equals(SEARCH_PROVIDER_SERVICE)) {
                url = SEARCH_PPROVIDER_SERVICE_CONTROLLER;
            } else if (action.equals(FILTER_PRODUCT_NAME) || action.equals(FILTER_PRODUCT_PRICE_UP) || action.equals(FILTER_PRODUCT_PRICE_DOWN)) {
                url = FILTER_PRODUCT_CONTROLLER;
            } else if (action.equals(FILTER_SERVICE_NAME) || action.equals(FILTER_SERVICE_PRICE_UP) || action.equals(FILTER_SERVICE_PRICE_DOWN)) {
                url = FILTER_SERVICE_CONTROLLER;
            } else if (action.equals(FILTER_STAFF_NAME) || action.equals(FILTER_STAFF_PENDING)) {
                url = FILTER_STAFF_CONTROLLER;
            } else if (action.equals(PROVIDER_EDIT_PRODUCT)) {
                url = PROVIDER_EDIT_PRODUCT_CONTROLLER;
            } else if (action.equals(PROVIDER_DELETE_PRODUCT)) {
                url = PROVIDER_DELETE_PRODUCT_CONTROLLER;
            } else if (action.equals(LOGOUT_PROVIDER)) {
                url = LOGOUT_PROVIDER_CONTROLLER;
            } else if (action.equals(PROVIDER_SERVICE_PRODUCT)) {
                url = PROVIDER_DELETE_SERVICE_CONTROLLER;
            } else if (action.equals(PROVIDER_STAFF)) {
                url = PROVIDER_STAFF_CONTROLLER;
            } else if (action.equals(SEARCH_PROVIDER_STAFF)) {
                url = SEARCH_PPROVIDER_STAFF_CONTROLLER;
            } else if (action.equals(PROVIDER_DELETE_STAFF)) {
                url = PROVIDER_DELETE_STAFF_CONTROLLER;
            } else if (action.equals(PRODUCT_CATEGORY_CHOOSE)) {
                url = PRODUCT_CATEGORY_CHOOSE_CONTROLLER;
            } else if (action.equals(CHANGEPASSWORD_PROVIDER)) {
                url = CHANGEPASSWORD_PROVIDER_CONTROLLER;
            } else if (action.equals(PROVIDER_EDIT_SERVICE)) {
                url = PROVIDER_EDIT_SERVICE_CONTROLLER;
            } else if (action.equals(PROVIDER_EDIT_STAFF)) {
                url = PROVIDER_EDIT_STAFF_CONTROLLER;
            } else if (action.equals(PROVIDER_UPDATE_PROFILE)) {
                url = PROVIDER_UPDATE_PROFILE_CONTROLLER;
            } else if (action.equals(PROVIDER_ADD_PRODUCT)) {
                url = PROVIDER_ADD_PRODUCT_CONTROLLER;
            } else if (action.equals(SERVICE_CATEGORY_CHOOSE)) {
                url = SERVICE_CATEGORY_CHOOSE_CONTROLLER;
            } else if (action.equals(PROVIDER_ADD_SERVICE)) {
                url = PROVIDER_ADD_SERVICE_CONTROLLER;
            } else if (action.equals(PROVIDER_ADD_STAFF)) {

                url = PROVIDER_ADD_STAFF_CONTROLLER;
            } else if (action.equals(STAFF_CATEGORY_CHOOSE)) {
                url = STAFF_CATEGORY_CHOOSE_CONTROLLER;

                url = PROVIDER_ADD_STAFF_CONTROLLER;
            } else if (action.equals(STAFF_CATEGORY_CHOOSE)) {
                url = STAFF_CATEGORY_CHOOSE_CONTROLLER;
            } else if (action.equals(SEARCH_SERVICE_DETAIL_BY_TYPE)) {
                url = SEARCH_SERVICE_DETAIL_BY_TYPE_CONTROLLER;
            } else if (action.equals(SORT_SERVICE_DETAIL_PRICE_UP)) {
                url = SORT_SERVICE_DETAIL_PRICE_UP_CONTROLLER;
            } else if (action.equals(SORT_SERVICE_DETAIL_PRICE_DOWN)) {
                url = SORT_SERVICE_PRICE_DOWN_CONTROLLER;
            } else if (action.equals(SORT_SERVICE_DETAIL_WORD_DOWN)) {
                url = SORT_SERVICE_DETAIL_WORD_DOWN_CONTROLLER;
            } else if (action.equals(SORT_SERVICE_DETAIL_WORD_UP)) {
                url = SORT_SERVICE_DETAIL_WORD_UP_CONTROLLER;
            }else if (action.equals(PROVIDER_ORDER)) {
                url = PROVIDER_ORDER_CONTROLLER;
            }else if (action.equals(PROVIDER_ORDER_DETAIL)) {
                url = PROVIDER_ORDER_DETAIL_CONTROLLER; 

            } else if (action.equals(SELECT_PROVICE)) {
                url = SELECT_PROVICE_CONTROLLER;
            } else if (action.equals(ADD_ADDRESS)) {
                url = ADD_ADDRESS_CONTROLLER;
            } else if (action.equals(SHOW_LIST_ADDRESS)) {
                url = SHOW_LIST_ADDRESS_CONTROLLER;
            } else if(action.equals(DELETE_ADDRESS)) {
                url = DELETE_ADDRESS_CONTROLLER;
            } else if (action.equals(SET_ADDRESS_DEFAULT)) {
                url = SET_ADDRESS_DEFAULT_CONTROLLER;
            } else if (action.equals(UPDATE_ADDRESS)) {
                url = UPDATE_ADDRESS_CONTROLLER;
            }else if (action.equals(PAGING_PRODUCT_DETAIL)) {
                url = PAGING_PRODUCT_DETAIL_CONTROLLER;
            }
             else if (action.equals(PROVIDER_DELETE_ORDER)) {
                url = PROVIDER_DELETE_ORDER_CONTROLLER ; 
            } else if (action.equals(ADD_REVIEW)) {
                url = ADD_REVIEW_CONTROLLER;
            } else if (action.equals(LOAD_REVIEW)) {
                url = LOAD_REVIEW_CONTROLLER;
            }
            else if (action.equals(DELIVERY_LOAD_DETAIL)) { 
                url = DELIVERY_LOAD_DETAIL_CONTROLLER ; 
            }else if (action.equals(UPDATE_DELIVERY)) { 
                url = UPDATE_DELIVERY_CONTROLLER ; 
            }else if (action.equals(ASSIGN_NOW)) { 
                url = ASSIGN_NOW_CONTROLLER ; 
            } else if (action.equals(CREATE_SHIPPING_ADDRESS)) {
                url = CREATE_SHIPPING_ADDRESS_CONTROLLER;
            } else if (action.equals(CANCEL_ORDER)) {
                url = CANCEL_ORDER_CONTROLLER;
            } else if (action.equals(CONTACT)) {
                url = CONTACT_CONTROLLER ;
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
