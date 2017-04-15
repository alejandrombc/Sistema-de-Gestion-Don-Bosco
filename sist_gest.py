# encoding=utf-8
import sist_gest_functs, config_vars
from flask import render_template, request, url_for, redirect, session, g,  json
from flaskext.mysql import MySQL
from flask_mail import Mail, Message #pip install Flask-Mail
import datetime, os
import MySQLdb as db


app = config_vars.app_conf()
mail = Mail(app)
mysql = MySQL()
mysql.init_app(app)

#Funcion index, llama a la funcion chequear usuario y retorna las vistas correspondientes
@app.route('/', methods=['GET','POST'])
def index():
	if(request.method == 'POST'): return sist_gest_functs.index_funct(request.form['username'], request.form['password'], session)
	else: return sist_gest_functs.index_funct()


@app.route('/seleccion_persona', methods=['POST'])
def seleccionarPersona():
	if(session.get('logged_in')):
		if request.form['ano'] != None: session['ano_esc'] = request.form['real_id']
		return render_template("seleccionar_tipo.html")


#Funcion seleccionar que muestra la ventana luego del logueo
@app.route('/seleccion')
def seleccionar():
	return sist_gest_functs.selec_funct(session)


#Funcion seleccionar que muestra la ventana luego del logueo
@app.route('/configuracion', methods=['GET'])
def configuracion():
	if(session.get('logged_in')): return render_template("configuracion.html")
	return redirect(url_for('index'))


@app.route('/agregar', methods=['GET','POST'])
def agregar():
	if request.method == 'POST' and session.get('logged_in'):
		return sist_gest_functs.agregar_funct(request.form['inicial'], request.form['final'], mysql.connect(), session)
	else:
		return render_template("agregar_ano.html")


#--------VISTA PERSONAL --------#
@app.route('/personal_ano', methods=['GET'])
def personal():
	# Aqui va el g con el ano escolar
	if session.get('logged_in'): return sist_gest_functs.personal_funct(mysql.connect().cursor())
	return redirect(url_for('index'))


@app.route('/personal_escoger_tipo', methods=['GET'])
def escoger_tipo_personal():
	if(session.get('logged_in')): return sist_gest_functs.escoger_tipo_personal_funct(mysql.connect().cursor(), request.args['id_tipo'])

#Aumenta el contador de inasistencias para los empleados
@app.route('/agregarInasistenciaPersonal', methods=['PUT'])
def agregarInasistenciaPersonal():
	if(session.get('logged_in')): return sist_gest_functs.agregarInasistenciaPersonal_funct(mysql.connect(), request.args['resultado'])


@app.route('/eliminarPersonal', methods=['DELETE'])
def eliminarPersonal():
	if(session.get('logged_in')): return sist_gest_functs.eliminarPersonal_funct(mysql.connect(), request.args['id'], session)


@app.route('/personal')
def getPersonal():
	if(session.get('logged_in')): return sist_gest_functs.getPersonal_funct(mysql.connect().cursor())


@app.route('/editarPersonal', methods=[ 'POST'])
def editarPersonal():
	if request.method == 'POST' and session.get('logged_in'): 
		return sist_gest_functs.editarPersonal_funct(mysql.connect(), request.form['apellidos'], request.form['hiddenCedula'], request.form['cedula'], request.form['nombres'], request.form['telefono'], request.form['id_tipo'], request.form['inasistencia'], request.form['direccion'], request.form['correo'])


@app.route('/anadirPersonal', methods=['GET', 'POST'])
def anadirPersonal():
	if(session.get('logged_in')): return render_template("personal_individual.html")	

#Buscar miembros del personal
@app.route('/buscarPersonal', methods=['POST'])
def buscarPersonal():
	if(session.get('logged_in')): return sist_gest_functs.buscarPersonal_funct(request.form['busqueda'], mysql.connect().cursor())

#Registrar nuevo trabajador
@app.route('/registrarPersonal', methods=['GET', 'POST'])
def registrarPersonal(): 
	if(session.get('logged_in')): return sist_gest_functs.registrarPersonal_funct(request.form.get('nombres'), request.form.get('apellidos'), request.form.get('cedula'), request.form.get('id_tipo'), request.form.get('correo'), request.form.get('direccion'), request.form.get('telefono'), mysql.connect())


#--------VISTA ESTUDIANTES--------#
@app.route('/estudiantes_ano', methods=['GET'])
def def_estudiantes(): 
	# Aqui va el g con el ano escolar
	if session.get('logged_in'): return sist_gest_functs.def_estudiantes_funct(mysql.connect().cursor())
	return redirect(url_for('index'))

#Selecciona el ano que se desee visualizar
@app.route('/estudiantes_escoger_ano', methods=['GET'])
def escoger_ano_estudiantes():
	if(session.get('logged_in')): return sist_gest_functs.escoger_ano_estudiantes_funct(mysql.connect().cursor(), request.args['id_carrera'])

#Aumenta el contador de inasistencias para un estudiante
@app.route('/agregarInasistencia', methods=['PUT'])
def agregarInasistencia():
	if(session.get('logged_in')): return sist_gest_functs.agregarInasistencia_funct(mysql.connect(), request.args['resultado'])

#Elimina un estudiante de un curso
@app.route('/eliminarEstudiante', methods=['DELETE'])
def eliminarEstudiante():
	if(session.get('logged_in')): return sist_gest_functs.eliminarEstudiante_funct(mysql.connect(), request.args['id'], session)

#Elimina una seccion de un curso
@app.route('/eliminarSeccion', methods=['DELETE'])
def eliminarSeccion():
	if(session.get('logged_in')): return sist_gest_functs.eliminarSeccion_funct(request.args['id_carrera'], request.args['cedulas'].split(","), mysql.connect(), session)


