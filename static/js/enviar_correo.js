

    $( document ).ready(function() {
    	llenarFormularios();

		$( "#spoiler1" ).click(function() {
		  $( "#Secciones" ).slideToggle( "slow", function() {

		    });
		});
		$( "#spoiler2" ).click(function() {
		  $( "#Secciones2" ).slideToggle( "slow", function() {

		  });
		});

		$( "#spoiler3" ).click(function() {
		  $( "#Secciones3" ).slideToggle( "slow", function() {

		  });
		});

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

	 	function TransSeccion( seccion ) {
	 		if ( seccion == "1") { return "A"; };
	 		if ( seccion == "2") { return "B"; };
	 		if ( seccion == "3") { return "C"; };
	 		if ( seccion == "4") { return "D"; };
	 		if ( seccion == "5") { return "E"; };
	 		if ( seccion == "6") { return "F"; };
	 	}


	 	function llenarFormularios() {
	 	  // Leer secciones 
	 	 var data = Retornar2();
			//  Llenamos las secciones de 4to Año 
			var string = '<table class="table" style="background-color: #FFFFFF;"><tbody><tr><td><b>4to Año: Tecnologia Grafica:</b></td>'
			for ( i = 0; i< data["1"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="1_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + '</tr><tr><td><b>4to Año: Mecanica:</b></td>';
			for ( i = 0; i< data["2"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="2_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + "</tr><tr><td><b>4to Año: Electronica:</b></td>";
			
			for ( i = 0; i< data["3"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="3_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + "</tr><tr><td><b>4to Año: Contabilidad:</b></td>";
			for ( i = 0; i< data["4"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="4_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + '</tr></tbody></table>'		
			$("#Secciones").html(string);
			//  Llenamos las secciones de 5to Año 
			var string = '<table class="table" style="background-color: #FFFFFF;"><tbody><tr><td><b>5to Año: Tecnologia Grafica:</b></td>'
			for ( i = 0; i< data["5"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="5_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + '</tr><tr><td><b>5to Año: Mecanica:</b></td>';
			for ( i = 0; i< data["6"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="6_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + "</tr><tr><td><b>5to Año: Electronica:</b></td>";
			for ( i = 0; i< data["7"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="7_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + "</tr><tr><td><b>5to Año: Contabilidad:</b></td>";
			for ( i = 0; i< data["8"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="8_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + '</tr></table>'		
			$("#Secciones2").html(string);
			//  Llenamos las secciones de 6to Año 
			var string = '<table class="table" style="background-color: #FFFFFF;"><tbody><tr><td><b>6to Año: Tecnologia Grafica:</b></td>'
			for ( i = 0; i< data["9"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="9_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + '</tr><tr><td><b>6to Año: Mecanica:</b></td>';
			for ( i = 0; i< data["10"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="10_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + "</tr><tr><td><b>6to Año: Electronica:</b></td>";
			for ( i = 0; i< data["11"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="11_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + "</tr><tr><td><b>6to Año: Contabilidad:</b></td>";
			for ( i = 0; i< data["12"];i++) {
				string = string + '<td><label class="checkbox-inline"><input type="checkbox" id="12_' + (i+1) +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></td>';
			}
			string = string + '</tr></table>'		
			$("#Secciones3").html(string);


	 	} // Fin Funcion
 });


/* 
		var string = '<ul class="list-inline"><li class="list-group-item"><b>4to Año Tecnologia Grafica:</b></li>'
			for ( i = 0; i< data["1"];i++) {
				string = string + '<li class="list-group-item"><label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["1"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></li>';
			}
			string = string + '<br/><li class="list-group-item"><b>4to Año Mecanica:</b></li>';
			for ( i = 0; i< data["2"];i++) {
				string = string + '<li class="list-group-item"><label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["2"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></li>';
			}
			string = string + "<br/><b>4to Año Electronica:</b>";
			for ( i = 0; i< data["3"];i++) {
				string = string + '<li class="list-group-item"><label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["3"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></li>';
			}
			string = string + "<br/><b>4to Año Contabilidad:</b>";
			for ( i = 0; i< data["4"];i++) {
				string = string + '<li class="list-group-item"><label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["4"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label></li>';
			}
			// Llenamos las secciones de 5to Año
			string = string + "<br/><b>5to Año Tecnologia Grafica:</b>"
			for ( i = 0; i< data["5"];i++) {
				string = string + '<label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["5"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label>';
			}
			string = string + "<br/><b>5to Año Mecanica:</b>";
			for ( i = 0; i< data["6"];i++) {
				string = string + '<label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["6"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label>';
			}
			string = string + "<br/><b>5to Año Electronica:</b>";
			for ( i = 0; i< data["7"];i++) {
				string = string + '<label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["7"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label>';
			}
			string = string + "<br/><b>5to Año Contabilidad:</b>";
			for ( i = 0; i< data["8"];i++) {
				string = string + '<label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["8"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label>';
			}	
			// Llenamos las secciones de 6to año
			string = string + "<br/><b>6to Año Tecnologia Grafica:</b>"
			for ( i = 0; i< data["9"];i++) {
				string = string + '<label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["9"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label>';
			}
			string = string + "<br/><b>6to Año Mecanica:</b>";
			for ( i = 0; i< data["10"];i++) {
				string = string + '<label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["10"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label>';
			}
			string = string + "<br/><b>6to Año Electronica:</b>";
			for ( i = 0; i< data["11"];i++) {
				string = string + '<label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["11"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label>';
			}
			string = string + "<br/><b>6to Año Contabilidad:</b>";
			for ( i = 0; i< data["12"];i++) {
				string = string + '<label class="checkbox-inline"><input type="checkbox" name=" 1_' + data["12"][i+1] +'"> Seccion: ' + TransSeccion(i+1).toString() +' </label>';
			}

*/