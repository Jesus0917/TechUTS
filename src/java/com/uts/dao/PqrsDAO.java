package com.uts.dao;

import com.conexion.Conexion;
import com.uts.modelo.pqrs;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class PqrsDAO extends Conexion {

    public ArrayList<pqrs> mostrarPQRS() {
        ArrayList<pqrs> listaPQRS = new ArrayList<>();
        try {
            this.conectar();
            String sql = "SELECT * FROM pqrs";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            ResultSet rs = pre.executeQuery();

            while (rs.next()) {
                pqrs p = new pqrs();
                p.setId(rs.getInt("id"));
                p.setDescripcion(rs.getString("descripcion"));
                listaPQRS.add(p);
            }

        } catch (SQLException e) {
            System.out.println("Error al mostrar pqrs: " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return listaPQRS;
    }

    public int insertarPQRS(pqrs p) {
        int res = 0;
        try {
            this.conectar();
            String sql = "INSERT INTO pqrs(id, descripcion) VALUES (NULL, ?)";
            PreparedStatement pre = this.getCon().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setString(1, p.getDescripcion());
            res = pre.executeUpdate();
            // Recuperar el ID generado automáticamente
            ResultSet generatedKeys = pre.getGeneratedKeys();
            if (generatedKeys.next()) {
                int generatedId = generatedKeys.getInt(1);
                p.setId(generatedId); // Establecer el ID generado en el objeto pqrs
            } else {
                System.out.println("No se pudo obtener el ID generado");
            }
        } catch (SQLException e) {
            System.out.println("Error al insertar pqrs: " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return res;
    }

    public int modificarPQRS(pqrs p) {
        int res = 0;
        try {
            this.conectar();
            String sql = "UPDATE pqrs SET descripcion=? WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setString(1, p.getDescripcion());
            pre.setInt(2, p.getId());
            res = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al modificar pqrs: " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return res;
    }

    public int eliminarPQRS(pqrs p) {
        int res = 0;
        try {
            this.conectar();
            String sql = "DELETE FROM pqrs WHERE id=?";
            PreparedStatement pre = this.getCon().prepareStatement(sql);
            pre.setInt(1, p.getId());
            res = pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al eliminar pqrs: " + e.getMessage());
        } finally {
            this.desconectar();
        }
        return res;
    }
}