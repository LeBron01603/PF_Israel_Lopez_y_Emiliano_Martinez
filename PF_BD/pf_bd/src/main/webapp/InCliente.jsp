<%
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("submit") != null) {
        String identificacion = request.getParameter("identificacion");
        String primerNombre = request.getParameter("primerNombre");
        String segundoNombre = request.getParameter("segundoNombre");
        String primerApellido = request.getParameter("primerApellido");
        String segundoApellido = request.getParameter("segundoApellido");
        String email = request.getParameter("email");

        // Variables de conexión
        String url = "jdbc:mysql://localhost:3306/bd_pf";
        String user = "root";
        String password = "Isra1107.";
        
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Conectar a la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            // Insertar el cliente usando el procedimiento almacenado
            String sqlCliente = "INSERT INTO cliente (Cedula, PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, Email) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sqlCliente);
            stmt.setString(1, identificacion);  
            stmt.setString(2, primerNombre);    
            stmt.setString(3, segundoNombre);   
            stmt.setString(4, primerApellido);  
            stmt.setString(5, segundoApellido); 
            stmt.setString(6, email);           
            stmt.executeUpdate();

            // Redirigir a la página de registro de pedidos
            response.sendRedirect("insertarPedido.jsp?cedula=" + identificacion);

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error al registrar al cliente.'); window.location.href='insertarCliente.jsp';</script>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
