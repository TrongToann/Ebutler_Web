/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.CustomerDAO;
import com.ebutler.swp.dao.ProductDAO;
import com.ebutler.swp.dao.ServiceDAO;
import com.ebutler.swp.dto.ProductCategoryDTO;
import com.ebutler.swp.dto.ServiceCategoryDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class LoadingProductAndServiceCategory extends HttpServlet {
    
    private static final String ERROR = "errorPage.jsp";
    private static final String SUCCESS = "customer_homePage.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            CustomerDAO customerDAO = new CustomerDAO();
            ProductDAO productDAO = new ProductDAO();
            ServiceDAO serviceDAO = new ServiceDAO();
            List<ProductCategoryDTO> productCategorylist = customerDAO.getProductCategoryList();
            List<ServiceCategoryDTO> serviceCategoryList = serviceDAO.getListServiceCategory();
            HttpSession session = request.getSession();
            
            session.setAttribute("PRODUCT_CATEGORY_BY_PLACE_LIST", productCategorylist);
            session.setAttribute("SERVICE_CATEGORY_BY_PLACE_LIST", serviceCategoryList);

        } catch (Exception e) {
            log("Error at LoadingProductAndServiceCategory: "+e.getMessage());
        } finally{
            request.getRequestDispatcher(SUCCESS).forward(request, response);
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
