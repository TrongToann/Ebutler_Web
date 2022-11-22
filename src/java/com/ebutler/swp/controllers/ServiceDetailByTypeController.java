/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ServiceDAO;
import com.ebutler.swp.dao.StaffDAO;
import com.ebutler.swp.dto.ServiceDetailDTO;
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
public class ServiceDetailByTypeController extends HttpServlet {

   private static final String SUCCESS = "customer_servicePage.jsp";
   private static final String ERROR = "errorPage.jsp";
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String serviceID = request.getParameter("service_ID");
            HttpSession session = request.getSession();
            session.setAttribute("SERVICEID", serviceID);
            String category_ID = (String) session.getAttribute("CATEGORYID");
            ServiceDAO dao = new ServiceDAO();
            StaffDAO staffDAO = new StaffDAO();
            
            List<StaffDTO> staffList = staffDAO.getListStaffByServiceDetail(serviceID);
            List<ServiceDetailDTO> list = dao.getListServiceDetailByType(category_ID, serviceID);
            session.setAttribute("SERVICE_DETAIL_BY_TYPE", list);
            session.setAttribute("STAFF_LIST_BY_TYPE", staffList);
            url = SUCCESS;
            
        } catch (Exception e) {
            log("Error at ServiceDetailByTypeController: "+e.getMessage());
        }finally{
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
