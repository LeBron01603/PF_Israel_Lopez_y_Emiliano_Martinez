function consultarCliente() {
    var cedula = document.getElementById('cedula').value.trim();
    if (cedula === '') {
        alert('Por favor ingrese una cédula.');
        return;
    }

    // Realizar consulta AJAX
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "consultarCliente.jsp", true);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

    // Agregar un console.log para depuración
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            if (xhr.status == 200) {
                var respuesta = xhr.responseText.trim();
                console.log("Respuesta del servidor: ", respuesta);  // Depuración

                if (respuesta === "existe") {
                    alert("Cliente encontrado.");
                    // Habilitar los campos para ingresar el pedido
                    document.getElementById('montoPedido').disabled = false;
                    document.getElementById('descripcionPedido').disabled = false;
                    document.getElementById('fechaPedido').disabled = false;
                    document.getElementById('registrarPedido').disabled = false;
                } else if (respuesta === "noExiste") {
                    alert("Cliente no encontrado. Registrando cliente...");
                    document.forms[0].submit(); // Enviar el formulario para registrar el cliente
                } else if (respuesta === "error") {
                    alert("Hubo un error al consultar el cliente. Verifique la base de datos.");
                } else {
                    alert("Respuesta inesperada del servidor: " + respuesta);
                }
            } else {
                console.error("Error en la comunicación con el servidor. Status: " + xhr.status);
                alert("Hubo un error al consultar el cliente. Estado HTTP: " + xhr.status);
            }
        }
    };

    xhr.send("cedula=" + cedula);
}
