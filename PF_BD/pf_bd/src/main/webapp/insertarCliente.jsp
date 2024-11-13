<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú</title>
    <link rel="stylesheet" href="menu.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script defer src="menu.js"></script>
</head>
<body>
    <div class="Menu">
        <h2>Menú Principal
        <i class='bx bx-home'></i>
        </h2>
        <form method="post" action="">
            <div class="insertar">
                <i class='bx bxs-user-plus'></i>
                <!-- Aquí está el enlace que redirige al formulario de cliente -->
                <a href="insertarCliente.jsp" class="btn">Insertar Cliente</a>
            </div>
            <div class="mantenimiento">
                <i class='bx bx-wrench'></i>
                <button type="button" id="btn-mantenimiento">Consulta Cliente</button>
            </div>
            <div class="mantenimiento">
                <i class='bx bx-wrench'></i>
                <button type="button" id="btn-mantenimientoP">Consulta Pedido</button>
            </div>
            <div class="Consulta">
                <i class='bx bxs-group'></i>
                <button type="button" id="btn-Consulta">Consulta General</button>
            </div>
            <div class="salir">
                <button type="button" id="btn-salir">Salir</button>
            </div>
        </form>
    </div>
</body>
</html>
