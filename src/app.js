const express = require("express");
const cors = require("cors");
const morgan = require("morgan");
const app = express();

const menuRoutes = require("./routes/menu.routes");

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(morgan("dev"));

app.use("/api/menu", menuRoutes);
// app.use("/api/pesanan", pesananRoutes);

module.exports = app;
