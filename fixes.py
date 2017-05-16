# Fix 1. Colocando join sist_gest_functs

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
				basedir = os.path.abspath(os.path.dirname(__file__))
				file.save(os.path.join(basedir, app.config['UPLOAD_FOLDER'], filename))		
				print(filename)		
				with app.open_resource(app.config['UPLOAD_FOLDER'] +"/"+ filename) as fp:
					msg.attach(app.config['UPLOAD_FOLDER'] +"/"+ filename, "application/x-rar-compressed", fp.read()) #El attachment si hay
				ruta_trabajo = os.getcwd()
				os.remove(app.config['UPLOAD_FOLDER'] +"/"+ filename)
	msg.html = render_template("correo_template.htm", body=body, titulo=titulo)
	mail.send(msg)

# Fix 2. Colocar ruta actual y borrar upload/ config_vars

UPLOAD_FOLDER = '.'

# Fix 3. Colocar / al final de upload config_vars

UPLOAD_FOLDER = 'upload/'

