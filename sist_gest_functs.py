# encoding=utf-8
import consultas
from sist_gest import app, mysql
from flask import render_template, request, url_for, redirect, session, g,  json
from flaskext.mysql import MySQL
from flask_mail import Mail, Message #pip install Flask-Mail
from werkzeug.utils import secure_filename
import hashlib
import datetime, os
import MySQLdb as db


#Para el UPLOAD de archivos en el servidor 
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif','rar', 'zip'])

########################################################################
#						  Funciones del main                           #
#																	   #
########################################################################

#Recibe argumento variado, en caso de ser POST recibe usuario y clave, sino solo retorna los valores del template
def index_funct(*args):
	bad_user = None
	if len(args) > 0:
		hashinput_user = hashlib.sha256(str(args[0]).encode('utf-8')).hexdigest() #Le hice encriptacion sha256
		hashinput_password = hashlib.sha256(str(args[1]).encode('utf-8')).hexdigest() #Le hice encriptacion sha256
		#Si entra un usuario comun
		if ("b20b0f63ce2ed361e8845d6bf2e59811aaa06ec96bcdb92f9bc0c5a25e83c9a6" != hashinput_user) or ("a280f9c1266fc6a4aea482b8206f367bbd96a76a075140cd67ef4e92c01e3142" != hashinput_password) :
			bad_user = "Usuario o contraseña erróneos. Por favor, intente de nuevo.";
		else:
			args[2]['logged_in'] = args[0] 
			args[2]['ano_esc'] = None
			return redirect(url_for('seleccionar'))
	return render_template("index.html", err=bad_user)

#Funcion que retorna la pantalla principal despues de logeo (tambien elimina la sesion)
def selec_funct(session):
	if session.get('logged_in'):
		return render_template("ano_escolar.html")
	else:
		return redirect(url_for('index'))

#Agregar nuevo ano escolar
def agregar_funct(inicio, final, conn, session):

	ano = inicio + "-" + final
	cursor = conn.cursor()
	consultas.select_periodo(ano, cursor)
	data = cursor.fetchone()

	if(data != None):
		error="Error: Ese año esta repetido, por favor seleccionelo o eliminelo."
		return render_template("agregar_ano.html", error=error)

	if (inicio[0] == '2') and (inicio[1] == '0') and (final[0] == '2') and (final[1] == '0') and (len(final)==4) and (len(inicio)==4) and (final > inicio):
		consultas.insert_periodo(ano, cursor)
		conn.commit()
		consultas.select_periodo(cursor)
		ID = cursor.fetchone()
		ID = ID[0]
		for i in range(1,13):
			consultas.insert_seccion(i, ID, cursor)
		conn.commit()
		session['logged_in'] = "newform" 
		return redirect(url_for('seleccionar'))
	else:
		error="Error: Año invalido"
		return render_template("agregar_ano.html", error=error)

#-------PERSONAL-------#

#Def Personal
def personal_funct(cursor):
	
	consultas.select_personal(session, cursor)
	data = cursor.fetchall()

	return render_template("personal.html", datos=data)

#Escoger Personal
def escoger_tipo_personal_funct(cursor, id_tipo):

	consultas.select_personal(id_tipo, session, cursor)
	
	data = cursor.fetchall()

	data = json.dumps(data)
	return data

#Agregar Inasistencias
def agregarInasistenciaPersonal_funct(conn, resultado):

	cursor = conn.cursor()
	arreglo = resultado.split("-")
	inasistencias = int(arreglo[1])
	consultas.update_trabaja(inasistencias, arreglo, session, cursor)
	conn.commit()

	return ""

#Eliminar Personal
def eliminarPersonal_funct(conn, idPersonal, session):
		
	cursor = conn.cursor()
	consultas.delete_personal(session, idPersonal, cursor)
	conn.commit()

	return ""

#Get Personal
def getPersonal_funct(cursor):

	consultas.select_personal_get(request, session, cursor)
	personal = cursor.fetchall()
	data = json.dumps(personal)

	return '{}'.format(data)

