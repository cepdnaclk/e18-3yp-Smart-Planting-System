const express = require('express');
const bodyParser = require('body-parser');
const app = express();

const userRoutes = require('./routes/users');
const plantRoutes = require('./routes/plants')
const plantDataRoutes = require('./routes/plantsData');

app.use(bodyParser.json());

app.use("/user", userRoutes);
app.use("/plant",plantRoutes);
app.use("/plantData",plantDataRoutes);


module.exports = app