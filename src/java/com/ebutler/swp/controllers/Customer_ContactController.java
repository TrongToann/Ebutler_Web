/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.email.Account;
import com.ebutler.swp.email.Email;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class Customer_ContactController extends HttpServlet {

    private final String ERROR = "errorPage.jsp";
    private final String SUCCESS = "customer_contactPage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String issue = request.getParameter("issue-input");
            String content = request.getParameter("content");
            HttpSession session = request.getSession();
            CustomerDTO customer = (CustomerDTO) session.getAttribute("CURRENT_CUSTOMER");
            String subject = "Your Problems has been processing.";
            String message = "<!DOCTYPE html>\n"
                    + "<html lang=\"en\">\n"
                    + "\n"
                    + "<head>\n"
                    + "</head>\n"
                    + "\n"
                    + "<body>\n"
                    + "    <h3 style=\"color: blue;\">Ebutler Had Receive Your Issue.</h3>\n"
                    + "    <div>Username: " + customer.getUsername() + "</div>\n"
                    + "    <div>About Issue: " + issue + "</div>\n"
                    + "    <div>Your Issue: " + content + "</div>\n"
                    + "    <h3 style=\"color: blue;\">Thank you very much!</h3>\n"
                    + "    <h3 style=\"color: blue;\">You Will Have Your Answer Quickly</h3>\n"
                    + "\n"
                    + "</body>\n"
                    + "\n"
                    + "</html>";

            Email.send(customer.getEmail(), subject, message, Account.EMAIL_EBUTLER, Account.PASSWORD_EBUTLER);

            String subjectEbutler = "Customer Problem!.";
            String messageEbutler = "<!DOCTYPE html>\n"
                    + "<html lang=\"en\">\n"
                    + "\n"
                    + "<head>\n"
                    + "</head>\n"
                    + "\n"
                    + "<body>\n"
                    + "    <div>Username: " + customer.getUsername() + "</div>\n"
                    + "    <div>About Issue: " + issue + "</div>\n"
                    + "    <div>Your Issue: " + content + "</div>\n"
                    + "\n"
                    + "</body>\n"
                    + "\n"
                    + "</html>";

            Email.send(Account.EMAIL_EBUTLER, subjectEbutler, messageEbutler, Account.EMAIL, Account.PASSWORD);
            url = SUCCESS;
        } catch (Exception e) {
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
