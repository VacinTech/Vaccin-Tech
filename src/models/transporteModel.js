var database = require("../database/config");

function listar() {

  var instrucaoSql = `SELECT * FROM transporte`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(placa, modelo, tipoRefrigeramento, empresaId, userId) {
  
  var instrucaoSql = `INSERT INTO Transporte (placa, modelo, tipoRefrigeramento, fkEmpresa, fkUsuario) VALUES ('${placa}', '${modelo}', '${tipoRefrigeramento}', ${empresaId}, ${userId})`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  listar,
  cadastrar
}
