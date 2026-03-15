# Resumen Parcial 1

## Tipos de datos

### Relacional (SQL)
- Tablas estrictas, con filas y columnas, conectadas por claves foráneas. Garantiza un seguimiento estricto de ACID (Atomicidad, Consistencia, Aislamiento y Durabilidad).
- Se usa cuando el modelo de datos es altamente estructurado, las relaciones son estables y previsibles, y el sistema requiere una **integridad referencial estricta** y **consistencia absoluta** (ej.: transacciones bancarias, donde un error es inaceptable).
- No se debería usar cuando el sistema exige distribuir la carga entre múltiples servidores (escalabilidad horizontal), o cuando el esquema de datos cambia constantemente o es impredecible.

### Documentales (MongoDB)
- Almacena la información en documentos con formato similar a JSON, donde cada documento puede tener su propia estructura; esto permite representar datos complejos de forma flexible.
- Se usa cuando las entidades varían en estructura y el esquema necesita evolucionar con agilidad (ej.: catálogos de e-commerce donde cada producto tiene unas propiedades distintas).
- No se debería usar cuando existen relaciones complejas entre múltiples entidades distintas.

### Grafos (Neo4j)
- Almacena nodos (entidades) y aristas (relaciones), que se usan para representar los datos. Están diseñadas para manejar relaciones complejas, permitiendo explorarlas de manera eficiente.
- Se usa cuando el valor real de los datos reside en sus interconexiones y se necesita recorrer dependencias o saltos múltiples de forma muy rápida (ej.: cálculo de rutas óptimas, sistemas de recomendación).
- No se debería usar si lo que se necesita es recorrer todos los registros o los datos no están altamente conectados.

### Clave-Valor (DynamoDB)
- Los datos se almacenan de forma similar a un diccionario, como pares donde una clave única se asocia a un valor. El sistema no necesita comprender la estructura interna del valor, solo debe almacenarlo y recuperarlo eficientemente.
- Se usa cuando la prioridad absoluta es la baja latencia, bajo un gran número de peticiones (ej.: gestión de sesiones de usuario, tokens que caducan).
- No debería usarse cuando necesitas hacer búsquedas filtrando por los atributos que están dentro del dato.

### Columnares (Cassandra)
- Almacena los datos en familias de columnas en lugar de filas rígidas. Cada registro puede contener diferentes columnas según sea necesario, proporcionando mayor flexibilidad que el modelo relacional tradicional; es útil cuando se manejan grandes volúmenes de datos que no comparten la misma estructura.
- Se usa en escenarios de Big Data para procesar escrituras masivas ininterrumpidas y donde las lecturas requieren hacer sumas o cálculos sobre billones de registros (ej.: logs, telemetría de sensores).
- No debería usarse para aplicaciones transaccionales comunes, debido a su modelado complejo y antiintuitivo.

### Vectoriales (Pinecone)
- Almacenan información en forma de vectores numéricos que permiten medir la similitud entre datos.
- Se utilizan principalmente en aplicaciones de inteligencia artificial y búsqueda semántica (ej.: LLM).
- No deberían usarse como una base de datos transaccional o de negocio principal.

## Sintaxis MongoDB

### 1. Inserción de Datos (Create)

Añadir nuevos documentos a una colección.

**Insertar un solo documento (`insertOne`):**
```javascript
db.coleccion.insertOne({
  campo1: "valor",
  campo2: 123,
  campo3: true
})
```

**Insertar varios documentos (`insertMany`):**
*(Ojo: Requiere corchetes `[ ]` porque pasas una lista de objetos).*
```javascript
db.coleccion.insertMany([
  { campo1: "valorA", campo2: 10 },
  { campo1: "valorB", campo2: 20 }
])
```

### 2. Consultas (Read)

Estructura general: `db.coleccion.find({ filtro }, { proyeccion })`

**Filtros Básicos y Operadores:**
```javascript
// Búsqueda exacta
db.coleccion.find({ nivel: "intermedio" })

// Operadores de comparación
// $gt (mayor), $gte (mayor o igual), $lt (menor), $lte (menor o igual), $ne (distinto)
db.coleccion.find({ creditos: { $gte: 5 } })

// Operador $in (busca si el valor está dentro de una lista de opciones)
db.coleccion.find({ departamento: { $in: ["Informatica", "Matematicas"] } })

// Operadores lógicos ($and, $or)
db.coleccion.find({
  $or: [
    { creditos: { $gt: 6 } },
    { nivel: "avanzado" }
  ]
})
```

