$(document).ready(function() {

    $("#abrirModal").on('click', function() {
      if($("#inicial").val() != "" && $("#final").val() != "")
        if (validateForm()) $("#myModal").modal('show');
        $("#confir").text("¿Está seguro de agregar el año escolar "+ $("#inicial").val() + " - " + $("#final").val() + "?");

    });

    $("#realSumbit").on('click', function() {
      $("#contact").submit();
    });

});

function validateForm() {
  var inicio = document.getElementById("inicial").value;
  var final = document.getElementById("final").value;
  if ((inicio[0] == '2') && (inicio[1] == '0') && (final[0] == '2') && (final[1] == '0') && (final.length == 4) && (inicio.length == 4) && (final > inicio))
    return true;
  return false;
}


function openModal(inicial, final, id) {
  $("#myModal").modal('show');
  $("#id_ano").val(id);
  var ano_real = inicial +"-"+final; 
  $("#ano_real").val(ano_real);
  $("#confir").text("¿Está seguro de eliminar el año escolar "+ inicial + " - " + final + "?");
}


function openModal_Rec(inicial, final, id) {
  $("#myModal").modal('show');
  var ano_real = inicial +"-"+final; 
  $("#id_ano").val(id);
  $("#ano_real").val(ano_real);
  $("#confir").text("¿Está seguro de recuperar el año escolar "+ inicial + " - " + final + "?");
}