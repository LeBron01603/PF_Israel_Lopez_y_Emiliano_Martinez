document.addEventListener("DOMContentLoaded", function() {
    // Redireccionar a la página de insertar cliente y pedido
    document.getElementById('btn-insertar').addEventListener('click', function() {
        window.location.href = 'insertarClienteYPedido.jsp';  // Asegúrate de que este sea el nombre correcto
    });

    // Redireccionar a la página de mantenimiento de cliente
    document.getElementById('btn-mantenimiento').addEventListener('click', function() {
        window.location.href = 'consultarC.jsp';  // Asegúrate de que este sea el nombre correcto
    });

    // Redireccionar a la página de consulta de pedido
    document.getElementById('btn-mantenimientoP').addEventListener('click', function() {
        window.location.href = 'consultarPedido.jsp';  // Asegúrate de que este sea el nombre correcto
    });

    // Redireccionar a la página de consulta general
    document.getElementById('btn-Consulta').addEventListener('click', function() {
        window.location.href = 'consultaGeneral.jsp';  // Asegúrate de que este sea el nombre correcto
    });

    // Redireccionar a la página de inicio de sesión
    document.getElementById('btn-salir').addEventListener('click', function() {
        window.location.href = 'index.jsp';  // Asegúrate de que este sea el nombre correcto
    });
});
