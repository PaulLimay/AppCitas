<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro Exitoso</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa; /* Color de fondo suave */
        }
        .container {
            margin-top: 100px; /* Espaciado superior */
            border: 1px solid #dee2e6; /* Borde alrededor del contenedor */
            border-radius: 5px; /* Bordes redondeados */
            background-color: #ffffff; /* Fondo blanco para el contenedor */
            padding: 30px; /* Relleno interno */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Sombra para efecto de profundidad */
        }
        h1 {
            color: #000000; /* Color cian */
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="text-center">Registro Exitoso</h1>
    <div class="alert alert-success text-center" role="alert">
        Tu cita ha sido registrada correctamente.
    </div>
    <div class="text-center">
        <a href="listarcitausuario.jsp" class="btn btn-dark">Volver a mis citas</a>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
