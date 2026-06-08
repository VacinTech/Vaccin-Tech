var express = require("express");
var router = express.Router();

router.get("/bobia", function (req, res) {
    res.render("bobia");
});

module.exports = router;