const express = require("express");
const User = require("../models/user.model");
const router = express.Router();

router.post("/signup", async (req, res) => {
  try {
    const existingUser = await User.findOne({ email: req.body.email });

    if (existingUser) {
      return res.json({ message: "Email is not available" });
    }

    const newUser = new User({
      email: req.body.email,
      password: req.body.password,
    });

    const savedUser = await newUser.save();
    console.log(savedUser);
    res.status(201).json(savedUser);
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ message: "Internal server error", error: err.message });
  }
});

router.post("/signin", async (req, res) => {
  try {
    const user = await User.findOne({
      email: req.body.email,
      password: req.body.password,
    });

    if (!user) {
      return res.status(401).json({ message: "Invalid email or password" });
    }

    res.status(200).json({ message: "valid email and password" });
  } catch (err) {
    console.error(err);
    res
      .status(500)
      .json({ message: "Internal server error", error: err.message });
  }
});

module.exports = router;
