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

            //Cuando hago click en una de las basuras de seccion abro el modal
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

             //Cuando presiono el modal de borrar seccion
            $("#realSumbit").on('click', function(){
                $('#'+seccion_borrar).parent().css('display','none');


                var idBody = $('#body_select'+seccion_borrar.substring(seccion_borrar.length-1));
                idBody.empty();
                console.log(seccion_borrar.substring(seccion_borrar.length-1));

                $('#modal_seccion').modal('toggle');


                    list = document.getElementById("internas");
                    childList = list.children;

                    console.log(childList);

                    console.log(childList[0].style.display);
                    var N = childList.length;

                for (var i = 0 ; i < N ; i++) {
                    console.log(childList[i].style.display);
                    if (childList[i].style.display != 'none'){
                        console.log('yes');
                        console.log(childList[i].firstChild.id);
                        var li = document.getElementById(childList[i].firstChild.id);
                        li.click();
                        break;
                    }
                }

console.log( $( ".delete_sec" ));

// console.log( $( "#internas" ).eq(1).text() ); 
// console.log( $( "#internas" ).eq(1).eq(0) ); 
// console.log( $( "#internas" ).eq(1).eq(1) ); 
// console.log( $( "#internas" ).eq(1).eq(2) ); 

// console.log( $( "#internas" ).eq(2).text() ); 
// console.log( $( "#internas" ).eq(3).text() ); 
// console.log( $( "#internas" ).eq(4).text() ); 
// console.log( $( "#internas" ).eq(5).text() ); 
// console.log( $( "#internas" ).eq(6).text() ); 
 // $( "#internas" ).first().click();
                

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

            

});

    /*Esta funcion es cuando se selecciona otro curso*/
    function cambiarValor(valor, id) 
    {
        var curso_actual = $("#curso_actual").text()
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
                    // if (idBody.childElementCount > 0) 
                    // {
                    //     fc = idBody.firstChild;
                    //     while(fc) 
                    //     {
                    //         idBody.removeChild(fc);
                    //         fc = idBody.firstChild;
                    //     }
                    // }

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
                    // if (idBody.childElementCount > 0) 
                    // {
                    //     fc = idBody.firstChild;
                    //     while(fc) 
                    //     {
                    //         idBody.removeChild(fc);
                    //         fc = idBody.firstChild;
                    //     }
                    // }

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

        // AQUI HAY QUE ACTUAlIZAR VALORES PORQUE CAMBIO EL ANO ESCOLAR
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