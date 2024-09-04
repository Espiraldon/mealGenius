const express = require("express");
const mysql = require("mysql2");

const app = express();
const port = 3000;

// Configurer la connexion à la base de données MySQL locale
const connection = mysql.createConnection({
  host: "0.0.0.0",
  user: "User", // Utilisateur MySQL
  password: "Naila1305", // Mot de passe MySQL
  database: "food_db", // Nom de ta base de données
});

// Connecter à MySQL
connection.connect((err) => {
  if (err) {
    console.error("Erreur de connexion à MySQL:", err);
    return;
  }
  console.log("Connecté à la base de données MySQL");
});
app.get("/ingredient/search/:query", (req, res) => {
  const query = req.params.query;

  // Requête SQL pour la correspondance partielle
  const sql = "SELECT * FROM ingredients WHERE name LIKE ?";
  connection.query(sql, [`%${query}%`], (error, results) => {
    if (error) {
      return res
        .status(500)
        .json({ error: "Erreur lors de la recherche des ingrédients" });
    }
    res.json(results);
  });
});

// Route pour récupérer un ingrédient par son nom
app.get("/ingredient/:name", (req, res) => {
  const ingredientName = req.params.name;

  // Requête SQL pour récupérer l'ingrédient
  const query = "SELECT * FROM ingredients WHERE name = ? LIMIT 1";
  connection.query(query, [ingredientName], (error, results) => {
    if (error) {
      res
        .status(500)
        .json({ error: "Erreur lors de la récupération de l'ingrédient" });
    } else if (results.length > 0) {
      res.json(results[0]); // Retourne le premier résultat
    } else {
      res.status(404).json({ message: "Ingrédient non trouvé" });
    }
  });
});

// Démarrer le serveur
app.listen(port, "0.0.0.0", () => {
  console.log(
    `Serveur API en cours d'exécution sur http://192.168.1.90:${port}`
  );
});
