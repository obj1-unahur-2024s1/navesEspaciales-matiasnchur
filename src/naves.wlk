class NaveEspacial {
	var velocidad = 0
	
	var direccion = 0
	
	/* Controlo que la velocidad tiene un tope y no puede ser negativa */
	method acelerar(cuanto){
		velocidad = 100000.min(velocidad + cuanto)
		//velocidad = (velocidad + cuanto).min(100000)
	}
	
	method desacelerar(cuanto){
		velocidad = 0.max(velocidad - cuanto)
		//velocidad = (velocidad - cuanto).max(0)
	}
	
	method irHaciaElSol(){
		direccion = 10
	}
	
	method escaparDelSol(){
		direccion = -10
	}
	
	method ponerseParaleloAlSol(){
		direccion = 0
	}
	
	method acercarseUnPocoAlSol(){
		direccion = 10.min(direccion + 1)
	}
	
	method alejarseUnPocoDelSol(){
		direccion = -10.max(direccion - 1)
	}
	
}

class NaveBaliza inherits NaveEspacial{
	var colorBaliza
	
	method cambiarColorDeBaliza(colorNuevo){
		colorBaliza = colorNuevo
	}
	
	method prepararViaje(){
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
}

class NaveDePasajeros inherits NaveEspacial{
	const cantidadDePasajeros
	var racionesDeComida = 0
	var racionesDeBebida = 0 
	
	method cargarComida(cuanto){
		racionesDeComida += cuanto
	}
	
	method cargarBebida(cuanto){
		racionesDeBebida += cuanto
	}
	
	method descargarComida(cuanto){
		racionesDeComida = 0.max(racionesDeComida - cuanto)
	}
	
	method descargarBebida(cuanto){
		racionesDeBebida = 0.max(racionesDeBebida - cuanto)
	}
	
	method prepararViaje(){
		self.cargarComida(4 * cantidadDePasajeros)
		self.cargarBebida(6 * cantidadDePasajeros)
		self.acercarseUnPocoAlSol()
	}
}

class NaveDeCombate inherits NaveEspacial {
	var estaVisible = true
	var misilesDesplegados = false
	const mensajes = []
	
	method ponerseVisible(){
		estaVisible = true
	}
	
	method ponerseInvisible(){
		estaVisible = false
	}
	
	method estaInvisible(){
		return not estaVisible 
	}
	
	method desplegarMisiles(){
		misilesDesplegados = true
	}
	
	method replegarMisiles(){
		misilesDesplegados = false
	}
	
	method misilesDesplegados(){
		return misilesDesplegados 
	}
	
	method emitirMensaje(mensaje){
		mensajes.add(mensaje)
	}
	
	method mensajesEmitidos(){
		return mensajes.size()
	}
	
	method primerMensajeEmitido(){
		return mensajes.first()
	}
	
	method ultimoMensajeEmitido(){
		return mensajes.last()
	}
	
	method esEscueta(){
		mensajes.all({m => m.size() <= 30})
		//not mensajes.any({m => m.size() > 30})
	}
	
	method emitioMensaje(mensaje){
		mensajes.contains(mensaje)
	}
	
	method prepararViaje(){
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
	}
	
}
