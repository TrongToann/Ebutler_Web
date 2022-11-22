/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.CustomerDAO;
import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.dto.UserDTO;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class UpdateCustomerInfoController extends HttpServlet {

    private final String ERROR = "errorPage.jsp";
    private final String SUCCESS = "MainController?action=GoToUserProfile&current_form=account";
    private final String SEND_ERROR = "customer_profilePage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO currentUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String dob = request.getParameter("dob");
            int gender = Integer.parseInt(request.getParameter("gender"));
            String phone = request.getParameter("phone");
            String avatar = request.getParameter("avatar");
            String username = currentUser.getUsername();
            String password = currentUser.getPassword();
            String roleid = currentUser.getRole_id();
            int status = currentUser.getStatus();
            if (avatar == null || avatar == "") {
                avatar = (String) session.getAttribute("PHOTO_PATH");
                if (avatar == null) {
                    avatar = "";
                }
            }
               
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDateTime now = LocalDateTime.now();
            String currentDate = dtf.format(now);

            boolean chevj = currentDate.compareTo(dob) > 0;

            CustomerDTO customer = new CustomerDTO(currentUser.getUsername(), currentUser.getPassword(), currentUser.getRole_id(), phone, email, name, gender, dob, avatar, currentUser.getStatus());
            session.setAttribute("CURRENT_CUSTOMER", customer);
            CustomerDAO dao = new CustomerDAO();

            Pattern VALID_EMAIL_ADDRESS_REGEX = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
            Matcher matcher = VALID_EMAIL_ADDRESS_REGEX.matcher(email);
            boolean regexEmail = matcher.find();

            if (currentUser != null) {
                if (name.equals("") && phone.equals("") && avatar.equals("")) {
                    request.setAttribute("EMPTY_INFO_ERROR", "Please fill up all information!!");
                    url = SEND_ERROR;
                    return;
                }
                if (regexEmail == false) {
                    request.setAttribute("EMAIL_WRONG_FORMAT", "Please check up email format!!");
                    url = SEND_ERROR;
                    return;
                }
                if (phone.length() > 11) {
                    request.setAttribute("PHONE_WRONG_LENGTH", "Phone number is too long!!");
                    url = SEND_ERROR;
                    return;
                }
                if (chevj == false) {
                    request.setAttribute("WRONG_DOB", "Please enter a correct date!!");
                    url = SEND_ERROR;
                    return;
                }
                if (true) {
                    boolean check = dao.updateCurrentCustomerInfo(avatar, name, email, dob, gender, phone, username);
                    if (check) {
                        request.setAttribute("UPDATE_SUCESSFULLY", "All your information has been updated!");
                        session.setAttribute("CURRENT_CUSTOMER", customer);
                        url = SUCCESS;
                    }
                }
            }
        } catch (Exception e) {
            log("Error at UpdateCustomerInfoController: " + e.getMessage());
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
