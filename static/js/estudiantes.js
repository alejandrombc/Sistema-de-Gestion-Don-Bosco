 var confirmacion_real = "";
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
                    $("#myModal").modal('show');
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

            //Confirmacion de entrada del modal estudiantes
            $("#confirmacion_real_est").on('input', function(){
                confirmacion_real = $("#confirmacion_real_est").val();
                if(confirmacion_real == "Deseo eliminar este estudiante"){
                    $("#realSumbitEst").removeAttr('disabled');
                }else{
                    $("#realSumbitEst").attr("disabled", "disabled");
                }
            });

            //Cuando presiono la papelere asociada al estudiante
             $(".botonDltEst").on('click', function(){
                 $("#modal_est").modal('show');
                 var estudiante = $(this).closest('tr').attr('id');
                 $("#texto_est").text(estudiante);
                //alert("EL ID: "+$(this).closest('tr').attr('id'));
             });

             //Cuando presiono el modal de borrar estudiante
            $("#realSumbitEst").on('click', function(){
                $('#cedula_a_eliminar').val($("#texto_est").text());
                $("#estudiantes_modal").submit();
            });

            //Cuando presiono el modal de borrar seccion
            $("#realSumbit").on('click', function(){
                //Submit
            });

        });

        function validateForm() {

            var inicio = document.getElementById("inicial").value;
            var final = document.getElementById("final").value;
            if ((inicio[0] == '2') && (inicio[1] == '0') && (final[0] == '2') && (final[1] == '0') && (final.length == 4) && (inicio.length == 4) && (final > inicio))
                return true;
            return false;

        }

        function cambiarValor(valor, id) {
            var text = $("#curso_actual").text()
            if(text != valor){
                $('#'+id).text(text);
                $("#curso_actual").html(valor);
                // AQUI HAY QUE CAMBIAR VALORES PORQUE CAMBIO EL TEXTO
            }

        }

        function openModalDesc(){
            alert("FINO");
        }

        function newActive(clase) {
            var curso_actual = $("#curso_actual").text();
            $('#4to').removeClass('active');
            $('#5to').removeClass('active');
            $('#6to').removeClass('active');
            $('#'+clase).addClass('active');

            curso_actual = curso_actual.replace(/á/gi,"a");
            curso_actual = curso_actual.replace(/é/gi,"e");
            curso_actual = curso_actual.replace(/í/gi,"i");
            curso_actual = curso_actual.replace(/ó/gi,"o");
            curso_actual = curso_actual.replace(/ /g,'')

            $.ajax({
            type:"GET" ,
            url: '/estudiantes_escoger_ano?ano='+clase+'&curso='+curso_actual,
            dataType: "text",
            error: function (xhr, ajaxOptions, thrownError) {
                    alert(xhr.status);
                    alert(thrownError);
                    alert(ajaxOptions);
                   
                  },
            success: function(str_secciones){
              
                console.log('fue exitoso, el numero de secciones es ' + str_secciones);
                
                var cant_secciones = parseInt(str_secciones);
              

            }

            });


            // AQUI HAY QUE ACTUAlIZAR VALORES PORQUE CAMBIO EL ANO ESCOLAR
        }