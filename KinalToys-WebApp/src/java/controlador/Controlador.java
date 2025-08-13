
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Empleados;
import modelo.EmpleadosDAO;
@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class Controlador extends HttpServlet {  
    Empleados empleado = new Empleados();
    EmpleadosDAO empleadoDAO = new EmpleadosDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        String menu = request.getParameter("menu");

        if ("principal-admin".equals(menu)) {
            request.getRequestDispatcher("/principal-admin.jsp").forward(request, response);
            
        } else if ("cliente".equals(menu)) {
            request.getRequestDispatcher("/cliente.jsp").forward(request, response);
        } else if ("factura".equals(menu)) {
            request.getRequestDispatcher("/factura.jsp").forward(request, response);
        } else if ("noticia".equals(menu)) {
            request.getRequestDispatcher("/noticia.jsp").forward(request, response);
        } else if ("proveedor".equals(menu)) {
            request.getRequestDispatcher("/proveedor.jsp").forward(request, response);
        } else if ("juguete".equals(menu)) {
            request.getRequestDispatcher("/juguete.jsp").forward(request, response);
        } else if ("cuenta".equals(menu)) {
            request.getRequestDispatcher("/cuenta.jsp").forward(request, response);
        } else if ("empleado".equals(menu)) {
            try {
                if (accion == null) {
                    accion = "Listar"; 
                }

                switch (accion) {
                    case "Listar":
                        List<Empleados> listaEmpleado = empleadoDAO.listar();
                        request.setAttribute("empleados", listaEmpleado);  
                        request.getRequestDispatcher("/empleados.jsp").forward(request, response);
                        return;

                    case "Agregar":
                        System.out.println("Entrando en caso de Agregar...");

                        String DPI = request.getParameter("txtDPIEmpleado");
                        String nombre = request.getParameter("txtNombre");
                        String apellido = request.getParameter("txtApellido");
                        String direccion = request.getParameter("txtDireccion");
                        String telefono = request.getParameter("txtTelefono");
                        String cargo = request.getParameter("txtCargo");
                        String salarioStr = request.getParameter("txtSalario");

                        double salario = 0.0;
                        if (salarioStr != null && !salarioStr.isEmpty()) {
                            try {
                                salario = Double.parseDouble(salarioStr);
                            } catch (NumberFormatException e) {
                                System.out.println("Error: " + e.getMessage());
                                e.printStackTrace();
                            }
                        } else {
                            System.out.println("Salario no proporcionado.");
                        }

                        empleado.setNombreEmpleado(nombre);
                        empleado.setApellidoEmpleado(apellido);
                        empleado.setDireccionEmpleado(direccion);
                        empleado.setTelefonoEmpleado(telefono);
                        empleado.setCargo(cargo);
                        empleado.setSalario(salario);
                        empleado.setDpiEmpleado(DPI);

                        empleadoDAO.agregar(empleado);

                        response.sendRedirect("Controlador?menu=empleado&accion=Listar");
                        return;

                    case "Editar":
                        break;

                    default:
                        throw new AssertionError("Acción no reconocida: " + accion);
                }

            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }

        }else if ("carrito".equals(menu)) {
            request.getRequestDispatcher("/carrito.jsp").forward(request, response);
        } else if ("detalles-carritos".equals(menu)) {
            request.getRequestDispatcher("/detalles-carritos.jsp").forward(request, response);
        } else {
            response.sendRedirect("/principal-admin.jsp");
            return;
        }

        
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
