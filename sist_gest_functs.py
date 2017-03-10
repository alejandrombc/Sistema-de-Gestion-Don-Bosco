# encoding=utf-8
from flask import render_template, request, url_for, redirect, session, g,  json
import hashlib

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