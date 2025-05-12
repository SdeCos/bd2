import neo4j from "neo4j-driver";
const driver = neo4j.driver(
  "bolt://localhost:7689",
  neo4j.auth.basic("neo4j", "123456789"),
);
const session = driver.session(
  { database: "Laboral" },
  { defaultAccessMode: neo4j.session.WRITE },
);
const createNodeQuery = "UNWIND $props AS map CREATE (n:Person) SET n = map";
const parameters = {
  props: [
    {
      name: "Melissa",
      twitter: "@melissa",
      yearsExperience: 0,
      birthdate: "",
    },
    {
      name: "Dan",
      twitter: "@dan",
      yearsExperience: 6,
      birthdate: "",
    },
    {
      name: "Sally",
      twitter: "",
      yearsExperience: 4,
      birthdate: "",
    },
  ],
};
session
  .run(createNodeQuery, parameters)
  .then((result) => {
    result.records.forEach((record) => {
      console.log(record.get(parameters).properties);
    });
  })
  .catch((error) => console.error(error))
  .finally(() => {
    session.close();
    driver.close();
  });
