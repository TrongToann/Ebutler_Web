/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.ProviderDTO;
import com.ebutler.swp.dto.ProviderStaffDTO;
import java.io.IOException;
import java.io.PrintWriter;
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
public class Provider_Filter_StaffController extends HttpServlet {

    private static final String SUCCESS = "StaffProvider.jsp";
    private static final String ERROR = "StaffProvider.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            List<ProviderStaffDTO> listFilter = new ArrayList();
            String action = request.getParameter("action");
            ProviderDAO providerDAO = new ProviderDAO();
            HttpSession session = request.getSession();
            ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER");
            if (action.equals("Staff_sortByName")) {
                listFilter = providerDAO.filterStaffByName(provider);
                if (listFilter != null) {
                    session.setAttribute("Provider_ListStaff", listFilter);
                    url = SUCCESS;
                } 
            }   else if (action.equals("Staff_sortByPedding")) {
                    listFilter = providerDAO.filterServiceByPending(provider); 
                    if (listFilter != null) {
                        session.setAttribute("Provider_ListStaff", listFilter);
                        url = SUCCESS;
                    }
                }
            
//            } else if (action.equals("Ser_sortByPriceUp")) {
//                listFilter = providerDAO.filterServiceByPriceUp(provider) ; 
//                if (listFilter != null) {
//                    session.setAttribute("Providder_ListService", listFilter);
//                    url = SUCCESS ; 
//                }
//            } else if (action.equals("Ser_sortByPriceDown")) {
//                listFilter = providerDAO.filterServiceByPriceDown(provider) ; 
//                if (listFilter != null) {
//                    session.setAttribute("Providder_ListService", listFilter);
//                    url = SUCCESS ; 
//                }
//            }
            }catch (Exception e) {
        }finally {
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
