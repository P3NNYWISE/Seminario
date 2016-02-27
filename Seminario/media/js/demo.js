
// Configuraciones Generales
var nombre_tabla = "#tabla_productos"; // id
var nombre_boton_eliminar = ".delete"; // Clase

var nombre_formulario_modal = "#frmEliminar"; //id
var nombre_ventana_modal = "#myModal"; // id
// Fin de configuraciones


    $(document).on('ready',function(){
        //$(nombre_boton_eliminar).on('click',function(e){
          //  e.preventDefault();
           // var Pid = $(this).attr('id');
           /* alert('fdsa');
            var name = $(this).data('name');
            
            $('#modal_idProducto').val(Pid);
            $('#modal_name').text(name);
            var u ='/os/delete/' + Pid +'/';
                                 
            $('#frmEliminar').attr('action',u);                                                
        });*/
        
       $(nombre_boton_eliminar).on('click',function(e){
            e.preventDefault();
            var Pid = $(this).attr('id');
            
            var name = $(this).data('name');
            
            $('#modal_iditem').val(Pid);
            $('#modal_name').text(name);
            //var u ='/afiliacion/delete/' + Pid +'/';
            var url = $('#frmEliminar').attr('action');
            
            var url  = url+ Pid +'/';
            //alert(url);
                                
            $('#frmEliminar').attr('action',url);                                               
        });



        
    });
        
       