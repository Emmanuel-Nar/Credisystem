<?php
session_start();
require_once 'conecta.php';

// DEBUG: Verificar que se está ejecutando
error_log("=== REGISTRAR_CREDITO.PHP INICIADO ===");

// 1. VERIFICAR SESIÓN
if (!isset($_SESSION['id_usuario'])) {
    error_log("❌ Usuario no logueado");
    header("Location: ../assets/html/login.html");
    exit();
}

error_log("Usuario logueado: " . $_SESSION['id_usuario']);

// 2. VERIFICAR MÉTODO POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    error_log("✅ Método POST recibido");
    
    // DEBUG: Verificar datos recibidos
    error_log("Datos POST: " . print_r($_POST, true));
    
    // 3. CAPTURAR DATOS
    $id_usuario = $_SESSION['id_usuario'];
    $monto = floatval($_POST['monto_original']);
    $plazo = intval($_POST['plazo_meses']);
    $primer_vencimiento = $_POST['primer_vencimiento'];

    error_log("Datos capturados - Monto: $monto, Plazo: $plazo, Vencimiento: $primer_vencimiento");

    // 4. VALIDACIONES
    if ($monto < 1000 || $monto > 1000000) {
        $error = "❌ El monto debe estar entre $1,000 y $1,000,000";
        error_log($error);
        echo "<script>alert('$error'); window.history.back();</script>";
        exit();
    }

    $plazos_permitidos = [6, 12, 18, 24, 36];
    if (!in_array($plazo, $plazos_permitidos)) {
        $error = "❌ Plazo no válido. Use: 6, 12, 18, 24 o 36 meses";
        error_log($error);
        echo "<script>alert('$error'); window.history.back();</script>";
        exit();
    }

    // 5. VALORES AUTOMÁTICOS
    $saldo = $monto;
    $tasa = 45.00;
    $fecha_otorgamiento = date('Y-m-d');
    $estado = 'vigente';

    error_log("Valores automáticos - Saldo: $saldo, Tasa: $tasa, Fecha: $fecha_otorgamiento, Estado: $estado");

    // 6. INSERTAR EN BASE DE DATOS
    $sql = "INSERT INTO credito 
            (id_usuario, monto_original, saldo_pendiente, tasa_interes_anual, plazo_meses, fecha_otorgamiento, primer_vencimiento, estado) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    
    error_log("SQL: $sql");
    
    $stmt = mysqli_prepare($conecta, $sql);
    if ($stmt) {
        mysqli_stmt_bind_param($stmt, "idddisss", $id_usuario, $monto, $saldo, $tasa, $plazo, $fecha_otorgamiento, $primer_vencimiento, $estado);
        
        if (mysqli_stmt_execute($stmt)) {
            $nuevo_id = mysqli_insert_id($conecta);
            error_log("✅ Crédito insertado correctamente. ID: $nuevo_id");
            
            // 7. ÉXITO - Redirigir al panel
            echo "<script>
                alert('✅ Crédito registrado con éxito\\\\nMonto: $$monto\\\\nPlazo: $plazo meses\\\\nPrimer vencimiento: $primer_vencimiento');
                window.location.href = '../assets/html/panel.php';
            </script>";
        } else {
            $error = "❌ Error al ejecutar consulta: " . mysqli_error($conecta);
            error_log($error);
            echo "<script>alert('$error'); window.history.back();</script>";
        }
        mysqli_stmt_close($stmt);
    } else {
        $error = "❌ Error preparando consulta: " . mysqli_error($conecta);
        error_log($error);
        echo "<script>alert('$error'); window.history.back();</script>";
    }
} else {
    error_log("❌ Método no permitido: " . $_SERVER['REQUEST_METHOD']);
    echo "<script>alert('❌ Método no permitido'); window.location.href = '../assets/html/creditos.html';</script>";
}
?>