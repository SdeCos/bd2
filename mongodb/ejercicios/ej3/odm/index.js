import { getdata } from "./api.js";
import { Takes } from "./schemas.js";

const query = await getdata()
  .then((data) => {
    console.log(data);
    return data;
  })
  .catch((error) => {
    console.log(
      "Error al recibir informacion del API, comprueba que la informacion de conexion es correcta",
    );
    console.log(error);
    process.exit(0);
  });

try {
  let inserted_a = await Takes.insertMany(query["1"]);
  process.exit(0);
} catch (e) {
  console.log("Error insertando informacion en la base de datos de MongoDB");
  console.log(e);
  process.exit(0);
}
