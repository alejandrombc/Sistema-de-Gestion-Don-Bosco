# encoding=utf-8
import sist_gest_functs, config_vars
from flask import render_template, request, url_for, redirect, session, g,  json
from flaskext.mysql import MySQL
from flask_mail import Mail, Message #pip install Flask-Mail
from werkzeug.utils import secure_filename
import datetime, os

#Para el UPLOAD de archivos en el servidor 
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif','rar', 'zip'])

app = config_vars.app_conf()
app.config['TEMPLATES_AUTO_RELOAD'] = True
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

@app.route('/agregar', methods=['GET','POST'])
def agregar():
	if request.method == 'POST' and session.get('logged_in'): 
		inicio = request.form['inicial']
		final = request.form['final']
		ano = inicio + "-" + final
		con = mysql.connect()
		cursor = con.cursor()
		cursor.execute("SELECT * from periodo WHERE periodo_nombre=%s", (ano))
		data = cursor.fetchone()

		if(data != None):
			error="Error: Ese año esta repetido, por favor seleccionelo o eliminelo."
			return render_template("agregar_ano.html", error=error)

		if (inicio[0] == '2') and (inicio[1] == '0') and (final[0] == '2') and (final[1] == '0') and (len(final)==4) and (len(inicio)==4) and (final > inicio):
			cursor.execute("""INSERT INTO periodo (periodo_nombre, eliminada) VALUES (%s, '0')""", (ano))
			con.commit()
			cursor.execute("SELECT COUNT(*) from periodo")
			ID = cursor.fetchone()
			ID = ID[0]
			for i in range(1,13):
				cursor.execute("""INSERT INTO seccion ( carrera_id, periodo_id, cantidad ) VALUES (%s, %s, 1)""", (i, ID))
			con.commit()
			session['logged_in'] = "newform" 
			return redirect(url_for('seleccionar'))
		else:
			error="Error: Año invalido"
			return render_template("agregar_ano.html", error=error)
	else:
		return render_template("agregar_ano.html")


#--------VISTA PERSONAL --------#
@app.route('/personal_ano', methods=['GET'])
def def_personal():
	# Aqui va el g con el ano escolar
	if session.get('logged_in'):
		cursor = mysql.connect().cursor()
		
		cursor.execute("SELECT estudiante.*, estudiante_temporal.inasistencias, estudiante_temporal.periodo_nombre, estudiante_temporal.seccion_actual FROM (SELECT cursa.cedula,cursa.seccion_actual,cursa.inasistencias, periodo_actual.periodo_nombre  FROM (SELECT periodo_nombre FROM periodo WHERE periodo_id='"+session['ano_esc']+"') periodo_actual, cursa WHERE cursa.periodo_id='"+session['ano_esc']+"' AND carrera_id=1) estudiante_temporal, estudiante WHERE estudiante_temporal.cedula = estudiante.cedula")
		data = cursor.fetchall()

		cursor.execute("SELECT cantidad FROM seccion WHERE carrera_id=1 AND periodo_id='"+session['ano_esc']+"'")
		secciones = cursor.fetchall()

		cant_secciones = int(secciones[0][0])
		return render_template("personal.html", datos=data, cant_secciones=cant_secciones )
	return redirect(url_for('index'))


#--------VISTA ESTUDIANTES--------#
@app.route('/estudiantes_ano', methods=['GET'])
def def_estudiantes():
	# Aqui va el g con el ano escolar
	if session.get('logged_in'):
		cursor = mysql.connect().cursor()
		
		cursor.execute("SELECT estudiante.*, estudiante_temporal.inasistencias, estudiante_temporal.periodo_nombre, estudiante_temporal.seccion_actual FROM (SELECT cursa.cedula,cursa.seccion_actual,cursa.inasistencias, periodo_actual.periodo_nombre  FROM (SELECT periodo_nombre FROM periodo WHERE periodo_id='"+session['ano_esc']+"') periodo_actual, cursa WHERE cursa.periodo_id='"+session['ano_esc']+"' AND carrera_id=1) estudiante_temporal, estudiante WHERE estudiante_temporal.cedula = estudiante.cedula")
		data = cursor.fetchall()

		cursor.execute("SELECT cantidad FROM seccion WHERE carrera_id=1 AND periodo_id='"+session['ano_esc']+"'")
		secciones = cursor.fetchall()

		cant_secciones = int(secciones[0][0])
		return render_template("estudiantes.html", datos=data, cant_secciones=cant_secciones )
	return redirect(url_for('index'))


