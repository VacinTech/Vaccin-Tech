var express = require("express");
var router = express.Router();

var transporteController = require("../controllers/transporteController");

router.post("/cadastrar", function (req, res) {
    transporteController.cadastrar(req, res);
})

router.get("/listar/:idUsuario", function (req, res) {
    transporteController.listar(req, res);
});

module.exports = router;