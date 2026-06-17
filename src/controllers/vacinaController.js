var vacinaModel = require("../models/vacinaModel");

function listar(req, res) {
    let idEmpresa = req.params.idEmpresa;
    
    vacinaModel.listar(idEmpresa).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar os vacinas: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}
function cadastrar(req, res) {
    var nome = req.body.nomeVacinaServer;
    var fabricante = req.body.fabricanteServer;
    var lote = req.body.loteServer;
    var tempMin = req.body.tempMinServer;
    var tempMax = req.body.tempMaxServer;
    var idUsuarioVar = req.body.userId;

    if (nome == undefined) {
        res.status(400).send("O nome está indefinido!");
    } else if (fabricante == undefined) {
        res.status(400).send("O fabricante está indefinido!");
    } else if (lote == undefined) {
        res.status(403).send("O lote está indefinido!");
    } else if (tempMin == undefined) {
        res.status(403).send("A temperatura mínima está indefinida!");
    } else if (tempMax == undefined) {
        res.status(403).send("A temperatura máxima está indefinida!");
    } else if (idUsuarioVar == undefined) {
        res.status(403).send("O id do usuário está indefinido!");
    } else {
        vacinaModel.cadastrar(nome, fabricante, lote, tempMin, tempMax, idUsuarioVar)
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            )
            .catch(
                function (erro) {
                    console.log(erro);
                    console.log("Houve um erro ao realizar o post: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    listar,
    cadastrar
}