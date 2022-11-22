/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.ebutler.swp.controllers;

import com.ebutler.swp.dao.ProviderDAO;
import com.ebutler.swp.dto.ProductDetailDTO;
import com.ebutler.swp.dto.ProductErrorDTO;
import com.ebutler.swp.dto.ProviderDTO;
import com.ebutler.swp.utils.ValiUtils;
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
public class Add_NewProduct_Controller extends HttpServlet {

    private static final String SUCCESS = "Provider_ProductController";
    private static final String ERROR = "Provider_ProductController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            boolean check = false;

            boolean isValidated = true;
            String productID = request.getParameter("categoryName");
            String nameProduct = request.getParameter("NameProduct");
            String quantityProduct = request.getParameter("QuantityProduct") + "";
            String price = Double.parseDouble(request.getParameter("PriceProduct")) + "";
            String description = request.getParameter("description");
            HttpSession session = request.getSession();
            ProviderDAO providerDAO = new ProviderDAO();
            ProviderDTO provider = (ProviderDTO) session.getAttribute("LOGIN_PROVIDER");

            ProductErrorDTO productError = new ProductErrorDTO();
//            Validation value
            if (!ValiUtils.isValidProductName(nameProduct)) {
                productError.setName("Name must be include at least 2 characters, and accepted [_-]");
                isValidated = false;
            }
            if (!ValiUtils.isValidQuantity(quantityProduct)) {
                productError.setQuantity("Should be valid number. Number should be positive");
                isValidated = false;
            }
            if (!ValiUtils.isValidPrice(price)) {
                productError.setPrice("Should be valid number. Number should be positive");
                isValidated = false;
            }
            
            
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

            ProductDetailDTO product = new ProductDetailDTO(productID, nameProduct, fileName, Double.parseDouble(price), Integer.parseInt(quantityProduct), description, 0);
            request.setAttribute("PRODUCT_INFO", product);

            if (isValidated) {
                check = providerDAO.providerAddProduct(provider, productID, nameProduct.trim(), quantityProduct, price, fileName, description);

                if (check) {
                    request.setAttribute("SUCCESS_MESS", "Thêm sản phẩm thành công");
                    url = SUCCESS;
                }
            } else {
                request.setAttribute("ERROR_MESS", "Thêm sản phẩm thất bại");
                url = ERROR;
                request.setAttribute("PRODUCT_ERROR", productError);
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
