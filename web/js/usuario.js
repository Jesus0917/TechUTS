/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

function llenarFormulario(fila){
    var id = $(fila).find(".id").text();
    var nombres = $(fila).find(".nombres").text();
    var apellidos = $(fila).find(".apellidos").text();
    var telefono = $(fila).find(".telefono").text();
    var correo = $(fila).find(".correo").text();
    var tipoDocumento = $(fila).find(".tipoDocumento").text();
    var documento = $(fila).find(".documento").text();
    var nombreUsuario = $(fila).find(".nombreUsuario").text();
    var contrasena = $(fila).find(".contrasena").text();
    var imagenSrc = $(fila).find(".imagen img").attr("src");
    
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
    $("#txtId option[selected]").removeAttr('selected');
    
}

$(document).ready(function(){
    $("#exampleModal").on("hidden.bs.modal", function(){
        $('form')[0].reset();
        $("#imgPreview").attr("src", "");  // Clear image preview
    });
   $(document).on('click', '.btnEditar', function(){
        llenarFormulario($(this).closest('tr'));
   });
   $(document).on('click', '.btnEliminar', function(){
        llenarFormulario($(this).closest('tr'));
   });
});