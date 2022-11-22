/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProductDAO;
import com.ebutler.swp.dto.CartDTO;
import com.ebutler.swp.dto.ProductCartDTO;
import com.ebutler.swp.dto.ProductDetailDTO;
import com.ebutler.swp.dto.QuantityStockDTO;
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
@WebServlet(name = "AddToCartController", urlPatterns = {"/AddToCartController"})
public class AddToCartController extends HttpServlet {

    private static final String ERROR = "errorPage.jsp";
    private static final String SUCCESS = "customer_productPage.jsp";
    private static final String SUCCESS_QUICKVIEW = "customer_cart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String id = request.getParameter("product_ID");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String quickview = request.getParameter("quickview");
            if (quickview == null) {
                quickview = "false";
            }
            ProductDAO dao = new ProductDAO();
            HttpSession session = request.getSession();
            if (session != null) {
                CartDTO cart = (CartDTO) session.getAttribute("CART");
                ProductCartDTO productDetail = dao.getProductForCart(id);
                QuantityStockDTO quantityStock = (QuantityStockDTO) session.getAttribute("STOCK");
                if (quantityStock == null) {
                    quantityStock = new QuantityStockDTO();
                }
                quantityStock.add(productDetail);
                productDetail.setQuantity(quantity);
                if (cart == null) {
                    cart = new CartDTO();
                }
                cart.add(productDetail);
                session.setAttribute("STOCK", quantityStock);
                session.setAttribute("CART", cart);
                request.setAttribute("ADD_SUCCESS", "Added " + quantity + " " + cart.getCart().get(id).getProduct_name() + " Successfully!");

                if (quickview.equals("true")) {
                    url = SUCCESS_QUICKVIEW;
                } else {
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
            log("Error at AddToCartController" + e.toString());
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
