//<?php
// declarar las variables en donde se guardaran los valores de la conexion
////$servidor = "127.0.0.1";
//$usuario = "root";
//$password = "";
//$bd = "credysistem";
//$conecta = mysqli_connect($servidor, $usuario, $password, $bd);
//if($conecta->connect_error){
//    die("Error al conectar la base de datos de la pagina".$conecta->connect_error);
//}


//?>
<?php
$servidor = "127.0.0.1";
$usuario = "root";
$password = "";
$bd = "credysistem";

$conecta = mysqli_connect($servidor, $usuario, $password, $bd);

if (!$conecta) {
    die("Conexión fallida: " . mysqli_connect_error());
} else {
    echo "Conexión exitosa a la base de datos.";
}
?>