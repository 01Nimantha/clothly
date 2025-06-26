const express = require("express");
const app = express();
const port = 8080;
const cors = require("cors");
const bodyParser = require("body-parser");

const mongoose = require("mongoose");
mongoose.connect("mongodb://localhost:27017/mydb");

app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use("/", require("./routes/user.route"));
app.use("/", require("./routes/item.route"));

app.listen(port, () => {
  console.log(`port running on ${port}+port`);
});
