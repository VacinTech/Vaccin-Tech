var database = require("../database/config");

function listar() {
    console.log("ACESSEI O VACINA  MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucaoSql = `
        SELECT idVacina, nome, fabricante, lote, temperaturaMin, temperaturaMax, dtValidade, dtFabricacao FROM vacina;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function cadastrar(nome, fabricante, lote, tempMin, tempMax, dataValidade, dataFabricacao) {
    console.log("ACESSEI O VACINA MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar(): ", nome, fabricante, lote, tempMin, tempMax, dataValidade, dataFabricacao);
    var instrucaoSql = `insert into vacina (nome, fabricante, lote, temperaturaMin, temperaturaMax, dtValidade, dtFabricacao) values ('${nome}', '${fabricante}', '${lote}', ${tempMin}, ${tempMax}, '${dataValidade}', '${dataFabricacao}');`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    listar,
    cadastrar
}
