document.addEventListener("DOMContentLoaded", function() {
    // Redireccionar a la página de insertar
    document.getElementById('btn-insertar').addEventListener('click', function() {
        window.location.href = 'insertarP-C.jsp';
    });

    // Redireccionar a la página de mantenimiento de cliente
    document.getElementById('btn-mantenimiento').addEventListener('click', function() {
        window.location.href = 'ConsultaC.jsp';
    });

    // Redireccionar a la página de consulta de pedido
    document.getElementById('btn-mantenimientoP').addEventListener('click', function() {
        window.location.href = 'ConsultaP.jsp';
    });

    // Redireccionar a la página de consulta de cliente y pedido
    document.getElementById('btn-Consulta').addEventListener('click', function() {
        window.location.href = 'ConsultaCP.jsp';
    });
    
    // Redireccionar a la página de inicio de sesión
    document.getElementById('btn-salir').addEventListener('click', function() {
        window.location.href = 'index.jsp';
    });
});
