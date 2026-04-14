import 'package:flutter/material.dart';
import 'guardardatosdiccionario.dart';

class CapturaEmpleadosScreen extends StatefulWidget {
  const CapturaEmpleadosScreen({super.key});

  @override
  State<CapturaEmpleadosScreen> createState() => _CapturaEmpleadosScreenState();
}

class _CapturaEmpleadosScreenState extends State<CapturaEmpleadosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _puestoController = TextEditingController();
  final _salarioController = TextEditingController();

  void _guardarDatos() {
    if (_formKey.currentState!.validate()) {
      final String nombre = _nombreController.text;
      final String puesto = _puestoController.text;
      final double salario = double.tryParse(_salarioController.text) ?? 0.0;

      // Usando el agente para guardar en el diccionario
      GuardarDatosDiccionario.registrar(nombre, puesto, salario);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 10),
              Text('Empleado registrado correctamente'),
            ],
          ),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      _nombreController.clear();
      _puestoController.clear();
      _salarioController.clear();
      
      // Regresar al inicio en lugar de quedarse ahí, o quedarse si se quiere seguir añadiendo (opcional).
      // En este caso, lo dejamos para permitir capturas masivas continuas.
      // Navigator.pop(context); 
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _puestoController.dispose();
    _salarioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Captura de Empleado', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1,
                    size: 60,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Empleado',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingresa un nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _puestoController,
                  decoration: const InputDecoration(
                    labelText: 'Puesto Asignado',
                    prefixIcon: Icon(Icons.work_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingresa un puesto';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _salarioController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Salario Mensual',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Por favor ingresa un salario';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Ingresa una cantidad numérica válida';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: _guardarDatos,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar Datos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 60),
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    elevation: 5,
                    shadowColor: const Color(0xFF1E3A8A).withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
