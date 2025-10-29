    <footer class="bg-dark text-light mt-5 py-3">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; @copyright 2025 Proyecto Web JSP. Todos los derechos reservados.</p>
                </div>
                <div class="col-md-6 text-end">
                    <small>
                        <c:choose>
                            <c:when test="${not empty usuario}">
                                Usuario: ${correoUsuario} | Rol: ${rolUsuario}
                            </c:when>
                            <c:otherwise>
                                No autenticado
                            </c:otherwise>
                        </c:choose>
                    </small>
                </div>
            </div>
        </div>
    </footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>