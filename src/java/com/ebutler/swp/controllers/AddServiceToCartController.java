/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ServiceDAO;
import com.ebutler.swp.dto.CartServiceDTO;
import com.ebutler.swp.dto.ServiceCartDTO;
import com.ebutler.swp.dto.ServiceDetailDTO;
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
@WebServlet(name = "AddServiceToCartController", urlPatterns = {"/AddServiceToCartController"})
public class AddServiceToCartController extends HttpServlet {

    private static final String ERROR = "errorPage.jsp";
    private static final String SUCCESS = "customer_serviceCategoryPage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String id = request.getParameter("service_ID");
            ServiceDetailDTO serviceDetail = new ServiceDetailDTO();
            ServiceCartDTO serviceCart = new ServiceCartDTO();
            ServiceDAO serviceDao = new ServiceDAO();
            HttpSession session = request.getSession();
            if (session != null) {
                CartServiceDTO cart = (CartServiceDTO) session.getAttribute("CART_SERVICE");
                if (cart == null) {
                    cart = new CartServiceDTO();
                }
//                serviceDetail = serviceDao.getServiceDetailByID(id);
                serviceCart = serviceDao.getServiceInfoByID(id);
                if (cart.add(serviceCart)) {
                    session.setAttribute("CART_SERVICE", cart);
                    request.setAttribute("MESSAGE_SUCCESS", "Booking service successfully!");
                    url = SUCCESS;
                } else {
                    request.setAttribute("MESSAGE_ERROR", "Booking service fail!");
                }

            }

        } catch (Exception e) {
            log("Error at AddServiceToCartController: " + e.getMessage());
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
