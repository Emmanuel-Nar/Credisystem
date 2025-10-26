<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'php/conecta.php';


function mostrarMensaje($tipo, $titulo, $mensaje, $detalle = '', $redireccion = 'http://localhost/credisystem/assets/html/registro.html', $tiempo = 4000) {
    $color = ($tipo === 'exito') ? 'success' : 'danger';
    echo "<div class='container mt-4' style='max-width:600px;'>
            <div class='alert alert-$color text-center'>
                <h3>$titulo</h3>
                <p>$mensaje</p>";
    if ($detalle != '') echo "<p>$detalle</p>";
    echo "<a href='$redireccion' class='btn btn-primary'>← Volver</a>
          <p class='mt-2'><small>Redirigiendo en " . ($tiempo/1000) . " segundos...</small></p>
        </div>
    </div>
    <script>
        setTimeout(()=>window.location.href='$redireccion',$tiempo);
    </script>";
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

  
    $nombre = $_POST['nombre'] ?? '';
    $apellido = $_POST['apellido'] ?? '';
    $telefono = $_POST['telefono'] ?? '';
    $dni = $_POST['dni'] ?? '';
    $email = $_POST['email'] ?? '';
    $direccion = $_POST['direccion'] ?? '';
    $pais = $_POST['pais'] ?? '';
    $ciudad = $_POST['ciudad'] ?? '';
    $codigo_postal = $_POST['codigo_postal'] ?? '';
    $password = $_POST['password'] ?? '';

  
    if (empty($email) || empty($password)) {
        mostrarMensaje('error', '❌ Campos incompletos', 'Debes ingresar un email y una contraseña.');
        exit;
    }

    
    $hash_password = password_hash($password, PASSWORD_DEFAULT);

    
   $sql = "INSERT INTO usuario 
        (nombre, apellido, telefono, documento, email, direccion, pais, ciudad, codigo_postal, hash_password)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    $stmt = $conecta->prepare($sql);

    if ($stmt) {
        $stmt->bind_param(
            "ssssssssss",
            $nombre, $apellido, $telefono, $dni, $email, $direccion,
            $pais, $ciudad, $codigo_postal, $hash_password
        );

        if ($stmt->execute()) {
            $detalle = "Usuario: $nombre $apellido<br>Email: $email<br>DNI: $dni<br>ID generado: " . $stmt->insert_id;
mostrarMensaje('exito', '✅ Registro exitoso', 'Tu cuenta fue creada correctamente.', $detalle, 'http://localhost/credysistem/assets/html/registro.html', 5000);
        } else {
            mostrarMensaje('error', '❌ Error al guardar', $stmt->error);
        }

        $stmt->close();
    } else {
        mostrarMensaje('error', '❌ Error en la consulta', $conecta->error);
    }

    $conecta->close();
} else {
    mostrarMensaje('error', '❌ Error', 'No se recibieron datos del formulario.');
}
?>
