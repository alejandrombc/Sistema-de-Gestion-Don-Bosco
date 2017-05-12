from flask import render_template, request, url_for, redirect, session, g,  json
from flaskext.mysql import MySQL
from flask_mail import Mail, Message #pip install Flask-Mail
from werkzeug.utils import secure_filename
import hashlib
import datetime, os

########################################################################
#						    Consultas MySQL                            #
#																	   #
########################################################################

def select_periodo(*args):
	if len(args) > 1:
		ano = args[0]
		cursor = args[1]
		cursor.execute("SELECT * from periodo WHERE periodo_nombre=%s", (ano))
	else:
		cursor = args[0]
		cursor.execute("SELECT COUNT(*) from periodo")

#-------Consultas Personal-------#

def select_personal(*args):
	#La diferencia entre las consultas radica en el id que categoriza al personal
	if len(args) == 2:
		session = args[0]
		cursor = args[1]
		return cursor.execute("SELECT personal.*, personal_temporal.inasistencias, personal_temporal.periodo_nombre " +
			           "FROM (SELECT trabaja.cedula,trabaja.inasistencias, periodo_actual.periodo_nombre  " +
		               "FROM (SELECT periodo_nombre FROM periodo WHERE periodo_id='"+session['ano_esc']+"') periodo_actual, trabaja WHERE trabaja.periodo_id='"+session['ano_esc']+"' AND tipo=1) personal_temporal, personal WHERE personal_temporal.cedula = personal.cedula")

	if len(args) == 3:
		id_tipo = args[0]
		session = args[1]
		cursor = args[2]
		return cursor.execute("SELECT personal.*, personal_temporal.inasistencias, personal_temporal.periodo_nombre " +
			           "FROM (SELECT trabaja.cedula,trabaja.inasistencias, periodo_actual.periodo_nombre  " +
		               "FROM (SELECT periodo_nombre FROM periodo WHERE periodo_id='"+session['ano_esc']+"') periodo_actual, trabaja WHERE trabaja.periodo_id='"+session['ano_esc']+"' AND tipo="+id_tipo+") personal_temporal, personal WHERE personal_temporal.cedula = personal.cedula")
	
def select_personal_get(request, session, cursor):
	return cursor.execute("SELECT personal.*, personal_temporal.inasistencias, tipo_trabajador.cargo FROM (SELECT trabaja.tipo, trabaja.cedula,trabaja.inasistencias FROM trabaja WHERE trabaja.periodo_id='"+session['ano_esc']+"' AND cedula='"+request.args['cedula']+"') personal_temporal, personal, tipo_trabajador WHERE tipo_trabajador.id_tipo = personal_temporal.tipo AND personal_temporal.cedula = personal.cedula")

#Busca empleados con nombre similar a lo indicado
def select_personal_like(busqueda, cursor):
	cursor.execute("SELECT * FROM personal WHERE " +
		"cedula LIKE '%"+busqueda+"%' OR nombres LIKE '%"+busqueda+"%' OR apellidos LIKE '%"+busqueda+"%' OR direccion LIKE '%"+busqueda+"%' OR " +
		"correo LIKE '%"+busqueda+"%' OR numero_de_telefono LIKE '%"+busqueda+"%'")

#Busca empleados por cedula
def select_personal_where(cedula, cursor):
	cursor.execute("SELECT * FROM personal WHERE cedula='"+cedula+"'")

#Agrega un nuevo empeado a la tabla personal
def insert_personal(cedula, nombres, apellidos, direccion, correo, telefono, cursor):
	return cursor.execute("INSERT INTO personal (cedula, nombres, apellidos, direccion, correo, numero_de_telefono) VALUES ('"+cedula+"','"+nombres+"','"+apellidos+"','"+direccion+"','"+correo+"','"+telefono+"')")

#Elimina un empleado de la tabla
def delete_personal(session, idPersonal, cursor):
	return cursor.execute("DELETE FROM trabaja WHERE periodo_id=%s AND cedula=%s", (session['ano_esc'], idPersonal))

