 var confirmacion_real = "";
 $(document).ready(function() {

            $("#abrirModal").on('click', function() {

                if($("#inicial").val() != "" && $("#final").val() != "")

                if (validateForm()) $("#myModal").modal('show');
                $("#confir").text("¿Está seguro de agregar el año escolar "+ $("#inicial").val() + " - " + $("#final").val() + "?");

                $("#realSumbit").on('click', function(){
                  $("#contact").submit();
                });

            });

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

            $(".delete_sec").mouseenter(function() {
                if($(this).closest('li').hasClass('ui-state-active')) $(this).css("color", "#FF2D27"); 
                
            }).mouseleave(function() {
                if($(this).closest('li').hasClass('ui-state-active')) $(this).css("color", "#000");
            });

             $(".delete_sec").on('click', function(){
                if($(this).closest('li').hasClass('ui-state-active')){
                    $("#myModal").modal('show');
                    $("#confir").text("¿Está seguro de recuperar el año escolar "+ inicial + " - " + final + "?");
                }
             });

             $("#confirmacion_real").on('input', function(){
                confirmacion_real = $("#confirmacion_real").val();
                if(confirmacion_real == "Deseo eliminar esta seccion"){
                    $("#realSumbit").removeAttr('disabled');
                }else{
                    $("#realSumbit").attr("disabled", "disabled");
                }
             });

        });

        function validateForm() {

            var inicio = document.getElementById("inicial").value;
            var final = document.getElementById("final").value;
            if ((inicio[0] == '2') && (inicio[1] == '0') && (final[0] == '2') && (final[1] == '0') && (final.length == 4) && (inicio.length == 4) && (final > inicio))
                return true;
            return false;

        }

        function cambiarValor(valor) {
            var text = $("#curso_actual").text()
            if(text != valor){
                $("#curso_actual").html(valor);
                // AQUI HAY QUE CAMBIAR VALORES PORQUE CAMBIO EL TEXTO
            }

        }

        function newActive(clase) {
            $('#4to').removeClass('active')
            $('#5to').removeClass('active')
            $('#6to').removeClass('active')
            $('#'+clase).addClass('active')

            // AQUI HAY QUE ACTUAlIZAR VALORES PORQUE CAMBIO EL ANO ESCOLAR
        }