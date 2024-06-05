class NaveEspacial {
	var velocidad = 0
	var direccion = 0
	var combustible = 0
	
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
	
	method cargarCombustible(cuanto){
		combustible += cuanto
	}
	
	method descargarCombustible(cuanto){
		combustible = 0.max(combustible - cuanto)
	}
	
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	
	method estaTranquila() {
		return combustible >= 4000 and velocidad < 1200 and self.condicionDeTranquilidad()
	}
	
	method condicionDeTranquilidad()
	
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	
	method escapar()
	
	method avisar()
	
	method estaDeRelajo(){
		return self.estaTranquila() and self.tienePocaActividad()
	}
	
	method tienePocaActividad()
}

class NaveBaliza inherits NaveEspacial{
	var colorBaliza = "azul"
	var cambioColorBaliza = false
	
	method cambiarColorDeBaliza(colorNuevo){
		colorBaliza = colorNuevo
		cambioColorBaliza = true
	}
	
	override method prepararViaje(){
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
	
	override method condicionDeTranquilidad() {
		return colorBaliza != "rojo"
	}
	
	override method escapar() {
		self.irHaciaElSol()
	}
	
	override method avisar() {
		self.cambiarColorDeBaliza("rojo")
	}
	
	override  method tienePocaActividad() {
		return not cambioColorBaliza
	}
}

class NaveDePasajeros inherits NaveEspacial{
	const cantidadDePasajeros
	var racionesDeComida = 0
	var racionesDeBebida = 0 
	var racionesDeComidasServidas = 0
	
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
	
	override method prepararViaje(){
		super()
		self.cargarComida(4 * cantidadDePasajeros)
		self.cargarBebida(6 * cantidadDePasajeros)
		self.acercarseUnPocoAlSol()
	}
	
	override method condicionDeTranquilidad() {
		return true
	}
	
	override method escapar() {
		self.acelerar(velocidad)
	}
	
	override method avisar() {
		self.servirComida(cantidadDePasajeros)
		self.descargarBebida(cantidadDePasajeros * 2)
	}
	
	method servirComida(cuanto){
		self.descargarComida(cuanto)
		racionesDeComidasServidas += cuanto
	}
	
	override  method tienePocaActividad() {
		return racionesDeComidasServidas > 50
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
		return mensajes.all({m => m.size() <= 30})
		//not mensajes.any({m => m.size() > 30})
	}
	
	method emitioMensaje(mensaje){
		mensajes.contains(mensaje)
	}
	
	override method prepararViaje(){
		super()
		self.ponerseVisible()
		self.replegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en misión")
	}
	
	override method condicionDeTranquilidad() {
		return not self.misilesDesplegados()
	}
	
	override method escapar() {
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	
	override method avisar() {
		self.emitirMensaje("Amenaza recibida")
	}
	
	override  method tienePocaActividad() { 
		return self.esEscueta()
	}
	
}

class NaveHospital inherits NaveDePasajeros{
	var quirofanosPreparados = false
	
	method prepararQuirofanos(){
		quirofanosPreparados = true
	}
	
	method noPrepararQuirofanos(){
		quirofanosPreparados = false
	}
	
	override method condicionDeTranquilidad() {
		return not quirofanosPreparados
	}
	
	override method recibirAmenaza(){
		super()
		self.prepararQuirofanos()
	}
}

class NaveSigilosa inherits NaveDeCombate {
	
	override method condicionDeTranquilidad() {
		return super() and !self.estaInvisible()
	}
	
	override method escapar(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
}
