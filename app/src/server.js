const express = require("express");

const app = express();

const PORT = process.env.PORT || 3000;

app.get("/", (req, res) => {
    res.json({
        name: "Homelab Dashboard",
        status: "running",
        environment: "homelab"
    });
});

app.get("/health", (req, res) => {
    res.json({
        status: "healthy"
    });
});

app.listen(PORT, "127.0.0.1", () => {
    console.log(`Homelab Dashboard listening on port ${PORT}`);
});