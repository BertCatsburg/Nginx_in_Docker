const express = require("express");
const PORT = process.env.PORT || 3001;
app = express();

app.get("/", (req, res) =>
    res.status(200).json({
        status: 200,
        message: "Hello world from Docker.",
    })
);

app.listen(PORT, () =>
    console.log("The server is running on port: %s", PORT)
);