@app.route('/estudiantes_escoger_ano', methods=['GET'])
def escoger_ano_estudiantes():
	if(session.get('logged_in')):
		cursor = mysql.connect().cursor()
		id_carrera = request.args['id_carrera']

		cursor.execute("SELECT estudiante.*, estudiante_temporal.inasistencias, estudiante_temporal.periodo_nombre, estudiante_temporal.seccion_actual FROM (SELECT cursa.cedula,cursa.seccion_actual,cursa.inasistencias, periodo_actual.periodo_nombre  FROM (SELECT periodo_nombre FROM periodo WHERE periodo_id='"+session['ano_esc']+"') periodo_actual, cursa WHERE cursa.periodo_id='"+session['ano_esc']+"' AND carrera_id='"+id_carrera+"') estudiante_temporal, estudiante WHERE estudiante_temporal.cedula = estudiante.cedula")
		data = cursor.fetchall()

		cursor.execute("SELECT cantidad FROM seccion WHERE carrera_id='"+id_carrera+"' AND periodo_id='"+session['ano_esc']+"'")
		secciones = cursor.fetchall()

		cant_secciones = int(secciones[0][0])

		data = json.dumps(data)
		return '{} {}'.format(cant_secciones, data)


@app.route('/agregarInasistencia', methods=['PUT'])
def agregarInasistencia():
	if(session.get('logged_in')):
		conn = mysql.connect()
		cursor = conn.cursor()
		resultado = request.args['resultado']
		arreglo = resultado.split("-")
		inasistencias = int(arreglo[1])
		
		cursor.execute("UPDATE cursa SET inasistencias='"+str(inasistencias)+"' WHERE periodo_id='"+session['ano_esc']+"' AND cedula='"+arreglo[0]+"'")
		conn.commit()

		return ""

@app.route('/eliminarEstudiante', methods=['DELETE'])
def eliminarEstudiante():
	if(session.get('logged_in')):
		conn = mysql.connect()
		cursor = conn.cursor()
		idStudent = request.args['id']
		
		cursor.execute("DELETE FROM cursa WHERE periodo_id=%s AND cedula=%s", (session['ano_esc'], idStudent))
		conn.commit()

		return ""

@app.route('/eliminarSeccion', methods=['DELETE'])
def eliminarSeccion():
	if(session.get('logged_in')):
		id_carrera = request.args['id_carrera']
		cedulas = request.args['cedulas'].split(",")

		conn = mysql.connect()
		cursor = conn.cursor()
		cursor.execute("SELECT cantidad FROM seccion WHERE carrera_id='"+id_carrera+"' AND periodo_id='"+session['ano_esc']+"'")
		secciones = cursor.fetchall()

		cant_secciones = int(secciones[0][0])
		
		cant_secciones -= 1 #Se decrementa el numero de secciones
		#Actualizo cantidad de secciones
		cursor.execute("UPDATE seccion SET cantidad=%s WHERE periodo_id=%s AND carrera_id=%s", (cant_secciones, session['ano_esc'], id_carrera ) )
		
		#Borrar estudiantes pertenecientes a ese periodo-curso-ano
		for cedula in cedulas:
			cursor.execute("DELETE FROM cursa WHERE periodo_id=%s AND cedula=%s", (session['ano_esc'], cedula))
			
		conn.commit()
		return ""

@app.route('/editarEstudiante', methods=[ 'POST'])
def def_editar_estudiantes():
	if request.method == 'POST' and session.get('logged_in'): 
		conn = mysql.connect()
		cursor = conn.cursor()
		apellidos = request.form['apellidos']
		hiddenCedula = request.form['hiddenCedula']
		seccion = request.form['seccion'];
		cedula = request.form['cedula']
		print(cedula)
		nombres = request.form['nombres']
		telefono = request.form['telefono']
		id_carrera = request.form['id_carrera']
		inasistencia = request.form['inasistencia']
		direccion = request.form['direccion']
		email = request.form['correo']

		cursor.execute("SET FOREIGN_KEY_CHECKS=0;")

		#Se actualizan los datos ingresados 
		cursor.execute("UPDATE estudiante SET apellidos='"+apellidos+"', cedula='"+cedula+"', nombres='"+nombres+"', numero_de_telefono='"+telefono+"', direccion='"+direccion+"', correo='"+email+"' WHERE cedula='"+hiddenCedula+"'")

		#Se actualiza los datos de la tabla cursa
		cursor.execute("UPDATE cursa SET cedula='"+cedula+"', periodo_id='"+session['ano_esc']+"', seccion_actual='"+seccion+"' , carrera_id='"+id_carrera+"', inasistencias='"+inasistencia+"' WHERE cedula='"+hiddenCedula+"'")
		conn.commit()

		cursor.execute("SET FOREIGN_KEY_CHECKS=1;")
		conn.commit()

		#Falta validar si la data es null o alguna excepcion
	return redirect(url_for('def_estudiantes'))


