/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.uts.dao;

import com.conexion.Conexion;
import com.uts.modelo.admin;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
/**
 *
 * @author ninoj
 */
public class AdminDAO extends Conexion {
    public ArrayList<admin> mostrarAdmins(){
        ArrayList<admin> listaU = new ArrayList<>();
        try{
            this.conectar();
            String sql = "SELECT * FROM admin";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            ResultSet rs;
            rs = pre.executeQuery();
            
            while(rs.next()){
                admin a = new admin();
                a.setUser(rs.getString(1));
                a.setContrasena(rs.getString(2));
                listaU.add(a);
            }
            
        }catch(SQLException e){
            System.out.println("Error al mostrar" +e.getMessage());
        } finally{
            this.desconectar();
        }
        return listaU;
    }
    public int insertarAdmins(admin a){
        int res = 0;
        try{
            this.conectar();
            String sql = "INSERT INTO admin(id, user, contrasena) VALUES (NULL, ?, ?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setString(1, a.getUser());
            pre.setString(2, a.getContrasena());
            res = pre.executeUpdate();
            // Recuperar el ID generado automáticamente
            ResultSet generatedKeys = pre.getGeneratedKeys();
            if (generatedKeys.next()) {
                int generatedId = generatedKeys.getInt(1);
                a.setId(generatedId); // Establecer el ID generado en el objeto Usuario
            } else {
                System.out.println("No se pudo obtener el ID generado");
            }
        }catch(SQLException e){
            System.out.println("Error al insertar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    public int modificarAdmin(admin a){
        int res = 0;
        try{
            this.conectar();
            String sql = "UPDATE admin SET user=?, contrasena=? WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, a.getUser());
            pre.setString(2, a.getContrasena());
            pre.setInt(3, a.getId());
            res = pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("Error al modificar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    public int eliminarAdmin(admin a){
        int res = 0;
        try{
            this.conectar();
            String sql = "DELETE FROM admin WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, a.getId());
            res = pre.executeUpdate();
        }catch(SQLException e){
            System.out.println("Error al eliminar" +e.getMessage());
        }finally{
            this.desconectar();
        }
        return res;
    }
    public admin obtenerUsuarioPorCredenciales(String user, String contrasena) {
        admin admin = null;

        try {
            this.conectar();
            String sql = "SELECT * FROM admin WHERE user=? AND contrasena=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, user);
            pre.setString(2, contrasena);

            ResultSet rs = pre.executeQuery();

            if (rs.next()) {
                admin = new admin();
                admin.setId(rs.getInt("id"));
                admin.setUser(rs.getString("user"));
                admin.setContrasena(rs.getString("contrasena"));
            }
        } catch (SQLException e) {
            System.out.println("Error al obtener usuario por credenciales: " + e.getMessage());
        } finally {
            this.desconectar();
        }

        return admin;
    }
}
