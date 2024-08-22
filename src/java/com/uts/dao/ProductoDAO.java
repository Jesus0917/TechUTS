package com.uts.dao;

import com.conexion.Conexion;
import com.uts.modelo.producto;
import java.io.ByteArrayInputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO extends Conexion {
    public ArrayList<producto> mostrarProductos() {
        ArrayList<producto> listap = new ArrayList<>();
        try {
            this.conectar();
            String sql = "SELECT * FROM producto";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            ResultSet rs;
            rs = pre.executeQuery();

            while (rs.next()) {
                producto p = new producto();
                p.setId(rs.getInt(1));
                p.setCodigoProducto(rs.getString(2));
                p.setNombre(rs.getString(3));
                p.setDescripcion(rs.getString(4));
                p.setPrecio(rs.getDouble(5));
                p.setCantidad(rs.getInt(6));
                p.setImagen(rs.getBytes(7)); // Cambio en la recuperación de la imagen como un array de bytes
                p.setEstado(rs.getString(8));
                listap.add(p);
            }

        } catch (SQLException e) {
            System.out.println("Error al mostrar" + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listap;
    }

    public int insertarProducto(producto p) {
        int res = 0;
        try {
            this.conectar();
            String sql = "INSERT INTO producto (codigo_producto, nombre, descripcion, precio, cantidad, imagen, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, p.getCodigoProducto());
            pre.setString(2, p.getNombre());
            pre.setString(3, p.getDescripcion());
            pre.setDouble(4, p.getPrecio());
            pre.setInt(5, p.getCantidad());
            // Establecer la imagen como un stream de bytes en el PreparedStatement
            ByteArrayInputStream imagenStream = new ByteArrayInputStream(p.getImagen());
            pre.setBinaryStream(6, imagenStream, p.getImagen().length);
            pre.setString(7, p.getEstado());
            res = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al insertar" + e.getMessage());
        } finally {
            this.desconectar();
        }
        return res;
    }

    public int modificarProducto(producto p) {
        int res = 0;
        try {
            this.conectar();
            String sql = "UPDATE producto SET codigo_producto=?, nombre=?, descripcion=?, precio=?, cantidad=?, imagen=?, estado=? WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, p.getCodigoProducto());
            pre.setString(2, p.getNombre());
            pre.setString(3, p.getDescripcion());
            pre.setDouble(4, p.getPrecio());
            pre.setInt(5, p.getCantidad());
            // Establecer la imagen como un stream de bytes en el PreparedStatement
            ByteArrayInputStream imagenStream = new ByteArrayInputStream(p.getImagen());
            pre.setBinaryStream(6, imagenStream, p.getImagen().length);
            pre.setString(7, p.getEstado());
            pre.setInt(8, p.getId());
            res = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al modificar" + e.getMessage());
        } finally {
            this.desconectar();
        }
        return res;
    }

    public int eliminarProducto(producto p) {
        int res = 0;
        try {
            this.conectar();
            String sql = "DELETE FROM producto WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, p.getId());
            res = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al eliminar" + e.getMessage());
        } finally {
            this.desconectar();
        }
        return res;
    }
    
    public void actualizarCantidadProductos(int idProducto, int nuevaCantidad) {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Conexion conexion = new Conexion();
            conexion.conectar();
            conn = conexion.getCon();

            String query = "UPDATE producto SET cantidad = ?, estado = ? WHERE id = ?";
            // Determinar el estado basado en la nueva cantidad
            String estado = (nuevaCantidad > 0) ? "estado" : "no disponible";
            
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, nuevaCantidad);
            stmt.setString(2, estado);
            stmt.setInt(3, idProducto);
            stmt.executeUpdate();
        } catch (SQLException e) {
            // Manejar excepciones de SQL
            e.printStackTrace();
        } finally {
            // Cerrar recursos
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}