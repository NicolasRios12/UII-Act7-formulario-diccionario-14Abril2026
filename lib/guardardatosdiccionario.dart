import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  // Variable estática para llevar la cuenta numérica automática de IDs
  static int _ultimoId = 0;

  static void registrar(String nombre, String puesto, double salario) {
    _ultimoId++; // Incrementamos para asignar un ID auto numérico
    
    Empleado nuevoEmpleado = Empleado(
      id: _ultimoId,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );

    // Guardamos en el diccionario
    datosEmpleado[_ultimoId] = nuevoEmpleado;
  }
}
