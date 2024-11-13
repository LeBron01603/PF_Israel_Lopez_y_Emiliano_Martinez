<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
    String cedula = request.getParameter("cedula");
    String url = "jdbc:mysql://localhost:3306/bd_pf";
    String user = "root";
    String password = "Isra1107.";
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        String sql = "SELECT * FROM cliente WHERE Cedula = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, cedula);
        rs = stmt.executeQuery();

        if (rs.next()) {
            out.print("existe");  // Cliente existe
        } else {
            out.print("noExiste");  // Cliente no existe
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
