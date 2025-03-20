import { getdata } from "./api.js";
import { Takes } from "./schemas.js";

// trayendo la data del api
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

try {
  let inserted_a = await Takes.insertMany(query.takes);
  //console.log(inserted_a);
  process.exit(0);
} catch (e) {
  console.log("Some error");
  console.log(e);
  process.exit(0);
}
