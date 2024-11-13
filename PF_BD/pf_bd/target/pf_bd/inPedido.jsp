<%
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("submit") != null) {
        String cedulaCliente = request.getParameter("cedulaCliente");
        double monto = Double.parseDouble(request.getParameter("monto"));
        String descripcion = request.getParameter("descripcion");
        Date fechaPedido = Date.valueOf(request.getParameter("fechaPedido"));

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

            // Insertar el pedido usando el procedimiento almacenado
            String sqlPedido = "INSERT INTO pedido (CedulaCliente, Monto, Descripcion, FechaPedido) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sqlPedido);
            stmt.setString(1, cedulaCliente);  // Cedula del cliente
            stmt.setDouble(2, monto);          // Monto del pedido
            stmt.setString(3, descripcion);    // Descripción del pedido
            stmt.setDate(4, fechaPedido);      // Fecha del pedido
            stmt.executeUpdate();

            // Mensaje de éxito
            out.println("<script>alert('Pedido registrado exitosamente'); window.location.href='menu.jsp';</script>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error al registrar el pedido.'); window.location.href='insertarPedido.jsp?cedula=" + cedulaCliente + "';</script>");
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
