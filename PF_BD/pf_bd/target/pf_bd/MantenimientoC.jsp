<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mantenimiento de Cliente</title>
    <link rel="stylesheet" href="MantenimientoC.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <style>
        .identificacion-wrapper {
            background-color: #f0f0f0;
            padding: 5px;
            border-radius: 3px;
        }
        .identificacion-wrapper input {
            border: none;
            background: transparent;
            font-size: inherit;
            width: 100%;
            box-sizing: border-box;
            padding: 5px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="ventana">
        <div class="title-icon-wrapper">
            <h2>Mantenimiento de Cliente</h2>
            <div class="icono-titulo">
                <i class='bx bx-cog'></i>
            </div>
        </div>
        <hr class="title-divider">

        <%-- Obtener el ID del cliente --%>
        <% 
            String idCliente = request.getParameter("idCliente");

            if (idCliente != null && !idCliente.isEmpty()) {
                // Variables de conexión y declaración de JDBC
                String URL = "jdbc:mysql://localhost:3306/bd_pf";
                String nombreUsuario = "root";
<<<<<<< HEAD
                String nombreClave = "Emiliano01603";
=======
                String nombreClave = "Isra1107.";
>>>>>>> Diseño

                Connection conn = null;
                CallableStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, nombreUsuario, nombreClave);

                    // Llamar al procedimiento almacenado 'ConsultarCliente'
                    String sql = "{CALL ConsultarCliente(?)}"; 
                    stmt = conn.prepareCall(sql);
                    stmt.setString(1, idCliente);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
        %>
        <form action="actualizarC.jsp" method="post" class="Mantenimiento">
            <div class="form-row">
                <div class="Identificación">
                    <label for="Identificación">Identificación:</label>
                    <div class="identificacion-wrapper">
                        <input type="text" id="Identificación" name="Identificacion" value="<%= rs.getString("Cedula") %>" readonly>
                    </div>
                </div>
            </div>
            
            <div class="form-row">
                <div class="Nombre1">
                    <label for="Nombre1">Nombre 1:</label>
                    <input type="text" id="Nombre1" name="Nombre1" value="<%= rs.getString("Nombre1") %>">
                </div>
                <div class="Nombre2">
                    <label for="Nombre2">Nombre 2:</label>
                    <input type="text" id="Nombre2" name="Nombre2" value="<%= rs.getString("Nombre2") %>">
                </div>
            </div>
            <div class="form-row">
                <div class="Apellido1">
                    <label for="Apellido1">Apellido 1:</label>
                    <input type="text" id="Apellido1" name="Apellido1" value="<%= rs.getString("Apellido1") %>">
                </div>
                <div class="Apellido2">
                    <label for="Apellido2">Apellido 2:</label>
                    <input type="text" id="Apellido2" name="Apellido2" value="<%= rs.getString("Apellido2") %>">
                </div>
            </div>
            <div class="form-row">
                <div class="Correo">
                    <label for="Correo">Correo:</label>
                    <input type="email" id="Correo" name="Correo" value="<%= rs.getString("Correo") %>"> 
                </div>
            </div>

            <!-- Campo oculto para enviar la cédula (no editable, solo referencia para actualizar) -->
            <input type="hidden" name="Cedula" value="<%= rs.getString("Cedula") %>">

            <div class="form-actions">
                <button type="submit" class="btn">Actualizar</button>
                <button type="button" onclick="window.location.href = 'ConsultaC.jsp';" class="btn-salir">Salir</button>
            </div>
        </form>

        <% 
                    } else {
                        out.println("No se encontró al cliente con Cédula: " + idCliente);
                    }

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
            } else {
                out.println("No se proporcionó Cédula del cliente.");
            }
        %>
    </div>
</body>
</html>
