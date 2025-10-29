package org.ies63.progI.entities;


	public class Usuario {

		private String correo;
		private String clave;
		private String nombreUsuario;
		private Rol rol;
		public Usuario() {}

		public Usuario(String correo, String clave, String nombreUsuario, Rol rol) {
			this.correo = correo;
			this.clave = clave;
			this.nombreUsuario = nombreUsuario;
			this.rol = rol;
		}

		public String getNombreUsuario() {
			return nombreUsuario;
		}

		public void setNombreUsuario(String nombreUsuario) {
			this.nombreUsuario = nombreUsuario;
		}

		public Usuario(String correo, String clave) {
			this.correo = correo;
			this.clave = clave;
		}

		public Rol getRol() {
			return rol;
		}

		public void setRol(Rol rol) {
			this.rol = rol;
		}


		@Override
		public String toString() {
			return "Usuario [correo=" + correo + ", clave=" + clave + "]";
		}

		public String getCorreo() {
			return correo;
		}

		public void setCorreo(String correo) {
			this.correo = correo;
		}

		public String getClave() {
			return clave;
		}

		public void setClave(String clave) {
			this.clave = clave;
		}

}
