<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Cliente</title>
    <link rel="stylesheet" href="insertarCliente.css">
</head>
<body>
    <div class="container">
        <h2>Registrar Cliente</h2>
        <form action="insertardatosC.jsp" method="post" onsubmit="return validarFormulario()">
            
            <!-- Sección de Datos del Cliente -->
            <div class="section">
                <h3>Datos del Cliente</h3>
                <div class="grid-container">
                    <div class="form-group">
                        <label for="tfIdentificacion">Cédula</label>
                        <input type="text" id="tfIdentificacion" name="identificacion" required>
                    </div>
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
            </div>

            <div class="button-container">
                <button type="submit">Registrar Cliente</button>
                <button type="button" onclick="window.location.href='menu.jsp';">Volver</button>
            </div>
        </form>
    </div>

    <script>
        function validarFormulario() {
            var cedula = document.getElementById('tfIdentificacion').value.trim();
            var primerNombre = document.getElementById('tfNombre1').value.trim();

            // Verificar que el primer nombre y la cédula no estén vacíos
            if (primerNombre === '') {
                alert('El campo Primer Nombre es obligatorio.');
                return false;
            }

            if (cedula === '') {
                alert('El campo Cédula es obligatorio.');
                return false;
            }

            // Verificar que la cédula contenga solo números
            if (!/^\d+$/.test(cedula)) {
                alert('La cédula debe contener solo números.');
                return false;
            }

            // Preguntar al usuario si la cédula es correcta antes de continuar
            var confirmacion = confirm('¿Está seguro de que la cédula "' + cedula + '" es correcta?');
            if (!confirmacion) {
                return false;  // Si el usuario cancela, no se enviará el formulario
            }

            return true;
        }
    </script>
</body>
</html>
