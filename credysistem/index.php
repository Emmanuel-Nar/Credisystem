<?php
// solicitar el archivo de conexion a base de datos
include 'php/conecta.php';
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Credisystem</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="assets/style/animaciones.css">
    <link rel="stylesheet" href="assets/style/style.css">
</head>

<body>
    <header class="height p-2">
        <nav class="navbar sticky-top navbar-expand-lg">
            <div class="container-fluid">
                <a class="navbar-brand text-white" href="#sobre-mi">CREDISYSTEM</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav" style="justify-content: end;">
                    <ul class="navbar-nav text-white">
                        <li class="nav-item ps-3">
                            <a class="nav-link active" aria-current="page" href="index.php">Home</a>
                        </li>
                        <li class="nav-item ps-3 text-white">
                            <a class="nav-link" href="assets/html/creditos.html">Nuevo Credito</a>
                        </li>
                        <li class="nav-item ps-3 text-white">
                            <a class="nav-link" href="assets/html/cuotas.html">Mis Creditos</a>
                        </li>
                        <li class="nav-item ps-3 text-white">
                            <a class="nav-link" href="assets/html/contacto.html">Contacto</a>
                        </li>
                        <li class="nav-item ps-3 pe-2 pe-3 text-white">
                            <a class="nav-link" href="https://maps.app.goo.gl/HA2VecZog98M5s5m7"
                                target="_blank">Sucursales</a>
                        </li>
                        <div>
                            <a href="assets/html/login.html"><button type="button"
                                    class="btn btn-outline-primary">Iniciar</button></a>
                            <a href="assets/html/registro.html"><button type="button"
                                    class="btn btn-outline-primary">Registrarse</button></a>
                        </div>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <main>
        <div class="my-2 text-center">
            <img class="img-fluid d-block mx-auto" src="assets/img/bostonlogo.jpg" alt="Boston Logo" width="720" height="500">
            <h1 id="h1hero" class="display-5 fw-bold">CREDITOS EN EL ACTO</h1><br><br>
            <div class="col-lg-6 mx-auto">
                <h2 id="h2hero" class="lead mb-4 fw-bold">SIMPLE, FACIL Y RAPIDO</h2>
                <h2 id="h2hero" class="lead mb-4 fw-bold" style="color: black; font-size: 30px;">MÍNIMOS REQUISITOS</h2>
                
                
                <div class="mt-4">
                    <?php if ($conecta): ?>
                        <div class="alert alert-success" role="alert">
                            ✅ Conexión a la base de datos establecida correctamente
                        </div>
                    <?php else: ?>
                        <div class="alert alert-danger" role="alert">
                            ❌ Error en la conexión a la base de datos
                        </div>
                    <?php endif; ?>
                </div>
            </div>
        </div>
    </main>

    <footer class="text-center py-3 bg-light">
        <small>© 2025 CREDISYSTEM - Todos los derechos reservados</small>
    </footer>

    <script src="assets/js/main.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>