	$(document).ready(function() 
    {
		 //Confirmacion de entrada del modal de seccion
	    $("#password").on('input', function()
	         {	

	            password = $("#password").val();
	            var hash = new jsSHA(password, "TEXT");
	            var value = hash.getHash("SHA-256","HEX");
	            if(value == "a280f9c1266fc6a4aea482b8206f367bbd96a76a075140cd67ef4e92c01e3142") $("#realSumbit").removeAttr('disabled');
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