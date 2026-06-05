var viagemModel = require("../models/viagemModel");

function buscarRotasPorEmpresa(req, res) {
  var empresaId = req.params.empresaId;

  viagemModel.buscarRotasPorEmpresa(empresaId).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os rotass: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}



function cadastrar(req, res) {
  var veiculo = req.body.veiculo;
  var vacina = req.body.vacina;
  var qtdVacina = req.body.qtdVacina;
  var origem = req.body.origem;
  var destino = req.body.destino;

  if (veiculo == undefined) {
    res.status(400).send("veiculo está undefined!");
  } else if (vacina == undefined) {
    res.status(400).send("vacina está undefined!");
  } else if (qtdVacina == undefined) {
    res.status(400).send("qtdVacina está undefined!");
  } else if (origem == undefined) {
    res.status(400).send("origem está undefined!");
  } else if (destino == undefined) {
    res.status(400).send("destino está undefined!");
  } else {


    viagemModel.cadastrar(veiculo, vacina, qtdVacina, origem, destino)
      .then((resultado) => {
        res.status(201).json(resultado);
      }
      ).catch((erro) => {
        console.log(erro);
        console.log(
          "\nHouve um erro ao realizar o cadastro! Erro: ",
          erro.sqlMessage
        );
        res.status(500).json(erro.sqlMessage);
      });
  }
}

module.exports = {
  buscarRotasPorEmpresa,
  cadastrar
}