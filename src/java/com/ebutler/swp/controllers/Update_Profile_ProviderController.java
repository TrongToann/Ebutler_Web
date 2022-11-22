/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.ProductDetailDTO;
import com.ebutler.swp.dto.ProviderDTO;
import com.ebutler.swp.dto.ProviderServiceDTO1;
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
public class Update_Profile_ProviderController extends HttpServlet {

    private static final String PRO = "Provider_ProductController";
    private static final String SER = "Provider_ServiceController";
    private static final String ERROR = "Provider_ProductController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean check = false;
            boolean check2 = false;
            boolean checkValidation = true;

            String fullName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            HttpSession session = request.getSession();
            ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER");
            ProviderDAO providerDAO = new ProviderDAO();
            check = providerDAO.editProviderProfile(provider, phoneNumber, email, fullName);
            check2 = providerDAO.editProviderProfileTOO(provider, phoneNumber, email);
            List<ProductDetailDTO> listProduct = (List<ProductDetailDTO>) session.getAttribute("Provider_ListProduct");
            List<ProviderServiceDTO1> listService = (List<ProviderServiceDTO1>) session.getAttribute("Providder_ListService");
            if (check) {
                ProviderDTO provider2 = providerDAO.getProvider(provider.getUsername(), provider.getPassword());
                session.setAttribute("LOGIN_PROVIDER", provider2);
                if (check2) {
                    if (listProduct.isEmpty()) {
                        url = SER;
                    } else if (listService.isEmpty()) {
                        url = PRO ;
                    } else {
                        url = SER ; 
                    }
                }
            } else {
                request.setAttribute("MESSAGE", "Oops!! Some Problems");
            }
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
