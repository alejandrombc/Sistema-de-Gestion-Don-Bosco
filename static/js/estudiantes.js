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
            console.log('klk');
            alert('hola');
            $('#4to').removeClass('active');
            $('#5to').removeClass('active');
            $('#6to').removeClass('active');
            $('#'+clase).addClass('active');

            // $.ajax({
            // type:"GET" ,
            // url: '/estudiantes_escoger_ano?ano='+clase,
            // dataType: "text",
            // error: function (xhr, ajaxOptions, thrownError) {
            //         alert(xhr.status);
            //         alert(thrownError);
            //         alert(ajaxOptions);
                   
            //       },
            // success: function(msg){
            //   no_mas_reciente = msg[1]
            //   var index = 1;
            //   var playlist = ""
            //   for (var i = 0; i < msg[0].length; i++) {
            //     if (index == 1) {
            //       playlist = playlist + "<div class='container-fluid text-center'><br><div style='word-wrap: break-word;'class='row'><div class='col-sm-4 col-sm-offset-1 wrapper'><div class='ribbon-wrapper-green'><div class='ribbon-heart'><i style='color:#DC2424;'class='fa fa-heart fa-lg'></i></div></div><h3>"+msg[0][i].nombre+"</h3><p class='publicado'>Publicado:"+msg[0][i].fecha+" por <strong>"+msg[0][i].user[1]+"</strong></p><div class='row'><div class='col-sm-7'><div class='imageWrapper2'><img src='static/imagenes/"+msg[0][i].user[0]+"/info_playlists/"+msg[0][i].foto+"') class='img-responsive imagen_playlist' title='Portada1'/><a href='/reproducir?id="+msg[0][i]._id+"' class='cornerLinkCover'><i id='playbtn' class='fa fa-play-circle fa-5x'></i></a></div></div><div class='col-sm-5 text-left'><div class='row'><span class='glyphicon glyphicon-heart'> "+msg[0][i].fav+" </span><span class='glyphicon glyphicon-thumbs-up'> "+msg[0][i].likes+"</span><p>Categorias:</p>"
            //       for (var j =0; j<(msg[0][i].categorias).length ; j++) {
            //         playlist = playlist + "<span class='tag categoria'>#"+msg[0][i].categorias[j]+"</span>"
            //       };
            //         playlist = playlist + "</div><br></div></div></div>"
            //       index = 2;
            //     }else{
            //       playlist = playlist +"<div class='col-sm-4 col-sm-offset-2 wrapper'><div class='ribbon-wrapper-green'><div class='ribbon-heart'><i style='color:#DC2424;'class='fa fa-heart fa-lg'></i></div></div><h3>"+msg[0][i].nombre+"</h3><p class='publicado'>Publicado:"+msg[0][i].fecha+" por <strong>"+msg[0][i].user[1]+"</strong></p><div class='row'><div class='col-sm-7'><div class='imageWrapper2'><img src='static/imagenes/"+msg[0][i].user[0]+"/info_playlists/"+msg[0][i].foto+"') class='img-responsive imagen_playlist' title='Portada1'/><a href='/reproducir?id="+msg[0][i]._id+"' class='cornerLinkCover'><i id='playbtn' class='fa fa-play-circle fa-5x'></i></a></div></div><div class='col-sm-5 text-left'><div class='row'><span class='glyphicon glyphicon-heart'> "+msg[0][i].fav+" </span><span class='glyphicon glyphicon-thumbs-up'> "+msg[0][i].likes+"</span><p>Categorias:</p>"
            //       for (var j =0; j<(msg[0][i].categorias).length ; j++) {
            //         playlist = playlist + "<span class='tag categoria'>#"+msg[0][i].categorias[j]+"</span>"
            //       };
            //       playlist = playlist + "</div></div></div></div></div></div><br>"
            //       index = 1;
            //     }
            //   };
            //     if(msg[2] % 2 == 1){
            //       playlist = playlist + "</div></div><br>"
            //     }
            //     $("#pelotas1").remove();
            //     playlist = playlist + "<center id='pelotas1'><div class='spinner'><div class='bounce1'></div><div class='bounce2'></div><div class='bounce3'></div></div></center>"
            //     $("#home").append(playlist);
            //     playlist = "";
              
              
            // }

            // });


            // AQUI HAY QUE ACTUAlIZAR VALORES PORQUE CAMBIO EL ANO ESCOLAR
        }