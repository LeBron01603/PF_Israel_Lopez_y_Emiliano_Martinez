<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Clientes</title>
    <link rel="stylesheet" href="ConsultaC.css">
    <!-- Incluir Font Awesome para los iconos -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
                <h2>Listado Cliente</h2>
            </div>
            <hr class="title-divider">

            <%-- Conexión a la base de datos --%>
            <%
                // Variables de conexión y declaración de JDBC
                String URL = "jdbc:mysql://localhost:3306/bd_pf";
                String nombreUsuario = "root";
                String nombreClave = "Emiliano01603";

                Connection conn = null;
                CallableStatement stmt = null;
                ResultSet rs = null;

                try {
                    // Cargar el driver de MySQL
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, nombreUsuario, nombreClave);

                    // Llamar al procedimiento almacenado 'obtenerClientes'
                    String sql = "{CALL obtenerClientes()}";
                    stmt = conn.prepareCall(sql);
                    rs = stmt.executeQuery();
            %>
            <% 
            // Verificar si existe el parámetro 'mensaje' en la URL
            String mensaje = request.getParameter("mensaje");
            if (mensaje != null && !mensaje.isEmpty()) {
                
                mensaje = java.net.URLDecoder.decode(mensaje, "UTF-8");
            %>
            <!-- Mostrar el mensaje -->
            <div class="mensaje">
                <p><%= mensaje %></p>
            </div>
            <% } %>

            <div id="resultado-listado">
                <table class="user-table">
                    <thead>
                        <tr>
                            <th style="min-width: 100px;">Cédula</th>
                            <th>Nombre 1</th>
                            <th>Nombre 2</th>
                            <th>Apellido 1</th>
                            <th>Apellido 2</th>
                            <th>Correo</th> 
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% while (rs.next()) { %>
                            <tr>
                                <td><%= rs.getString("Cedula") %></td>
                                <td><%= rs.getString("Nombre1") %></td>
                                <td><%= rs.getString("Nombre2") %></td>
                                <td><%= rs.getString("Apellido1") %></td>
                                <td><%= rs.getString("Apellido2") %></td>
                                <td><%= rs.getString("Correo") %></td> 
                                <td>
                                    <!-- Formulario para editar el cliente -->
                                    <form method="get" action="MantenimientoC.jsp">
                                        <input type="hidden" name="idCliente" value="<%= rs.getString("Cedula") %>">
                                        <button type="submit" class="btn-editar">
                                            <i class="fas fa-edit"></i> Editar
                                        </button>
                                    </form>
                                    <!-- Formulario para eliminar el cliente -->
                                    <form method="post" action="eliminarC.jsp" onsubmit="return confirmarEliminacion(this);">
                                        <input type="hidden" name="cedula" value="<%= rs.getString("Cedula") %>">
                                        <button type="submit" class="btn-eliminar">
                                            <i class="fas fa-trash-alt"></i> Eliminar
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <%-- Manejo de excepciones y cierre de conexiones --%>
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
                <button type="button" onclick="window.location.href = 'menu.jsp';" class="btn-exit btn-salir">Salir</button>
            </div>
            
        </div>
    </div>
</body>
</html>