@app.route('/agregar_seccion', methods=['GET', 'POST'])
def seccion():
	if request.method == 'POST' and session.get('logged_in'):
		id_carrera = request.form.get('id_carrera')
		conn = mysql.connect()
		cursor = conn.cursor()

		cursor.execute("UPDATE seccion SET cantidad=cantidad+1 WHERE carrera_id='"+id_carrera+"' AND periodo_id='"+session['ano_esc']+"'")
		conn.commit()
		return redirect(url_for('def_estudiantes'))
	return render_template("agregar_seccion.html")


@app.route('/cant_secciones')
def getCantidadSecciones():
	if(session.get('logged_in')):
		cursor = mysql.connect().cursor()
		id_carrera = request.args['id_carrera']

		cursor.execute("SELECT cantidad FROM seccion WHERE carrera_id='"+id_carrera+"' AND periodo_id='"+session['ano_esc']+"'")
		secciones = cursor.fetchall()

		cant_secciones = int(secciones[0][0])
		return '{}'.format(cant_secciones)

@app.route('/buscarEstudiante', methods=['POST'])
def buscarEstudiante():
	if(session.get('logged_in')):
		busqueda = request.form['busqueda']
		# print(busqueda)
		cursor = mysql.connect().cursor()

		if (busqueda != ""):
			cursor.execute("SELECT * FROM estudiante WHERE " +
			"cedula LIKE '%"+busqueda+"%' OR nombres LIKE '%"+busqueda+"%' OR apellidos LIKE '%"+busqueda+"%' OR direccion LIKE '%"+busqueda+"%' OR " +
			"correo LIKE '%"+busqueda+"%' OR numero_de_telefono LIKE '%"+busqueda+"%'" )
			estudiantes = cursor.fetchall()
			if(estudiantes != () ):
				hayResultado = 1
			else:
				hayResultado = 0
		else:
			hayResultado = 0
			estudiantes = ""

		return render_template("resultado_busqueda_estudiante.html", datos=estudiantes, hayResultado=hayResultado)

@app.route('/buscarPersonal', methods=['POST'])
def buscarPersonal():
	if(session.get('logged_in')):
		busqueda = request.form['busqueda']
		# print(busqueda)
		cursor = mysql.connect().cursor()

		if (busqueda != ""):
			cursor.execute("SELECT * FROM estudiante WHERE " +
			"cedula LIKE '%"+busqueda+"%' OR nombres LIKE '%"+busqueda+"%' OR apellidos LIKE '%"+busqueda+"%' OR direccion LIKE '%"+busqueda+"%' OR " +
			"correo LIKE '%"+busqueda+"%' OR numero_de_telefono LIKE '%"+busqueda+"%'" )
			estudiantes = cursor.fetchall()
			if(estudiantes != () ):
				hayResultado = 1
			else:
				hayResultado = 0
		else:
			hayResultado = 0
			estudiantes = ""

		return render_template("resultado_busqueda_personal.html", datos=estudiantes, hayResultado=hayResultado)

@app.route('/anadirEstudiante', methods=['GET', 'POST'])
def anadirEstudiante():
	if(session.get('logged_in')): return render_template("estudiante_individual.html")	

@app.route('/anadirPersonal', methods=['GET', 'POST'])
def anadirPersonal():
	if(session.get('logged_in')): return render_template("personal_individual.html")	

@app.route('/estudiante')
def getEstudiante():
	if(session.get('logged_in')):
		cursor = mysql.connect().cursor()	
		cursor.execute("SELECT estudiante.*, estudiante_temporal.inasistencias, estudiante_temporal.seccion_actual, carrera.carrera_nombre, carrera.ano_escolar FROM (SELECT cursa.carrera_id, cursa.cedula,cursa.seccion_actual,cursa.inasistencias FROM cursa WHERE cursa.periodo_id='"+session['ano_esc']+"' AND cedula='"+request.args['cedula']+"') estudiante_temporal, estudiante, carrera WHERE carrera.carrera_id = estudiante_temporal.carrera_id AND estudiante_temporal.cedula = estudiante.cedula")
		estudiante = cursor.fetchall()
		data = json.dumps(estudiante)

		return '{}'.format(data)