#Editar Personal
def editarPersonal_funct(conn, apellidos, hiddenCedula, cedula, nombres, telefono, tipo, inasistencia, direccion, email):

	cursor = conn.cursor()
	cursor.execute("SET FOREIGN_KEY_CHECKS=0;")

	#Se actualizan los datos ingresados 
	consultas.update_personal(apellidos, hiddenCedula, cedula, nombres, telefono, direccion, email, cursor)

	#Se actualiza los datos de la tabla trabaja
	consultas.update_trabaja(cedula, tipo, inasistencia, hiddenCedula, session, cursor)
	conn.commit()

	cursor.execute("SET FOREIGN_KEY_CHECKS=1;")
	conn.commit()

	return redirect(url_for('personal'))

#Buscar Personal
def buscarPersonal_funct(busqueda, cursor):

	if (busqueda != ""):
		consultas.select_personal_like(busqueda, cursor)
		personal = cursor.fetchall()
		if(personal != () ):
			hayResultado = 1
		else:
			hayResultado = 0
	else:
		hayResultado = 0
		personal = ""  
	return render_template("resultado_busqueda_personal.html", datos=personal, hayResultado=hayResultado)

def registrarPersonal_funct(nombres, apellidos, cedula, id_tipo, correo, direccion, telefono, conn):
	
	cursor = conn.cursor()
	consultas.select_personal_where(cedula, cursor)
	data = cursor.fetchall()
	if(len(data) > 0):
		consultas.select_trabaja(cedula, session, cursor)
		data = cursor.fetchall()
		if(len(data) == 0):
			consultas.insert_trabaja(cedula, session, id_tipo, cursor)
	else:
		consultas.insert_personal(cedula, nombres, apellidos, direccion, correo, telefono, cursor)

		consultas.insert_trabaja(cedula, session, id_tipo, cursor)

	#Se debe validar antes si ese estudiante esta repetido
	conn.commit()

	return redirect(url_for('personal'))

#-------ESTUDIANTES-------#

#Def Estudiantes
def def_estudiantes_funct(cursor):
	
	consultas.select_estudiante(session, cursor)
	data = cursor.fetchall()

	consultas.select_cantidad(session, cursor)
	secciones = cursor.fetchall()
	cant_secciones = int(secciones[0][0])

	return render_template("estudiantes.html", datos=data, cant_secciones=cant_secciones )

#Escoger ano
def escoger_ano_estudiantes_funct(cursor, id_carrera):

	consultas.select_estudiante(id_carrera, session, cursor)
	data = cursor.fetchall()

	consultas.select_cantidad(id_carrera, session, cursor)
	secciones = cursor.fetchall()

	cant_secciones = int(secciones[0][0])

	data = json.dumps(data)
	return '{} {}'.format(cant_secciones, data)

#Agregar Inasistencia
def agregarInasistencia_funct(conn, resultado):
	
	cursor = conn.cursor()
	arreglo = resultado.split("-")
	inasistencias = int(arreglo[1])
	consultas.update_cursa(inasistencias, arreglo, session, cursor)
	conn.commit()

	return ""

#Eliminar estudiante
def eliminarEstudiante_funct(conn, idStudent, session):
	
	cursor = conn.cursor()
	consultas.delete_cursa(idStudent, session, cursor)
	conn.commit()

	return ""

#Eliminar Seccion
def eliminarSeccion_funct(id_carrera, cedulas, conn, session):
	cursor = conn.cursor()
	consultas.select_cantidad(id_carrera, session, cursor)
	secciones = cursor.fetchall()

	cant_secciones = int(secciones[0][0])
	
	cant_secciones -= 1 #Se decrementa el numero de secciones
	#Actualizo cantidad de secciones
	consultas.update_seccion(cant_secciones, id_carrera, session, cursor)
	
	#Borrar estudiantes pertenecientes a ese periodo-curso-ano
	for cedula in cedulas:
		consultas.delete_cursa(cedula, session, cursor)
		
	conn.commit()
	return ""

#Editar Estudiantes
def editar_estudiantes_funct(conn, apellidos, hiddenCedula, seccion, cedula, nombres, telefono, id_carrera, inasistencia, direccion, email, nombresPadre, telefonoPadre, emailPadre):
	
	cursor = conn.cursor()
	cursor.execute("SET FOREIGN_KEY_CHECKS=0;")

	#Se actualizan los datos ingresados 
	consultas.update_estudiante(apellidos, hiddenCedula, cedula, nombres, telefono, inasistencia, direccion, email, nombresPadre, telefonoPadre, emailPadre, cursor)

	#Se actualiza los datos de la tabla cursa
	consultas.update_cursa(hiddenCedula, seccion, cedula, id_carrera, inasistencia, session, cursor)
	conn.commit()

	cursor.execute("SET FOREIGN_KEY_CHECKS=1;")
	conn.commit()

	#Falta validar si la data es null o alguna excepcion
	return redirect(url_for('def_estudiantes'))
	

