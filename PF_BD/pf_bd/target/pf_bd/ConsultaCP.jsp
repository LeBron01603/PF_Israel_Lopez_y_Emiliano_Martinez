<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta Cliente y Pedido</title>
    <link rel="stylesheet" href="ConsultaCP.css">
    <script>
        function confirmarBusqueda(form) {
            if (form.cedula.value.trim() === "") {
                alert("Por favor, ingrese una cédula.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="ventana">
        <div class="title-icon-wrapper">
            <h2>Consulta de Cliente y Pedido</h2>
        </div>
        <hr class="title-divider">

        <form action="ConsultaCP.jsp" method="get" onsubmit="return confirmarBusqueda(this);">
            <div class="form-row">
                <label for="cedula">Cédula del Cliente:</label>
                <input type="text" id="cedula" name="cedula" placeholder="Ingrese la cédula" required>
                <button type="submit" class="btn-buscar">Buscar</button>
            </div>
        </form>

        <%-- Obtener la cédula ingresada y realizar la consulta --%>
        <% 
            String cedulaCliente = request.getParameter("cedula");

            if (cedulaCliente != null && !cedulaCliente.trim().isEmpty()) {
                // Variables de conexión y declaración de JDBC
                String URL = "jdbc:mysql://localhost:3306/proyecto_bd";
                String nombreUsuario = "root";
                String nombreClave = "Isra1107.";

                Connection conn = null;
                CallableStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(URL, nombreUsuario, nombreClave);

                    String sql = "{CALL Consultar_PedidoCliente(?)}"; // Procedimiento almacenado
                    stmt = conn.prepareCall(sql);
                    stmt.setString(1, cedulaCliente); // Pasar la cédula como parámetro
                    rs = stmt.executeQuery();

                    // Mostrar los detalles del cliente siempre
                    boolean clienteEncontrado = false; // bandera para verificar si el cliente existe
                    while (rs.next()) {
                        if (!clienteEncontrado) {
                            clienteEncontrado = true;
                            // Si encontramos al cliente, mostrar sus datos
        %>
        <!-- Mostrar los resultados del cliente -->
        <div id="resultado-cliente">
            <h3>Detalles del Cliente</h3>
            <table class="cliente-table">
                <tr>
                    <th>Cédula</th>
                    <td><%= cedulaCliente %></td>
                </tr>
                <tr>
                    <th>Nombre</th>
                    <td><%= rs.getString("Nombre1") %></td>
                </tr>
                <tr>
                    <th>Apellido</th>
                    <td><%= rs.getString("Apellido1") %></td>
                </tr>
            </table>
        </div>
<!-- th es para la etiqueta de la columna
    td es el dato que va en el campo, el rs.getString atrae los datos, recibe el resultado -->
        <% 
                        } // Fin de la condición para mostrar datos del cliente

                        // Mostrar los pedidos solo si existen
                        if (rs.getInt("id_pedido") != 0) {
        %>
            <h3>Pedidos del Cliente</h3>
            <table class="pedido-table">
                <thead>
                    <tr>
                        <th>ID Pedido</th>
                        <th>Monto</th>
                        <th>Descripción</th>
                        <th>Fecha</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><%= rs.getInt("id_pedido") %></td>
                        <td><%= rs.getString("Monto") %></td>
                        <td><%= rs.getString("Descripcion") %></td>
                        <td><%= rs.getDate("Fecha") %></td>
                    </tr>
                </tbody>
            </table>
        <% 
                        } 
                    }
                    if (!clienteEncontrado) {
                        out.println("<p>No se encontró un cliente con la cédula: " + cedulaCliente + "</p>");
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
            }
        %>

        <div class="actions-wrapper">
            <button type="button" onclick="window.location.href = 'menu.jsp';" class="btn-exit btn-salir">Salir</button>
        </div>
    </div>
</body>
</html>
