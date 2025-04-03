class Controlador {

    //constructor del modelo y la vista
    constructor(modelo, vista) {
        this.modelo = modelo;
        this.vista = vista;
    }

    //cargar los datos de los jugadores y equipos en la vista
    cargarDatos() {
        const jugadores = this.modelo.obtenerJugadores();
        const equipos = this.modelo.obtenerEquipos();
        this.vista.mostrarJugadores(jugadores);
        this.vista.mostrarEquipos(equipos);
    }

    //agregar un jugador con sus atributos correspondientes a un equipo
    agregarJugador(nombre, posicion, nacimiento, idEquipo) {
        if (!nombre || !posicion || !nacimiento) {
            this.vista.mostrarError("Esta mal");
            return;
        }
        this.modelo.agregarJugador(nombre, posicion, nacimiento, idEquipo);
    }

    //agregar un equipo con sus atributos correspondientes
    agregarEquipo(nombre, ciudad, estadio) {
        if (!nombre || !ciudad || !estadio) {
            this.vista.mostrarError("Esta mal");
            return;
        }
        this.modelo.agregarEquipo(nombre, ciudad, estadio);
    }

    //asignar un jugador a un equipo
    asignarJugadorAEquipo(idJugador, idEquipo) {
        if (!idJugador || !idEquipo) {
            this.vista.mostrarError("Debe seleccionar un jugador y un equipo");
            return;
        }
        this.modelo.asignarJugadorAEquipo(idJugador, idEquipo);
    }
}