var database = require("../database/config");

function listar() {

  var instrucaoSql = `SELECT * FROM transporte`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(placa, modelo, tipoRefrigeramento, empresaId) {
  
  var instrucaoSql = `INSERT INTO transporte (placa, modelo, tipoRefrigeramento, fkEmpresa) VALUES ('${placa}', '${modelo}', '${tipoRefrigeramento}', ${empresaId})`;
  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  listar,
  cadastrar
}
