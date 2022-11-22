/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.OrderDTO;
import com.ebutler.swp.dto.ProductDetailDTO;
import com.ebutler.swp.dto.ProviderDTO;
import com.ebutler.swp.dto.ProviderServiceDTO1;
import java.io.IOException;
import java.util.ArrayList;
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
public class Provider_OrderController extends HttpServlet {

    private static final String ERROR = "OrderProvider.jsp" ; 
    private static final String SUCCESS = "OrderProvider.jsp" ;  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR ; 
        try {
            ProviderDAO dao = new ProviderDAO(); 
            HttpSession session = request.getSession(); 
            ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER") ; 
            List<OrderDTO> listOrder = new ArrayList();   
            List<ProductDetailDTO> listProduct = (List<ProductDetailDTO>) session.getAttribute("Provider_ListProduct") ; 
            List<ProviderServiceDTO1> listService = (List<ProviderServiceDTO1>) session.getAttribute("Providder_ListService") ;   
            int check = 0 ; 
            if (!listProduct.isEmpty()) {
                check = 1 ; 
            } 
             if (check == 1) {
                listOrder = dao.loadListOrder(provider); 
            } 
             else{
                listOrder = dao.loadListOrderService(provider) ;
            }
            if (listOrder != null) {
                url = SUCCESS ; 
                 session.setAttribute("Provider_ListOrder", listOrder);
            }
            
        } catch (Exception e) {
        }
        finally {
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
