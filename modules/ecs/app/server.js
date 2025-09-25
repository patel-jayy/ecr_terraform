const express = require("express");
const mysql = require("mysql2/promise");

const app = express();
const port = 80;

app.get("/", (req, res) => {
  res.send("Hello from ECS Node App!");
});

app.get("/db", async (req, res) => {
  try {
    const connection = await mysql.createConnection({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME
    });

    await connection.query("SELECT 1");
    res.send("✅ Successfully connected to RDS!");
    await connection.end();
  } catch (err) {
    console.error(err);
    res.status(500).send("❌ DB connection failed");
  }
});

app.listen(port, () => {
  console.log(`App running on port ${port}`);
});
