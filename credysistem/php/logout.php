<?php
session_start();
session_destroy();
header("Location: ../assets/html/login.html");
exit();
?>