import mongoose from "./db.js";
const { Schema, model } = mongoose;

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

const Takes = mongoose.model("takes2", takesSchema);

export { Takes };
