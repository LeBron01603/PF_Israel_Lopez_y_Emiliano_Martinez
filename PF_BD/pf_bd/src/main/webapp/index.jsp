<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión</title>
    <link rel="stylesheet" href="login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <div class="Login">
        <h2>Inicio de Sesión</h2>
        <% if ("true".equals(request.getParameter("error"))) { %>
            <p style="color: red;">Usuario o contraseña incorrectos. Intente de nuevo.</p>
        <% } %>
        <form action="login.jsp" method="post">
            <div class="usuario">
                <input type="text" name="id_Usuario" placeholder="Usuario" required>
                <i class='bx bx-user'></i>
            </div>
            <div class="usuario">
                <input type="password" name="Contraseña" placeholder="Contraseña" class="password" required>
                <i class='bx bx-hide eye-icon'></i>
            </div>                    
            <div class="recordarU">
                <label>
                    <input id="recordarUsuario" type="checkbox">Mantener sesión iniciada
                </label>
            </div>
            <div class="botones">
                <button type="reset">Cancelar</button>
                <button type="submit">Ingresar</button>
            </div>
        </form>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const pwShowHide = document.querySelectorAll(".eye-icon");
            pwShowHide.forEach(eyeIcon => {
                eyeIcon.addEventListener("click", () => {
                    let pwField = eyeIcon.previousElementSibling;
                    if (pwField.type === "password") {
                        pwField.type = "text";
                        eyeIcon.classList.replace("bx-hide", "bx-show");
                    } else {
                        pwField.type = "password";
                        eyeIcon.classList.replace("bx-show", "bx-hide");
                    }
                });
            });
        });
    </script>
</body>
</html>