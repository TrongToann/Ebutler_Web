/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.AddressDAO;
import com.ebutler.swp.dao.ShipperCompanyDAO;
import com.ebutler.swp.dto.CartDTO;
import com.ebutler.swp.dto.CartServiceDTO;
import com.ebutler.swp.dto.CustomerDTO;
import com.ebutler.swp.dto.ProvinceDTO;
import com.ebutler.swp.dto.UserDTO;
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
@WebServlet(name = "LoadCartDataController", urlPatterns = {"/LoadCartDataController"})
public class LoadCartDataController extends HttpServlet {

    private static final String ERROR = "errorPage.jsp";
    private static final String SUCCESS = "customer_checkoutPage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            if (session != null) {
                AddressDAO addressDao = new AddressDAO();
                CartDTO cart = (CartDTO) session.getAttribute("CART");
                CartServiceDTO cartService = (CartServiceDTO) session.getAttribute("CART_SERVICE");
                ArrayList<ProvinceDTO> province_list = addressDao.SelectProvince();
                
                UserDTO currentUser = (UserDTO) session.getAttribute("LOGIN_USER");
                CustomerDTO customer = (CustomerDTO) session.getAttribute("CURRENT_CUSTOMER");
                String phone = customer.getPhone();
                ShipperCompanyDAO companyDAO = new ShipperCompanyDAO();


                session.setAttribute("CART", cart);
                session.setAttribute("CART_SERVICE", cartService);
                session.setAttribute("PROVINCE_LIST", province_list);

                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at LoadCartDataController" + e.toString());
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
