<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Kinal Toy's (Login)</title>
        <!-- Icono -->
        <link rel="icon" href="img/kinal toys.png">
        <!-- Icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- CSS -->
        <link rel="stylesheet" href="css/login.css">
    </head>
    <body>
        <%-- Crear una nueva Cuenta--%> 
        <div class="container" id="container">
            <div class="form-container sign-up-container">
                <form action="Validar" method="POST">
                    <h1>Crear cuenta</h1>
                    <div class="social-container">
                        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                    <span>o usa tu correo electrónico para registrarte</span>
                    <div class="infield">
                        <input type="text" placeholder="Name" />
                        <label></label>
                    </div>
                    <div class="infield">
                        <input type="email" placeholder="Email" name="email"/>
                        <label></label>
                    </div>
                    <div class="infield">
                        <input type="password" placeholder="Password" />
                        <label></label>
                    </div>
                    <div class="infield">
                        <input type="text" placeholder="DPI" name="dpi" required/>
                        <label></label>
                    </div>
                    <button type="submit" name="accion" value="Ingresar">Registrarse</button>
                </form>
            </div>
            
            
            <%-- Inicio de Sesion--%>
            <div class="form-container sign-in-container">
                <form action="${pageContext.request.contextPath}/Validar" method="POST">
                    <h1>Inicio de Sesión</h1>
                    <div class="social-container">
                        <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                        <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                    <span>o usa tu cuenta</span>
                    <div class="infield">
                        <input type="email" placeholder="Email" name="email"/>
                        <label></label>
                    </div>
                    <div class="infield">
                        <input type="password" placeholder="Password" name="Password" />
                        <label></label>
                    </div>
                    <div class="infield">
                        <input type="text" name="dpi" placeholder="DPI" required>
                        <label></label>
                    </div>
                    <a href="#" class="forgot">¿Olvidaste tu contraseña?</a>
                    <button type="submit" name="accion" value="Ingresar">Iniciar sesión</button>
                </form>
            </div>
                    
                    
            <div class="overlay-container" id="overlayCon">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>¡Hola, amigo!</h1>
                        <p>Para mantenerte conectado con nosotros, por favor, inicia sesión con tu información personal</p>
                        <button>Iniciar sesión</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>¡Bienvenido de nuevo!</h1>
                        <p>Ingresa tus datos personales y comienza tu viaje con nosotros</p>
                        <button>Registrarse</button>
                    </div>
                </div>
                <button id="overlayBtn"></button>
            </div>
        </div>
        <script>
            const container = document.getElementById('container');
            const overlayCon = document.getElementById('overlayCon');
            const overlayBtn = document.getElementById('overlayBtn');

            overlayBtn.addEventListener('click', () => {
                container.classList.toggle('right-panel-active');

                overlayBtn.classList.remove('btnScaled');
                window.requestAnimationFrame(() => {
                    overlayBtn.classList.add('btnScaled');
                })
            });
        </script>
    </body>
</html>