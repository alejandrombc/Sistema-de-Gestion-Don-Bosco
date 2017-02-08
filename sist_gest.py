# encoding=utf-8
from flask import Flask, render_template, request, url_for, redirect, session, g,  json
from flaskext.mysql import MySQL
import hashlib
import datetime

app = Flask(__name__)
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
# app.config['MYSQL_DATABASE_PASSWORD'] = '123'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'don_bosco'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

app.secret_key = "Estodeberiaserandom"

@app.route('/', methods=['GET','POST'])
def index():
	error = None
	if request.method == 'POST':
		hashinput_user = hashlib.sha256(str(request.form['username']).encode('utf-8')).hexdigest() #Le hice encriptacion sha256
		hashinput_password = hashlib.sha256(str(request.form['password']).encode('utf-8')).hexdigest() #Le hice encriptacion sha256
		#Si entra un usuario comun
		print (hashinput_password)
		if ("b20b0f63ce2ed361e8845d6bf2e59811aaa06ec96bcdb92f9bc0c5a25e83c9a6" != hashinput_user) or ("a280f9c1266fc6a4aea482b8206f367bbd96a76a075140cd67ef4e92c01e3142" != hashinput_password) :
			error = "Usuario o contraseña erróneos. Por favor, intente de nuevo."
		else:
			session['logged_in'] = request.form['username']
			session['ano_esc'] = None
			return redirect(url_for('seleccionar'))

	return render_template("index.html", err=error)

@app.route('/seleccion')
def seleccionar():
	if session.get('logged_in'):
		session.pop('logged_in',None)
		return render_template("ano_escolar.html")
	else:
		return redirect(url_for('index'))

