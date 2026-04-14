import 'dart:io';

/// Agente Interactivo para Guardar en GitHub
/// Puedes ejecutarlo corriendo el siguiente comando en tu terminal:
/// dart run agenteguardarepositorio.dart
void main() async {
  print('\n=============================================');
  print('🤖 Agente GitHub: Guardado Automático de Repositorio');
  print('=============================================\n');

  // 1. Checar si Git está inicializado en la carpeta
  var gitStatusResult = await runProcess('git', ['rev-parse', '--is-inside-work-tree'], throwOnError: false);
  if (gitStatusResult.exitCode != 0) {
    print('>> Inicializando repositorio Git (git init)...');
    await runProcess('git', ['init']);
  }

  // 2. Agregar todos los archivos
  print('>> Preparando archivos modificados...');
  await runProcess('git', ['add', '.']);

  // 3. Solicitar mensaje de Commit
  stdout.write('>> Escribe tu mensaje de commit (Ej. "Versión inicial"): ');
  String? commitMessage = stdin.readLineSync();
  if (commitMessage == null || commitMessage.trim().isEmpty) {
    commitMessage = 'Actualización automática usando Agente GitHub';
  }

  // 4. Realizar el Commit
  var commitResult = await runProcess('git', ['commit', '-m', commitMessage], throwOnError: false);
  if (commitResult.exitCode != 0) {
    String output = commitResult.stdout.toString() + commitResult.stderr.toString();
    if (output.contains('nothing to commit') || output.contains('nada para hacer commit')) {
      print('>> No hay cambios nuevos registrados para hacer commit.');
    } else {
      print('>> Advertencia al hacer commit:\n$output');
    }
  } else {
    print('>> Commit creado con éxito 📦.');
  }

  // 5. Solicitar la Rama (Branch)
  stdout.write('\n>> ¿A qué rama deseas subir los cambios? [Enter para "main"]: ');
  String? branch = stdin.readLineSync();
  if (branch == null || branch.trim().isEmpty) {
    branch = 'main';
  }

  // Renombramos la rama actual a la elegida (por convención nueva de git init -> main)
  await runProcess('git', ['branch', '-M', branch]);

  // 6. Configurar Repositorio Remoto (GitHub)
  var remoteResult = await runProcess('git', ['remote', '-v'], throwOnError: false);
  String remoteOutput = remoteResult.stdout.toString();

  if (!remoteOutput.contains('origin')) {
    stdout.write('\n>> No tienes un link de GitHub configurado.\n>> Pega aquí tu link de repositorio (ej. https://github.com/usuario/repo.git): ');
    String? githubLink = stdin.readLineSync();
    
    if (githubLink != null && githubLink.trim().isNotEmpty) {
      print('>> Configurando origen remoto en $githubLink...');
      await runProcess('git', ['remote', 'add', 'origin', githubLink.trim()]);
    } else {
      print('\n[!] No proporcionaste un enlace. Los cambios se han guardado LOCALMENTE, pero no se subirán a internet.');
      exit(0);
    }
  } else {
    print('\n>> Tu proyecto ya está vinculado a un repositorio en GitHub.');
    stdout.write('>> ¿Deseas CAMBIAR el enlace a un nuevo repositorio? (s/N): ');
    String? changeRemote = stdin.readLineSync();
    if (changeRemote != null && changeRemote.trim().toLowerCase() == 's') {
      stdout.write('>> Pega aquí tu NUEVO enlace de GitHub: ');
      String? githubLink = stdin.readLineSync();
      if (githubLink != null && githubLink.trim().isNotEmpty) {
        await runProcess('git', ['remote', 'set-url', 'origin', githubLink.trim()]);
        print('>> Enlace de repositorio actualizado.');
      }
    }
  }

  // 7. Push a GitHub
  print('\n>> 🚀 Subiendo código pesado a GitHub (Rama: $branch)...');
  
  var pushResult = await runProcess('git', ['push', '-u', 'origin', branch], throwOnError: false);
  
  if (pushResult.exitCode == 0) {
    print('\n=============================================');
    print('✅ ¡Éxito total! Todo está guardado en la nube.');
    print('=============================================');
  } else {
    print('\n[X] Ocurrió un error al intentar subir a GitHub.');
    print('Detalle del error:\n${pushResult.stderr}');
    print('\nSugerencia: Asegúrate de tener permisos o haber iniciado sesión en GitHub en tu terminal (GitHub CLI u oAuth).');
  }
}

/// Función auxiliar para ejecutar llamadas de sistema
Future<ProcessResult> runProcess(String executable, List<String> arguments, {bool throwOnError = true}) async {
  var result = await Process.run(executable, arguments);
  if (throwOnError && result.exitCode != 0) {
    print('\n[Error Fatal] Falló la ejecución de: $executable ${arguments.join(' ')}');
    print(result.stderr);
    exit(result.exitCode);
  }
  return result;
}
