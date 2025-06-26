const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const newSchema = new Schema({
  chooseSize: String,
  description: String,
  id: Number,
  imageLink: String,
  item: String,
  name: String,
  price: Number,
  size: [String],
});

module.exports = mongoose.model("Item", newSchema);
