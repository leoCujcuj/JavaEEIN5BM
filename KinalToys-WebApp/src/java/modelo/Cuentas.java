
package modelo;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Cuentas")
public class Cuentas implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codigoCuenta")
    private Integer codigoCuenta;

    @Column(name = "rol")
    private String rol;

    @Column(name = "nombreCuenta")
    private String nombreCuenta;

    @Column(name = "correoCuenta")
    private String correoCuenta;

    @Column(name = "contrasenaCuenta")
    private String contrasenaCuenta;

    @Column(name = "fotoperfil")
    private String fotoPerfil;

    @Column(name = "codigoCliente")
    private Integer codigoCliente;

    @Column(name = "codigoEmpleado")
    private Integer codigoEmpleado;

    public Cuentas() {
    }

    public Integer getCodigoCuenta() {
        return codigoCuenta;
    }

    public void setCodigoCuenta(Integer codigoCuenta) {
        this.codigoCuenta = codigoCuenta;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getNombreCuenta() {
        return nombreCuenta;
    }

    public void setNombreCuenta(String nombreCuenta) {
        this.nombreCuenta = nombreCuenta;
    }

    public String getCorreoCuenta() {
        return correoCuenta;
    }

    public void setCorreoCuenta(String correoCuenta) {
        this.correoCuenta = correoCuenta;
    }

    public String getContrasenaCuenta() {
        return contrasenaCuenta;
    }

    public void setContrasenaCuenta(String contrasenaCuenta) {
        this.contrasenaCuenta = contrasenaCuenta;
    }

    public String getFotoPerfil() {
        return fotoPerfil;
    }

    public void setFotoPerfil(String fotoPerfil) {
        this.fotoPerfil = fotoPerfil;
    }

    public Integer getCodigoCliente() {
        return codigoCliente;
    }

    public void setCodigoCliente(Integer codigoCliente) {
        this.codigoCliente = codigoCliente;
    }

    public Integer getCodigoEmpleado() {
        return codigoEmpleado;
    }

    public void setCodigoEmpleado(Integer codigoEmpleado) {
        this.codigoEmpleado = codigoEmpleado;
    }

    @Override
    public String toString() {
        return "Cuentas{" + "codigoCuenta=" + codigoCuenta + ", rol=" + rol + ", nombreCuenta=" + nombreCuenta + ", correoCuenta=" + correoCuenta + ", contrasenaCuenta=" + contrasenaCuenta + ", fotoPerfil=" + fotoPerfil + ", codigoCliente=" + codigoCliente + ", codigoEmpleado=" + codigoEmpleado + '}';
    }
    
}