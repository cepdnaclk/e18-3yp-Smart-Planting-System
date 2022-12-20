const express = require('express');
const bodyParser = require('body-parser');
const app = express();

userRoutes = require('./routes/users.js');
plantRoutes = require('./routes/plants.js');
plantDataRoutes = require('./routes/plantsData.js');
plantOwnership = require("./routes/plantOwner.js");
imageRoute = require("./routes/images.js");

app.use(bodyParser.json());
app.use('/uploads', express.static('./uploads'));

// Route middleware
app.use("/api/user", userRoutes);
app.use("/api/plant", plantRoutes);
app.use("/api/plantData",plantDataRoutes);
app.use("/api/plantOwner", plantOwnership);
app.use("/api/images", imageRoute);

module.exports = app