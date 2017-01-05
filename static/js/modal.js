$(document).ready(function() {

	$("#abrirModal").on('click', function() {
		if($("#inicial").val() != "" && $("#final").val() != "")
			$("#myModal").modal('show');
			$("#confir").text("¿Está seguro de agregar el año escolar "+ $("#inicial").val() + " - " + $("#final").val() + "?");
	

	$("#realSumbit").on('click', function(){
		$("#contact").submit();
	});

	});

});