# Docker - MongoDB

## Comandos

**Levantar el entorno en segundo plano:**

```bash
docker compose up -d
```

**Ver los logs (si algo falla o no arranca):**

```bash
docker compose logs -f
```

**Apagar el entorno al terminar:**

```bash
docker compose down
```

**BOTÓN DE PÁNICO: Borrar la base de datos entera y empezar de cero:**
_(Úsalo si has roto la base de datos haciendo pruebas y necesitas volver al estado inicial)._

```bash
docker compose down -v
```

---

## 🚨 Solución de Errores Frecuentes

### Error: `The container name "..." is already in use`

Si al hacer el `up` recibes un error diciendo que el contenedor ya está en uso (Conflict), significa que un entorno anterior se ha quedado atascado en tu ordenador y no se borró correctamente.

**Solución rápida (Fuerza el borrado de los contenedores conflictivos):**

```bash
docker rm -f mongo_express_docencia mongodb_docencia mongosh_docencia mongo_init_docencia
```

_(Después de ejecutar esto, vuelve a lanzar el `docker compose up -d` y funcionará a la primera)._

---

## Conexion a la BD

### [Usando 1-teoria(bueno)](<./1-teoria(bueno)>)

Si usas la carpeta `1-teoria(bueno)`, tienes dos formas de conectarte:

- **Visual (Recomendado):** Abre en tu navegador http://localhost:8091
- **Consola:** Abre otra terminal y pégalo directamente en el contenedor durmiente de mongosh:

```bash
docker exec -it mongosh_docencia mongosh "mongodb://admin:admin123@mongodb_docencia:27017/"
```

### [Usando 6-modeladoavanzado(transacciones)](<./6-modeladoavanzado(transacciones)>)

Si el examen te obliga a usar transacciones ACID y levantas esta carpeta, recuerda que **no hay interfaz gráfica (Mongo Express)** y no hay usuario/contraseña configurados.

- **Consola:** Abre una terminal y pega este comando para entrar directamente al contenedor de mongosh conectado al Replica Set:

```bash
docker exec -it mongosh_docencia mongosh "mongodb://mongodb_docencia:27017/"
```

