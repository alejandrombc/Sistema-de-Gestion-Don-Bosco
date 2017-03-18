	var confirmacion_real = "";

	$(document).ready(function() 
    {
        $( "#tabs" ).tabs();
        $( ".btn" ).button();
        $("#vertical").tabs().addClass("ui-tabs-vertical");
        $("#vertical > ul > li").removeClass("ui-corner-top").addClass("ui-corner-left");

        $("body").on('click', function()
        {
            if (($("#tocheck").hasClass("open"))) 
                $("#spaces").css({ display: "none" });
        });


        $("#space").on('click', function()
        {
            if (($("#tocheck").hasClass("open"))) $("#spaces").css({ display: "none" });
            else $("#spaces").css({ display: "block" });
        });

        $("#ocultar").on('click', function(){
            if (($("#tocheck").hasClass("open"))) {
                $("#spaces").css({ display: "none" });
            }
            else $("#spaces").css({ display: "block" });
        });



        //Confirmacion de entrada del modal estudiantes
        $("#confirmacion_real_per").on('input', function()
        {
            confirmacion_real = $("#confirmacion_real_per").val();
            if(confirmacion_real == "Deseo eliminar a esta persona") $("#realSumbit").removeAttr('disabled');
            else $("#realSumbit").attr("disabled", "disabled");
        });

         //Cuando presiono el modal de borrar estudiante
        $("#realSumbit").on('click', function()
        {
            eliminarPersonal($("#texto_per").text());
        });

        //Cuando un modal se esconde, elimino el texto que hay en el input
        $('#modal_seccion').on('hidden.bs.modal', function() 
        {
            $('#confirmacion_real').val('');
        })

        $('#modal_est').on('hidden.bs.modal', function() 
        {
            $('#confirmacion_real_est').val('');
        })

        
        if( $('#updateado').val() == "True" ) { 
            $( "#dialog-message" ).dialog({
              modal: true,
              buttons: {
                Ok: function() {
                  $( this ).dialog( "close" );
                }
              }
            });
        }


    });


	/*Esta funcion es cuando se selecciona otro tipo de personal*/
    function cambioCargo(tipo)
    {
     	
        $('#docente').removeClass('active');
        $('#admin').removeClass('active');
        $('#obrero').removeClass('active');
        $('#'+tipo).addClass('active');

        var id_tipo = createID_tipo(tipo);
        $.ajax
        ({
            type:"GET" ,
            url: '/personal_escoger_tipo?id_tipo='+id_tipo,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError)
            {
                    console.log(xhr.status);
                    console.log(thrownError);
                    console.log(ajaxOptions);  
            },
            success: function(data)
            {    
            	var new_personal, idBody, tag, cant_personal, boton, span, element;

            	idBody = $('#body_select');
            	idBody.empty();

            	new_personal = jQuery.parseJSON(data);
            	cant_personal = new_personal.length;

            	for (j = 0; j < cant_personal; j++) 
            	{
            		tag = document.createElement('tr');
            		tag.setAttribute('id', (String(new_personal[j][0])));
            		tag.setAttribute('class', ("active"));

            		element = document.createElement('td');
            		element.setAttribute('class', 'cedulaPersonal editarPersonal');
            		element.setAttribute('onclick',"mostrarDetallePersonal("+new_personal[j][0]+")");
            		element.innerHTML = new_personal[j][0];
            		tag.appendChild(element);

            		element = document.createElement('td');
            		element.setAttribute('class', 'editarPersonal');
            		element.setAttribute('onclick',"mostrarDetallePersonal("+new_personal[j][0]+")");
            		element.innerHTML = new_personal[j][1];
            		tag.appendChild(element);

            		element = document.createElement('td');
            		element.setAttribute('class', 'editarPersonal');
            		element.setAttribute('onclick',"mostrarDetallePersonal("+new_personal[j][0]+")");
            		element.innerHTML = new_personal[j][2];
            		tag.appendChild(element);

            		element = document.createElement('td');
            		element.setAttribute('class', 'editarPersonal');
            		element.setAttribute('onclick',"mostrarDetallePersonal("+new_personal[j][0]+")");
            		element.innerHTML = new_personal[j][4];
            		tag.appendChild(element);

            		element = document.createElement('td');
            		element.setAttribute('id', 'inasistencia'+ new_personal[j][0]);
            		element.innerHTML = new_personal[j][6];
            		tag.appendChild(element);

            		element = document.createElement('td');
            		boton = document.createElement('button');
            		boton.setAttribute('class', 'btn btn-warning');
            		boton.setAttribute('id','add'+ new_personal[j][0]);
            		boton.setAttribute('onclick',"agregarInasistencia(this.id)");
            		boton.innerHTML = 'Agregar inasistencia';
            		element.appendChild(boton);
            		tag.appendChild(element);

            		element = document.createElement('td');
            		boton = document.createElement('button');
            		boton.setAttribute('class', 'btn btn-danger botonDltEst');
            		boton.setAttribute('id','del'+new_personal[j][0]);
            		boton.setAttribute('onclick',"mostrarModalEliminarPersonal(this.id)");

            		span = document.createElement('span');
            		span.setAttribute('class', 'glyphicon glyphicon-trash');
            		boton.appendChild(span);

            		element.appendChild(boton);
            		tag.appendChild(element);
            		idBody.append(tag);
            	}  
            }
        });
    }

	// Funcion que retorna el ID de la BD del tipo de trabajador especificado
    function createID_tipo(tipo)
    {
        var id_tipo = 0;

        switch(tipo) {
        case "Docente":
            id_tipo = 1;
        break;
        case "Administrativo":
            id_tipo = 2;
        break;
        case "Obrero":
            id_tipo = 3;
        break;
        }
        
        return id_tipo;
    }

    /*Funcion para sumar 1 en la inasistencia del personal*/
    function agregarInasistencia(id) 
    {
        var inasistencia, res;
        
        id = id.substring(3);
        
        inasistencia = $('#inasistencia'+id).text();
        inasistencia = inasistencia.replace(/ /g,'');
        inasistencia = parseInt(inasistencia);
        inasistencia += 1;
        
        $('#inasistencia'+ id).text(inasistencia);

        res = id+'-'+inasistencia;

        $.ajax
        ({
            type:"PUT" ,
            url: '/agregarInasistenciaPersonal?resultado='+res,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError)
            {
                    console.log(xhr.status);
                    console.log(thrownError);
                    console.log(ajaxOptions);
                   
            },
            success: function() {}
       }); 
    }

    /*Funciones para borrar personal*/
    function mostrarModalEliminarPersonal(id) 
    {
        $("#modal_per").modal('show');
        id = id.substring(3);
        $("#texto_per").text(id);
    }

    /*Funcion para eliminar a una persona de la lista*/
    function eliminarPersonal(id) 
    {
        $('#'+id).remove();

        $.ajax
        ({
            type:"DELETE" ,
            url: '/eliminarPersonal?id='+id,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError)
            {
                    console.log(xhr.status);
                    console.log(thrownError);
                    console.log(ajaxOptions);
                   
            },
            success: function()
            {    
                $('#modal_per').modal('toggle');
            }
       }); 
    }


    function mostrarDetallePersonal(cedula) 
    {
        $.ajax
            ({
                type:"GET" ,
                url: '/personal?cedula='+cedula,
                dataType: "text",
                error: function (xhr, ajaxOptions, thrownError)
                {
                    console.log(xhr.status);
                    console.log(thrownError);
                    console.log(ajaxOptions); 
                },
                success: function(personal)
                {       
                    var array = jQuery.parseJSON(personal);
                    var nombre = array[0][1];
                    var apellido = array[0][2];
                    var cedula = array[0][0];
                    var telefono = array[0][5];
                    var direccion = array[0][3];
                    var email = array[0][4];
                    var inasistencias = array[0][6];
                    var curso = (array[0][7]);
                    
                    $('#apellidos').val(apellido);
                    $('#nombres').val(nombre);
                    $('#cedula').val(cedula);

                    $('#hiddenCedula').val(cedula);
                    $('#tipo').val(curso);
                    $('#inasistencia').val(inasistencias);
                    $('#direccion').val(direccion);
                    $('#correo').val(email);
                    $('#telefono').val(telefono);
                }
            });

        $("#modal_detalle_per").modal('show');
    }


    function updateSubmit() 
    {
    	var tipo = $('#tipo').find(":selected").text();

	 	$("#real_tipo").val(createID_tipo(tipo));
	 	// $("#modalUpdate").submit();

    }