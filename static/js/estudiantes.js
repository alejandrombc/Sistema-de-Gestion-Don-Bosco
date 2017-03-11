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


        //Para el responsive en la busqueda (falta editar)
        // $('#ano_selectA-table').DataTable({
        //         "searching": true,
        //         "bPaginate": false,
        //         "bLengthChange": false,
        //         "bFilter": false,
        //         responsive: true,
        //         "bInfo": false,
        //         "language": {
        //             "sProcessing":     "Procesando...",
        //             "sZeroRecords":    "No se encontraron resultados.",
        //             "sEmptyTable":     "Ningún dato disponible en esta tabla.",
        //             "sLoadingRecords": "Cargando...",
        //             "search": "_INPUT_",
        //             "searchPlaceholder": "Buscar en esta sección."
        //         }
        // });

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
            if ($('#4to').hasClass('active')) ano = "4to";
            else if ($('#5to').hasClass('active')) ano = "5to";
            else ano = "6to";

            var id_carrera = createID_carrera(ano, curso_actual);

            /*Se elimina la seccion de la BD*/
            $.ajax
            ({
                type:"DELETE" ,
                url: '/eliminarSeccion?id_carrera='+id_carrera+'&cedulas='+lista_cedulas,
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

        $( "#ano" ).change(function() {
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

    function changeYearVal(ano){
        if(ano == 4) ano = "4to";
        else if (ano == 5) ano = "5to";
        else if(ano == 6) ano = "6to";
        return ano;
    }

    function setCantidadSecciones(ano, curso, seccion) {
        ano = changeYearVal(ano);
        curso = eliminarCaracteres(curso).replace("_","");
        var id_carrera = createID_carrera(ano, curso);
        $.ajax
            ({
                type:"GET" ,
                url: '/cant_secciones?id_carrera='+id_carrera,
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
                    if(seccion != null) $('#seccion').val(seccion);
                    else $('#seccion').val('A');
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

    // Funcion que retorna el ID de la BD de la carrera especificada
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
            
            var id_carrera = createID_carrera(clase,valor);
        
            $.ajax
            ({
                type:"GET" ,
                url: '/estudiantes_escoger_ano?id_carrera='+id_carrera,
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
                    // setCantidadSecciones(clase, valor);
                }
            });
        }

    }


    function updateSubmit(){
        var ano, curso;
        ano = $('#ano').find(":selected").text();
        curso = $('#curso').find(":selected").text();


        ano = changeYearVal(ano);

        curso = eliminarCaracteres(curso);        
        var id_carrera = createID_carrera(ano,curso);

        $("#real_carrera").val(id_carrera);
        $("#modalUpdate").sumbit();
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

        id_carrera = createID_carrera(clase, curso_actual);
        $.ajax
        ({
            type:"GET" ,
            url: '/estudiantes_escoger_ano?id_carrera='+id_carrera,
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
                // setCantidadSecciones(clase, curso_actual);   
            }
        });
    }

    /*Se agrega en pantalla la lista de estudiantes corrrespondiente al año-curso*/
    function mostrarListaEstudiantes(str_secciones) 
    {
        var list, childList, cant_secciones, new_estudiantes, i, N, idBody, array, fc, tag, li, cant_estudiantes, boton, span, a;

        list = document.getElementById("internas");
        cant_secciones = parseInt(str_secciones[0]);
    
        if($('#liA').length) {
            li = document.getElementById('liA');
            li.click();
        }

        childList = list.children;
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
                    tag.setAttribute('id', (String(new_estudiantes[j][0])));
                    tag.setAttribute('class', ("active"));
                    
                    element = document.createElement('td');
                    element.setAttribute('class', 'cedulaEstudiante editarEstudiante');
                    element.setAttribute('onclick',"mostrarDetalleEstudiante("+new_estudiantes[j][0]+")");
                    element.innerHTML = new_estudiantes[j][0];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    element.setAttribute('class', 'editarEstudiante');
                    element.setAttribute('onclick',"mostrarDetalleEstudiante("+new_estudiantes[j][0]+")");
                    element.innerHTML = new_estudiantes[j][1];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    element.setAttribute('class', 'editarEstudiante');
                    element.setAttribute('onclick',"mostrarDetalleEstudiante("+new_estudiantes[j][0]+")");
                    element.innerHTML = new_estudiantes[j][2];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    element.setAttribute('class', 'editarEstudiante');
                    element.setAttribute('onclick',"mostrarDetalleEstudiante("+new_estudiantes[j][0]+")");
                    element.innerHTML = new_estudiantes[j][4];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    element.setAttribute('id', 'inasistencia'+ new_estudiantes[j][0]);
                    element.innerHTML = new_estudiantes[j][7];
                    tag.appendChild(element);

                    element = document.createElement('td');
                    boton = document.createElement('button');
                    boton.setAttribute('class', 'btn btn-warning');
                    boton.setAttribute('id','add'+ new_estudiantes[j][0]);
                    boton.setAttribute('onclick',"agregarInasistencia(this.id)");
                    boton.innerHTML = 'Agregar inasistencia';
                    element.appendChild(boton);
                    tag.appendChild(element);

                    element = document.createElement('td');
                    boton = document.createElement('button');
                    boton.setAttribute('class', 'btn btn-danger botonDltEst');
                    boton.setAttribute('id','del'+new_estudiantes[j][0]);
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
        var seccion = "";
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
                    var array = jQuery.parseJSON(estudiante);
                    //array = array.split(',');
                    var nombre = array[0][1];
                    var apellido = array[0][2];
                    var cedula = array[0][0];
                    var telefono = array[0][5];
                    var direccion = array[0][3];
                    var email = array[0][4];
                    var curso_for_id = array[0][9]; //Para la funcion de set cantidad
                    if(array[0][9] == "Tecnologia_Grafica") var curso = (array[0][9]).replace('_',' ');
                    else var curso = (array[0][9]);
                    var inasistencias = array[0][7];
                    var ano = array[0][10];
                    var ano_for_id = changeYearVal(ano); //Para la funcion de set cantidad
                    seccion = array[0][8];
                    

                    setCantidadSecciones(ano, curso_for_id, seccion);
                
                    $('#apellidos').val(apellido);
                    $('#nombres').val(nombre);
                    $('#cedula').val(cedula);

                    $('#hiddenCedula').val(cedula);

                    

                    $('#curso').val(curso);


                    // $('#periodo_lectivo').val(periodo_lectivo);
                    $('#ano').val(ano);
                    $('#inasistencia').val(inasistencias);
                    $('#direccion').val(direccion);
                    $('#correo').val(email);
                    $('#telefono').val(telefono);
                }
            });

        $("#modal_detalle_est").modal('show');
    }


    function getIDCarrera(){
        ano = $('#ano').find(":selected").text();
        curso = $('#curso').find(":selected").text();
        curso = eliminarCaracteres(curso);

        var id_carrera = createID_carrera(ano, curso);

        $('#id_carrera').val(id_carrera);
        if($('#formulario_sec').valid()){
            $('#formulario_sec').submit();
        }
    }