#Actualiza datos de un empleado
def update_personal(apellidos, hiddenCedula, cedula, nombres, telefono, direccion, email, cursor):
	return cursor.execute("UPDATE personal SET apellidos='"+apellidos+"', cedula='"+cedula+"', nombres='"+nombres+"', numero_de_telefono='"+telefono+"', direccion='"+direccion+"', correo='"+email+"' WHERE cedula='"+hiddenCedula+"'")

#Agrega nuevo periodo academico
def insert_periodo(ano, cursor):
	return cursor.execute("""INSERT INTO periodo (periodo_nombre, eliminada) VALUES (%s, '0')""", (ano))

#Con esta tabla se crea la relacion entre Personal y Trabaja y se lleva registro de inasistencias
def select_trabaja(cedula, session, cursor):
	return cursor.execute("SELECT * FROM trabaja WHERE cedula='"+cedula+"' AND periodo_id='"+session['ano_esc']+"'")

#Agrega empleado a la tabla trabaja
def insert_trabaja(cedula, session, id_tipo, cursor):
	return cursor.execute("INSERT INTO trabaja (cedula, periodo_id, tipo, inasistencias) VALUES ('"+cedula+"', '"+session['ano_esc']+"','"+id_tipo+"','"+str(0)+"')")

#Se actualiza informacion del empleado
def update_trabaja(*args):
	if len(args) == 4: #Se actualizan inasistencias
		inasistencias = args[0]
		arreglo = args[1]
		session = args[2]
		cursor = args[3]
		return cursor.execute("UPDATE trabaja SET inasistencias='"+str(inasistencias)+"' WHERE periodo_id='"+session['ano_esc']+"' AND cedula='"+arreglo[0]+"'")

	else: #Se actualiza informacion personal
		cedula = args[0]
		tipo = args[1]
		inasistencia = args[2]
		hiddenCedula = args[3]
		session = args[4]
		cursor = args[5]
		return cursor.execute("UPDATE trabaja SET cedula='"+cedula+"', periodo_id='"+session['ano_esc']+"', tipo='"+tipo+"', inasistencias='"+inasistencia+"' WHERE cedula='"+hiddenCedula+"'")

#Elimina personal
def delete_personal(session, idPersonal, cursor):
	return cursor.execute("DELETE FROM trabaja WHERE periodo_id=%s AND cedula=%s", (session['ano_esc'], idPersonal))

#-------Consultas Estudiante-------#

def select_estudiante(*args):
	if len(args) > 2: #En este caso se especifica el id de la carrera
		id_carrera = args[0]
		session = args[1]
		cursor = args[2]
		return cursor.execute("SELECT estudiante.*, estudiante_temporal.inasistencias, estudiante_temporal.periodo_nombre, estudiante_temporal.seccion_actual FROM (SELECT cursa.cedula,cursa.seccion_actual,cursa.inasistencias, periodo_actual.periodo_nombre  FROM (SELECT periodo_nombre FROM periodo WHERE periodo_id='"+session['ano_esc']+"') periodo_actual, cursa WHERE cursa.periodo_id='"+session['ano_esc']+"' AND carrera_id='"+id_carrera+"') estudiante_temporal, estudiante WHERE estudiante_temporal.cedula = estudiante.cedula")
	else:
		session = args[0]
		cursor = args[1]
		return cursor.execute("SELECT estudiante.*, estudiante_temporal.inasistencias, estudiante_temporal.periodo_nombre, estudiante_temporal.seccion_actual FROM (SELECT cursa.cedula,cursa.seccion_actual,cursa.inasistencias, periodo_actual.periodo_nombre  FROM (SELECT periodo_nombre FROM periodo WHERE periodo_id='"+session['ano_esc']+"') periodo_actual, cursa WHERE cursa.periodo_id='"+session['ano_esc']+"' AND carrera_id=1) estudiante_temporal, estudiante WHERE estudiante_temporal.cedula = estudiante.cedula")

