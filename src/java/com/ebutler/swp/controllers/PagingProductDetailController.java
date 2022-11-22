/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProductDAO;
import com.ebutler.swp.dto.ProductDetailDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Dang Viet
 */
public class PagingProductDetailController extends HttpServlet {

    String ERROR = "errorPage.jsp";
    String SUCCESS = "customer_productPage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            String index = request.getParameter("index");
            if (index == null) {
                index = "1";
            }
            int indexPage = Integer.parseInt(index);
            String productID = request.getParameter("product_ID");
            if (productID == null) {
                productID = (String) session.getAttribute("PRODUCTID");
            } else {
                session.setAttribute("PRODUCTID", productID);
            }

            String category_ID = (String) session.getAttribute("CATEGORYID");

            ProductDAO dao = new ProductDAO();

            List<ProductDetailDTO> list = dao.getPagingProductDetail(category_ID, productID, indexPage);
            session.setAttribute("PRODUCT_DETAIL_BY_TYPE", list);

            int numberPageProductDetail = dao.getNumberPageProductDetail(category_ID, productID);
            if(numberPageProductDetail == 1){
                numberPageProductDetail = 0;
            }
//            List<ProductDetailDTO> list1 = dao.getListProductByPlaceDetail(category_ID, productID);
//            
//            session.setAttribute("PRODUCT_DETAIL_BY_TYPE", list);
            session.setAttribute("NUMBER_PAGE_PRODUCT_DETAIL", numberPageProductDetail);
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
