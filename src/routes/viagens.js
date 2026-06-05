var express = require("express");
var router = express.Router();

var viagemController = require("../controllers/viagemController");

router.post("/cadastrar", function (req, res) {
    viagemController.cadastrar(req, res);
})

router.post("/listar", function (req, res) {
    viagemController.listar(req, res);
});


module.exports = router;