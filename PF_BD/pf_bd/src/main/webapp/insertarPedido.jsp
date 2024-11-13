<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Pedido</title>
    <link rel="stylesheet" href="estilos.css"> <!-- Suponiendo que ya tienes el CSS de los estilos -->
</head>
<body>
    <div class="container">
        <h2>Registrar Pedido para el Cliente</h2>

        <form action="insertarPedido.jsp" method="POST">
            <input type="hidden" name="cedulaCliente" value="<%= request.getParameter("cedula") %>">
            
            <div class="form-group">
                <label for="monto">Monto del Pedido</label>
                <input type="number" id="monto" name="monto" required>
            </div>
            
            <div class="form-group">
                <label for="descripcion">Descripción del Pedido</label>
                <textarea id="descripcion" name="descripcion" rows="4" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="fechaPedido">Fecha del Pedido</label>
                <input type="date" id="fechaPedido" name="fechaPedido" required>
            </div>
            
            <div class="button-container">
                <button type="submit" name="submit" value="registrarPedido">Registrar Pedido</button>
                <button type="button" onclick="window.location.href='menu.jsp'">Cancelar</button>
            </div>
        </form>
    </div>
</body>
</html>
