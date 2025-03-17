import mongoose from "mongoose";
import { getdata } from "./api.js";
const { Schema, model } = mongoose;
let uri = "mongodb://saul:1234@127.0.0.1:27017/intersect";
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

/*Valorar el caso en que query sea un array de strins como*/
/*let query = {
  intersect: ["DARWIN"], // Ahora es un array de strings
};*/
console.log(query);
const options = {
  autoIndex: false, // Don't build indexes
  maxPoolSize: 10, // Maintain up to 10 socket connections
  serverSelectionTimeoutMS: 5000, // Keep trying to send operations for 5 seconds
  socketTimeoutMS: 45000, // Close sockets after 45 seconds of inactivity
  family: 4, // Use IPv4, skip trying IPv6
  authSource: "admin",
};
mongoose.connect(uri, options).then(
  () => {
    console.log("se ha conectado exitosamente");
  },
  (err) => {
    console.log("no se ha podido conectar");
  },
);

const intersectSchema = new mongoose.Schema({
  // Caso 1: Array de objetos
  intersect: [
    {
      edificio: { type: String, required: true },
    },
  ],
  // Caso 2: Cadena
  edificio: { type: String },
  // Caso 3: Array de strings
  /* intersect: [{
		type: String, required: true   
	  }],*/
});
//TODO:
//let intersect = new mongoose.model("intersect", intersectSchema);
//console.log(intersect);
//try {
//  let intersect_a = await intersect.insertOne(query.intersect);
//  let intersect_b = await intersect.insertOne(query.intersect[0]);
//  process.exit(0);
//} catch (e) {
//  console.log("Some error");
//  console.log(e);
//  process.exit(0);
//}
//
let intersect = new mongoose.model("intersect", intersectSchema);

// Fetching data from API

// Check if query.advisor is an array and has data
try {
  // Insert the whole advisor array into the database
  let intersect_a = await intersect.insertMany(query.advisor);

  // Optionally, insert the first element if needed
  let intersect_b = await intersect.insertOne(query.advisor[0]);
  console.log(intersect_a, intersect_b);

  process.exit(0);
} catch (e) {
  console.log("Some error occurred during insertion:");
  console.log(e);
  process.exit(0);
}
