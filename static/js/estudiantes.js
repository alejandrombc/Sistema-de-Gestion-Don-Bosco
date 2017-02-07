 var confirmacion_real = "";
 var seccion_borrar = "";

 $(document).ready(function() {


            $( "#tabs" ).tabs();
            $( ".btn" ).button();
            $("#externas").tabs();
            $("#vertical").tabs().addClass("ui-tabs-vertical");
            $("#vertical > ul > li").removeClass("ui-corner-top").addClass("ui-corner-left");
            $("#internasA").tabs();
            $("#internasB").tabs();
            $("#internasC").tabs();



            $("body").on('click', function(){
                if (($("#tocheck").hasClass("open"))) {
                    $("#SUPERparche").css({ display: "none" });
                }
            });



            $("#parchesito").on('click', function(){
                if (($("#tocheck").hasClass("open"))) {
                    $("#SUPERparche").css({ display: "none" });
                }
                else $("#SUPERparche").css({ display: "block" });
            });



            $("#ocultar").on('click', function(){
                if (($("#tocheck").hasClass("open"))) {
                    $("#SUPERparche").css({ display: "none" });
                }
                else $("#SUPERparche").css({ display: "block" });
            });



            $('#4toA-table, #4toB-table, #4toC-table, #5toA-table, #5toB-table, #5toC-table, #6toA-table, #6toB-table, #6toC-table').DataTable({
                "searching": true,
                "bPaginate": false,
                "bLengthChange": false,
                "bFilter": false,
                "bInfo": false,
                "language": {
                    "sProcessing":     "Procesando...",
                    "sZeroRecords":    "No se encontraron resultados.",
                    "sEmptyTable":     "Ningún dato disponible en esta tabla.",
                    "sLoadingRecords": "Cargando...",
                    "search": "_INPUT_",
                    "searchPlaceholder": "Buscar en esta sección."
                }
            });



            //Basuras de las secciones (para borrarlas)
            $(".delete_sec").mouseenter(function() {
                if($(this).closest('li').hasClass('ui-state-active')) $(this).css("color", "#FF2D27"); 
                
            }).mouseleave(function() {
                if($(this).closest('li').hasClass('ui-state-active')) $(this).css("color", "#000");
            });



            //====Cuando hago click en una de las basuras de seccion abro el modal
             $(".delete_sec").on('click', function(){
                if($(this).closest('li').hasClass('ui-state-active')){
                    $("#modal_seccion").modal('show');
                    seccion_borrar = $(this).parent().attr('id');
                }
             });



             //Confirmacion de entrada del modal de seccion
             $("#confirmacion_real").on('input', function(){
                confirmacion_real = $("#confirmacion_real").val();
                if(confirmacion_real == "Deseo eliminar esta seccion"){
                    $("#realSumbit").removeAttr('disabled');
                }else{
                    $("#realSumbit").attr("disabled", "disabled");
                }
             });



             //Cuando presiono el boton de borrar seccion dentro del modal====\\
            $("#realSumbit").on('click', function(){

                /*Se borra la lista de estudiantes*/
                $('#'+seccion_borrar).parent().css('display','none');
                var seccion = seccion_borrar.substring(seccion_borrar.length-1);
                var idBody = $('#body_select'+seccion);


                /*Tomo las cedulas de todos los estudiantes de la seccion a borrar y los agrego a una lista*/
                var lista_cedulas = [];
                $( '#body_select'+seccion +' td.cedulaEstudiante').each(function() { 
                    // alert($(this).html()); 
                    lista_cedulas.push( $(this).html() );
                });
                console.log('lista_cedulas = '+lista_cedulas);

                /*busco el curso actual*/
                var curso_actual = $("#curso_actual").text();

                /*Esto podria ser una funcion ya q se usa varias veces*/
                curso_actual = curso_actual.replace(/á/gi,"a");
                curso_actual = curso_actual.replace(/é/gi,"e");
                curso_actual = curso_actual.replace(/í/gi,"i");
                curso_actual = curso_actual.replace(/ó/gi,"o");
                curso_actual = curso_actual.replace(/ /g,'');
                console.log('curso_actual = ' + curso_actual);


                /*busco el ano*/
                var ano;
                if ( $('#4to').hasClass('active') ) {
                    ano = 'cuarto';
                } else if ( $('#5to').hasClass('active') ) {
                    ano = 'quinto';
                } else {
                    ano = 'sexto';
                }
                console.log('anio = ' + ano);



                //En el success es que hago todo lo que esta aqui abajo

                


                var lista = ['hola', 'adios'];
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
                        
                        /*borro todos los estudiantes de la seccion a borrar en el front*/
                        idBody.empty();

                        /*se esconde el modal*/
                        $('#modal_seccion').modal('toggle');

                        /*se busca la lista de secciones (Seccion A, Seccion B,..., Seccion N)*/
                        list = document.getElementById("internas");
                        childList = list.children;
                        var N = childList.length;

                        /*Se busca la seccion que este mas a la izquierda para posicionarse en ella*/
                        for (var i = 0 ; i < N ; i++) 
                        {
                            if (childList[i].style.display != 'none'){
                                var li = document.getElementById(childList[i].firstChild.id);
                                li.click();
                                break;
                            }
                        }

                    }
               }); 

                /*Se busca la ultima seccion para agregarle el span de eliminar*/
                /*for (var i = N-1 ; i >=0 ; i--) {
                    if (childList[i].style.display != 'none'){
                        var a = document.getElementById(childList[i].firstChild.id);
                        console.log(a);



                        var span = document.createElement('span');
                        span.setAttribute('class', 'glyphicon glyphicon-trash delete_sec');
                        a.appendChild(span);

                        break;
                    }
                }*/

            });



            //Confirmacion de entrada del modal estudiantes
            $("#confirmacion_real_est").on('input', function(){
                confirmacion_real = $("#confirmacion_real_est").val();
                if(confirmacion_real == "Deseo eliminar este estudiante"){
                    $("#realSumbitEst").removeAttr('disabled');
                }else{
                    $("#realSumbitEst").attr("disabled", "disabled");
                }
            });



             //Cuando presiono el modal de borrar estudiante
            $("#realSumbitEst").on('click', function(){
                eliminarEstudiante( $("#texto_est").text() );
            });



            //Cuando un modal se esconde, elimino el texto que hay en el input
            $('#modal_seccion').on('hidden.bs.modal', function() {
                $('#confirmacion_real').val('');
            })
            $('#modal_est').on('hidden.bs.modal', function() {
                $('#confirmacion_real_est').val('');
            })

            

            

});

    /*Esta funcion es cuando se selecciona otro curso*/
    function cambiarValor(valor, id) 
    {
        var curso_actual = $("#curso_actual").text();
        var clase;
        if(curso_actual != valor){
            $('#'+id).text(curso_actual);
            $("#curso_actual").html(valor);

            valor = valor.replace(/á/gi,"a");
            valor = valor.replace(/é/gi,"e");
            valor = valor.replace(/í/gi,"i");
            valor = valor.replace(/ó/gi,"o");
            valor = valor.replace(/ /g,'');


            if ( $('#4to').hasClass('active') ) {
                clase = '4to';
            } else if ( $('#5to').hasClass('active') ) {
                clase = '5to';
            } else {
                clase = '6to';
            }
            
            $.ajax
            ({
                type:"GET" ,
                url: '/estudiantes_escoger_ano?ano='+clase+'&curso='+valor,
                dataType: "text",
                error: function (xhr, ajaxOptions, thrownError)
                {
                        alert(xhr.status);
                        alert(thrownError);
                        alert(ajaxOptions);
                       
                },
                success: function(str_secciones)
                {    
                    var li = document.getElementById('liA');
                    li.click();

                    var list, childList, cant_secciones, new_estudiantes, i, idBody, array, fc, tag;

                    list = document.getElementById("internas");
                    childList = list.children;
                    cant_secciones = parseInt(str_secciones[0]);
                    new_estudiantes = jQuery.parseJSON(str_secciones.substring(2));
                    array = ['A','B','C', 'D', 'E', 'F'];
                    var N = childList.length;
                    var cant_estudiantes;
                    for (i = 0; i < N; i++) 
                {
                    idBody = $('#body_select' + array[i]);
                    idBody.empty();

                    cant_estudiantes = new_estudiantes.length;

                    if(i < cant_secciones) 
                        childList[i].style.display = 'block';
                    else
                        childList[i].style.display = 'none';


                    for (j = 0; j < cant_estudiantes; j++) {
                            
                            if (str_secciones.substring(2).length > 2 && array[i] == new_estudiantes[j][7]) 
                            {
                                tag = document.createElement('tr');
                                tag.setAttribute('id', (String(new_estudiantes[j][2])));
                                tag.setAttribute('class', ("active"));
                                
                                element = document.createElement('td');
                                element.setAttribute('class', 'cedulaEstudiante');
                                element.innerHTML = new_estudiantes[j][2];
                                tag.appendChild(element);

                                element = document.createElement('td');
                                element.innerHTML = new_estudiantes[j][1];
                                tag.appendChild(element);

                                element = document.createElement('td');
                                element.innerHTML = new_estudiantes[j][4];
                                tag.appendChild(element);

                                element = document.createElement('td');
                                element.setAttribute('id', 'inasistencia'+new_estudiantes[j][2]);
                                element.innerHTML = new_estudiantes[j][9];
                                tag.appendChild(element);

                                element = document.createElement('td');
                                var boton = document.createElement('button');
                                boton.setAttribute('class', 'btn btn-warning');
                                boton.setAttribute('id','add'+new_estudiantes[j][2]);
                                boton.setAttribute('onclick',"agregarInasistencia(this.id)");
                                boton.innerHTML = 'Agregar inasistencia';
                                element.appendChild(boton);
                                tag.appendChild(element);

                                element = document.createElement('td');
                                var boton = document.createElement('button');
                                boton.setAttribute('class', 'btn btn-danger botonDltEst');
                                boton.setAttribute('id','del'+new_estudiantes[j][2]);
                                boton.setAttribute('onclick',"mostrarModalEliminarEstudiante(this.id)");
                                

                                var span = document.createElement('span');
                                span.setAttribute('class', 'glyphicon glyphicon-trash');
                                boton.appendChild(span);

                                element.appendChild(boton);
                                tag.appendChild(element);
                                
                                idBody.append(tag);
                            }; 
                        
                        
                    }
                    
                }



                }
            });
        }
    }

    /*Esta funcion es cuando se selecciona otro año*/
    function cambioAnio(clase)
    {
        var curso_actual = $("#curso_actual").text();
        $('#4to').removeClass('active');
        $('#5to').removeClass('active');
        $('#6to').removeClass('active');
        $('#'+clase).addClass('active');

        curso_actual = curso_actual.replace(/á/gi,"a");
        curso_actual = curso_actual.replace(/é/gi,"e");
        curso_actual = curso_actual.replace(/í/gi,"i");
        curso_actual = curso_actual.replace(/ó/gi,"o");
        curso_actual = curso_actual.replace(/ /g,'');

        $.ajax
        ({
            type:"GET" ,
            url: '/estudiantes_escoger_ano?ano='+clase+'&curso='+curso_actual,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError)
            {
                    alert(xhr.status);
                    alert(thrownError);
                    alert(ajaxOptions);
                   
            },
            success: function(str_secciones)
            {    

                var li = document.getElementById('liA');
                li.click();

                var list, childList, cant_secciones, new_estudiantes, i, idBody, array, fc, tag;

                list = document.getElementById("internas");
                childList = list.children;
                cant_secciones = parseInt(str_secciones[0]);
                new_estudiantes = jQuery.parseJSON(str_secciones.substring(2));
                array = ['A','B','C', 'D', 'E', 'F'];



                var N = childList.length;
                var cant_estudiantes;



                for (i = 0; i < N; i++) 
                {
                    idBody = $('#body_select' + array[i]);
                    idBody.empty();

                    cant_estudiantes = new_estudiantes.length;

                    if(i < cant_secciones) 
                        childList[i].style.display = 'block';
                    else
                        childList[i].style.display = 'none';


                    for (j = 0; j < cant_estudiantes; j++) {
                            
                            if (str_secciones.substring(2).length > 2 && array[i] == new_estudiantes[j][7]) 
                            {
                                tag = document.createElement('tr');
                                tag.setAttribute('id', (String(new_estudiantes[j][2])));
                                tag.setAttribute('class', ("active"));
                                
                                element = document.createElement('td');
                                element.setAttribute('class', 'cedulaEstudiante');
                                element.innerHTML = new_estudiantes[j][2];
                                tag.appendChild(element);

                                element = document.createElement('td');
                                element.innerHTML = new_estudiantes[j][1];
                                tag.appendChild(element);

                                element = document.createElement('td');
                                element.innerHTML = new_estudiantes[j][4];
                                tag.appendChild(element);

                                element = document.createElement('td');
                                element.setAttribute('id', 'inasistencia'+new_estudiantes[j][2]);
                                element.innerHTML = new_estudiantes[j][9];
                                tag.appendChild(element);

                                element = document.createElement('td');
                                var boton = document.createElement('button');
                                boton.setAttribute('class', 'btn btn-warning');
                                boton.setAttribute('id','add'+new_estudiantes[j][2]);
                                boton.setAttribute('onclick',"agregarInasistencia(this.id)");
                                boton.innerHTML = 'Agregar inasistencia';
                                element.appendChild(boton);
                                tag.appendChild(element);

                                element = document.createElement('td');
                                var boton = document.createElement('button');
                                boton.setAttribute('class', 'btn btn-danger botonDltEst');
                                boton.setAttribute('id','del'+new_estudiantes[j][2]);
                                boton.setAttribute('onclick',"mostrarModalEliminarEstudiante(this.id)");
                                

                                var span = document.createElement('span');
                                span.setAttribute('class', 'glyphicon glyphicon-trash');
                                boton.appendChild(span);

                                element.appendChild(boton);
                                tag.appendChild(element);
                                
                                idBody.append(tag);
                            }; 
                        
                        
                    }
                    
                }



            }
        });

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
    function agregarInasistencia(id) {

        id = id.substring(3);
        var inasistencia = $('#inasistencia'+id).text();
        inasistencia = inasistencia.replace(/ /g,'');
        inasistencia = parseInt(inasistencia);
        inasistencia += 1;
        $('#inasistencia'+id).text(inasistencia);

        var res = id+'-'+inasistencia;

        $.ajax
        ({
            type:"PUT" ,
            url: '/agregarInasistencia?resultado='+res,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError)
            {
                    alert(xhr.status);
                    alert(thrownError);
                    alert(ajaxOptions);
                   
            },
            success: function()
            {    
            }
       }); 
    }

    /*Funciones para borrar estudiante*/
    function mostrarModalEliminarEstudiante(id) {
        $("#modal_est").modal('show');
        id = id.substring(3);
        $("#texto_est").text(id);
    }

    /*Funcion para eliminar a un estudiante de la lista*/
    function eliminarEstudiante(id) {
        $('#'+id).remove();

        $.ajax
        ({
            type:"DELETE" ,
            url: '/eliminarEstudiante?id='+id,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError)
            {
                    alert(xhr.status);
                    alert(thrownError);
                    alert(ajaxOptions);
                   
            },
            success: function()
            {    
                $('#modal_est').modal('toggle');
            }
       }); 

    }