#Seccion
def seccion_funct(id_carrera, conn):

	cursor = conn.cursor()
	consultas.update_seccion(id_carrera, session, cursor)
	conn.commit()
	return redirect(url_for('def_estudiantes'))

#Cantidad de Secciones
def getCantidadSecciones_funct(cursor, id_carrera):
	consultas.select_cantidad(id_carrera, session, cursor)
	secciones = cursor.fetchall()

	cant_secciones = int(secciones[0][0])
	return '{}'.format(cant_secciones)

#Buscar Estudiante
def buscarEstudiante_funct(busqueda, cursor):

	if (busqueda != ""):
		consultas.select_estudiante_where(busqueda, cursor)
		estudiantes = cursor.fetchall()
		if(estudiantes != () ):
			hayResultado = 1
		else:
			hayResultado = 0
	else:
		hayResultado = 0
		estudiantes = ""

	return render_template("resultado_busqueda_estudiante.html", datos=estudiantes, hayResultado=hayResultado)

#Obtener Estudiante
def getEstudiante_funct(cursor):
	consultas.select_estudiante_get(request, session, cursor)
	estudiante = cursor.fetchall()
	data = json.dumps(estudiante)

	return '{}'.format(data)

#Registrar Estudiante
def registrarEstudiante_funct(nombres, apellidos, cedula, fechaNac, dateFechaNac, id_carrera, seccion, correo, direccion, telefono, nombresPadre, telefonoPadre, emailPadre, conn):
	if(fechaNac != None ): dateFechaNac = datetime.datetime.strptime(fechaNac, "%d/%m/%Y").strftime("%Y-%m-%d")
	cursor = conn.cursor()
	consultas.select_estudiante_where_CI(cedula, cursor)
	data = cursor.fetchall()
	if(len(data) > 0):
		consultas.select_cursa(cedula, session, cursor)
		data = cursor.fetchall()
		if(len(data) == 0):
			consultas.insert_cursa(cedula, session, id_carrera, seccion, cursor)
	else:
		consultas.insert_estudiante(nombres, apellidos, cedula, dateFechaNac, correo, direccion, telefono, nombresPadre, telefonoPadre, emailPadre, cursor)
		
		consultas.insert_cursa(cedula, session, id_carrera, seccion, cursor)

	#Se debe validar antes si ese estudiante esta repetido
	conn.commit()

	return redirect(url_for('def_estudiantes'))

#------Fin Estudiantes------#

#Seleccionar ano
def seleccion_ano_funct(cursor):
	consultas.select_periodo_ano(cursor)
	data = cursor.fetchall()
	return render_template("escoger_ano.html", datos=data)

#Eliminar ano
def eliminar_ano_funct(cursor):
	consultas.delete_periodo(cursor)
	data = cursor.fetchall()
	return render_template("eliminar_ano.html", datos=data)

#Eliminar anos
def eliminar_anos_funct(real_id, ano, conn):
	cursor = conn.cursor()
	consultas.update_periodo_eliminar(real_id, cursor)
	conn.commit()
	return redirect(url_for('eliminar_ano'))

#Recuperar ano
def recuperar_ano_funct(cursor):
	consultas.select_periodo_recuperar(cursor)
	data = cursor.fetchall()
	return render_template("recuperar_ano.html", datos=data)

#Recuperar anos
def recuperar_anos_funct(real_id, ano, conn):
	cursor = conn.cursor()
	consultas.update_periodo_recuperar(real_id, cursor)
	conn.commit()
	return redirect(url_for('recuperar_ano'))

#-----------FUNCIONES DE CARGAR, EXPORTAR BD Y CERRAR---------#

#Exportar BD
def exportarBD_funct():
	#DEBE ESTAR EN EL PATH DE WINDOWS EL MYSQLDUMP
	password = 1234 #Clave de la BD
	os.system('mysqldump -u root -p%s don_bosco > BaseDeDatos_DonBosco.sql' % password)
	sucess = "¡Exportado realizado correctamente!"
	return render_template("configuracion.html", sucess=sucess)

