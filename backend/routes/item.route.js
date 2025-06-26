const express = require("express");
const Item = require("../models/item.model");
const router = express.Router();

//CREATE Item
router.post("/create-item", async (req, res) => {
  try {
    const existingItem = await Item.findOne({ id: req.body.id });

    if (existingItem) {
      return res.status(400).json({ message: "ID is already in use" });
    }

    const newItem = new Item(req.body);
    const savedItem = await newItem.save();
    res.status(201).json(savedItem);
  } catch (err) {
    res
      .status(500)
      .json({ message: "Internal server error", error: err.message });
  }
});

//READ all Items
router.get("/items", async (req, res) => {
  try {
    const items = await Item.find();
    res.status(200).json(items);
  } catch (err) {
    res
      .status(500)
      .json({ message: "Failed to fetch items", error: err.message });
  }
});

//READ one Item by ID
router.get("/item/:id", async (req, res) => {
  try {
    const item = await Item.findOne({ id: req.params.id });

    if (!item) {
      return res.status(404).json({ message: "Item not found" });
    }

    res.status(200).json(item);
  } catch (err) {
    res
      .status(500)
      .json({ message: "Error retrieving item", error: err.message });
  }
});

//UPDATE an Item by ID
router.put("/update-item/:id", async (req, res) => {
  try {
    const updatedItem = await Item.findOneAndUpdate(
      { id: req.params.id },
      req.body,
      { new: true }
    );

    if (!updatedItem) {
      return res.status(404).json({ message: "Item not found" });
    }

    res.status(200).json(updatedItem);
  } catch (err) {
    res.status(500).json({ message: "Update failed", error: err.message });
  }
});

//DELETE an Item by ID
router.delete("/delete-item/:id", async (req, res) => {
  try {
    const deletedItem = await Item.findOneAndDelete({ id: req.params.id });

    if (!deletedItem) {
      return res.status(404).json({ message: "Item not found" });
    }

    res
      .status(200)
      .json({ message: "Item deleted successfully", item: deletedItem });
  } catch (err) {
    res.status(500).json({ message: "Delete failed", error: err.message });
  }
});

module.exports = router;
