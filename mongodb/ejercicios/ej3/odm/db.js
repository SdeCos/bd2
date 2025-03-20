import mongoose from "mongoose";

let uri = "mongodb://saul:1234@localhost:27018/test?authSource=admin";

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
    console.log("Error conectandose a mongodb");
    console.log(err);
  },
);

export default mongoose;