**Proyecciones (Filtrar columnas devueltas):**
Sirven para elegir qué campos queremos que nos devuelva la consulta.
* `1` significa "mostrar".
* `0` significa "ocultar".
* El `_id` siempre se muestra por defecto, hay que apagarlo explícitamente con `_id: 0`.

```javascript
// Devuelve SOLO el nombre del curso, y oculta el _id
db.coleccion.find(
  { nivel: "intermedio" }, // 1er parámetro: Filtro
  { nombre: 1, _id: 0 }    // 2do parámetro: Proyección
)
```

### 3. Actualizaciones (Update)

Estructura general: `db.coleccion.updateOne({ filtro }, { $operador: { cambios } })`

**Operadores de Actualización Principales:**
```javascript
// $set: Modifica el valor de un campo (o lo crea si no existe)
db.coleccion.updateOne(
  { nombre: "MongoDB Avanzado" }, // A quién actualizamos
  { $set: { creditos: 6, nivel: "experto" } } // Qué le cambiamos
)

// $inc: Incrementa o decrementa un valor numérico (ideal para contadores o sumar)
db.coleccion.updateOne(
  { nombre: "MongoDB Avanzado" },
  { $inc: { creditos: 2 } } // Le suma 2 a los créditos que ya tuviera
)

// $unset: Elimina un campo completamente del documento
db.coleccion.updateOne(
  { nombre: "MongoDB Avanzado" },
  { $unset: { campoViejo: "" } } 
)
```

**Operadores de Arrays (Listas):**
```javascript
// $push: Añade un elemento al final de una lista
db.coleccion.updateOne(
  { _id: 1 },
  { $push: { tags: "nuevoTag" } }
)

// $pull: Elimina de la lista el elemento especificado
db.coleccion.updateOne(
  { _id: 1 },
  { $pull: { tags: "tagViejo" } }
)
```

### 4. Aggregation Framework (Analítica Avanzada)

Es una tubería (*pipeline*) por donde pasan los datos. El resultado de una etapa es la entrada de la siguiente. Todo va dentro de un array `[ ]`.

**Ejemplo Completo Explicado:**
```javascript
db.coleccion.aggregate([
  // 1. MATCH: Filtramos igual que en un find()
  { 
    $match: { nivel: "intermedio" } 
  },
  
  // 2. GROUP: Agrupamos por un campo y usamos acumuladores
  { 
    $group: { 
      // El campo por el que agrupamos DEBE llevar "$" y comillas
      _id: "$departamento", 
      
      // Acumuladores matemáticos
      totalCursos: { $sum: 1 },         // Cuenta los documentos agrupados
      promedioCreditos: { $avg: "$creditos" }, // Promedio de un campo
      maximosCreditos: { $max: "$creditos" }   // Valor máximo
    } 
  },
  
  // 3. SORT: Ordenar resultados (1 ascendente, -1 descendente)
  { 
    $sort: { totalCursos: -1 } 
  },
  
  // 4. LIMIT: Quedarse con el Top N
  { 
    $limit: 5 
  }
])
```

### 5. Índices y Rendimiento

Los índices evitan que la base de datos lea todos los documentos uno por uno, logrando consultas instantáneas.

**Creación de Índices:**
```javascript
// Índice Simple (Ascendente: 1, Descendente: -1)
db.coleccion.createIndex({ nivel: 1 })

// Índice Único (Fuerza a que no existan registros duplicados en ese campo)
db.coleccion.createIndex({ email: 1 }, { unique: true })

// Índice Compuesto
// REGLA DE ORO: Primero el campo por el que filtras ($match/find), luego por el que ordenas ($sort)
db.coleccion.createIndex({ nivel: 1, creditos: -1 })
```

**Análisis de Consultas (Explain):**
Si en el examen te piden auditar o explicar una consulta, añade `.explain("executionStats")` al final del `find`.

```javascript
db.coleccion.find({ nivel: "intermedio" }).explain("executionStats")
```

**Qué debes buscar en la salida del Explain (Teoría clave):**
* `stage: "IXSCAN"` $\rightarrow$ **¡Excelente!** Usó el índice (Index Scan).
* `stage: "COLLSCAN"` $\rightarrow$ **¡Peligro!** Escaneó toda la colección (Collection Scan). Te falta crear un índice.
* `totalDocsExamined` $\rightarrow$ Cuántos documentos leyó del disco.
* `nReturned` $\rightarrow$ Cuántos devolvió. (Si examina 10,000 para devolver 2, la consulta es ineficiente).
