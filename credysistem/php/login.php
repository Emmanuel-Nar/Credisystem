<?php
session_start();
require_once 'conecta.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email']);
    $password = trim($_POST['password']);
    
    // Consulta preparada para seguridad
    $sql = "SELECT id_usuario, nombre, apellido, email, hash_password FROM usuario WHERE email = ?";
    $stmt = mysqli_prepare($conecta, $sql);
    
    if ($stmt) {
        mysqli_stmt_bind_param($stmt, "s", $email);
        mysqli_stmt_execute($stmt);
        $resultado = mysqli_stmt_get_result($stmt);

        if (mysqli_num_rows($resultado) === 1) {
            $usuario = mysqli_fetch_assoc($resultado);
            
            if (password_verify($password, $usuario['hash_password'])) {
                // Login exitoso
                $_SESSION['id_usuario'] = $usuario['id_usuario'];
                $_SESSION['nombre'] = $usuario['nombre'];
                $_SESSION['apellido'] = $usuario['apellido'];
                $_SESSION['email'] = $usuario['email'];
                
                header("Location: ../assets/html/panel.php");
                exit();
            } else {
                echo "<script>alert('❌ Contraseña incorrecta'); window.location.href='../assets/html/login.html';</script>";
            }
        } else {
            echo "<script>alert('❌ No existe una cuenta con ese email'); window.location.href='../assets/html/login.html';</script>";
        }
        
        mysqli_stmt_close($stmt);
    } else {
        echo "<script>alert('❌ Error del sistema'); window.location.href='../assets/html/login.html';</script>";
    }
} else {
    header("Location: ../assets/html/login.html");
    exit();
}
?>