<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Cliente</title>
    <link rel="stylesheet" href="estilos.css"> <!-- Suponiendo que ya tienes el CSS de los estilos -->
</head>
<body>
    <div class="container">
        <h2>Registrar Cliente</h2>
        <form action="insertarCliente.jsp" method="POST">
            <div class="form-group">
                <label for="identificacion">Cédula de Identidad</label>
                <input type="text" id="identificacion" name="identificacion" required>
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
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="button-container">
                <button type="submit" name="submit" value="registrar">Registrar Cliente</button>
                <button type="button" onclick="window.location.href='menu.jsp'">Cancelar</button>
            </div>
        </form>

        <br>
        <!-- Botón para consultar si el cliente existe -->
        <button onclick="checkClienteExistente()">Consultar Cliente</button>
    </div>

    <script>
        // Función para consultar si el cliente ya existe
        function checkClienteExistente() {
            var cedula = document.getElementById("identificacion").value;
            if (cedula == "") {
                alert("Por favor, ingresa una cédula.");
                return;
            }

            // Realizar una solicitud AJAX para verificar si el cliente ya existe
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "checkClienteExistente.jsp?cedula=" + cedula, true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var response = xhr.responseText;
                    if (response == "existe") {
                        alert("El cliente ya existe. Puedes proceder a registrar el pedido.");
                        window.location.href = "insertarPedido.jsp?cedula=" + cedula; // Redirigir a la página de pedido
                    } else {
                        alert("El cliente no existe. Se registrará ahora.");
                        document.forms[0].submit(); // Enviar el formulario para registrar al cliente
                    }
                }
            };
            xhr.send();
        }
    </script>
</body>
</html>
