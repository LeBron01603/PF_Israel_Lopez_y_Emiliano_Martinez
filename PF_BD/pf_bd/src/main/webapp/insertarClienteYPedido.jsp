<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.sql.Date" %> <!-- Importamos java.sql.Date -->

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

            // Agregar un console.log para depuración
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var respuesta = xhr.responseText.trim();
                    console.log("Respuesta del servidor: ", respuesta);  // Depuración

                    if (respuesta === "existe") {
                        alert("Cliente encontrado.");
                        // Habilitar los campos para ingresar el pedido
                        document.getElementById('montoPedido').disabled = false;
                        document.getElementById('descripcionPedido').disabled = false;
                        document.getElementById('fechaPedido').disabled = false;
                        document.getElementById('registrarPedido').disabled = false;
                    } else if (respuesta === "noExiste") {
                        alert("Cliente no encontrado. Registrando cliente...");
                        document.forms[0].submit(); // Enviar el formulario para registrar el cliente
                    } else {
                        alert("Hubo un error al consultar el cliente.");
                    }
                } else if (xhr.readyState == 4 && xhr.status != 200) {
                    // Agregar manejo de errores
                    console.error("Error en la comunicación con el servidor.");
                    alert("Hubo un error al consultar el cliente.");
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
        // Recuperando los datos del formulario
        String cedula = request.getParameter("cedula");
        String montoPedido = request.getParameter("montoPedido");
        String descripcionPedido = request.getParameter("descripcionPedido");
        String fechaPedido = request.getParameter("fechaPedido");

        String url = "jdbc:mysql://localhost:3306/bd_pf";
        String user = "root";
        String password = "Isra1107.";
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Cargar el controlador JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establecer conexión
            conn = DriverManager.getConnection(url, user, password);

            // Aquí utilizamos el procedimiento almacenado para insertar el pedido
            String sql = "INSERT INTO bd_pf.pedidos (cedula_cliente, monto, descripcion, fecha_pedido) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, cedula);
            stmt.setDouble(2, Double.parseDouble(montoPedido));
            stmt.setString(3, descripcionPedido);

            // Utilizamos java.sql.Date para convertir la fecha correctamente
            java.sql.Date fechaSql = java.sql.Date.valueOf(fechaPedido); // Asegúrate de que la fecha esté en formato yyyy-MM-dd
            stmt.setDate(4, fechaSql);

            // Ejecutar la inserción
            stmt.executeUpdate();

            out.print("Pedido registrado con éxito.");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("Hubo un error al registrar el pedido.");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
