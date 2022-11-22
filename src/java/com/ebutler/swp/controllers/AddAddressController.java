/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.AddressDAO;
import com.ebutler.swp.dto.AddressDTO;
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
public class AddAddressController extends HttpServlet {

    private final String ERROR = "errorPage.jsp";
    private final String SUCCESS = "ShowListAddressController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String current_form = request.getParameter("current_form");

            String city_id = request.getParameter("city_id");
            String street = request.getParameter("street");

            HttpSession session = request.getSession();
            UserDTO login_user = (UserDTO) session.getAttribute("LOGIN_USER");

            AddressDAO addressDAO = new AddressDAO();

            int status = (addressDAO.CountAddress(login_user.getUsername()) > 0) ? 0 : 1;

            AddressDTO address = new AddressDTO(city_id, street, login_user.getUsername(), status);

            if (addressDAO.InserAddress(address)) {
                request.setAttribute("MESSAGE_SUCCESS", "Add new address successfully!");
            } else {
                request.setAttribute("MESSAGE_FAIL", "Add new address fail!");
            }
            url = SUCCESS;

            request.setAttribute("CURRENT_FORM", current_form);

        } catch (Exception e) {
            log("ERROR at AddAddressController: " + e.toString());
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
