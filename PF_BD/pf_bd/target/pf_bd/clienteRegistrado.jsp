<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cliente Registrado Exitosamente</title>
    <style>
        body {
            font-family: "Poppins", sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background: rgba(0, 0, 0, 0.8);
            color: #fff;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            width: 80%;
            max-width: 600px;
        }
        h2 {
            font-size: 28px;
            margin-bottom: 20px;
        }
        p {
            font-size: 18px;
            margin-bottom: 30px;
        }
        button {
            padding: 12px 25px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            background-color: #00bcd4;
            color: #fff;
            cursor: pointer;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        button:hover {
            background-color: #00796b;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Cliente Registrado Exitosamente</h2>
        <p>El cliente ha sido registrado correctamente en la base de datos.</p>
        <button onclick="window.location.href='menu.jsp'">Aceptar</button>
    </div>
</body>
</html>
