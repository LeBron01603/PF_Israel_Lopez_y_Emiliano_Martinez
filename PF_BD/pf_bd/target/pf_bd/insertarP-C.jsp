<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulario de Cliente y Pedido</title>
    <link rel="stylesheet" href="insertarP-C.css">
</head>
<body>
    <div class="container">
        <h2>Registrar Cliente y Pedido</h2>
        <form action="insertardatos.jsp" method="post" onsubmit="return validarFormulario()">
            
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

            <!-- Sección de Datos del Pedido -->
            <div class="section">
                <h3>Datos del Pedido</h3>
                <div class="grid-container">
                    <div class="form-group">
                        <label for="cedulaPedido">Cédula del Cliente</label>
                        <input type="text" id="cedulaPedido" name="cedulaPedido" required>
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
            </div>

            <div class="button-container">
                <button type="submit" name="accion" value="registrarCliente">Registrar Cliente</button>
                <button type="submit" name="accion" value="registrarPedido">Registrar Pedido</button>
                <button type="button" onclick="window.location.href='menu.jsp';">Volver</button>
            </div>
        </form>
    </div>

    <script>
        function validarFormulario() {
            // Validar campos obligatorios
            var primerNombre = document.getElementById('tfNombre1').value.trim();
            var cedula = document.getElementById('tfIdentificacion').value.trim();
            var monto = document.getElementById('monto').value.trim();
            
            if (primerNombre === '') {
                alert('El campo Primer Nombre es obligatorio.');
                return false;
            }
    
            if (cedula === '') {
                alert('El campo Cédula es obligatorio.');
                return false;
            }
    
            if (!/^\d+$/.test(cedula)) { // Verificar que la cédula sea solo números
                alert('La cédula debe contener solo números.');
                return false;
            }
    
            if (monto === '' || isNaN(monto) || parseFloat(monto) <= 0) {
                alert('El monto debe ser un número positivo.');
                return false;
            }
    
            return true;
        }
    </script>
</body>
</html>
