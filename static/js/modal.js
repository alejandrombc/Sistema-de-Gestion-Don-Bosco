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

 function createID_carrera(clase, valor)
    {
        var id_carrera = 0;
        if(clase == '4to'){
                switch(valor) {
                case "TecnologiaGrafica":
                    id_carrera = 1;
                    break;
                case "Mecanica":
                    id_carrera = 2;
                    break;
                case "Electronica":
                    id_carrera = 3;
                    break;
                case "Contabilidad":
                    id_carrera = 4;
                    break;
                }
            }
        else if(clase == '5to'){
                switch(valor) {
                case "TecnologiaGrafica":
                    id_carrera = 5;
                    break;
                case "Mecanica":
                    id_carrera = 6;
                    break;
                case "Electronica":
                    id_carrera = 7;
                    break;
                case "Contabilidad":
                    id_carrera = 8;
                    break;
                }
            }
        else{
                switch(valor) {
                case "TecnologiaGrafica":
                    id_carrera = 9;
                    break;
                case "Mecanica":
                    id_carrera = 10;
                    break;
                case "Electronica":
                    id_carrera = 11;
                    break;
                case "Contabilidad":
                    id_carrera = 12;
                    break;
                }
            }
        return id_carrera;
    }


  function eliminarCaracteres(palabra)
  {
      palabra = palabra.replace(/á/gi,"a");
      palabra = palabra.replace(/é/gi,"e");
      palabra = palabra.replace(/í/gi,"i");
      palabra = palabra.replace(/ó/gi,"o");
      palabra = palabra.replace(/ /g,'');

      return palabra;
  }


function getIDCarrera(){
  ano = $('#ano').find(":selected").text();
  curso = $('#curso').find(":selected").text();
  curso = eliminarCaracteres(curso);

  var id_carrera = createID_carrera(ano, curso);

  $('#id_carrera').val(id_carrera);

  $('.formulario_sec').submit();

}