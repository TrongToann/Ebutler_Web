/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.CustomerDAO;
import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class ChangeCustomerPasswordController extends HttpServlet {
    
   private final String ERROR = "errorPage.jsp";
   private final String SUCCESS = "guest_loginPage.jsp";
   private final String THROW_ERROR = "customer_profilePage.jsp";
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String currentPassword = request.getParameter("current-password");
            String newPassword = request.getParameter("new-password");
            String confirmNewPassword = request.getParameter("confirm-new-password");

            HttpSession session = request.getSession();
            UserDTO currentUser = (UserDTO) session.getAttribute("LOGIN_USER");
            
//            UserDAO dao = new UserDAO();
            CustomerDTO customer = (CustomerDTO)session.getAttribute("CURRENT_CUSTOMER");
            CustomerDAO dao = new CustomerDAO();
            String currentPasswordDAO = dao.getCurrentCustomerPassword(customer.getUsername());
            
            if(currentUser != null){
                //current password
                if(currentPassword.equals("") && newPassword.equals("") && confirmNewPassword.equals("")){
                            request.setAttribute("EMPTY", "All fields are empty!!");  
                            url = THROW_ERROR;
                            return;
                }
                if(currentPassword.equals(currentPasswordDAO)){
                    if(newPassword.equals(currentPassword)){
                            request.setAttribute("DUPLICATE_NEW_PASSWORD", "New password is  equals with current password!!");  
                            url = THROW_ERROR;
                            return;
                    }
                    if(!newPassword.equals(currentPassword)){
                        
                        if(newPassword.equals(confirmNewPassword)){
                            boolean checkUpdatePassword = dao.updateCurrentPassword(newPassword ,customer.getUsername());
                            if(checkUpdatePassword){
                                url = SUCCESS;
                            }
                        }
                        if(!newPassword.equals(confirmNewPassword)){
                            request.setAttribute("CONFIRM_PASSWORD_WRONG", "Confirm password is not equals with new password!!");
                            url = THROW_ERROR;
                        }
                            
                    }
                    
                }
                               
            }
        } catch (Exception e) {
            log("Error at ChangeCustomerPasswordController: "+e.getMessage());
        }finally{
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
