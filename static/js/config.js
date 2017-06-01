	$(document).ready(function() 
    {
		 //Confirmacion de entrada del modal de seccion
	    $("#password").on('input', function()
	         {	

	            password = $("#password").val();
	            var hash = new jsSHA(password, "TEXT");
	            var value = hash.getHash("SHA-256","HEX");
	            if(value == "84f314a9e51934fcb70eb44c5d6c4b4f135a8bdf4cbc37a833ae388324612375") $("#realSumbit").removeAttr('disabled');
	            else $("#realSumbit").attr("disabled", "disabled");
	         });  

	   	$("#success_alert").hide();

	   	$('#filename').on('change', function() {
		  $('#formLoad').submit();
		});
    }); 

    function openModal() 
    {
        $("#modal_config").modal('show');
    }

    function openFile() 
    {
        $("#filename").click();
    }