@app.route('/agregar', methods=['GET','POST'])
def agregar():
	if request.method == 'POST': 
		inicio = request.form['inicial']
		final = request.form['final']
		ano = inicio + "-" + final
		con = mysql.connect()
		cursor = con.cursor()
		cursor.execute("SELECT * from anos_escolares WHERE inicial=%s AND final=%s", (inicio,final))
		data = cursor.fetchone()

		if(data != None):
			error="Error: Ese año esta repetido, por favor seleccionelo o eliminelo."
			return render_template("agregar_ano.html", error=error)

		if (inicio[0] == '2') and (inicio[1] == '0') and (final[0] == '2') and (final[1] == '0') and (len(final)==4) and (len(inicio)==4) and (final > inicio):
			cursor.execute("""INSERT INTO anos_escolares (inicial, final, eliminada) VALUES (%s, %s, '0')""", (inicio,final))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('cuarto', 'Tecnología Gráfica', %s, '1', '0')""", (ano))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('cuarto', 'contabilidad', %s, '1', '0')""", (ano))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('cuarto', 'mecanica', %s, '1', '0')""", (ano))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('cuarto', 'electronica', %s, '1', '0')""", (ano))

			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('quinto', 'Tecnología Gráfica', %s, '1', '0')""", (ano))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('quinto', 'contabilidad', %s, '1', '0')""", (ano))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('quinto', 'mecanica', %s,'1', '0')""", (ano))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('quinto', 'electronica', %s, '1', '0')""", (ano))

			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('sexto', 'Tecnología Gráfica', %s, '1', '0')""", (ano))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('sexto', 'contabilidad', %s, '1', '0')""", (ano))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('sexto', 'mecanica', %s, '1', '0')""", (ano))
			cursor.execute("""INSERT INTO secciones ( ano, curso, ano_escolar, secciones, eliminada ) VALUES ('sexto', 'electronica', %s, '1', '0')""", (ano))
			con.commit()
			session['logged_in'] = "newform" 
			return redirect(url_for('seleccionar'))
		else:
			error="Error: Año invalido"
			return render_template("agregar_ano.html", error=error)
	else:
		return render_template("agregar_ano.html")


#--------VISTA ESTUDIANTES--------#

@app.route('/estudiantes_ano', methods=['GET', 'POST'])
def def_estudiantes():
	# Aqui va el g con el ano escolar
	if request.method == 'POST': 
		if request.form['ano'] != None: session['ano_esc'] = request.form['ano']
		cursor = mysql.connect().cursor()
		
		cursor.execute("SELECT * from estudiante WHERE curso='Tecnología Gráfica' AND ano=4 AND periodo_lectivo='"+request.form['ano']+"' ")
		data = cursor.fetchall()

		cursor.execute("SELECT secciones from secciones WHERE curso='Tecnología Gráfica' AND ano=4 AND ano_escolar=%s", (session['ano_esc']))
		secciones = cursor.fetchall()
		
		cant_secciones = int(secciones[0][0])
		print(cant_secciones)

		#Falta validar si la data es null o alguna excepcion
	return render_template("estudiantes.html", datos=data, cant_secciones=cant_secciones )


@app.route('/estudiantes_escoger_ano', methods=['GET'])
def escoger_ano_estudiantes():
	cursor = mysql.connect().cursor()
	curso_actual = request.args['curso']
	
	if curso_actual == 'TecnologiaGrafica':
		curso_actual = 'Tecnología Gráfica'
	
	if request.args['ano'] == "4to":
		cursor.execute("SELECT secciones from secciones WHERE curso=%s AND ano=4 AND ano_escolar=%s", (curso_actual, session['ano_esc']))
		secciones = cursor.fetchall()
		cursor.execute("SELECT * from estudiante WHERE curso=%s AND ano=4 AND periodo_lectivo=%s", (curso_actual, session['ano_esc']))
	elif request.args['ano'] == "5to":
		cursor.execute("SELECT secciones from secciones WHERE curso=%s AND ano=5 AND ano_escolar=%s", (curso_actual, session['ano_esc']))
		secciones = cursor.fetchall()
		cursor.execute("SELECT * from estudiante WHERE curso=%s AND ano=5 AND periodo_lectivo=%s", (curso_actual, session['ano_esc']))
	else:
		cursor.execute("SELECT secciones from secciones WHERE curso=%s AND ano=6 AND ano_escolar=%s", (curso_actual, session['ano_esc']))
		secciones = cursor.fetchall()
		cursor.execute("SELECT * from estudiante WHERE curso=%s AND ano=6 AND periodo_lectivo=%s", (curso_actual, session['ano_esc']))
		
	lista = list(cursor.fetchall())
	tupla = []
	lista2 = []

	# print(lista)

	for campo in lista:
		tupla = []
		for i in range(0,len(campo)):
			if (i==4):
				print( campo[i] )
				fecha =  campo[i]
				tupla.append( campo[i].strftime("%d/%m/%y") ) 
			else:
				tupla.append( campo[i] )
		tupla = tuple(tupla)
		lista2.append(tupla)

	print(lista2)

	# data = json.dumps(lista)
	data = json.dumps(lista2)
	print (data)
	return '{} {}'.format(secciones[0][0], data)


@app.route('/agregarInasistencia', methods=['PUT'])
def agregarInasistencia():
	conn = mysql.connect()
	cursor = conn.cursor()
	resultado = request.args['resultado']
	arreglo = resultado.split("-")
	inasistencias = int(arreglo[1])
	
	cursor.execute("UPDATE estudiante SET inasistencias=%s WHERE periodo_lectivo=%s AND cedula=%s", (inasistencias, session['ano_esc'], arreglo[0]))
	conn.commit()

	return ""

@app.route('/eliminarEstudiante', methods=['DELETE'])
def eliminarEstudiante():
	conn = mysql.connect()
	cursor = conn.cursor()
	idStudent = request.args['id']
	
	cursor.execute("DELETE FROM estudiante WHERE periodo_lectivo=%s AND cedula=%s", (session['ano_esc'], idStudent))
	conn.commit()

	return ""

@app.route('/eliminarSeccion', methods=['DELETE'])
def eliminarSeccion():
	
	# Se tiene que disminuir en uno la cantidad de secciones dentro de la tabla Secciones, en el caso de que el numero sea cero se borra de la BD ese registro
	# Se tienen que eliminar a todos los estudiantes de la seccion. 
	# Los argumentos que tengo que pasarle son: año (cuarto, quinto, sexto), curso, lista de cedulas de los estudiantes

	print('=================================================================================================')

	

	curso_actual = request.args['curso']
	ano = request.args['ano'] 

	if curso_actual == 'TecnologiaGrafica':
		curso_actual = 'Tecnología Gráfica'

	cedulas = request.args['cedulas'].split(",")


	print( curso_actual )
	print( ano )
	print( cedulas )

	#Revisar si el numero de secciones es mayor a 1
	cursor = mysql.connect().cursor()
		
	cursor.execute("SELECT secciones from secciones WHERE ano_escolar=%s AND ano=%s AND curso=%s", (session['ano_esc'], ano, curso_actual ) )
	data = cursor.fetchall()
	cant_secciones = int(data[0][0])

	print(cant_secciones)


	conn = mysql.connect()
	cursor = conn.cursor()

	if cant_secciones == 1:
		#se borra el registro
		cursor.execute("DELETE FROM secciones WHERE ano_escolar=%s AND ano=%s AND curso=%s", (session['ano_esc'], ano, curso_actual ) )
	else:
		#se decrementa el numero de secciones
		cant_secciones -= 1
		cursor.execute("UPDATE secciones SET secciones=%s WHERE ano_escolar=%s AND ano=%s AND curso=%s", (cant_secciones, session['ano_esc'], ano, curso_actual ) )
		#Al hacer esto de arriba y actualizar si borre seccion A, seguira saliendo A y B por ejemplo.. pero se supone q solo se podra borrar la ultima seccion

	#Borrar estudiantes pertenecientes a ese periodo-curso-ano
	for cedula in cedulas:
		print(cedula)
		cursor.execute("DELETE FROM estudiante WHERE periodo_lectivo=%s AND cedula=%s AND curso=%s AND ano=%s", (session['ano_esc'], cedula, curso_actual, ano))
		
	conn.commit()



	print('=================================================================================================')

	return ""





#--------FIN VISTA ESTUDIANTES--------#


# Al darle a seleccionar busco todos los anos y los mando al html
@app.route('/seleccionar')
def seleccion_ano():
	cursor = mysql.connect().cursor()
	cursor.execute("SELECT * from anos_escolares WHERE eliminada='0'")
	data = cursor.fetchall()
	return render_template("escoger_ano.html", datos=data)


@app.route('/eliminar')
def eliminar_ano():
	cursor = mysql.connect().cursor()
	cursor.execute("SELECT * from anos_escolares WHERE eliminada='0'")
	data = cursor.fetchall()
	return render_template("eliminar_ano.html", datos=data)	


@app.route('/eliminar_ano', methods=['POST'])
def eliminar_anos():
	real_id = request.form['real_id']
	ano = request.form['ano_escolar']
	conn = mysql.connect()
	cursor = conn.cursor()
	cursor.execute("UPDATE anos_escolares SET eliminada = 1 WHERE ID=%s",(int(real_id)))
	cursor.execute("UPDATE secciones SET eliminada = '1' WHERE ano_escolar=%s",(ano))
	conn.commit()
	return redirect(url_for('eliminar_ano'))


@app.route('/recuperar')
def recuperar_ano():
	cursor = mysql.connect().cursor()
	cursor.execute("SELECT * from anos_escolares WHERE eliminada='1'")
	data = cursor.fetchall()
	return render_template("recuperar_ano.html", datos=data)		


@app.route('/recuperar_ano', methods=['POST'])
def recuperar_anos():
	real_id = request.form['real_id']
	ano = request.form['ano_escolar']
	conn = mysql.connect()
	cursor = conn.cursor()
	cursor.execute("UPDATE anos_escolares SET eliminada = 0 WHERE ID=%s",(int(real_id)))
	cursor.execute("UPDATE secciones SET eliminada = '0' WHERE ano_escolar=%s",(ano))
	conn.commit()
	return redirect(url_for('recuperar_ano'))


@app.route('/agregar_seccion', methods=['GET', 'POST'])
def seccion():
	if request.method == 'POST'and session['ano_esc'] != None:
		ano = request.form.get('ano')
		curso = request.form.get('curso')
		conn = mysql.connect()
		cursor = conn.cursor()
		cursor.execute("SELECT secciones from secciones WHERE curso=%s AND ano=%s AND ano_escolar=%s", (curso, ano, session['ano_esc']))
		data = cursor.fetchone()
		nueva_seccion = int(data[0]) + 1;
		query = "UPDATE secciones SET secciones='"+str(nueva_seccion)+"' WHERE curso='"+curso+"' AND ano='"+ano+"' AND ano_escolar='"+session['ano_esc']+"'"
		print(query)
		cursor.execute(query)
		conn.commit()
		return redirect(url_for('def_estudiantes'))
	return render_template("agregar_seccion.html")

@app.route('/anadirEstudiante', methods=['GET', 'POST'])
def anadirEstudiante():
	return render_template("estudiante_individual.html")	

@app.route('/registrarEstudiante', methods=['GET', 'POST'])
def registrarEstudiante():
	nombres = request.form.get('nombres')
	apellidos  = request.form.get('apellidos')	
	cedula = request.form.get('cedula')
	fechaNac = request.form.get('fechaNac')	
	dateFechaNac = datetime.datetime.strptime(fechaNac, "%d/%m/%Y").strftime("%Y-%m-%d")
	curso = request.form.get('curso')	
	ano = request.form.get('ano')
	anoInt = 4
	if ano == '5to':
		anoInt = 5
	if ano == '6to':
		anoInt = 6
	periodo = '2016-2017'
	seccion = request.form.get('seccion')
	correo = request.form.get('correo')
	direccion = request.form.get('direccion')
	telefono = request.form.get('telefono')
	query = "INSERT INTO estudiante (nombres, apellidos, fecha_nacimiento, cedula, telefono, email, direccion, ano, seccion, periodo_lectivo, curso) VALUES ('"+nombres+"', '"+apellidos+"','"+dateFechaNac+"',"+str(cedula)+",'"+telefono+"','"+correo+"','"+direccion+"',"+str(anoInt)+",'"+seccion+"','"+periodo+"','"+curso+"')"
	conn = mysql.connect()
	cursor = conn.cursor()
	cursor.execute(query) 
	#Se debe validar antes si ese estudiante esta repetido
	conn.commit()
		
	cursor.execute("SELECT * from estudiante WHERE curso='"+curso+"' AND ano="+str(anoInt)+" AND periodo_lectivo='"+periodo+"' ")
	data = cursor.fetchall()

	cursor.execute("SELECT secciones from secciones WHERE curso='"+curso+"' AND ano="+str(anoInt)+" AND ano_escolar='"+periodo+"'")
	secciones = cursor.fetchall()
	
	cant_secciones = int(secciones[0][0])
	print(cant_secciones)

	return render_template("estudiantes.html", datos=data, cant_secciones=cant_secciones )


if __name__ == "__main__":
	app.run(debug=True, host='127.0.0.1', port=3000)


#====ACOTACION====#
# Se deberia tener una opcion para eliminar a todos los estudiantes de algun periodo especifico DE LA BD, ya que con el tiempo se vovleria muy lento por la cantidad de registros.