#Run SQL
def run_sql_file_funct(filename, connection):
    sql = s = " ".join(filename.readlines())
    cursor = connection.cursor()
    cursor.execute(sql)    
    connection.commit()
    return True

#Cargar BD
def cargarBD_funct(file, conn):
	cursor = conn.cursor()
	cursor.execute("DROP DATABASE IF EXISTS don_bosco")
	cursor.execute("CREATE DATABASE don_bosco")

	filename = secure_filename(file.filename)
	file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
	conn = mysql.connect()
	filepath = "upload/"+file.filename 
	os.system('mysql -u root -p1234 don_bosco < '+filepath)
	ruta_trabajo = os.getcwd()
	sucess = "¡Cargado realizado correctamente!"
	os.remove(ruta_trabajo + '/upload/' + filename)

	return render_template("configuracion.html", sucess=sucess)

#-----------ENVIAR CORREO Y UPLOAD DE ARCHIVO---------#

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

#Enviar Correo
def send_mail_funct(conn, request, titulo, body, app, mail):
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
			cursor.execute("SELECT estudiante.correo, estudiante.correo_representante FROM (SELECT cedula FROM cursa WHERE carrera_id='"+id_carreras[i]+"' AND periodo_id='"+session['ano_esc']+"' AND seccion_actual='"+secciones[i]+"') estudiante_cursando, estudiante WHERE estudiante_cursando.cedula=estudiante.cedula ")
			correos = cursor.fetchall()
			for correo in correos: 
				receptores.append(correo[0]) #Estudiante
				receptores.append(correo[1]) #Representante

	
	# if user does not select file, browser also
	# submit a empty part without filename
	
	msg = Message(
	              titulo, #Asunto
		       sender='escuelatecnicadonbosco@gmail.com', #Emisor
		       bcc=receptores)
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

#Enviar Correo 2
def enviar_correo_funct(cursor):
	# Busco los correos enviados y lo guardo en un arreglo
	consultas.select_correo(cursor)
	correos = cursor.fetchall()
	correos_enviados = []
	for correo in correos: correos_enviados.append(correo[0])
	
	# Busco las secciones y creo un json asociado
	consultas.select_cantidad_correo(session, cursor)
	cantidad_sec = cursor.fetchall()

	listado_secciones = {}
	for i in range(0, 12): listado_secciones.update({str(i+1):cantidad_sec[i][0]})

	return render_template("enviar_correo.html", Array = correos_enviados, Datos= listado_secciones)

#Enviar Correo Personal
def enviar_correo_personal_funct(cursor):
	# Busco los correos enviados y lo guardo en un arreglo
	cursor.execute("SELECT correo FROM correo_enviado")
	correos = cursor.fetchall()
	correos_enviados = []
	for correo in correos: correos_enviados.append(correo[0])
	
	# Busco las secciones y creo un json asociado
	consultas.select_cantidad_correo(session, cursor)
	cantidad_sec = cursor.fetchall()

	listado_secciones = {}
	for i in range(0, 12): listado_secciones.update({str(i+1):cantidad_sec[i][0]})

	print(correos_enviados)
	print(listado_secciones)

	return render_template("enviar_correo_personal.html", Array = correos_enviados, Datos= listado_secciones)

def send_mail_personal_funct(conn, request, titulo, body, app, mail):
	cursor = conn.cursor()
	receptores = []

	print(request.form['correos'])
	if(request.form['correos'] != None): receptores = request.form['correos'].split(',') #Puedo agregar mas con , 'otrocorreo@gmail.com' etc
	

	if(request.form['ResSec'] != ""):
		tipos_personal = request.form['ResSec']

		tipos_personal = tipos_personal.split(",")
		N = len(tipos_personal)
		for x in range(0,N):
			tipos_personal[x] = int(tipos_personal[x])
		print(tipos_personal)
		
		format_strings = ','.join(['%s'] * len(tipos_personal))
		print(format_strings)
		consultas.select_correo(tipos_personal, cursor)
		correos = cursor.fetchall()
		print (correos)

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

	return redirect(url_for('enviar_correo_personal'))