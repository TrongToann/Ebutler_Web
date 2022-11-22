/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.ProviderDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author DELL
 */
public class Provider_ChangePasswordController extends HttpServlet {

    private final String SUCCESS = "changePassword.jsp" ;  
    private final String ERROR = "changePassword.jsp" ;  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR ; 
        try {
            boolean check = false ; 
            String oldPassword = request.getParameter("OldPassword") ; 
            String newPassword = request.getParameter("NewPassword") ; 
            String confirmPassword = request.getParameter("ConfirmPassword") ; 
            HttpSession session = request.getSession() ; 
            ProviderDAO providerDAO = new ProviderDAO() ; 
            ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER") ; 
            if (confirmPassword.equals(newPassword)) {
                
                if (provider.getPassword().equals(oldPassword)) {
                    check = providerDAO.changePassword(provider, newPassword) ;  
                    if (check ) {
                        url = SUCCESS ; 
                        provider = providerDAO.getProvider(provider.getUsername() , newPassword) ;
                        session.setAttribute("LOGIN_PROVIDER", provider); 
                        request.setAttribute("MESSAGE", "Password Change Successfully!!"); 
                        
                    } 
                } else {
                    request.setAttribute("MESSAGE", "Oops!! Incorrect Recent Password To Change");
                }
            }else {
                request.setAttribute("MESSAGE", "Oops!! Conflict Between Two Password"); 
            }
            
            
        } catch (Exception e) {
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
