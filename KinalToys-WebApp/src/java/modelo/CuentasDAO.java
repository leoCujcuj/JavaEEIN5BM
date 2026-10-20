
package modelo;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CuentasDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    int resp;
    
    public Cuentas Validar(String dpi, String correo, String password) {
        Cuentas cuenta = null;
        String sql = "CALL sp_validarCuentas(?,?,?);";

        try {
            con = cn.Conexion();
            ps = con.prepareCall(sql);
            ps.setString(1, dpi);
            ps.setString(2, correo);
            ps.setString(3, password);

            rs = ps.executeQuery();
            if (rs.next()) {
                cuenta = new Cuentas();
                cuenta.setCodigoCuenta(rs.getInt("codigoCuenta"));
                cuenta.setRol(rs.getString("rol"));
                cuenta.setNombreCuenta(rs.getString("nombreCuenta"));
                cuenta.setCorreoCuenta(rs.getString("correoCuenta"));
                cuenta.setContrasenaCuenta(rs.getString("contrasenaCuenta"));
                cuenta.setFotoPerfil(rs.getString("fotoperfil"));
                cuenta.setCodigoCliente(rs.getInt("codigoCliente"));
                cuenta.setCodigoEmpleado(rs.getInt("codigoEmpleado"));
            }
        } catch (Exception e) {
            System.out.println("Error en Validar: " + e.getMessage());
        }
        return cuenta;
    }
}
