import neo4j from "neo4j-driver";
const driver = neo4j.driver(
  "bolt://localhost:7689",
  neo4j.auth.basic("neo4j", "123456789"),
);
const session = driver.session(
  { database: "prueba" },
  { defaultAccessMode: neo4j.session.WRITE },
);
const createNodeQuery = "CREATE (p:Person {name: $name, age: $age}) RETURN p";
const parameters = { name: "Jorgeasdf", age: 40 };
session
  .run(createNodeQuery, parameters)
  .then((result) => {
    result.records.forEach((record) => {
      console.log(record.get("p").properties);
    });
  })
  .catch((error) => console.error(error))
  .finally(() => {
    session.close();
    driver.close();
  });
