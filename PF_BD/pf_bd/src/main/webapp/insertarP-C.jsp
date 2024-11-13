<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

            // Realizamos la consulta al backend (mismo archivo insertarP-C.jsp)
            fetch('insertarP-C.jsp?accion=consultarCliente&cedula=' + cedula)
                .then(response => response.json())  // Esperamos una respuesta en formato JSON
                .then(data => {
                    // Verificamos si hay un error en el servidor
                    if (data.error) {
                        console.error('Error del servidor:', data.error);
                        alert('Hubo un error en el servidor: ' + data.error);
                        return;
                    }

                    // Si el cliente existe, mostrar el formulario de pedido
                    if (data.existe) {
                        alert("El cliente ya existe.");
                        document.getElementById("clienteExistente").style.display = "block";
                        document.getElementById("btnRegistrarPedido").disabled = false;
                        document.getElementById("datosCliente").style.display = "none"; // Ocultar formulario de cliente
                        document.getElementById("cedulaPedido").value = cedula;
                    } else {
                        // Si el cliente no existe, mostrar el formulario de registro de cliente
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
        <form action="insertarP-C.jsp" method="post" onsubmit="return validarFormulario()">
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
                        <label for="tfNombre2">Segundo Nombre</label>
                        <input type="text" id="tfNombre2" name="segundoNombre">
                    </div>
                    <div class="form-group">
                        <label for="tfApellido1">Primer Apellido</label>
                        <input type="text" id="tfApellido1" name="primerApellido" required>
                    </div>
                    <div class="form-group">
                        <label for="tfApellido2">Segundo Apellido</label>
                        <input type="text" id="tfApellido2" name="segundoApellido">
                    </div>
                    <div class="form-group">
                        <label for="E-mail">E-mail</label>
                        <input type="email" id="E-mail" name="Email">
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
        String segundoNombre = request.getParameter("segundoNombre");
        String primerApellido = request.getParameter("primerApellido");
        String segundoApellido = request.getParameter("segundoApellido");
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

                // Verificar si el cliente existe
                if (rsCliente.next()) {
                    existe = true;  // Si hay resultados, el cliente existe
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
    %>
</body>
</html>
