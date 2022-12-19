const express = require('express');
const bodyParser = require('body-parser');
const app = express();

userRoutes = require('./routes/users.js');
plantRoutes = require('./routes/plants.js');
plantDataRoutes = require('./routes/plantsData.js');
plantOwnership = require("./routes/plantOwner.js");

app.use(bodyParser.json());

// Route middleware
app.use("/api/user", userRoutes);
app.use("/api/plant", plantRoutes);
app.use("/api/plantData",plantDataRoutes);
app.use("/api/plantOwner", plantOwnership);

module.exports = app