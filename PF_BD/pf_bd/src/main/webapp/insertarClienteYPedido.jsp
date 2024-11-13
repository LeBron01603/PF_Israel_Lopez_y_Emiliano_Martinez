<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.*" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Cliente y Pedido</title>
    <link rel="stylesheet" href="insertarClienteYPedido.css">
    <script>
        function consultarCliente() {
            var cedula = document.getElementById('cedula').value.trim();
            if (cedula === '') {
                alert('Por favor ingrese una cédula.');
                return;
            }

            // Realizar consulta AJAX
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "consultarCliente.jsp", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var respuesta = xhr.responseText.trim();
                    if (respuesta === "existe") {
                        alert("Cliente encontrado.");
                        document.getElementById('montoPedido').disabled = false;
                        document.getElementById('descripcionPedido').disabled = false;
                        document.getElementById('fechaPedido').disabled = false;
                        document.getElementById('registrarPedido').disabled = false;
                    } else {
                        alert("Cliente no encontrado. Registrando cliente...");
                        document.forms[0].submit();
                    }
                }
            };
            xhr.send("cedula=" + cedula);
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Registrar Cliente y Pedido</h2>
        <form action="insertarClienteYPedido.jsp" method="POST">
            <div class="section">
                <h3>Datos del Cliente</h3>
                <div class="form-group">
                    <label for="cedula">Cédula</label>
                    <input type="text" id="cedula" name="cedula" required>
                </div>
                <div class="form-group">
                    <label for="primerNombre">Primer Nombre</label>
                    <input type="text" id="primerNombre" name="primerNombre" required>
                </div>
                <div class="form-group">
                    <label for="segundoNombre">Segundo Nombre</label>
                    <input type="text" id="segundoNombre" name="segundoNombre">
                </div>
                <div class="form-group">
                    <label for="primerApellido">Primer Apellido</label>
                    <input type="text" id="primerApellido" name="primerApellido" required>
                </div>
                <div class="form-group">
                    <label for="segundoApellido">Segundo Apellido</label>
                    <input type="text" id="segundoApellido" name="segundoApellido">
                </div>
                <div class="form-group">
                    <label for="email">E-mail</label>
                    <input type="email" id="email" name="email">
                </div>
                <button type="button" onclick="consultarCliente()">Consultar</button>
            </div>

            <div class="section" id="pedidoSection" style="display:none;">
                <h3>Datos del Pedido</h3>
                <div class="form-group">
                    <label for="montoPedido">Monto del Pedido</label>
                    <input type="number" id="montoPedido" name="montoPedido" disabled required>
                </div>
                <div class="form-group">
                    <label for="descripcionPedido">Descripción del Pedido</label>
                    <textarea id="descripcionPedido" name="descripcionPedido" rows="4" disabled required></textarea>
                </div>
                <div class="form-group">
                    <label for="fechaPedido">Fecha del Pedido</label>
                    <input type="date" id="fechaPedido" name="fechaPedido" disabled required>
                </div>
                <button type="submit" id="registrarPedido" name="submitPedido" disabled>Registrar Pedido</button>
            </div>
        </form>
    </div>

    <% 
        if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("submitPedido") != null) {
            String cedula = request.getParameter("cedula");
            double monto = Double.parseDouble(request.getParameter("montoPedido"));
            String descripcion = request.getParameter("descripcionPedido");
            java.sql.Date fechaPedido = java.sql.Date.valueOf(request.getParameter("fechaPedido"));

            String url = "jdbc:mysql://localhost:3306/bd_pf";
            String user = "root";
            String password = "Isra1107.";
            try (Connection conn = DriverManager.getConnection(url, user, password)) {
                // Llamada al procedimiento almacenado para insertar pedido
                String sqlPedido = "{call insertarPedido(?, ?, ?, ?)}";
                try (PreparedStatement stmt = conn.prepareStatement(sqlPedido)) {
                    stmt.setString(1, cedula);
                    stmt.setDouble(2, monto);
                    stmt.setString(3, descripcion);
                    stmt.setDate(4, fechaPedido);
                    stmt.executeUpdate();
                    out.println("<script>alert('Pedido registrado exitosamente');</script>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<script>alert('Error al registrar el pedido: " + e.getMessage() + "');</script>");
            }
        }
    %>
</body>
</html>
