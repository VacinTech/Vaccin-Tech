var transporteModel = require("../models/transporteModel");

function listar(req, res) {
  var idUsuario = req.params.idUsuario;

  transporteModel.listar(idUsuario).then((resultado) => {
    if (resultado.length > 0) {
      res.status(200).json(resultado);
    } else {
      res.status(204).json([]);
    }
  }).catch(function (erro) {
    console.log(erro);
    console.log("Houve um erro ao buscar os transportes: ", erro.sqlMessage);
    res.status(500).json(erro.sqlMessage);
  });
}


function cadastrar(req, res) {
  var placa = req.body.placa;
  var modelo = req.body.modelo;
  var tipoRefrigeramento = req.body.tipoRefrigeramento;
  var empresaId = req.body.empresaId;
  var userId = req.body.userId;

  if (placa == undefined) {
    res.status(400).send("placa está undefined!");
  } else if (modelo == undefined) {
    res.status(400).send("modelo está undefined!");
  } else if (tipoRefrigeramento == undefined) {
    res.status(400).send("tipoRefrigeramento está undefined!");
  } else if (empresaId == undefined) {
    res.status(400).send("empresaId está undefined!");
  } else if (userId == undefined) {
    res.status(400).send("userId está undefined!");
  }else {


    transporteModel.cadastrar(placa, modelo, tipoRefrigeramento, empresaId, userId)
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
  listar,
  cadastrar
}