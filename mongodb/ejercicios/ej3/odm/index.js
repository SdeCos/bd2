import mongoose from "mongoose";
import { getdata } from "./api.js";
const { Schema, model } = mongoose;
let uri = "mongodb://saul:1234@localhost:27018/uni_2025_ej4?authSource=admin";
//trayendo la data del api
const query = await getdata()
  .then((data) => {
    console.log(data);
    return data;
  })
  .catch((error) => {
    console.log("no va");
    console.log(error);
    process.exit(0);
  });

const options = {
  autoIndex: false, // Don't build indexes
  maxPoolSize: 10, // Maintain up to 10 socket connections
  serverSelectionTimeoutMS: 5000, // Keep trying to send operations for 5 seconds
  socketTimeoutMS: 45000, // Close sockets after 45 seconds of inactivity
  family: 4, // Use IPv4, skip trying IPv6
};
mongoose.connect(uri, options).then(
  () => {
    console.log("se ha conectado exitosamente");
  },
  (err) => {
    console.log("no se ha podido conectar");
    console.log(err);
  },
);
/*Agregue un campo enum que contemple el estatus de la matrícula. Dicho status puede ser:
   1.No matriculado
   2.En proceso
   3.Matriculado
   4.Otro*/
/*Agregue un array matricula compuesto por:
1. Primera
2.Segunda
3. Tercera*/
/*Agregue un esquema "alumno" que contenga:
1. Un id númerico agregado por el alumno con el número que prefiera
2. Un campo name con el valor de su nombre,
3.Un campo last_name con el valor de su apellido
4.Un campo dni alphanumérico con el valor de su dni*/
const takesSchema = new mongoose.Schema({
  course_id: { type: String, index: true },
  sec_id: { type: String },
  semester: { type: String },
  year: { type: mongoose.Types.Decimal128 },
  grade: { type: String },
  update: { type: Date, default: Date.now },
});

let takes = new mongoose.model("takes2", takesSchema);
try {
  let inserted_a = await takes.insertMany(query.takes);
  //console.log(inserted_a);
  process.exit(0);
} catch (e) {
  console.log("Some error");
  console.log(e);
  process.exit(0);
}
