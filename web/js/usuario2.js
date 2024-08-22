function llenarFormulario(fila) {
    var id = $(".id").text().trim();
    var nombres = $(".nombres").text().trim();
    var apellidos = $(".apellidos").text().trim();
    var telefono = $(".telefono").text().trim();
    var correo = $(".correo").text().trim();
    var tipoDocumento = $(".tipoDocumento").text().trim();
    var documento = $(".documento").text().trim();
    var nombreUsuario = $(".nombreUsuario").text().trim();
    var contrasena = $(".contrasena").text().trim();
    var imagenSrc = $(".imagen img").attr("src");

    console.log("Datos obtenidos:");
    console.log("ID: ", id);
    console.log("Nombres: ", nombres);
    console.log("Apellidos: ", apellidos);
    console.log("Telefono: ", telefono);
    console.log("Correo: ", correo);
    console.log("Tipo Documento: ", tipoDocumento);
    console.log("Documento: ", documento);
    console.log("Nombre Usuario: ", nombreUsuario);
    console.log("Contraseña: ", contrasena);
    console.log("Imagen: ", imagenSrc);

    $("#txtId").val(id);
    $("#txtNombres").val(nombres);
    $("#txtApellidos").val(apellidos);
    $("#txtTelefono").val(telefono);
    $("#txtCorreo").val(correo);
    $("#txtTipoDocumento").val(tipoDocumento);
    $("#txtDocumento").val(documento);
    $("#txtNombreUsuario").val(nombreUsuario);
    $("#txtContrasena").val(contrasena);
    $("#imgPreview").attr("src", imagenSrc);
}

$(document).ready(function(){
    $("#exampleModal").on("hidden.bs.modal", function(){
        $('form')[0].reset();
        $("#imgPreview").attr("src", "");  // Clear image preview
    });
    $(document).on('click', '.btnEditar', function(){
        var fila = $(this).closest('tr');
        llenarFormulario(fila);
    });
    $(document).on('click', '.btnEliminar', function(){
        var fila = $(this).closest('tr');
        llenarFormulario(fila);
    });
});