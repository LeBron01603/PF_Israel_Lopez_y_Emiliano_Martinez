<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Pedido</title>
    <link rel="stylesheet" href="insertarP.css">
    <!-- Incluir Font Awesome para los iconos -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h2>Registrar Pedido</h2>
        <form action="insertardatosP.jsp" method="post" onsubmit="return validarFormulario()">
            
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
                <!-- Botón de Registrar con ícono -->
                <button type="submit">
                    <i class="fas fa-save"></i> Registrar Pedido
                </button>

                <!-- Botón Volver con ícono -->
                <button type="button" onclick="window.location.href='menu.jsp';">
                    <i class="fas fa-arrow-left"></i> Volver
                </button>
            </div>
        </form>
    </div>

    <script>
        function validarFormulario() {
            var cedula = document.getElementById('cedulaPedido').value.trim();
            var monto = document.getElementById('monto').value.trim();

            if (cedula === '') {
                alert('El campo Cédula del Cliente es obligatorio.');
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
