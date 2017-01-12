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

            var table = $('#example').DataTable({
                "searching": true,
                "bPaginate": false,
                "bLengthChange": false,
                "bFilter": false,
                "bInfo": false,
                "language": {
                    "sProcessing":     "Procesando...",
                    "sZeroRecords":    "No se encontraron resultados.",
                    "sEmptyTable":     "Ningún dato disponible en esta tabla.",
                    "sLoadingRecords": "Cargando..."
                }
            });

            $('#searchBox').keyup(function(){
                table.search($(this).val()).draw() ;
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