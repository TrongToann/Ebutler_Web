/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.CustomerDAO;
import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dao.RoleDAO;
import com.ebutler.swp.dao.UserDAO;
import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.dto.ProviderDTO;
import com.ebutler.swp.dto.RoleDTO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class RegisterController extends HttpServlet {

    private final String ERROR = "errorPage.jsp";
    private final String SUCCESS = "MainController?action=Login";
    private final String NOT_PASS = "guest_registerPage.jsp";
    private final String CUSTOMER = "CUS";
    private final String PROVIDER = "PRO";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = NOT_PASS;
        try {

//            gửi danh sách role  
            RoleDAO roleDAO = new RoleDAO();
            ArrayList<RoleDTO> role_list = roleDAO.GetRole();

            request.setAttribute("ROLE_LIST", role_list);

//            check Register or not
            boolean isRegister = Boolean.parseBoolean(request.getParameter("isRegister"));

            if (!isRegister) {
                return;
            }

//            Lấy thông tin user
            String username = request.getParameter("username").trim();
            String password = request.getParameter("password").trim();
            String confirm_password = request.getParameter("confirm_password").trim();
            String phone = request.getParameter("phone").trim();
            String email = request.getParameter("email").trim();
            String name = request.getParameter("name").trim();

//            Lấy user role
            String role_id = request.getParameter("role_id");
            request.setAttribute("ROLE_ID", role_id);

//            Check validation cho input
            UserDAO userDAO = new UserDAO();

            if (role_id.equals(CUSTOMER)) {
                int gender = Integer.parseInt(request.getParameter("gender"));
                String dob = request.getParameter("dob");
                
//                gửi lại thông tin đã nhập
                CustomerDTO customer = new CustomerDTO(username, password, role_id, phone, email, name, gender, dob, "", 1);
                
                request.setAttribute("CUS_INFO", customer);

                CustomerDTO customerError = new CustomerDTO();

                boolean checkValidation = true;

                if (userDAO.isExisted(username)) {
                    customerError.setUsername("Username has already existed!");
                    checkValidation = false;
                }
                
                if (userDAO.isExistedPhone(phone)) {
                    customerError.setPhone("Phone has already existed");
                    checkValidation = false;
                }

                if (userDAO.isExistedEmail(email)) {
                    customerError.setEmail("Email has already existed");
                    checkValidation = false;
                }

                if (checkValidation) {
                    CustomerDAO cusDAO = new CustomerDAO();

//                    add thông tin customer vào database
                    if (cusDAO.InsertCus(customer)) {
                        request.setAttribute("REGIST_SUCCESS", "Register susscessfully!");
                        url = SUCCESS;
                    }

                } else {
                    request.setAttribute("CUS_ERROR", customerError);
                    request.setAttribute("REGIST_FAIL", "Register fail!");
                    url = NOT_PASS;
                }
            }

            if (role_id.equals(PROVIDER)) {
                ProviderDTO providerError = new ProviderDTO();

//                gửi dữ liệu đã nhập
                ProviderDTO provider = new ProviderDTO(username, password, role_id, phone, email, name, "", 1);
                request.setAttribute("PRO_INFO", provider);

                boolean checkValidation = true;

                if (userDAO.isExisted(username)) {
                    providerError.setUsername("Username has already existed!");
                    checkValidation = false;
                }
                
                if (userDAO.isExistedEmail(email)) {
                    providerError.setEmail("Email has already existed");
                    checkValidation = false;
                }
                
                if (userDAO.isExistedPhone(phone)) {
                    providerError.setPhone("Phone has already existed");
                    checkValidation = false;
                }

                if (checkValidation) {
                    ProviderDAO proDAO = new ProviderDAO();

//                    add thông tin provider vào database
                    if (proDAO.InsertPro(provider)) {
                        url = SUCCESS;
                    }
                } else {
                    request.setAttribute("PRO_ERROR", providerError);
                    url = NOT_PASS;
                }
            }

        } catch (Exception e) {
            log("ERROR at RegisterController: " + e.toString());
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
