from flask import Flask, render_template, request, url_for, redirect, session
from flaskext.mysql import MySQL
import hashlib

app = Flask(__name__)
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = '123'
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
			error = "Usuario o contraseña erroneos. Porfavor, intente de nuevo."
		else:
			session['logged_in'] = request.form['username']
			return redirect(url_for('seleccionar'))

	return render_template("index.html", err=error)

@app.route('/conectar')
def users():
	cursor = mysql.connect().cursor()
	cursor.execute("SELECT * from prueba")
	data = str(cursor.fetchone())
	return (data)

@app.route('/seleccion')
def seleccionar():
	if session.get('logged_in'):
		session.pop('logged_in',None)
		return render_template("ano_escolar.html")
	else:
		return redirect(url_for('index'))

# FALTA HACER UN ALERT PARA CONFIRMAR!
@app.route('/agregar')
def agregar(): 
	return render_template("agregar_ano.html")


#Cuando agrego un ano llamo a este enlace para guardarlo en la BD
@app.route('/agregar_post', methods=['POST'])
def agregarpost():
	inicio = request.form['inicial']
	final = request.form['final']
	con = mysql.connect()
	cursor = con.cursor()
	cursor.execute("""INSERT INTO anos_escolares (inicial, final) VALUES (%s, %s)""", (inicio,final))
	con.commit()
	session['logged_in'] = "newform" 
	return redirect(url_for('seleccionar'))

# Al darle a seleccionar busco todos los anos y los mando al html
@app.route('/seleccionar')
def seleccion_ano():
	cursor = mysql.connect().cursor()
	cursor.execute("SELECT * from anos_escolares")
	data = cursor.fetchall()
	print(data[0][1])
	return render_template("escoger_ano.html", datos=data)



if __name__ == "__main__":
	app.run(debug=True, host="192.168.0.108", port=80)