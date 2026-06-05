var express = require("express");
var router = express.Router();

var rotasController = require("../controllers/rotasController");

router.get("/buscarRotasPorEmpresa/:empresaId", function (req, res) {
  rotasController.buscarRotasPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  rotasController.cadastrar(req, res);
})



module.exports = router;