def select_estudiante_get(request, session, cursor):
	return cursor.execute("SELECT estudiante.*, estudiante_temporal.inasistencias, estudiante_temporal.seccion_actual, carrera.carrera_nombre, carrera.ano_escolar FROM (SELECT cursa.carrera_id, cursa.cedula,cursa.seccion_actual,cursa.inasistencias FROM cursa WHERE cursa.periodo_id='"+session['ano_esc']+"' AND cedula='"+request.args['cedula']+"') estudiante_temporal, estudiante, carrera WHERE carrera.carrera_id = estudiante_temporal.carrera_id AND estudiante_temporal.cedula = estudiante.cedula")

#Obtiene estudiante por CI
def select_estudiante_where_CI(cedula, cursor):
	return cursor.execute("SELECT * FROM estudiante WHERE cedula='"+cedula+"'")

#Lista estudiantes con nombres similares al indicado
def select_estudiante_where(busqueda, cursor):
	return cursor.execute("SELECT * FROM estudiante WHERE " +
		"cedula LIKE '%"+busqueda+"%' OR nombres LIKE '%"+busqueda+"%' OR apellidos LIKE '%"+busqueda+"%' OR direccion LIKE '%"+busqueda+"%' OR " +
		"correo LIKE '%"+busqueda+"%' OR numero_de_telefono LIKE '%"+busqueda+"%'")

#Inserta en la tabla estudiantes, la tabla tiene informacion personal
def insert_estudiante(nombres, apellidos, cedula, dateFechaNac, correo, direccion, telefono, nombresPadre, telefonoPadre, emailPadre, cursor):
	return cursor.execute("INSERT INTO estudiante (cedula, nombres, apellidos, direccion, correo, numero_de_telefono, fecha_de_nacimiento, nombres_representante, numero_de_telefono_representante, correo_representante) VALUES ('"+cedula+"','"+nombres+"','"+apellidos+"','"+direccion+"','"+correo+"','"+telefono+"','"+dateFechaNac+"','"+nombresPadre+"','"+telefonoPadre+"','"+emailPadre+"')")

#Actualiza informacion personal
def update_estudiante(apellidos, hiddenCedula, cedula, nombres, telefono, inasistencia, direccion, email, nombresPadre, telefonoPadre, emailPadre, cursor):
	return cursor.execute("UPDATE estudiante SET apellidos='"+apellidos+"', cedula='"+cedula+"', nombres='"+nombres+"', numero_de_telefono='"+telefono+"', direccion='"+direccion+"', correo='"+email+"', nombres_representante='"+nombresPadre+"', Numero_de_telefono_representante='"+telefonoPadre+"', correo_representante='"+emailPadre+"' WHERE cedula='"+hiddenCedula+"'")

#Se obtienen la cantidad de secciones
def select_cantidad(*args):
	if len(args) > 2:
		id_carrera = args[0]
		session = args[1]
		cursor = args[2]
		return cursor.execute("SELECT cantidad FROM seccion WHERE carrera_id='"+id_carrera+"' AND periodo_id='"+session['ano_esc']+"'")
	else:
		session = args[0]
		cursor = args[1]
		return cursor.execute("SELECT cantidad FROM seccion WHERE carrera_id=1 AND periodo_id='"+session['ano_esc']+"'")

#Estudiante-Cursa, similar a Empleado-Trabaja, se lleva control de inasistencias y del curso en el que se encuentra con esta tabla
def select_cursa(cedula, session, cursor):
	return cursor.execute("SELECT * FROM cursa WHERE cedula='"+cedula+"' AND periodo_id='"+session['ano_esc']+"'")

#Se agrega estudiante a un curso
def insert_cursa(cedula, session, id_carrera, seccion, cursor):
	return cursor.execute("INSERT INTO cursa (cedula, periodo_id, carrera_id, seccion_actual, inasistencias) VALUES ('"+cedula+"', '"+session['ano_esc']+"','"+id_carrera+"','"+seccion+"','"+str(0)+"')")

