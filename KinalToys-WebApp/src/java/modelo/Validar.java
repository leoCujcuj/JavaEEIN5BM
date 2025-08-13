
package modelo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "Validar", urlPatterns = {"/Validar"})
public class Validar extends HttpServlet {

    CuentasDAO cuentasDAO = new CuentasDAO();
    Cuentas cuenta = new Cuentas();
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String menu = request.getParameter("menu");
        String accion = request.getParameter("accion");
        
        if (menu.equals("Principal")) {
            request.getRequestDispatcher("principal-admin.jsp").forward(request, response);
        }else if (menu.equals("Empleado")) {
            switch (accion) {
                case "Listar":
                    
                    break;
                default:
                    throw new AssertionError();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("Ingresar".equalsIgnoreCase(accion)) {
            String correo = request.getParameter("email");
            String password = request.getParameter("Password");
            String dpi = request.getParameter("dpi");

            Cuentas cuentas = cuentasDAO.Validar(dpi,correo,password);

            if (cuentas != null && cuentas.getCorreoCuenta() != null) {
                request.setAttribute("cuenta", cuentas);

                if ("Cliente".equalsIgnoreCase(cuentas.getRol())) {
                    request.getRequestDispatcher("principal-usuario.jsp?").forward(request, response);
                } else if ("Empleado".equalsIgnoreCase(cuentas.getRol())) {
                    request.getRequestDispatcher("principal-admin.jsp?").forward(request, response);
                } else {
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }

            } else {
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
