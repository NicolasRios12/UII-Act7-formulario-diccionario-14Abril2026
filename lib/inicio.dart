import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Empleados', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.business_center,
                size: 80,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/captura');
              },
              icon: const Icon(Icons.person_add, size: 24),
              label: const Text(
                'Capturar Empleados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(260, 60),
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor: const Color(0xFF1E3A8A).withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/ver');
              },
              icon: const Icon(Icons.people_alt, size: 24),
              label: const Text(
                'Ver Empleados',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(260, 60),
                foregroundColor: const Color(0xFF1E3A8A),
                side: const BorderSide(color: Color(0xFF1E3A8A), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
