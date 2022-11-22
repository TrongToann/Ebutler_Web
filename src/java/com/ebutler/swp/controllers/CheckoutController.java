/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.CustomerDAO;
import com.ebutler.swp.dao.OrderDAO;
import com.ebutler.swp.dao.ProductDAO;
import com.ebutler.swp.dao.StaffDAO;
import com.ebutler.swp.dto.CartDTO;
import com.ebutler.swp.dto.CartServiceDTO;
import com.ebutler.swp.dto.ConfirmDTO;
import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.dto.OrderDTO;
import com.ebutler.swp.dto.ProductCartDTO;
import com.ebutler.swp.dto.ServiceCartDTO;
import com.ebutler.swp.dto.UserDTO;
import com.ebutler.swp.email.Account;
import com.ebutler.swp.email.Email;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author thekh
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String ERROR = "errorPage.jsp";
    private static final String SUCCESS = "customer_confirmation.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            request.setCharacterEncoding("UTF-8");
            String total = request.getParameter("total");
            String total2 = request.getParameter("total2");
            String payment = request.getParameter("payment");
            String address = request.getParameter("address");
            String pointBefore = request.getParameter("point");

            OrderDTO order = new OrderDTO();
            OrderDAO orderDao = new OrderDAO();
            CustomerDAO customerDao = new CustomerDAO();
            ProductDAO productDao = new ProductDAO();
            StaffDAO staffDao = new StaffDAO();

            ConfirmDTO confirmation = new ConfirmDTO("Thank you for your order!", "We're sorry! Your order was unsuccessful");
            String statement = confirmation.getFail();
            HttpSession session = request.getSession();

            UserDTO login_user = (UserDTO) session.getAttribute("LOGIN_USER");

            if (session != null) {
                if (total == null) {
                    total = (String) session.getAttribute("TOTAL");
                }
                if (payment == null) {
                    payment = (String) session.getAttribute("PAYMENT");
                }
                if (total2 == null) {
                    total2 = (String) session.getAttribute("TOTAL2");
                }
                if (address == null) {
                    address = (String) session.getAttribute("ADDRESS");
                }
                if (pointBefore == null) {
                    pointBefore = (String) session.getAttribute("POINT_BEFORE");
                }

                CustomerDTO customer = (CustomerDTO) session.getAttribute("CURRENT_CUSTOMER");
                UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
                CartDTO cart = (CartDTO) session.getAttribute("CART");
                CartServiceDTO cartService = (CartServiceDTO) session.getAttribute("CART_SERVICE");
                if (cart != null) {
                    /*flag to count whether the quatity equals to the size of cart
                    if true --> success | false --> fail*/
                    int count = 0;

//                  Check quantity
                    for (ProductCartDTO product : cart.getCart().values()) {
                        if (productDao.checkQuantiy(product.getId(), product.getQuantity())) {
                            count++;
                        }
                    }

//                  Insert
                    if (count == cart.getCart().values().size()) {
                        orderDao.insertOrder(java.sql.Date.valueOf(java.time.LocalDate.now()), user.getUsername(), 0, Double.parseDouble(total), payment);
                        int order_ID = orderDao.getAllOrder().size();
                        orderDao.insertDelivery(order_ID, address);
                        for (ProductCartDTO product : cart.getCart().values()) {

                            orderDao.insertOrderDetail(product.getId(), order_ID, product.getQuantity(), product.getPrice(), 0);
                            productDao.setQuantiy(product.getId(), product.getQuantity());
                        }
                        statement = confirmation.getSuccess();
                    }
                }
                if (cartService != null) {
                    /*count para to check whether the status of staff is 1 or 0
                    if 1 --> success | 0 --> fail*/
                    int count = 0;
                    for (ServiceCartDTO service : cartService.getCart().values()) {
                        if (service.getStatus() == 1) {
                            count++;
                        }
                    }
//                    Insert
                    if (count == cartService.getCart().values().size()) {
                        if (cart == null) {
                            orderDao.insertOrder(java.sql.Date.valueOf(java.time.LocalDate.now()), user.getUsername(), 0, Double.parseDouble(total), payment);
                            statement = confirmation.getSuccess();
                        }
                        for (ServiceCartDTO service : cartService.getCart().values()) {
                            int order_ID = orderDao.getAllOrder().size();
                            orderDao.insertOrderServiceDetail(service.getId(), service.getId(), order_ID, service.getPrice(), 0);
                            staffDao.updateStatus(-1, service.getId());
                        }

                    }
                }
                if (statement == confirmation.getSuccess()) {
                    double point = (Double.parseDouble(total) / 100);
                    if ( Double.parseDouble(pointBefore) > 0) {
                        if (Double.parseDouble(total) < Double.parseDouble(total2)) {
                            if (Double.parseDouble(pointBefore) > Double.parseDouble(total2)) {
                                customerDao.accumulatePoint(user.getUsername(), -Double.parseDouble(total2));
                            } else {
                                customerDao.accumulatePoint(user.getUsername(), -Double.parseDouble(pointBefore));
                            }
                        }
                    }
                    customerDao.accumulatePoint(user.getUsername(), point);
                    customer.setPoint(customerDao.getPoint(user.getUsername()));
                }
                session.setAttribute("CURRENT_CUSTOMER", customer);
            }
            session.setAttribute("CART", null);
            session.setAttribute("CART_SERVICE", null);
            session.setAttribute("STATEMENT", statement);

            String subject = "Your order has been processing.";
            String message = "<!DOCTYPE html>\n"
                    + "<html lang=\"en\">\n"
                    + "\n"
                    + "<head>\n"
                    + "</head>\n"
                    + "\n"
                    + "<body>\n"
                    + "    <h3 style=\"color: blue;\">Your order has been processing.</h3>\n"
                    + "    <div>Username: " + login_user.getUsername() + "</div>\n"
                    + "    <div>Phone: " + login_user.getPhone() + "</div>\n"
                    + "    <div>address: " + address + "</div>\n"
                    + "    <div>Your total bill: " + total + "</div>\n"
                    + "    <h3 style=\"color: blue;\">Thank you very much!</h3>\n"
                    + "\n"
                    + "</body>\n"
                    + "\n"
                    + "</html>";

            Email.send(login_user.getEmail(), subject, message, Account.EMAIL, Account.PASSWORD);

            url = SUCCESS;
        } catch (Exception e) {
            log("Error at CheckoutController" + e.toString());
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
