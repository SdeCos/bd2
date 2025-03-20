import mongoose from "mongoose";
import dbConfig from "./dbConfig.js";

const uri = `mongodb://${dbConfig.username}:${dbConfig.password}@${dbConfig.host}:${dbConfig.port}/${dbConfig.database}?authSource=${dbConfig.authSource}`;

const options = {
  autoIndex: false,
  maxPoolSize: 10,
  serverSelectionTimeoutMS: 5000,
  socketTimeoutMS: 45000,
  family: 4,
};

mongoose.connect(uri, options).then(
  () => {
    console.log("Se ha conectado correctamente");
  },
  (err) => {
    console.log("Error conectandose a mongodb");
    console.log(err);
  },
);

export default mongoose;
