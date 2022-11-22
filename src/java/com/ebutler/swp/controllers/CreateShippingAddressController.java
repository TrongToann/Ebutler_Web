/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.AddressDAO;
import com.ebutler.swp.dto.AddressDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class CreateShippingAddressController extends HttpServlet {

    private final String ERROR = "errorPage.jsp";
    private final String SUCCESS = "customer_checkoutPage.jsp";
            
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        
        try {
            String province_id = request.getParameter("province_id");
            String city_id = request.getParameter("city_id");
            String street = request.getParameter("address");
            
            AddressDAO addressDAO = new AddressDAO();
            AddressDTO new_address = new AddressDTO();
            
            String province_name = addressDAO.SelectProvinceById(province_id);
            String city_name = addressDAO.SelectCityById(city_id);
            
            new_address.setStreet(street);
            new_address.setProvince_name(province_name);
            new_address.setDistrict_name(addressDAO.SelectCityById(city_id));
            
//            String address_ha = new_address.toString();
            
            request.setAttribute("NEW_ADDRESS", new_address);
            url = SUCCESS;
        }
        catch (Exception e) {
            log("ERROR at CreateShippingAddressController");
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