@app.route('/registrarEstudiante', methods=['GET', 'POST'])
def registrarEstudiante():
	if(session.get('logged_in')):
		nombres = request.form.get('nombres')
		apellidos  = request.form.get('apellidos')	
		cedula = request.form.get('cedula')
		fechaNac = request.form.get('fechaNac')	
		dateFechaNac = '1900-01-01'
		if(fechaNac != None ): dateFechaNac = datetime.datetime.strptime(fechaNac, "%d/%m/%Y").strftime("%Y-%m-%d")
		id_carrera = request.form.get('id_carrera')
		seccion = request.form.get('seccion')
		correo = request.form.get('correo')
		direccion = request.form.get('direccion')
		telefono = request.form.get('telefono')
		conn = mysql.connect()
		cursor = conn.cursor()
		cursor.execute("SELECT * FROM estudiante WHERE cedula='"+cedula+"'")
		data = cursor.fetchall()
		if(len(data) > 0):
			cursor.execute("SELECT * FROM cursa WHERE cedula='"+cedula+"' AND periodo_id='"+session['ano_esc']+"'")
			data = cursor.fetchall()
			if(len(data) == 0):
				cursor.execute("INSERT INTO cursa (cedula, periodo_id, carrera_id, seccion_actual, inasistencias) VALUES ('"+cedula+"', '"+session['ano_esc']+"','"+id_carrera+"','"+seccion+"','"+str(0)+"')")
		else:
			cursor.execute("INSERT INTO estudiante (cedula, nombres, apellidos, direccion, correo, numero_de_telefono, fecha_de_nacimiento) VALUES ('"+cedula+"','"+nombres+"','"+apellidos+"','"+direccion+"','"+correo+"','"+telefono+"','"+dateFechaNac+"')")

			cursor.execute("INSERT INTO cursa (cedula, periodo_id, carrera_id, seccion_actual, inasistencias) VALUES ('"+cedula+"', '"+session['ano_esc']+"','"+id_carrera+"','"+seccion+"','"+str(0)+"')")

		#Se debe validar antes si ese estudiante esta repetido
		conn.commit()

		return redirect(url_for('def_estudiantes'))




#--------FIN VISTA ESTUDIANTES--------#


# Al darle a seleccionar busco todos los anos y los mando al html
@app.route('/seleccionar')
def seleccion_ano():
	if(session.get('logged_in')):
		cursor = mysql.connect().cursor()
		cursor.execute("SELECT periodo_id, periodo_nombre from periodo WHERE eliminada='0'")
		data = cursor.fetchall()
		return render_template("escoger_ano.html", datos=data)


@app.route('/eliminar')
def eliminar_ano():
	if(session.get('logged_in')):
		cursor = mysql.connect().cursor()
		cursor.execute("SELECT periodo_id, periodo_nombre from periodo WHERE eliminada=0")
		data = cursor.fetchall()
		return render_template("eliminar_ano.html", datos=data)	


@app.route('/eliminar_ano', methods=['POST'])
def eliminar_anos():
	if(session.get('logged_in')):
		real_id = request.form['real_id']
		ano = request.form['ano_escolar']
		conn = mysql.connect()
		cursor = conn.cursor()
		cursor.execute("UPDATE periodo SET eliminada = 1 WHERE periodo_id=%s",(int(real_id)))
		conn.commit()
		return redirect(url_for('eliminar_ano'))


@app.route('/recuperar')
def recuperar_ano():
	if(session.get('logged_in')):
		cursor = mysql.connect().cursor()
		cursor.execute("SELECT periodo_id, periodo_nombre from periodo WHERE eliminada=1")
		data = cursor.fetchall()
		return render_template("recuperar_ano.html", datos=data)		


@app.route('/recuperar_ano', methods=['POST'])
def recuperar_anos():
	if(session.get('logged_in')):
		real_id = request.form['real_id']
		ano = request.form['ano_escolar']
		conn = mysql.connect()
		cursor = conn.cursor()
		cursor.execute("UPDATE periodo SET eliminada = 0 WHERE periodo_id=%s",(int(real_id)))
		conn.commit()
		return redirect(url_for('recuperar_ano'))

#-----------FUNCIONES DE CARGAR Y EXPORTAR BD---------#
@app.route('/exportarBD', methods=['GET'])
def exportarBD():
	if(session.get('logged_in')):
		password = 123
		os.system('mysqldump -u root -p%s don_bosco > database.sql' % password)
		return "Done!"


