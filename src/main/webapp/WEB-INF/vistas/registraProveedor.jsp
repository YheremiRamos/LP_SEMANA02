<!DOCTYPE html>
<html lang="esS" >
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>
<script type="text/javascript" src="js/global.js"></script>

<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/bootstrapValidator.css"/>
<title>Registra Proveedor </title>
</head>
<body>

<div class="container">
<h3>Registra Proveedor</h3>
	
	<form  id="id_form" method="post"> 
	 <div class="col-md-12" style="margin-top: 2%">
	 
	 
			<div class="row">
			
			
				<div class="form-group col-md-6">
					<label class="control-label" for="id_nombre">Nombre y Apellido</label>
					<input class="form-control" type="text" id="id_nombre" name="nombre" placeholder="Ingrese el nombre">
				</div>
				
				<div class="form-group col-md-6">
					<label class="control-label" for="id_dni">DNI</label>
					<input class="form-control" type="text" id="id_dni" name="dni" placeholder="Ingrese el dni" maxlength="8">
				</div>
				
			<div class="form-group col-md-3">
					<label class="control-label" for="id_tipo">Tipo</label>
					<select id="id_tipo" name="tipo.idTipo" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
			    
			    <div class="form-group col-md-3">
					<label class="control-label" for="id_pais">Pais</label>
					<select id="id_pais" name="pais.idPais" class='form-control'>
						<option value=" ">[Seleccione]</option>    
					</select>
			    </div>
				
				
			</div>
			
			
		    <div class="row">
				<div class="form-group col-md-12" align="center">
					<button id="id_registrar" type="button" class="btn btn-primary" >Registra</button>
				</div>
			</div>
	</div>
	</form>
	
</div>

<script type="text/javascript">

$.getJSON("listaTipo", {}, function(data){
	$.each(data, function(index,item){
		$("#id_tipo").append("<option value="+item.idTipo +">"+ item.descripcion +"</option>");
	});
});


$.getJSON("listaPais", {}, function(data){
	$.each(data, function(index,item){
		$("#id_pais").append("<option value="+item.idPais +">"+ item.nombre +"</option>");
	});
});

$("#id_registrar").click(function (){ 

	var validator = $('#id_form').data('bootstrapValidator');
	validator.validate();

	if (validator.isValid()){
		$.ajax({
			type: 'POST',  
			data: $("#id_form").serialize(),
			url: 'registraProveedor',
			success: function(data){
				mostrarMensaje(data.MENSAJE);
				limpiar();
				validator.resetForm();
			},
			error: function(){
				mostrarMensaje(MSG_ERROR);
			}
		});
	}
});

function limpiar(){
	$("#id_nombre").val('');
	$("#id_dni").val('');
	$("#id_tipo").val('');
	$("#id_pais").val('');
	
}

$('#id_form').bootstrapValidator({
    message: 'This value is not valid',
    feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
    	nombre: {
    		selector : '#id_nombre',
            validators: {
                notEmpty: {
                    message: 'El nombre es un campo obligatorio'
                },
                stringLength :{
                	message:'El nombre es de 3 a 100 caracteres',
                	min : 3,
                	max : 100
                },
                //agregar6
                remote:{
                	delay:1000,
                	url: 'buscaPorNombreProveedor',
                	message: 'El nombre ya existe'
                }
            }
        },
        
        dni:{
            selector: "#id_dni",
            validators:{
                notEmpty: {
                     message: 'El dni es obligatorio'
                },
                regexp: {
                    regexp: /^[0-9]{8}$/,
                    message: 'el dni es de 8 dígitos'
                },
              //agregar6
                remote:{
                	delay:1000,
                	url: 'buscaPorDniProveedor',
                	message: 'El DNI ya existe'
                }
            }
        },
        tipo: {
    		selector : '#id_tipo',
            validators: {
            	notEmpty: {
                    message: 'El tipo es un campo obligatorio'
                },
            }
        },
        pais: {
    		selector : '#id_pais',
            validators: {
            	notEmpty: {
                    message: 'El pais es un campo obligatorio'
                },
            }
        },
     
    	
    }   
});
</script>


</body>
</html>