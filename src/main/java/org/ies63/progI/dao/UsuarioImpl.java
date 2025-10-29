package org.ies63.progI.dao;

import org.ies63.progI.entities.Rol;
import org.ies63.progI.entities.Usuario;
import org.ies63.progI.interfaces.AdmConnexion;
import org.ies63.progI.interfaces.DAO;
import org.ies63.progI.util.PasswordUtil;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UsuarioImpl implements AdmConnexion, DAO<Usuario, String> {
	private PreparedStatement psInsertar;
	private PreparedStatement psBuscar;
	private PreparedStatement psActualizar;
	private PreparedStatement psActualizarPassword;
	private PreparedStatement psEliminar;

	// Consultas SQL corregidas
	private static final String SQL_INSERT =
			"INSERT INTO usuarios (correo, clave, nombreUsuario, rol) " +
					"VALUES (?, ?, ?, ?)";

	private static final String SQL_UPDATE =
			"UPDATE usuarios SET nombreUsuario = ?, rol = ? " +
					"WHERE correo = ?";

	private static final String SQL_UPDATE_PASSWORD =
			"UPDATE usuarios SET clave = ? WHERE correo = ?";

	private static final String SQL_DELETE =
			"DELETE FROM usuarios WHERE correo = ?";

	private static final String SQL_GETALL =
			"SELECT correo, clave, nombreUsuario, rol FROM usuarios";

	private static final String SQL_GETBYID =
			"SELECT correo, clave, nombreUsuario, rol FROM usuarios WHERE correo = ?";

	@Override
	public Usuario getById(String id) {
		Usuario usuario = null;

		try {
			if (null == psBuscar) {
				psBuscar = obtenerConexion().prepareStatement(SQL_GETBYID);
			}

			psBuscar.setString(1, id);
			ResultSet resultado = psBuscar.executeQuery();

			if (resultado.next()) {
				usuario = new Usuario();
				usuario.setCorreo(resultado.getString("correo"));
				usuario.setClave(resultado.getString("clave"));
				usuario.setNombreUsuario(resultado.getString("nombreUsuario"));
				usuario.setRol(Rol.valueOf(resultado.getString("rol")));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return usuario;
	}

	@Override
	public List<Usuario> getAll() {
		List<Usuario> usuarios = new ArrayList<>();

		try {
			if (null == psBuscar) {
				psBuscar = obtenerConexion().prepareStatement(SQL_GETALL);
			}

			ResultSet resultado = psBuscar.executeQuery();

			while (resultado.next()) {
				Usuario usuario = new Usuario();
				usuario.setCorreo(resultado.getString("correo"));
				usuario.setClave(resultado.getString("clave")); // Mantenemos el hash para posibles migraciones
				usuario.setNombreUsuario(resultado.getString("nombreUsuario"));
				usuario.setRol(Rol.valueOf(resultado.getString("rol")));
				usuarios.add(usuario);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return usuarios;
	}

	@Override
	public void insert(Usuario objeto) {
		Usuario usuario = objeto;
		try {
			if (null == psInsertar) {
				psInsertar = obtenerConexion().prepareStatement(SQL_INSERT);
			}

			// Validar y hashear la contraseña antes de insertar
			String claveHash = PasswordUtil.hashPassword(usuario.getClave());

			psInsertar.setString(1, usuario.getCorreo());
			psInsertar.setString(2, claveHash); // Guardar el hash, no la contraseña en texto plano
			psInsertar.setString(3, usuario.getNombreUsuario());
			psInsertar.setString(4, usuario.getRol().toString());

			psInsertar.executeUpdate();
			System.out.println("Usuario insertado: " + usuario.getCorreo());

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			System.err.println("Error al hashear contraseña para " + usuario.getCorreo() + ": " + e.getMessage());
		}
	}

	@Override
	public void update(Usuario objeto) {
		Usuario usuario = objeto;
		try {
			if (null == psActualizar) {
				psActualizar = obtenerConexion().prepareStatement(SQL_UPDATE);
			}

			psActualizar.setString(1, usuario.getNombreUsuario());
			psActualizar.setString(2, usuario.getRol().toString());
			psActualizar.setString(3, usuario.getCorreo());

			psActualizar.executeUpdate();
			System.out.println("Usuario actualizado: " + usuario.getCorreo());

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Método adicional para actualizar solo la contraseña
	 */
	public void updatePassword(String correo, String nuevaClavePlana) {
		try {
			if (null == psActualizarPassword) {
				psActualizarPassword = obtenerConexion().prepareStatement(SQL_UPDATE_PASSWORD);
			}

			// Hashear la nueva contraseña
			String claveHash = PasswordUtil.hashPassword(nuevaClavePlana);

			psActualizarPassword.setString(1, claveHash);
			psActualizarPassword.setString(2, correo);

			psActualizarPassword.executeUpdate();
			System.out.println("Contraseña actualizada para: " + correo);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			System.err.println("Error al hashear nueva contraseña para " + correo + ": " + e.getMessage());
		}
	}

	/**
	 * Método para verificar si una contraseña es válida para un usuario
	 */
	public boolean verificarPassword(String correo, String clavePlana) {
		Usuario usuario = getById(correo);
		if (usuario == null) {
			return false;
		}
		return PasswordUtil.verifyPassword(clavePlana, usuario.getClave());
	}

	@Override
	public void delete(String id) {
		try {
			if (null == psEliminar) {
				psEliminar = obtenerConexion().prepareStatement(SQL_DELETE);
			}
			psEliminar.setString(1, id);
			psEliminar.executeUpdate();
			System.out.println("Usuario eliminado: " + id);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean existsById(String id) {
		return getById(id) != null;
	}
}