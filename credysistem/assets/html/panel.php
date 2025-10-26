<?php
session_start();
require_once '../../php/conecta.php';

if (!isset($_SESSION['id_usuario'])) {
    header("Location: login.html");
    exit();
}

$id_usuario = $_SESSION['id_usuario'];

$sql = "SELECT * FROM credito WHERE id_usuario = '$id_usuario' ORDER BY fecha_otorgamiento DESC";
$res = mysqli_query($conecta, $sql);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Créditos - CREDISYSTEM</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../style/style.css">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="#">CREDISYSTEM</a>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text text-white me-3">
                Hola, <?php echo $_SESSION['nombre'] . ' ' . $_SESSION['apellido']; ?>
            </span>
            <a class="nav-link text-white" href="../../php/logout.php">Cerrar Sesión</a>
        </div>
    </div>
</nav>

<div class="container mt-4">
    <h2 class="text-center mb-4">💳 Mis Créditos</h2>

    <div class="text-center mb-4">
        <a href="creditos.html" class="btn btn-success">➕ Solicitar Nuevo Crédito</a>
    </div>

    <?php if (mysqli_num_rows($res) > 0): ?>
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-primary">
                    <tr>
                        <th>Monto Original</th>
                        <th>Saldo Pendiente</th>
                        <th>Tasa (%)</th>
                        <th>Plazo (meses)</th>
                        <th>Fecha Otorgamiento</th>
                        <th>Primer Vencimiento</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($c = mysqli_fetch_assoc($res)): ?>
                        <tr>
                            <td>$<?php echo number_format($c['monto_original'], 2); ?></td>
                            <td>$<?php echo number_format($c['saldo_pendiente'], 2); ?></td>
                            <td><?php echo $c['tasa_interes_anual']; ?>%</td>
                            <td><?php echo $c['plazo_meses']; ?></td>
                            <td><?php echo date('d/m/Y', strtotime($c['fecha_otorgamiento'])); ?></td>
                            <td><?php echo date('d/m/Y', strtotime($c['primer_vencimiento'])); ?></td>
                            <td>
                                <?php if ($c['estado'] == 'vigente'): ?>
                                    <span class="badge bg-success">Vigente</span>
                                <?php elseif ($c['estado'] == 'en_mora'): ?>
                                    <span class="badge bg-danger">En mora</span>
                                <?php else: ?>
                                    <span class="badge bg-secondary">Cancelado</span>
                                <?php endif; ?>
                            </td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
    <?php else: ?>
        <div class="alert alert-info text-center">
            <h4>No tenés créditos registrados</h4>
            <p>¡Solicitá tu primer crédito haciendo clic en el botón de arriba!</p>
        </div>
    <?php endif; ?>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>