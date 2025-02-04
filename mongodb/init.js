db = db.getSiblingDB("saul");
db.createUser({
  user: "saul",
  pwd: "1234",
  roles: [
    { role: "userAdminAnyDatabase", db: "admin" },
    { role: "readWriteAnyDatabase", db: "admin" },
  ],
});
