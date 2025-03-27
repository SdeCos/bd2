import mongoose from "mongoose";
import { getdata } from "./api.js";
const { Schema, model } = mongoose;
let uri = "mongodb://saul:1234@127.0.0.1:27018/prueba1?authSource=admin";
const query = await getdata()
  .then((data) => {
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
    process.exit(0);
  },
);

const courseSchema = new Schema({
  course_id: String,
  title: String,
  dept_name: String,
  credits: Number,
  ID: String,
  sec_id: String,
  semester: String,
  year: Number,
});

const instructorSchema = new Schema({
  ID: String,
  name: String,
  dept_name: String,
  salary: Number,
});

const jsonAllSchema = new Schema({
  id: Number,
  json_register: String,
});

const studentCourseSchema = new Schema({
  ID: String,
  name: String,
  dept_name: String,
  tot_cred: Number,
  course_id: String,
  sec_id: String,
  semester: String,
  year: Number,
});
// crear funcion insertData

let objectsagregations = new mongoose.model("objectsagregations", courseSchema);
let objectsbasics = new mongoose.model("objectsbasics", instructorSchema);
let objectscomplexes = new mongoose.model("objectscomplexes", jsonAllSchema);
let objectsindexs = new mongoose.model("objectsindexs", studentCourseSchema);

console.log(query.course);
try {
  let insert_a = await objectsagregations.insertMany(query.objectsagregations);
  let insert_b = await objectsbasics.insertMany(query.objectsbasics);
  let insert_c = await objectscomplexes.insertMany(query.objectscomplexes);
  let insert_d = await objectsindexs.insertMany(query.objectsindexs);
  process.exit(0);
} catch (e) {
  console.log("Some error");
  console.log(e);
  process.exit(0);
}
