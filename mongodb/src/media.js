var data;
function media() {
  var boton = document.getElementById("guardar");
  boton.addEventListener("click", insertar, false);
}
function insertar() {
  var clave = document.getElementById("clave").value;
  var valor = document.getElementById("valor").value;
  localStorage.setItem(clave, valor);
  mostrar_dudas(clave);
  document.getElementById("clave").value = "";
  document.getElementById("valor").value = "";
}
function mostrar_dudas(clave) {
  data = document.getElementById("data");
  data.innerHTML = " ";
  data.innerHTML =
    '<div><button onclick="deleteAll()">Eliminar Todos</button></div>';
  for (i = 0; i < localStorage.length; i++) {
    var clave = localStorage.key(i);
    var mivalor = localStorage.getItem(clave);
    data.innerHTML +=
      "<div> Clave:" +
      clave +
      "--" +
      "Valor: " +
      mivalor +
      "<br><button onclick=\"deleteItem('" +
      clave +
      "')\">Eliminar</button></div>";
  }
}
function deleteAll() {
  if (confirm("¿Estás seguro?")) {
    localStorage.clear();
    mostrar_dudas();
  }
}
function deleteItem(clave) {
  if (confirm("¿Estás seguro?")) {
    localStorage.removeItem(clave);
    mostrar_dudas();
  }
}