#-----------ENVIAR CORREO Y UPLOAD DE ARCHIVO---------#
@app.route('/test-mail')
def test_mail():
	return render_template("enviar_correo.html")	

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/send_mail', methods=['POST'])
def send_mail():
	if session.get('logged_in') and request.method == 'POST':
		print("ALGO AQUI")
		conn = mysql.connect()
		cursor = conn.cursor()
		receptores = []
		if(request.form['correos'] != None): receptores = request.form['correos'].split(',') #Puedo agregar mas con , 'otrocorreo@gmail.com' etc
		
		if(request.form['ResSec'] != ""):
			uniones = request.form['ResSec'].split(',')
			id_carreras = []
			secciones = []
			for union in uniones:
				lista = union.split('_')
				id_carreras.append(lista[0])
				if(lista[1] == '1'): secciones.append('A')
				elif(lista[1] == '2'): secciones.append('B')
				elif(lista[1] == '3'): secciones.append('C')
				elif(lista[1] == '4'): secciones.append('D')
				elif(lista[1] == '5'): secciones.append('E')
				else: secciones.append('F')

			for i in range(0, len(id_carreras)):
				cursor.execute("SELECT estudiante.correo FROM (SELECT cedula FROM cursa WHERE carrera_id='"+id_carreras[i]+"' AND periodo_id='"+session['ano_esc']+"' AND seccion_actual='"+secciones[i]+"') estudiante_cursando, estudiante WHERE estudiante_cursando.cedula=estudiante.cedula ")
				correos = cursor.fetchall()
				for correo in correos: receptores.append(correo[0])

		
		# if user does not select file, browser also
		# submit a empty part without filename
		titulo = request.form['asunto']
		body = request.form['Mensaje']
		msg = Message(
	              titulo, #Asunto
		       sender='escuelatecnicadonbosco@gmail.com', #Emisor
		       bcc=receptores) #Receptor/es
		msg.body = body #El body del mensaje en caso de no soportar html
		if (request.files['filetype'] != None): 
			file = request.files['filetype']
			if file.filename != '':
				if file and allowed_file(file.filename):
					filename = secure_filename(file.filename)
					file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
					with app.open_resource('upload/' + filename) as fp:
						msg.attach(filename, "application/x-rar-compressed", fp.read()) #El attachment si hay
					ruta_trabajo = os.getcwd()
					os.remove(ruta_trabajo + '/upload/' + filename)
		msg.html = render_template("correo_template.htm", body=body, titulo=titulo)
		mail.send(msg)
		
		# Luego de enviar el correo actualizo la tabla de correos enviados
		receptores = [x.strip(' ') for x in receptores] #Le quito los espacios a los elementos

		sql='SELECT correo FROM correo_enviado WHERE correo IN (%s)' 
		in_p=', '.join(list(map(lambda x: '%s', receptores)))
		sql = sql % in_p
		cursor.execute(sql, receptores)
		lista_correos = cursor.fetchall()
		correos_usados = []
		for correo in lista_correos: 
			correo_sin_espacio = correo[0].replace(' ','')
			correos_usados.append(correo_sin_espacio)

		correos_a_insertar = list(set(receptores).difference(correos_usados))
		correos_a_insertar = [x.strip(' ') for x in correos_a_insertar] #Le quito los espacios a los elementos

		for correo in correos_a_insertar: cursor.execute("INSERT INTO correo_enviado (correo) VALUES (%s)", (correo))
		conn.commit()

		return redirect(url_for('enviar_correo'))

@app.route('/enviar_correo', methods=['GET', 'POST'])
def enviar_correo():
	if session['ano_esc'] != None:

		# Busco los correos enviados y lo guardo en un arreglo
		cursor = mysql.connect().cursor()
		cursor.execute("SELECT correo FROM correo_enviado")
		correos = cursor.fetchall()
		correos_enviados = []
		for correo in correos: correos_enviados.append(correo[0])
		
		# Busco las secciones y creo un json asociado
		cursor.execute("SELECT cantidad FROM seccion WHERE periodo_id=%s", (session['ano_esc']))
		cantidad_sec = cursor.fetchall()

		listado_secciones = {}
		for i in range(0, 12): listado_secciones.update({str(i+1):cantidad_sec[i][0]})

		return render_template("enviar_correo.html", Array = correos_enviados, Datos= listado_secciones)
	else:
		print("Error no selecciono periodo escolar!")
		return render_template("ano_escolar.html")


if __name__ == "__main__":
	app.run(debug=True, port=3000)