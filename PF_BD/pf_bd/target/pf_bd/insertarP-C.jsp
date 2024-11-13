<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Cliente y Pedido</title>
    <link rel="stylesheet" href="insertarP-C.css">

    <script>
        // Función para consultar si el cliente existe
        function consultarCliente() {
            var cedula = document.getElementById("tfIdentificacion").value.trim();
            if (cedula === '') {
                alert('Debe ingresar una cédula para consultar.');
                return;
            }

            // Realizamos la consulta al backend
            fetch('insertarP-C.jsp?accion=consultarCliente&cedula=' + cedula)
                .then(response => response.json())  // Esperamos una respuesta en formato JSON
                .then(data => {
                    if (data.existe) {
                        alert("El cliente ya existe.");
                        document.getElementById("clienteExistente").style.display = "block";
                        document.getElementById("btnRegistrarPedido").disabled = false;
                        document.getElementById("datosCliente").style.display = "none"; // Ocultar formulario de cliente
                        document.getElementById("cedulaPedido").value = cedula;
                    } else {
                        alert("El cliente no existe. Ingrese los datos.");
                        document.getElementById("datosCliente").style.display = "block"; // Mostrar formulario de cliente
                        document.getElementById("clienteExistente").style.display = "none"; // Ocultar formulario de pedido
                    }
                })
                .catch(error => {
                    console.error('Error al consultar cliente:', error);
                    alert('Hubo un error al consultar la cédula.');
                });
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Registrar Cliente y Pedido</h2>
        <form action="insertarP-C.jsp" method="post">
            <!-- Sección de Consulta de Cliente -->
            <div class="section">
                <h3>Consultar Cliente</h3>
                <div class="form-group">
                    <label for="tfIdentificacion">Cédula</label>
                    <input type="text" id="tfIdentificacion" name="identificacion" required>
                </div>
                <button type="button" onclick="consultarCliente()">Consultar</button>
            </div>

            <!-- Sección de Datos del Cliente (Solo visible si el cliente no existe) -->
            <div class="section" id="datosCliente" style="display:none;">
                <h3>Datos del Cliente</h3>
                <div class="grid-container">
                    <div class="form-group">
                        <label for="tfNombre1">Primer Nombre</label>
                        <input type="text" id="tfNombre1" name="primerNombre" required>
                    </div>
                    <div class="form-group">
                        <label for="tfApellido1">Primer Apellido</label>
                        <input type="text" id="tfApellido1" name="primerApellido" required>
                    </div>
                    <div class="form-group">
                        <label for="E-mail">E-mail</label>
                        <input type="email" id="E-mail" name="Email" required>
                    </div>
                </div>
                <button type="submit" name="accion" value="registrarCliente">Registrar Cliente</button>
            </div>

            <!-- Sección de Datos del Pedido (Solo visible si el cliente ya existe) -->
            <div class="section" id="clienteExistente" style="display:none;">
                <h3>Registrar Pedido</h3>
                <div class="grid-container">
                    <div class="form-group">
                        <label for="cedulaPedido">Cédula del Cliente</label>
                        <input type="text" id="cedulaPedido" name="cedulaPedido" disabled>
                    </div>
                    <div class="form-group">
                        <label for="monto">Monto</label>
                        <input type="number" id="monto" name="monto" required>
                    </div>
                    <div class="form-group">
                        <label for="descripcion">Descripción</label>
                        <input type="text" id="descripcion" name="descripcion" required>
                    </div>
                    <div class="form-group">
                        <label for="fechaPedido">Fecha de Pedido</label>
                        <input type="date" id="fechaPedido" name="fechaPedido" required>
                    </div>
                </div>
                <button type="submit" name="accion" value="registrarPedido" id="btnRegistrarPedido" disabled>Registrar Pedido</button>
            </div>

            <div class="button-container">
                <button type="button" onclick="window.location.href='menu.jsp';">Volver</button>
            </div>
        </form>
    </div>

    <%
        String accion = request.getParameter("accion");
        String identificacion = request.getParameter("identificacion");
        String primerNombre = request.getParameter("primerNombre");
        String primerApellido = request.getParameter("primerApellido");
        String email = request.getParameter("Email");
        String cedulaPedido = request.getParameter("cedulaPedido");
        double monto = 0;
        if(request.getParameter("monto") != null) {
            monto = Double.parseDouble(request.getParameter("monto"));
        }
        String descripcion = request.getParameter("descripcion");
        Date fechaPedido = null;
        if(request.getParameter("fechaPedido") != null) {
            fechaPedido = Date.valueOf(request.getParameter("fechaPedido"));
        }

        // Variables de conexión
        String url = "jdbc:mysql://localhost:3306/bd_pf";
        String user = "root";
        String password = "Isra1107.";  // Cambia si es necesario
        Connection conn = null;
        CallableStatement stmtConsultarCliente = null;
        ResultSet rsCliente = null;

        if ("consultarCliente".equals(accion)) {
            boolean existe = false;
            try {
                // Conectar a la base de datos
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                // Procedimiento para consultar si el cliente existe
                String sqlConsultarCliente = "{CALL ConsultarCliente(?)}";
                stmtConsultarCliente = conn.prepareCall(sqlConsultarCliente);
                stmtConsultarCliente.setString(1, identificacion);
                rsCliente = stmtConsultarCliente.executeQuery();

                // Comprobar si la respuesta contiene el campo 'existe'
                if (rsCliente.next()) {
                    existe = rsCliente.getInt("existe") == 1;  // Verificar si la columna 'existe' es 1
                }

                // Enviar respuesta en formato JSON
                out.print("{\"existe\": " + existe + "}");
            } catch (Exception e) {
                e.printStackTrace();
                out.print("{\"existe\": false, \"error\": \"" + e.getMessage() + "\"}");
            } finally {
                try {
                    if (rsCliente != null) rsCliente.close();
                    if (stmtConsultarCliente != null) stmtConsultarCliente.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Acción de registrar cliente
        if ("registrarCliente".equals(accion)) {
            try {
                // Conectar a la base de datos
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                // Procedimiento para registrar cliente
                String sqlRegistrarCliente = "{CALL RegistrarCliente(?, ?, ?, ?)}";
                CallableStatement stmtRegistrarCliente = conn.prepareCall(sqlRegistrarCliente);
                stmtRegistrarCliente.setString(1, identificacion);
                stmtRegistrarCliente.setString(2, primerNombre);
                stmtRegistrarCliente.setString(3, primerApellido);
                stmtRegistrarCliente.setString(4, email);

                stmtRegistrarCliente.executeUpdate();
                out.print("<script>alert('Cliente registrado exitosamente.');</script>");
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>alert('Hubo un error al registrar el cliente: " + e.getMessage() + "');</script>");
            } finally {
                try {
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Acción de registrar pedido
        if ("registrarPedido".equals(accion)) {
            try {
                // Conectar a la base de datos
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);

                // Procedimiento para registrar pedido
                String sqlRegistrarPedido = "{CALL RegistrarPedido(?, ?, ?, ?, ?)}";
                CallableStatement stmtRegistrarPedido = conn.prepareCall(sqlRegistrarPedido);
                stmtRegistrarPedido.setString(1, cedulaPedido);
                stmtRegistrarPedido.setDouble(2, monto);
                stmtRegistrarPedido.setString(3, descripcion);
                stmtRegistrarPedido.setDate(4, fechaPedido);

                stmtRegistrarPedido.executeUpdate();
                out.print("<script>alert('Pedido registrado exitosamente.');</script>");
            } catch (Exception e) {
                e.printStackTrace();
                out.print("<script>alert('Hubo un error al registrar el pedido: " + e.getMessage() + "');</script>");
            } finally {
                try {
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
