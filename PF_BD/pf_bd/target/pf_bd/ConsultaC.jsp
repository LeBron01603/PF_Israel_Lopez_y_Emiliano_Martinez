<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Cliente</title>
    <link rel="stylesheet" href="ConsultaC.css">
    <script>
        function confirmarEliminacion(form) {
            if (confirm("¿Está seguro de que desea ELIMINAR este CLIENTE con su PEDIDO?")) {
                form.submit();
            } else {
                window.location.href = "ConsultaC.jsp";
            }
            return false;
        }
    </script>
</head>
<body>
    <div class="ventana">
        <div class="Listado">
            <div class="title-icon-wrapper">
                <h2>Actualizar Cliente</h2>
            </div>
            <hr class="title-divider">

            <%-- Conexión a la base de datos --%>
            <%
                String URL = "jdbc:mysql://localhost:3306/bd_pf";
                String nombreUsuario = "root";
                String nombreClave = "Isra1107.";
                Connection conn = null;
                CallableStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Cargar el driver de MySQL
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, nombreUsuario, nombreClave);

                    // Llamar al procedimiento almacenado 'obtenerCliente' con el id del cliente
                    String cedula = request.getParameter("idCliente");
                    String sql = "SELECT * FROM clientes WHERE Cedula = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, cedula);
                    rs = stmt.executeQuery();
            %>
            
            <div id="formulario-actualizar">
                <% if (rs.next()) { %>
                <form method="POST" action="ActualizarCliente.jsp" enctype="multipart/form-data">
                    <input type="hidden" name="cedula" value="<%= rs.getString("Cedula") %>">
                    <div class="form-group">
                        <label for="nombre1">Nombre 1:</label>
                        <input type="text" name="nombre1" value="<%= rs.getString("Nombre1") %>" required>
                    </div>
                    <div class="form-group">
                        <label for="nombre2">Nombre 2:</label>
                        <input type="text" name="nombre2" value="<%= rs.getString("Nombre2") %>">
                    </div>
                    <div class="form-group">
                        <label for="apellido1">Apellido 1:</label>
                        <input type="text" name="apellido1" value="<%= rs.getString("Apellido1") %>" required>
                    </div>
                    <div class="form-group">
                        <label for="apellido2">Apellido 2:</label>
                        <input type="text" name="apellido2" value="<%= rs.getString("Apellido2") %>">
                    </div>
                    <div class="form-group">
                        <label for="correo">Correo:</label>
                        <input type="email" name="correo" value="<%= rs.getString("Correo") %>" required>
                    </div>
                    <div class="form-group">
                        <label for="imagen">Imagen (Opcional):</label>
                        <input type="file" name="imagen" accept="image/*">
                    </div>
                    <div class="actions-wrapper">
                        <button type="submit" class="btn-editar">Actualizar</button>
                    </div>
                </form>
                <% } %>
            </div>
            
            <% 
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("Error: " + e.getMessage());
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

            <div class="actions-wrapper">
                <button type="button" onclick="window.location.href = 'ConsultaC.jsp';" class="btn-exit btn-salir">Volver</button>
            </div>
        </div>
    </div>
</body>
</html>