@app.route('/editarEstudiante', methods=[ 'POST'])
def editar_estudiantes():
	if request.method == 'POST' and session.get('logged_in'): return sist_gest_functs.editar_estudiantes_funct(mysql.connect(), request.form['apellidos'], request.form['hiddenCedula'], request.form['seccion'], request.form['cedula'], request.form['nombres'], request.form['telefono'], request.form['id_carrera'], request.form['inasistencia'], request.form['direccion'], request.form['correo'])
	return redirect(url_for('def_estudiantes'))

#Agrega una seccion nueva a un curso
@app.route('/agregar_seccion', methods=['GET', 'POST'])
def seccion():
	if request.method == 'POST' and session.get('logged_in'): return sist_gest_functs.seccion_funct(request.form.get('id_carrera'), mysql.connect())
	return render_template("agregar_seccion.html")

#Cantidad de secciones de un curso
@app.route('/cant_secciones')
def getCantidadSecciones():
	if(session.get('logged_in')): return sist_gest_functs.getCantidadSecciones_funct(mysql.connect().cursor(), request.args['id_carrera'])


@app.route('/buscarEstudiante', methods=['POST'])
def buscarEstudiante():
	if(session.get('logged_in')): return sist_gest_functs.buscarEstudiante_funct(request.form['busqueda'], mysql.connect().cursor())


@app.route('/anadirEstudiante', methods=['GET', 'POST'])
def anadirEstudiante():
	if(session.get('logged_in')): return render_template("estudiante_individual.html")	


@app.route('/estudiante')
def getEstudiante():
	if(session.get('logged_in')): return sist_gest_functs.getEstudiante_funct(mysql.connect().cursor())


@app.route('/registrarEstudiante', methods=['GET', 'POST'])
def registrarEstudiante():
	if(session.get('logged_in')): return sist_gest_functs.registrarEstudiante_funct(request.form.get('nombres'), request.form.get('apellidos'), request.form.get('cedula'), request.form.get('fechaNac'), '1900-01-01', request.form.get('id_carrera'), request.form.get('seccion'), request.form.get('correo'), request.form.get('direccion'), request.form.get('telefono'), mysql.connect())


#--------FIN VISTA ESTUDIANTES--------#


# Al darle a seleccionar busco todos los anos y los mando al html
@app.route('/seleccionar')
def seleccion_ano():
	if(session.get('logged_in')): return sist_gest_functs.seleccion_ano_funct(mysql.connect().cursor())

#Vista para eliminar anos
@app.route('/eliminar')
def eliminar_ano():
	if(session.get('logged_in')): return sist_gest_functs.eliminar_ano_funct(mysql.connect().cursor())

#Oculta el ano de la vista
@app.route('/eliminar_ano', methods=['POST'])
def eliminar_anos():
	if(session.get('logged_in')): return sist_gest_functs.eliminar_anos_funct(request.form['real_id'], request.form['ano_escolar'], mysql.connect())

#Vista para recuperar anos
@app.route('/recuperar')
def recuperar_ano():
	if(session.get('logged_in')): return sist_gest_functs.recuperar_ano_funct(mysql.connect().cursor())		

#Vuelve a colocar el ano en la vista
@app.route('/recuperar_ano', methods=['POST'])
def recuperar_anos():
	if(session.get('logged_in')): return sist_gest_functs.recuperar_anos_funct(request.form['real_id'], request.form['ano_escolar'], mysql.connect(), conn.cursor())


#-----------FUNCIONES DE CARGAR, EXPORTAR BD Y CERRAR---------#
@app.route('/exportarBD', methods=['GET'])
def exportarBD():
	if(session.get('logged_in')): return sist_gest_functs.exportarBD_funct()
	return redirect(url_for('index'))

def run_sql_file(filename, connection): return sist_gest_functs.run_sql_file_funct(filename, connection)


@app.route('/cargarBD', methods=['POST'])
def cargarBD():
	if(session.get('logged_in')): return sist_gest_functs.cargarBD_funct(request.files['archivo'], db.connect(host="localhost", user="root", passwd=""), conn.cursor())
	return redirect(url_for('index'))

@app.route('/cerrar_sesion', methods=['GET'])
def cerrar_sesion():
	if(session.get('logged_in')): 
		session.pop('logged_in', None)
		return redirect(url_for('index'))


#-----------ENVIAR CORREO Y UPLOAD DE ARCHIVO---------#

@app.route('/send_mail', methods=['POST'])
def send_mail():
	if session.get('logged_in') and request.method == 'POST': return sist_gest_functs.send_mail_funct(mysql.connect(), request, request.form['asunto'], request.form['Mensaje'], config_vars.app_conf(), mail)


@app.route('/enviar_correo', methods=['GET', 'POST'])
def enviar_correo():
	if session['ano_esc'] != None: 
		return sist_gest_functs.enviar_correo_funct(mysql.connect().cursor())
	else:
		print("Error no selecciono periodo escolar!")
		return render_template("ano_escolar.html")

@app.route('/enviar_correo_personal', methods=['GET', 'POST'])
def enviar_correo_personal():
	if session['ano_esc'] != None:
		return sist_gest_functs.enviar_correo_personal_funct(mysql.connect().cursor())
	else:
		print("Error no selecciono periodo escolar!")
		return render_template("ano_escolar.html")

@app.route('/send_mail_personal', methods=['POST'])
def send_mail_personal():
	if session.get('logged_in') and request.method == 'POST': return sist_gest_functs.send_mail_personal_funct(mysql.connect(), request, request.form['asunto'], request.form['Mensaje'], config_vars.app_conf(), mail)


if __name__ == "__main__":
	app.run(debug=True, host='127.0.0.1', port=3000)
