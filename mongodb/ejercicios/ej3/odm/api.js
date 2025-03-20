import fetch from "node-fetch";
let API = "http://localhost:8000";

export async function getdata() {
  const res = await fetch(API);
  const data = await res.json();
  try {
    return data;
  } catch (e) {
    console.log(
      "Error recibiendo informacion del API php, comprueba que el servidor esta iniciado y en el puerto correspondiente",
    );
    console.log(e);
    process.exit(0);
  }
}
