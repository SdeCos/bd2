import mongoose from "mongoose";
import { getdata } from "./api.js";

const { Schema, model } = mongoose;
// conexion con mongodb, al usar docker necestio autenticarme con mi usuario y contraseña (saul:1234), además de
// tener que indicar que la base de datos de autenticacion es admin (?authSource=admin)
const uri = "mongodb://saul:1234@127.0.0.1:27017/prueba?authSource=admin";

// configuracion de la conexion
const options = {
  autoIndex: true, // permite la creacion automatica de los indices definidos en los esquemas
  maxPoolSize: 10, // numero maximo de conexiones simultaneas en el pool
  serverselectiontimeoutMS: 5000, // tiempo maximo para seleccionar un servidor antes de lanzar error
  socketTimeoutMS: 45000, // tiempo maximo antes de cerrar un socket inactivo
  family: 4, // establece que las conexiones se haran por IPv4
};

mongoose.connect(uri, options).then(
  () => console.log("conexion correcta"), // conexion correcta
  (err) => console.log(err), // imprime el error si la conexion falla
);

let registro = {
  alumno: [
    {
      s_id: 1,
      name: "Saul",
      last_name: "De Cos Sanchez",
      dni: "72194936Y",
    },
  ],
};

// esquemas
// alumno
const alumnoSchema = new mongoose.Schema({
  id: { type: Number },
  name: { type: String },
  last_name: { type: String },
  dni: { type: String },
});

//natural join
const naturalJoinSchema = new Schema({
  course_id: { type: String },
  title: { type: String },
  dept_name: { type: String },
  credits: { type: Number },
  ID: { type: Number },
  sec_id: { type: Number },
  semester: { type: String },
  year: { type: Number },
});

//natural join con indices
const naturalJoin2Schema = new Schema({
  course_id: { type: String, index: true },
  title: { type: String },
  dept_name: { type: String },
  credits: { type: Number },
  ID: { type: Number },
  sec_id: { type: Number },
  semester: { type: String },
  year: { type: Date, default: Date.now },
});

const objectsBasicsSchema = new Schema({
  ID: { type: String },
  name: { type: String },
  dept_name: { type: String },
  salary: { type: mongoose.Types.Decimal128 },
});

const jsonSchema = new mongoose.Schema({
  ID: { type: String }, // campo id, cadena de texto
  name: { type: String }, // campo nombre, cadena de texto
  takes: [
    // array de objetos (en este caso cursos que toma un estudiante)
    {
      // estructura que tiene cada elemento del array
      year: { type: Number }, // campo year, numero
      semester: { type: String }, // campo semester, cadena de texto
      course_id: { type: String }, // campo id curso, cadena de texto
    },
  ],
  dept_name: { type: String }, // campo nombre departamento, cadena de texto
});

naturalJoin2Schema.index({ course_id: 1, credits: -1 });
// crea indice en el esquema naturalJoin2Schema, ordena el campo course_id
// de manera ascendente (1) y credits de manera descendente (-1)

let alumno = new mongoose.model("alumno", alumnoSchema);
// crea el modelo alumno a partir del esquema alumnoSchema

const CreditsForCourses = model(
  "CreditsForCourses",
  new Schema({ _id: mongoose.Types.Decimal128, creditTotal: Number }),
);
// crea el modelo y el esquema a la vez

let ObjectsAgregations = new mongoose.model(
  "objectAgregations",
  naturalJoinSchema,
);
// crea el modelo alumno a partir del esquema naturalJoinSchema

let ObjectsBasics = new mongoose.model("objectBasics", objectsBasicsSchema);
let ObjectsIndexs = new mongoose.model("objectIndexs", naturalJoin2Schema);
let ObjectsComplexes = model("objectComplexes", jsonSchema);
// crea el resto de modelos

// main
async function main() {
  try {
    const data = await getdata();
    //console.log("Datos obtenidos:", data);

    let inserted_a = await alumno.insertMany(registro.alumno);
    let inserted_b = await ObjectsAgregations.insertMany(data.reunionnatural);
    // inserta documentos desde el api (data.reunionnatural (nombre variable api)),
    // a la coleccion ObjectsAgregations

    let inserted_d = await ObjectsBasics.insertMany(data.instructors);
    // inserta documentos desde el api (data.instructors (nombre variable api)),
    // a la coleccion ObjectsBasics

    let inserted_e = await ObjectsIndexs.insertMany(data.reunionnatural);
    // inserta documentos desde el api (data.reunionnatural (nombre variable api)),
    // a la coleccion ObjectsIndexs

    // procesa y transforma los datos JSON antes de insertarlos en MongoDB
    data.json = data.json
      // .json es nombre variable del api
      .map((item) => {
        try {
          return {
            object_mongodb: JSON.parse(item.object_mongodb),
            // object_mongodb es el nombre de la columna en la que se encuentran los datos json
          };
        } catch (error) {
          console.error("error:", error, "data:", item);
          return null;
        }
      })
      .filter((item) => item !== null);
    // elimina elementos null (los que dieron error)

    await ObjectsComplexes.create({ json: data.json.json_register });
    // accede a la columna json_register dentro de la tabla json de mysql

    // agregacion calculando los creditos totales
    const creditsForCourses = await CreditsForCourses.aggregate([
      {
        $group: { _id: { $year: "$year" }, creditTotal: { $sum: "$credits" } },
        // agrupa los elementos por el campo year y suma el campo credits
        // equivalente a SELECT year, SUM(credits) FROM tabla GROUP BY year
      },
      { $sort: { _id: -1 } }, // ordena los resultados por año de manera descendente
    ]);

    console.log("creditos por año:", creditsForCourses);

    // inserta la agregacion hecha anteriormente en CreditsForCourses
    await Promise.all(
      creditsForCourses.map(async (doc) => {
        await CreditsForCourses.updateOne(
          { _id: doc._id },
          { $set: { creditTotal: doc.creditTotal } },
          { upsert: true }, // crea el documento en caso de que no exista
        );
      }),
    );
    console.log("creditos por año insertados");

    console.log("ejecucion correcta");
    process.exit(0);
  } catch (error) {
    console.error("error:", error);
    process.exit(1);
  }
}

// Ejecutar la función principal
main();
