/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.AddressDAO;
import com.ebutler.swp.dao.CustomerDAO;
import com.ebutler.swp.dao.UserDAO;
import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.dto.GoogleUserDTO;
import com.ebutler.swp.dto.ProvinceDTO;
import com.ebutler.swp.dto.UserDTO;
import com.ebutler.swp.utils.GoogleUtils;
import java.io.IOException;
import java.util.ArrayList;
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
@WebServlet(name = "LoginWithGoogleController", urlPatterns = {"/LoginWithGoogleController"})
public class LoginWithGoogleController extends HttpServlet {

    private static final String ERROR = "LoadingProductAndServiceCategory";
    private static final String SUCCESS = "LoadingProductAndServiceCategory";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String code = request.getParameter("code");
            UserDAO userDAO = new UserDAO();
            CustomerDAO customerDAO = new CustomerDAO();
            UserDTO loginUser = new UserDTO();
            CustomerDTO customer = new CustomerDTO();
            if (!code.isEmpty()) {
                HttpSession session = request.getSession();
                AddressDAO addressDAO = new AddressDAO();
                ArrayList<ProvinceDTO> province_list = addressDAO.SelectProvince();
                if (province_list != null) {
                    session.setAttribute("PROVINCE_LIST", province_list);
                }
                
                String accessToken = GoogleUtils.getToken(code); // BUG here
                GoogleUserDTO googleUser = GoogleUtils.getUserInfo(accessToken);

                String username = googleUser.getName();
                boolean checkDuplicate = customerDAO.checkExistAccount(username);

                if (checkDuplicate) {
                    String name = googleUser.getName();
                    String email = googleUser.getEmail();
                    String password = "123";
                    String roleID = "CUS";
                    String phone = "";
                    int gender = 1;
                    String dob = "";
                    String avatar = "";
                    int status = 1;
                    customer = new CustomerDTO(username, password, roleID, phone, email, name, gender, dob, avatar, status);
                    loginUser = new UserDTO(username, password, roleID, phone, email, status);
                    boolean createAccount = customerDAO.createCustomer(customer);
                    if (createAccount) {
                        session.setAttribute("LOGIN_USER", loginUser);
                        session.setAttribute("CURRENT_CUSTOMER", customer);
                        url = SUCCESS;
                    }
                } else {
                    String password = "123";
                    UserDTO user = userDAO.Login(username, password);
                    customer = customerDAO.getCurrentCustomer(username);
                    session.setAttribute("LOGIN_USER", user);
                    session.setAttribute("CURRENT_CUSTOMER", customer);
                    url = SUCCESS;
                }

            }

        } catch (Exception e) {
            log("Error at LoginGoogleController: " + e.toString());
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
