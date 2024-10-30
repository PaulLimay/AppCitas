<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Exitoso</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <script>
        // Redirige automáticamente al index después de 5 segundos
        setTimeout(function() {
            window.location.href = 'index.jsp';
        }, 5000);
    </script>
</head>
<body class="bg-light d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="container text-center">
        <div class="card">
            <div class="card-body">
                <h1 class="card-title">¡Registro Exitoso!</h1>
                <p class="card-text">Tu cuenta ha sido creada exitosamente. Serás redirigido a la página de inicio en 5 segundos.</p>
                <hr>
                <p>Si no deseas esperar, puedes regresar haciendo clic en el siguiente botón:</p>
                <a href="index.jsp" class="btn btn-primary">Regresar a la Página de Inicio</a>
            </div>
        </div>
    </div>
</body>
</html>
