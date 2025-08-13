/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author edvin
 */
public class EmpleadosDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;
    int resp;
    
    public List<Empleados> listar(){
        String sql = "call sp_ListarEmpleados()";
        List<Empleados> listaEmpleado = new ArrayList<>();
        try {
            con = cn.Conexion(); 
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Empleados em = new Empleados();
                em.setCodigoEmpleado(rs.getInt(1));  
                em.setNombreEmpleado(rs.getString(2)); 
                em.setApellidoEmpleado(rs.getString(3));
                em.setDireccionEmpleado(rs.getString(4)); 
                em.setTelefonoEmpleado(rs.getString(5)); 
                em.setCargo(rs.getString(6)); 
                em.setSalario(rs.getDouble(7));
                em.setDpiEmpleado(rs.getString(8));
                
                listaEmpleado.add(em);  
            }
            
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
            e.printStackTrace();
        } 
        
        
        return listaEmpleado; 
        }
    
        public int agregar(Empleados emp) {
            String sql = "call sp_AgregarEmpleados(?,?,?,?,?,?,?)";
            try {
                
                con = cn.Conexion(); 
                ps = con.prepareStatement(sql);
                
                ps.setString(1, emp.getNombreEmpleado());
                ps.setString(2, emp.getApellidoEmpleado());
                ps.setString(3, emp.getDireccionEmpleado());
                ps.setString(4, emp.getTelefonoEmpleado());
                ps.setString(5, emp.getCargo());
                ps.setDouble(6, emp.getSalario());
                ps.setString(7, emp.getDpiEmpleado());

                resp = ps.executeUpdate();
                if (emp.getNombreEmpleado() == null) {
                    System.out.println("El nombre es null o vacío");
                    return 0;
                }

            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
            return resp; 
        }

        public int actualizar(Empleados empleado) {
            String sql = "call sp_ActualizarEmpleado(?, ?, ?, ?, ?, ?, ?, ?)";
            try {
                con = cn.Conexion();
                ps = con.prepareStatement(sql);
                ps.setInt(1, empleado.getCodigoEmpleado());
                ps.setString(2, empleado.getNombreEmpleado());
                ps.setString(3, empleado.getApellidoEmpleado());
                ps.setString(4, empleado.getDireccionEmpleado());
                ps.setString(5, empleado.getTelefonoEmpleado());
                ps.setString(6, empleado.getCargo());
                ps.setDouble(7, empleado.getSalario());
                ps.setString(8, empleado.getDpiEmpleado());

                resp = ps.executeUpdate();
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
            return resp;
        }
        public int eliminar(int codigoEmpleado) {
            String sql = "call sp_EliminarEmpleado(?)";
            try {
                con = cn.Conexion();
                ps = con.prepareStatement(sql);
                ps.setInt(1, codigoEmpleado);

                resp = ps.executeUpdate();
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace();
            }
            return resp;
        }

}
