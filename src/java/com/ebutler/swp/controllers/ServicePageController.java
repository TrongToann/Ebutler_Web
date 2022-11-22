/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ServiceDAO;
import com.ebutler.swp.dao.StaffDAO;
import com.ebutler.swp.dto.ServiceCategoryDTO;
import com.ebutler.swp.dto.ServiceDTO;
import com.ebutler.swp.dto.StaffDTO;
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
public class ServicePageController extends HttpServlet {

    private static final String SUCCESS = "customer_serviceCategoryPage.jsp";
    private static final String ERROR = "errorPage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String category_ID = request.getParameter("category_ID");
            String category_name = request.getParameter("category_name");
            ServiceDAO dao = new ServiceDAO();
            StaffDAO staffDAO = new StaffDAO();
            List<ServiceDTO> list = dao.getListService(category_ID);
            List<ServiceCategoryDTO> list2 = dao.getListServiceByServiceID(category_ID);

            HttpSession session = request.getSession();
//            List<StaffDTO> staffList = staffDAO.getListStaffByServiceDetail(serviceID);
            session.setAttribute("CATEGORYID", category_ID);
            session.setAttribute("CUSTOMER_SERVICE_LIST", list);
            
            request.setAttribute("CATEGORY_NAME", category_name);
            
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at ServicePageController: " + e.getMessage());
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
