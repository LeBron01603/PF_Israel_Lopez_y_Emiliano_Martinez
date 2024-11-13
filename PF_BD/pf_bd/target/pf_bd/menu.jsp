<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menú</title>
    <link rel="stylesheet" href="menu.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <script defer src="menu.js"></script> <!-- Asegúrate de que el archivo JS se carga correctamente -->
</head>
<body>
    <div class="Menu">
        <h2>Menú Principal <i class='bx bx-home'></i></h2>
        <div class="insertar">
            <i class='bx bxs-user-plus'></i>
            <button type="button" onclick="location.href='insertarClienteYPedido.jsp'">Insertar Cliente</button>
        </div>
        <div class="mantenimiento">
            <i class='bx bx-wrench'></i>
            <button type="button" onclick="location.href='consultarC.jsp'">Consultar Cliente</button>
        </div>
        <div class="mantenimiento">
            <i class='bx bx-wrench'></i>
            <button type="button" onclick="location.href='consultarPedido.jsp'">Consultar Pedido</button>
        </div>
        <div class="Consulta">
            <i class='bx bxs-group'></i>
            <button type="button" onclick="location.href='consultaGeneral.jsp'">Consulta General</button>
        </div>
        <div class="salir">
            <button type="button" id="btn-salir">Salir</button>
        </div>
    </div>
</body>
</html>
