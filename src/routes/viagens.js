var express = require("express");
var router = express.Router();

var viagemController = require("../controllers/viagemController");

router.get("/buscarRotasPorEmpresa/:empresaId", function (req, res) {
  viagemController.buscarRotasPorEmpresa(req, res);
});

router.post("/cadastrar", function (req, res) {
  viagemController.cadastrar(req, res);
})



module.exports = router;