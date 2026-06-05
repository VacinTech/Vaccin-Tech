var express = require("express");
var router = express.Router();

var vacinaController = require("../controllers/vacinaController");

router.post("/cadastrar", function (req, res) {
    vacinaController.cadastrar(req, res);
})

router.get("/listar", function (req, res) {
    vacinaController.listar(req, res);
});


module.exports = router;