import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleadosScreen extends StatefulWidget {
  const VerEmpleadosScreen({super.key});

  @override
  State<VerEmpleadosScreen> createState() => _VerEmpleadosScreenState();
}

class _VerEmpleadosScreenState extends State<VerEmpleadosScreen> {
  @override
  Widget build(BuildContext context) {
    // Obtenemos una lista de los valores del mapa
    final empleadosList = datosEmpleado.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empleados', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.grey.shade100,
      body: empleadosList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 100, color: Colors.grey.shade300),
                  const SizedBox(height: 20),
                  Text(
                    'No hay empleados registrados',
                    style: TextStyle(
                      fontSize: 20, 
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              itemCount: empleadosList.length,
              itemBuilder: (context, index) {
                final empleado = empleadosList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1E3A8A).withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: () {}, // Puede servir para ver un detalle futuro
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              // Avatar llamativo con el ID
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF1E3A8A), Color(0xFF4F46E5)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF1E3A8A).withOpacity(0.3),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '#${empleado.id}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              
                              // Datos del Empleado
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      empleado.nombre,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF111827),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.business_center, size: 18, color: Colors.grey.shade600),
                                        const SizedBox(width: 6),
                                        Text(
                                          empleado.puesto,
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.attach_money, size: 18, color: Color(0xFF10B981)),
                                        const SizedBox(width: 6),
                                        Text(
                                          empleado.salario.toStringAsFixed(2),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF10B981),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
