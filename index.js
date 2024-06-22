const express = require("express");
const { exec } = require("child_process");
const app = express();

app.get("/git-log", (req, res) => {
  exec("./git-tracker.sh log", (error, stdout, stderr) => {
    if (error) {
      res.status(500).send("Error executing git-tracker");
      return;
    }
    res.send(stdout);
  });
});

app.listen(3000, () => console.log("Server running on port 3000"));
