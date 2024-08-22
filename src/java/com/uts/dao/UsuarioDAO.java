/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uts.dao;

import com.conexion.Conexion;
import com.uts.modelo.usuario;
import java.io.ByteArrayInputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author ninoj
 */
public class UsuarioDAO extends Conexion{
    public ArrayList<usuario> mostrarUsuarios(){
        ArrayList<usuario> listaU = new ArrayList<>();
        try{
            this.conectar();
            String sql = "SELECT * FROM usuario";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            ResultSet rs;
            rs = pre.executeQuery();
            
            while(rs.next()){
                usuario u = new usuario();
                u.setId(rs.getInt(1));
                u.setNombres(rs.getString(2));
                u.setApellidos(rs.getString(3));
                u.setTelefono(rs.getLong(4));
                u.setCorreo(rs.getString(5));
                u.setTipoDocumento(rs.getString(6));
                u.setDocumento(rs.getLong(7));
                u.setNombreUsuario(rs.getString(8));
                u.setImagen(rs.getBytes(9));
                u.setContrasena(rs.getString(10));
                listaU.add(u);
            }
            
        }catch(SQLException e){
            System.out.println("Error al mostrar" +e.getMessage());
        } finally{
            this.desconectar();
        }
        return listaU;
    }
    public int insertarUsuario(usuario u) {
        int res = 0;
        try {
            this.conectar();
            String sql = "INSERT INTO usuario(id, nombres, apellidos, telefono, correo, tipoDocumento, documento, nombre_usuario, contrasena, imagen) VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setString(1, u.getNombres());
            pre.setString(2, u.getApellidos());
            pre.setLong(3, u.getTelefono());
            pre.setString(4, u.getCorreo());
            pre.setString(5, u.getTipoDocumento());
            pre.setLong(6, u.getDocumento());
            pre.setString(7, u.getNombreUsuario());
            pre.setString(8, u.getContrasena());
            // Set image as a stream of bytes
            ByteArrayInputStream imagenStream = new ByteArrayInputStream(u.getImagen());
            pre.setBinaryStream(9, imagenStream, u.getImagen().length);
            res = pre.executeUpdate();
            // Recover the automatically generated ID
            ResultSet generatedKeys = pre.getGeneratedKeys();
            if (generatedKeys.next()) {
                int generatedId = generatedKeys.getInt(1);
                u.setId(generatedId); // Set the generated ID in the User object
            } else {
                System.out.println("Could not get the generated ID");
            }
        } catch (SQLException e) {
            System.out.println("Error al insertar" + e.getMessage());
        } finally {
            this.desconectar();
        }
        return res;
    }
    public int modificarUsuario(usuario u) {
        int res = 0;
        try {
            this.conectar();
            String sql = "UPDATE usuario SET nombres=?, apellidos=?, telefono=?, correo=?, tipoDocumento=?, documento=?, nombre_usuario=?, contrasena=? WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, u.getNombres());
            pre.setString(2, u.getApellidos());
            pre.setLong(3, u.getTelefono());
            pre.setString(4, u.getCorreo());
            pre.setString(5, u.getTipoDocumento());
            pre.setLong(6, u.getDocumento());
            pre.setString(7, u.getNombreUsuario());
            pre.setString(8, u.getContrasena());
            pre.setInt(9, u.getId());
            res = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al modificar" + e.getMessage());
        } finally {
            this.desconectar();
        }
        return res;
    }
    public int eliminarUsuario(usuario u){
        int res = 0;
        try{
            this.conectar();
            String sql = "DELETE FROM usuario WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, u.getId());
            res = pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("Error al eliminar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    public usuario obtenerUsuarioPorCredenciales(String correo, String contrasena) {
    usuario usuario = null;

    try {
        this.conectar();
        String sql = "SELECT * FROM usuario WHERE correo=? AND contrasena=?";
        PreparedStatement pre = this.getCon().prepareStatement(sql);
        pre.setString(1, correo);
        pre.setString(2, contrasena);

        ResultSet rs = pre.executeQuery();

        if (rs.next()) {
            usuario = new usuario();
            usuario.setId(rs.getInt("id"));
            usuario.setNombres(rs.getString("nombres"));
            usuario.setApellidos(rs.getString("apellidos"));
            usuario.setTelefono(rs.getLong("telefono"));
            usuario.setCorreo(rs.getString("correo"));
            usuario.setTipoDocumento(rs.getString("tipoDocumento"));
            usuario.setDocumento(rs.getLong("documento"));
            usuario.setNombreUsuario(rs.getString("nombre_usuario"));
            usuario.setContrasena(rs.getString("contrasena"));
            // Retrieve image as byte array
            usuario.setImagen(rs.getBytes("imagen"));
        }
    } catch (SQLException e) {
        System.out.println("Error al obtener usuario por credenciales: " + e.getMessage());
    } finally {
        this.desconectar();
    }

    return usuario;
}
    public boolean existeCorreo(String correo) {
        boolean existe = false;
        
        try {
            this.conectar();
            String sql = "SELECT COUNT(*) FROM usuario WHERE correo=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, correo);
            ResultSet rs = pre.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    existe = true;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al verificar correo: " + e.getMessage());
        } finally {
            this.desconectar();
        }
        
        return existe;
    }
    
    public usuario obtenerUsuarioPorId(int id) {
        usuario u = null;
        try {
            this.conectar();
            String sql = "SELECT * FROM usuario WHERE id = ?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            
            if (rs.next()) {
                u = new usuario();
                u.setId(rs.getInt("id"));
                u.setNombres(rs.getString("nombres"));
                u.setApellidos(rs.getString("apellidos"));
                u.setTelefono(rs.getLong("telefono"));
                u.setCorreo(rs.getString("correo"));
                u.setTipoDocumento(rs.getString("tipoDocumento"));
                u.setDocumento(rs.getLong("documento"));
                u.setNombreUsuario(rs.getString("nombre_usuario"));
                u.setImagen(rs.getBytes("imagen"));
                u.setContrasena(rs.getString("contrasena"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error al obtener usuario por ID: " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return u;
    }
    
}

