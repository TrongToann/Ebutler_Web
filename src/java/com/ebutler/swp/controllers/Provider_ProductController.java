/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.ProductDTO;
import com.ebutler.swp.dto.ProductDetailDTO;
import com.ebutler.swp.dto.ProviderDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class Provider_ProductController extends HttpServlet {

    private static final String SUCCESS = "ProductProvider.jsp";
    private static final String ERROR = "index.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            ProviderDAO dao = new ProviderDAO();
            String chooseCategory = request.getParameter("productID_ADD");
            HttpSession session = request.getSession();
            request.setAttribute("choose", chooseCategory);
            ProviderDTO provider = new ProviderDTO();
            provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER");
            List<ProductDetailDTO> listProduct = dao.loadListProduct(provider);
            List<ProductDTO> listCategory = dao.loadListProductCategory();
            List<ProductDTO> listCategoryChoose = dao.loadListProductCategoryChoose(chooseCategory);
            if (listProduct != null) {
                session.setAttribute("Provider_ListProduct", listProduct);
                session.setAttribute("Provider_ListProductCategory", listCategory);
                session.setAttribute("Provider_ListProductCategoryChoose", listCategoryChoose);
                url = SUCCESS;
            } else if (listProduct.isEmpty()) { 
                session.setAttribute("MESSAGE_PRODUCT", "Your Company Don't Serve This Service");
            }
        } catch (Exception e) {

        } finally {
            request.getRequestDispatcher(url).include(request, response);
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
