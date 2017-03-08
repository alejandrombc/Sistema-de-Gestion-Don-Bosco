 var confirmacion_real = "";
 var seccion_borrar = "";

    $(document).ready(function() 
    {
        $( "#tabs" ).tabs();
        $( ".btn" ).button();
        $("#externas").tabs();
        $("#vertical").tabs().addClass("ui-tabs-vertical");
        $("#vertical > ul > li").removeClass("ui-corner-top").addClass("ui-corner-left");
        $("#internas").tabs();


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

         //Confirmacion de entrada del modal de seccion
         $("#confirmacion_real").on('input', function()
         {
            confirmacion_real = $("#confirmacion_real").val();
            if(confirmacion_real == "Deseo eliminar esta seccion") $("#realSumbit").removeAttr('disabled');
            else $("#realSumbit").attr("disabled", "disabled");
         });



         /*Cuando presiono el boton de borrar seccion dentro del modal */
        $("#realSumbit").on('click', function()
        {
            var seccion, idBody, lista_cedulas, curso_actual, ano;
            /*Se borra la lista de estudiantes*/
            $('#'+seccion_borrar).parent().css('display','none');
            seccion = seccion_borrar.substring(seccion_borrar.length-1);
            idBody = $('#body_select'+seccion);


            /*Tomo las cedulas de todos los estudiantes de la seccion a borrar y los agrego a una lista*/
            lista_cedulas = [];
            
            $( '#body_select'+seccion +' td.cedulaEstudiante').each(function() 
            { 
                lista_cedulas.push( $(this).html() );
            });

            /*busco el curso actual*/
            curso_actual = eliminarCaracteres($("#curso_actual").text());


            /*busco el ano*/
            if ($('#4to').hasClass('active')) ano = 4;
            else if ($('#5to').hasClass('active')) ano = 5;
            else ano = 6;



            /*Se elimina la seccion de la BD*/
            $.ajax
            ({
                type:"DELETE" ,
                url: '/eliminarSeccion?curso='+curso_actual+'&ano='+ano+'&cedulas='+lista_cedulas,
                dataType: "text",
                error: function (xhr, ajaxOptions, thrownError){
                        console.log(xhr.status);
                        console.log(thrownError);
                        console.log(ajaxOptions);
                        alert('Error: No se pudo realizar esta operación.');
                },
                success: function()
                {    
                    var N, list, childList, i, a, span;
                    
                    /*borro todos los estudiantes de la seccion a borrar en el front*/
                    idBody.empty();

                    /*se esconde el modal*/
                    $('#modal_seccion').modal('toggle');

                    /*se busca la lista de secciones (Seccion A, Seccion B,..., Seccion N)*/
                    list = document.getElementById("internas");
                    childList = list.children;
                    N = childList.length;

                    /*Se busca la seccion que este mas a la izquierda para posicionarse en ella*/
                    for (i = 0; i < N; i++) 
                    {
                        if (childList[i].style.display != 'none')
                        {
                            var li = document.getElementById(childList[i].firstChild.id);
                            li.click();
                            break;
                        }
                    }

                    /*Se busca la ultima seccion para agregarle el span de eliminar*/
                    for (i = N - 1; i >= 0; i--)
                    {
                        if (childList[i].style.display != 'none')
                        {
                            a = document.getElementById(childList[i].firstChild.id);
                            span = document.createElement('span');
                            span.setAttribute('class', 'glyphicon glyphicon-trash delete_sec');
                            a.appendChild(span);
                            break;
                        }
                    }
                }
            });   





        });


        //Confirmacion de entrada del modal estudiantes
        $("#confirmacion_real_est").on('input', function()
        {
            confirmacion_real = $("#confirmacion_real_est").val();
            if(confirmacion_real == "Deseo eliminar este estudiante") $("#realSumbitEst").removeAttr('disabled');
            else $("#realSumbitEst").attr("disabled", "disabled");
        });

         //Cuando presiono el modal de borrar estudiante
        $("#realSumbitEst").on('click', function()
        {
            eliminarEstudiante($("#texto_est").text());
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


        //se colocan las secciones adecuadas al curso y año actual
        setCantidadSecciones($('#ano').val()[0], $('#curso').val());


        $( "#curso" ).change(function() {
            setCantidadSecciones($('#ano').val()[0], $('#curso').val());
        });


        
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

    function setCantidadSecciones(ano, curso) {
        $.ajax
            ({
                type:"GET" ,
                url: '/cant_secciones?ano='+ano+'&curso='+curso,
                dataType: "text",
                error: function (xhr, ajaxOptions, thrownError)
                {
                        console.log(xhr.status);
                        console.log(thrownError);
                        console.log(ajaxOptions);
                       
                },
                success: function(cant_secciones)
                {    
                    cant_secciones = parseInt(cant_secciones);
                    $('#seccion').find('option').remove().end();

                    for (var i=65; i<65+cant_secciones; i++) {
                        $('#seccion').append($('<option>', {
                            value: String.fromCharCode(i),
                            text: String.fromCharCode(i)
                        }));

                    }
                }
            });
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

    /*Esta funcion es cuando se selecciona otro curso*/
    function cambiarValor(valor, id) 
    {
        var curso_actual, clase;
        
        curso_actual = $("#curso_actual").text();
    
        if(curso_actual != valor)
        {
            $('#'+ id).text(curso_actual);
            $("#curso_actual").html(valor);

            valor = eliminarCaracteres(valor);

            if ($('#4to').hasClass('active')) clase = '4to';
            else if ($('#5to').hasClass('active')) clase = '5to';
            else clase = '6to';
            
            $.ajax
            ({
                type:"GET" ,
                url: '/estudiantes_escoger_ano?ano='+clase+'&curso='+valor,
                dataType: "text",
                error: function (xhr, ajaxOptions, thrownError)
                {
                        console.log(xhr.status);
                        console.log(thrownError);
                        console.log(ajaxOptions);
                       
                },
                success: function(str_secciones)
                {    
                    mostrarListaEstudiantes(str_secciones); 
                }
            });
        }
    }

    /*Esta funcion es cuando se selecciona otro año*/
    function cambioAnio(clase)
    {
        var curso_actual;

        $('#4to').removeClass('active');
        $('#5to').removeClass('active');
        $('#6to').removeClass('active');
        $('#'+clase).addClass('active');

        curso_actual = $("#curso_actual").text();
        curso_actual = eliminarCaracteres(curso_actual);

        $.ajax
        ({
            type:"GET" ,
            url: '/estudiantes_escoger_ano?ano='+clase+'&curso='+curso_actual,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError)
            {
                    console.log(xhr.status);
                    console.log(thrownError);
                    console.log(ajaxOptions);
                   
            },
            success: function(str_secciones)
            {    
                mostrarListaEstudiantes(str_secciones);    
            }
        });
    }

    /*Se agrega en pantalla la lista de estudiantes corrrespondiente al año-curso*/
    function mostrarListaEstudiantes(str_secciones) 
    {
        var list, childList, cant_secciones, new_estudiantes, i, N, idBody, array, fc, tag, li, cant_estudiantes, boton, span, a;

        li = document.getElementById('liA');
        li.click();

        list = document.getElementById("internas");
        childList = list.children;
        cant_secciones = parseInt(str_secciones[0]);
        new_estudiantes = jQuery.parseJSON(str_secciones.substring(2));
        array = ['A','B','C', 'D', 'E', 'F'];
        N = childList.length;

        for (i = 0; i < N; i++) 
        {
            idBody = $('#body_select' + array[i]);
            idBody.empty();

            cant_estudiantes = new_estudiantes.length;

            if(i < cant_secciones) childList[i].style.display = 'block';
            else childList[i].style.display = 'none';


            for (j = 0; j < cant_estudiantes; j++) 
            {
                if (str_secciones.substring(2).length > 2 && array[i] == new_estudiantes[j][9]) 
                {   
                    tag = document.createElement('tr');
                    tag.setAttribute('id', (String(new_estudiantes[j][3])));
                    tag.setAttribute('class', ("active"));
                    
                    element = document.createElement('td');
                    element.setAttribute('class', 'cedulaEstudiante editarEstudiante');
                    element.setAttribute('onclick',"mostrarDetalleEstudiante("+new_estudiantes[j][3]+")");
                    element.innerHTML = new_estudiantes[j][3];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    element.setAttribute('class', 'editarEstudiante');
                    element.setAttribute('onclick',"mostrarDetalleEstudiante("+new_estudiantes[j][3]+")");
                    element.innerHTML = new_estudiantes[j][1];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    element.setAttribute('class', 'editarEstudiante');
                    element.setAttribute('onclick',"mostrarDetalleEstudiante("+new_estudiantes[j][3]+")");
                    element.innerHTML = new_estudiantes[j][2];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    element.setAttribute('class', 'editarEstudiante');
                    element.setAttribute('onclick',"mostrarDetalleEstudiante("+new_estudiantes[j][3]+")");
                    element.innerHTML = new_estudiantes[j][6];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    element.setAttribute('id', 'inasistencia'+ new_estudiantes[j][3]);
                    element.innerHTML = new_estudiantes[j][11];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    boton = document.createElement('button');
                    boton.setAttribute('class', 'btn btn-warning');
                    boton.setAttribute('id','add'+ new_estudiantes[j][3]);
                    boton.setAttribute('onclick',"agregarInasistencia(this.id)");
                    boton.innerHTML = 'Agregar inasistencia';
                    element.appendChild(boton);
                    tag.appendChild(element);

                    element = document.createElement('td');
                    boton = document.createElement('button');
                    boton.setAttribute('class', 'btn btn-danger botonDltEst');
                    boton.setAttribute('id','del'+new_estudiantes[j][3]);
                    boton.setAttribute('onclick',"mostrarModalEliminarEstudiante(this.id)");
                    
                    span = document.createElement('span');
                    span.setAttribute('class', 'glyphicon glyphicon-trash');
                    boton.appendChild(span);

                    element.appendChild(boton);
                    tag.appendChild(element);
                    idBody.append(tag);
                }
            }  
        }

        /*Elimino el icono de la papelera de todas las secciones*/
        for (i = N-1 ; i >=0 ; i--) $('#'+childList[i].firstChild.id).find('span').remove();

        /*Se busca la ultima seccion para agregarle el span de eliminar*/
        for (i = N-1 ; i >=0 ; i--) 
        {
            if (childList[i].style.display != 'none')
            {
                a = document.getElementById(childList[i].firstChild.id);
        
                span = document.createElement('span');
                span.setAttribute('class', 'glyphicon glyphicon-trash delete_sec');
                span.setAttribute('onmouseover', 'mouseOverTrash(this)');
                span.setAttribute('onmouseout', 'mouseOutTrash(this)');
                span.setAttribute('onclick', 'mostrarBorrarSeccion(this)');
                a.appendChild(span);
                break;
            }
        }
    }

    function validateForm() 
    {
        var inicio = document.getElementById("inicial").value;
        var final = document.getElementById("final").value;
        if ((inicio[0] == '2') && (inicio[1] == '0') && (final[0] == '2') && (final[1] == '0') && (final.length == 4) && (inicio.length == 4) && (final > inicio))
            return true;
        return false;
    }

    /*Funcion para sumar 1 en la inasistencia de un estudiante*/
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
            url: '/agregarInasistencia?resultado='+res,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError)
            {
                    console.log(xhr.status);
                    console.log(thrownError);
                    console.log(ajaxOptions);
                   
            },
            success: function()
            {    
            }
       }); 
    }

    /*Funciones para borrar estudiante*/
    function mostrarModalEliminarEstudiante(id) 
    {
        $("#modal_est").modal('show');
        id = id.substring(3);
        $("#texto_est").text(id);
    }

    /*Funcion para eliminar a un estudiante de la lista*/
    function eliminarEstudiante(id) 
    {
        $('#'+id).remove();

        $.ajax
        ({
            type:"DELETE" ,
            url: '/eliminarEstudiante?id='+id,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError)
            {
                    console.log(xhr.status);
                    console.log(thrownError);
                    console.log(ajaxOptions);
                   
            },
            success: function()
            {    
                $('#modal_est').modal('toggle');
            }
       }); 
    }


    function mouseOverTrash(x) 
    {
        x.style.color =  '#FF2D27' ;
    }

    function mouseOutTrash(x) 
    {
        x.style.color =  '#000' ;
    }


    function mostrarBorrarSeccion(x) 
    {
        seccion_borrar = x.closest('li').firstChild.id;
        $("#modal_seccion").modal('show');
    }

    function mostrarDetalleEstudiante(cedula) {

        $.ajax
            ({
                type:"GET" ,
                url: '/estudiante?cedula='+cedula,
                dataType: "text",
                error: function (xhr, ajaxOptions, thrownError)
                {
                        console.log(xhr.status);
                        console.log(thrownError);
                        console.log(ajaxOptions);
                       
                },
                success: function(estudiante)
                {    
                    var array = estudiante.split(",");
                    var nombre = array[1].replace(/'/g,"").replace(" ",'');
                    var apellido = array[2].replace(/'/g,"").replace(" ",'');
                    var cedula = array[3].replace(" ",'');
                    var telefono = array[4].replace(/'/g,"").replace(/ /g,'');
                    var direccion = array[6].replace(/'/g,"").replace(/ /,'');
                    var email = array[5].replace(/'/g,"").replace(/ /g,'');
                    var curso = array[11].replace(/'/g,"").replace(/ /,'').replace("]","");
                    var seccion = array[8].replace(/'/g,"").replace(/ /g,'');
                    // var periodo_lectivo = array[9].replace(/'/g,"").replace(/ /g,'');
                    var ano = array[7].replace(/ /g,'');

                    $('#apellidos').val(apellido);
                    $('#nombres').val(nombre);
                    $('#cedula').val(cedula);
                    $('#hiddenCedula').val(cedula);

                    $('#curso').val(curso);

                    // $('#periodo_lectivo').val(periodo_lectivo);
                    $('#ano').val(ano);
                    $('#seccion').val(seccion);
                    $('#direccion').val(direccion);
                    $('#correo').val(email);
                    $('#telefono').val(telefono);

                }
            });


        $("#modal_detalle_est").modal('show');
    }