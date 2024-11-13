<%@ page import="java.sql.*" %>
<%
    // Variables de conexión
    String url = "jdbc:mysql://localhost:3306/bd_pf";
    String user = "root"; 
    String password = "Isra1107."; // Cambia por tu contraseña de MySQL

    // Parámetros de usuario (asegúrate de que los nombres coincidan con los campos del formulario en index.jsp)
    String idUsuario = request.getParameter("root");
    String contrasena = request.getParameter("Isra1107.");
    boolean usuarioValido = false;

    try {
        // Establecer conexión
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, user, password);

        // Preparar llamada al procedimiento almacenado
        CallableStatement stmt = conn.prepareCall("{CALL Verificar_Usuario(?, ?, ?)}");
        stmt.setString(1, idUsuario);
        stmt.setString(2, contrasena);
        stmt.registerOutParameter(3, Types.BOOLEAN);

        // Ejecutar procedimiento y obtener el resultado
        stmt.execute();
        usuarioValido = stmt.getBoolean(3);

        // Validar resultado
        if (usuarioValido) {
            response.sendRedirect("menu.jsp");
        } else {
            out.println("Usuario o contraseña incorrectos.");
        }

        // Cerrar conexión
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error en la conexión o en el procedimiento.");
    }
%>
