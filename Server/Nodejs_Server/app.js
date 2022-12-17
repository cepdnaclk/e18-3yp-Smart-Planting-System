const express = require('express');
const bodyParser = require('body-parser');
const app = express();

const userRoutes = require('./routes/users');

app.use(bodyParser.json());

app.use("/user", userRoutes);

module.exports = app