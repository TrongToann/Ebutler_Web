/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ebutler.swp.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class DBUtils {
    private static final String DATABASE = "SWP391_Project";
    
    public static Connection getConnection() throws SQLException, ClassNotFoundException
    {
        Connection conn = null; 
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver") ;
        String url = "jdbc:sqlserver://localhost:1433;databaseName=" + DATABASE;
        conn = DriverManager.getConnection(url, "sa" , "12345");
        return conn ; 
    }
}
