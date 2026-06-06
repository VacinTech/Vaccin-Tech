var express = require("express");
var router = express.Router();

var viagemController = require("../controllers/viagemController");

router.get("/buscarRotasPorEmpresa/:empresaId", function (req, res) {
  viagemController.buscarRotasPorEmpresa(req, res);
});

router.get("/tudoDashIndividual/:idViagem", function (req, res) {
  viagemController.tudoDashIndividual(req, res);
});

router.post("/cadastrar", function (req, res) {
  viagemController.cadastrar(req, res);
})

router.get("/buscarUltimasTemp/:idSensor", function (req, res) {
    viagemController.buscarUltimasTemp(req, res);
});



module.exports = router;