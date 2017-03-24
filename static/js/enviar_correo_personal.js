

    $( document ).ready(function() {
    	llenarFormularios();

		// $( "#spoiler1" ).click(function() {
		//   $( "#Secciones" ).slideToggle( "slow", function() {

		//     });
		// });

		$(".group-span-filestyle input-group-btn").css("z-index",0)


	    $('#tokenfield').tokenfield(
	    {
		  autocomplete: {
		  	// Array de objetos
		    source: Retornar() ,
		    delay: 100,
		    minLength: 3
		  },
		  showAutocompleteOnFocus: true
		})

	    $('#tokenfield')
		  .on('tokenfield:createtoken', function (e) {
			    var data = e.attrs.value.split('|')
			    e.attrs.value = data[1] || data[0]
			    e.attrs.label = data[1] ? data[0] + ' (' + data[1] + ')' : data[0]
		  })
		  .on('tokenfield:createdtoken', function (e) {
			    // Über-simplistic e-mail validation
			    var re = /\S+@\S+\.\S+/
			    var valid = re.test(e.attrs.value)
			    if (!valid) {
			      $(e.relatedTarget).addClass('invalid')
			    }
		  })
		  .on('tokenfield:edittoken', function (e) {
			    if (e.attrs.label !== e.attrs.value) {
			      var label = e.attrs.label.split(' (')
			      e.attrs.value = label[0] + '|' + e.attrs.value
			    }

			})
		  .on('tokenfield:removedtoken', function (e) {
		  		$('#div_correo').attr('class', 'form-group');
		  		$('#glyphicon_error').remove();
		  })
	 	.tokenfield()



	 	function llenarFormularios() {

			var string = '<table class="table" style="background-color: #FFFFFF; border-radius: 10px;"><tbody><tr><td><b>Docente:</b></td>'
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="1"></label></td>';

			string = string + '</tr><tr><td><b>Administrativo:</b></td>';
			string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="2"></label></td>';
			

			string = string + "</tr><tr><td><b>Obrero:</b></td>";
			string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="3"></label></td>';
			

			string = string + '</tr></tbody></table>'		
			$("#Personal").html(string);



	 	} // Fin Funcion
 });
