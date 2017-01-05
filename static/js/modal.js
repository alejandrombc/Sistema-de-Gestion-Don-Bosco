$(document).ready(function(){
	$("#abrirModal").on('click', function(){
		if($("#inicial").val() != "" && $("#final").val() != "")
			$("#myModal").modal('show');
			$("#confir").text("¿En serio desea agregar el año escolar "+ $("#inicial").val() + " - " + $("#final").val() + "?");
	

	$("#realSumbit").on('click', function(){
		$("#contact").submit();
	});

	});



});