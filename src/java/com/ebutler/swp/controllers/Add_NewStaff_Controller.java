/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.ProviderDTO;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author DELL
 */
@MultipartConfig
public class Add_NewStaff_Controller extends HttpServlet {

    private static final String SUCCESS = "Provider_StaffController";
    private static final String ERROR = "Provider_StaffController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean check = false;
            String nameStaff = request.getParameter("staffName");
            String idService = request.getParameter("IDService");
            String staffIDCard = request.getParameter("idCard");
            HttpSession session = request.getSession();
            ProviderDAO providerDAO = new ProviderDAO();
            ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER");

            String uploadPath = getServletContext().getRealPath("") + File.separator + "img";
            File uploadDir = new File(uploadPath);

            String newPath = "";
            if (uploadPath.contains(File.separator + "build")) {
                newPath = uploadPath.replace(File.separator + "build", "");
            }
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            Part part = request.getPart("img");
            String fileName = part.getSubmittedFileName();

            part.write(newPath + File.separator + fileName);

            check = providerDAO.providerAddStaff(provider, idService, nameStaff, staffIDCard, fileName);
            if (check) {
                url = SUCCESS;

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