#Actualiza informacion de un estudiante de un curso
def update_cursa(*args):
	if len(args) < 7: #Actualiza inasistencias
		inasistencias = args[0]
		arreglo = args[1]
		session = args[2]
		cursor = args[3]
		return cursor.execute("UPDATE cursa SET inasistencias='"+str(inasistencias)+"' WHERE periodo_id='"+session['ano_esc']+"' AND cedula='"+arreglo[0]+"'")
	else: #Informacion personal
		hiddenCedula = args[0]
		seccion = args[1]
		cedula = args[2]
		id_carrera = args[3]
		inasistencia = args[4]
		session = args[5]
		cursor = args[6]
		return cursor.execute("UPDATE cursa SET cedula='"+cedula+"', periodo_id='"+session['ano_esc']+"', seccion_actual='"+seccion+"' , carrera_id='"+id_carrera+"', inasistencias='"+inasistencia+"' WHERE cedula='"+hiddenCedula+"'")

#Elimina estudiante de un curso
def delete_cursa(ID, session, cursor):
	return cursor.execute("DELETE FROM cursa WHERE periodo_id=%s AND cedula=%s", (session['ano_esc'], ID))

#Actualiza la cantidad de estudiantes e informacion de una seccion
def update_seccion(*args):
	if len(args) > 3:
		cant_secciones = args[0]
		id_carrera = args[1]
		session = args[2]
		cursor = args[3]
		return cursor.execute("UPDATE seccion SET cantidad=%s WHERE periodo_id=%s AND carrera_id=%s", (cant_secciones, session['ano_esc'], id_carrera ))
	else:
		id_carrera = args[0]
		session = args[1]
		cursor = args[2]
		return cursor.execute("UPDATE seccion SET cantidad=cantidad+1 WHERE carrera_id='"+id_carrera+"' AND periodo_id='"+session['ano_esc']+"'")

#Agrega una seccion nueva a un curso
def insert_seccion(i, ID, cursor):	
	return cursor.execute("""INSERT INTO seccion ( carrera_id, periodo_id, cantidad ) VALUES (%s, %s, 1)""", (i, ID))

#-------Consultas Periodo Academico-------#

#Seleccion de ano escolar
def select_periodo_ano(cursor):
	return cursor.execute("SELECT periodo_id, periodo_nombre from periodo WHERE eliminada='0'")

#Opcion de recuperar ano
def select_periodo_recuperar(cursor):
	return cursor.execute("SELECT periodo_id, periodo_nombre from periodo WHERE eliminada=1")

#Actualiza el ano como eliminado
def update_periodo_eliminar(real_id, cursor):
	return cursor.execute("UPDATE periodo SET eliminada = 1 WHERE periodo_id=%s",(int(real_id)))

#Se recupera ano eliminado
def update_periodo_recuperar(real_id, cursor):
	return cursor.execute("UPDATE periodo SET eliminada = 0 WHERE periodo_id=%s",(int(real_id)))

#Elimina ano
def delete_periodo(cursor):
	return cursor.execute("SELECT periodo_id, periodo_nombre from periodo WHERE eliminada=0")

#-------Consultas Correo-------#

def select_correo(*args):
	if len(args) == 1:
		cursor = args [0]
		return cursor.execute("SELECT correo FROM correo_enviado")
	if len(args) == 2:
		tipos_personal = args[0]
		cursor = args [1]
		return cursor.execute("SELECT correo FROM view_correos WHERE tipo IN (%s)" % format_strings,tuple(tipos_personal))
	if len(args) == 3:
		id_carreras = args[0]
		secciones = args[1]
		session = args[2]
		cursor = args[3]
		return cursor.execute("SELECT estudiante.correo FROM (SELECT cedula FROM cursa WHERE carrera_id='"+id_carreras[i]+"' AND periodo_id='"+session['ano_esc']+"' AND seccion_actual='"+secciones[i]+"') estudiante_cursando, estudiante WHERE estudiante_cursando.cedula=estudiante.cedula ")

def select_cantidad_correo(session, cursor):	
	return cursor.execute("SELECT cantidad FROM seccion WHERE periodo_id=%s", (session['ano_esc']))