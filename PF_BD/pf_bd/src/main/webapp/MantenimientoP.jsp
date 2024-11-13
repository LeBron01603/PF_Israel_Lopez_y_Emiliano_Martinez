<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mantenimiento de Pedido</title>
    <link rel="stylesheet" href="MantenimientoP.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <div class="ventana">
        <div class="title-icon-wrapper">
            <h2>Mantenimiento de Pedido</h2>
            <div class="icono-titulo">
                <i class='bx bx-cog'></i>
            </div>
        </div>
        <hr class="title-divider">

        <%-- Obtener el ID del pedido desde la URL --%>
        <% 
            String idPedido = request.getParameter("idPedido");

            if (idPedido != null && !idPedido.isEmpty()) {
                // Variables de conexión y declaración de JDBC
                String URL = "jdbc:mysql://localhost:3306/bd_pf";
                String nombreUsuario = "root";
                String nombreClave = "Isra1107.";

                Connection conn = null;
                CallableStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, nombreUsuario, nombreClave);

                    // Llamar al procedimiento almacenado 'ConsultarPedido'
                    String sql = "{CALL ConsultarPedido(?)}"; 
                    stmt = conn.prepareCall(sql);
                    stmt.setString(1, idPedido);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
        %>
        <form action="actualizarP.jsp" method="post" class="Mantenimiento">
            <div class="form-row">
                <div class="Identificación">
                    <label for="Identificación">Cédula Cliente:</label>
                    <div class="identificacion-wrapper">
                        <!-- Campo de cédula no editable -->
                        <input type="text" id="Identificación" name="Identificacion" value="<%= rs.getString("Cedula") %>" readonly>
                    </div>
                </div>
                <div class="ID-Pedido">
                    <label for="idPedido">ID Pedido:</label>
                    <!-- Campo de ID de Pedido no editable -->
                    <input type="text" id="idPedido" name="idPedido" value="<%= rs.getString("id_pedido") %>" readonly>
                </div>
            </div>

            <div class="form-row">
                <div class="Monto">
                    <label for="Monto">Monto:</label>
                    <!-- Campo editable para el Monto -->
                    <input type="text" id="Monto" name="Monto" value="<%= rs.getString("Monto") %>">
                </div>
            </div>

            <div class="form-row">
                <div class="Descripcion">
                    <label for="Descripcion">Descripción:</label>
                    <!-- Campo editable para la Descripción -->
                    <input type="text" id="Descripcion" name="Descripcion" value="<%= rs.getString("Descripcion") %>">
                </div>
            </div>

            <div class="form-row">
                <div class="Fecha">
                    <label for="Fecha">Fecha:</label>
                    <!-- Campo editable para la Fecha -->
                    <input type="date" id="Fecha" name="Fecha" value="<%= rs.getString("Fecha") %>">
                </div>
            </div>

            <div class="form-actions">
                <!-- Botón para actualizar -->
                <button type="submit" class="btn">Actualizar</button>
                <!-- Botón para salir -->
                <button type="button" onclick="window.location.href = 'ConsultaP.jsp';" class="btn-salir">Salir</button>
            </div>
        </form>

        <% 
                    } else {
                        out.println("<p>No se encontró el pedido con ID: " + idPedido + "</p>");
                    }

                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else {
                out.println("<p>No se proporcionó ID de pedido.</p>");
            }
        %>
    </div>
</body>
</html>
