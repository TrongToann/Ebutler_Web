/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.ProviderDTO;
import com.ebutler.swp.dto.ServiceDetailDTO;
import com.ebutler.swp.dto.ServiceErrorDTO;
import com.ebutler.swp.utils.ValiUtils;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class Add_NewService_Controller extends HttpServlet {

    private static final String SUCCESS = "Provider_ServiceController";
    private static final String ERROR = "Provider_ServiceController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean check = false;
            boolean isValidated = true;

            ProviderDAO providerDAO = new ProviderDAO();
            String serviceID = request.getParameter("IDService");
            String name = request.getParameter("ServiceName");
            String price = Double.parseDouble(request.getParameter("ServicePrice")) + "";
            HttpSession session = request.getSession();
            ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER");
            

            ServiceDetailDTO service_info = new ServiceDetailDTO(provider.getUsername(), serviceID, 0, name, Double.parseDouble(price), "", 0);
            request.setAttribute("SERVICE_INFO", service_info);
            
            ServiceErrorDTO serviceError = new ServiceErrorDTO();

//            validation value
            if (!ValiUtils.isValidServiceName(name)) {
                serviceError.setName("Name must be include at least 2 characters, and accepted [_-]");
                isValidated = false;
            }
            if (!ValiUtils.isValidPrice(price)) {
                serviceError.setPrice("Should be valid number. Number should be positive");
                isValidated = false;
            }

            if (isValidated) {
                check = providerDAO.providerAddService(provider, serviceID, name.trim(), price);
                if (check) {
                    request.setAttribute("SUCCESS_MESS", "Thêm dịch vụ thành công");
                    url = SUCCESS;
                }
            } else {
                request.setAttribute("ERROR_MESS", "Thêm dịch vụ thất bại");
                url = ERROR;
                request.setAttribute("SERVICE_ERROR", serviceError);
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
