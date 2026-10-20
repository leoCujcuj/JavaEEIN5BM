
package modelo;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Clientes")
public class Clientes implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codigoCliente")
    private Integer codigoCliente;

    @Column(name = "nombreCliente")
    private String nombreCliente;

    @Column(name = "apellidoCliente")
    private String apellidoCliente;

    @Column(name = "direccionCliente")
    private String direccionCliente;

    @Column(name = "telefonoCliente")
    private String telefonoCliente;
    
    @Column(name = "dpiCliente")
    private String dpiCliente;
    
    public Clientes() {
    }

    public String getDpiCliente() {
        return dpiCliente;
    }

    public void setDpiCliente(String dpiCliente) {
        this.dpiCliente = dpiCliente;
    }
    
    public Integer getCodigoCliente() {
        return codigoCliente;
    }

    public void setCodigoCliente(Integer codigoCliente) {
        this.codigoCliente = codigoCliente;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getApellidoCliente() {
        return apellidoCliente;
    }

    public void setApellidoCliente(String apellidoCliente) {
        this.apellidoCliente = apellidoCliente;
    }

    public String getDireccionCliente() {
        return direccionCliente;
    }

    public void setDireccionCliente(String direccionCliente) {
        this.direccionCliente = direccionCliente;
    }

    public String getTelefonoCliente() {
        return telefonoCliente;
    }

    public void setTelefonoCliente(String telefonoCliente) {
        this.telefonoCliente = telefonoCliente;
    }

    @Override
    public String toString() {
        return "Clientes{" + "codigoCliente=" + codigoCliente + ", nombreCliente=" + nombreCliente + ", apellidoCliente=" + apellidoCliente + ", direccionCliente=" + direccionCliente + ", telefonoCliente=" + telefonoCliente + '}';
    }

    
}
