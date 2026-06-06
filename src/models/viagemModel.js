var database = require("../database/config");

function  buscarRotasPorEmpresa(empresaId) {

    var instrucaoSql = `select * from vwGeralRotas
	 where fkEmpresa = ${empresaId};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function  tudoDashIndividual(idViagem) {

    var instrucaoSql = `select * from vwTudoDashIndividual
	 where idViagem = ${idViagem};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function  buscarUltimasTemp(idSensor, limite_linhas) {

    var instrucaoSql = `select 
                        temperatura,
                        dataHora,
                        date_format(dataHora,'%H:%i:%s') as hora
                    from Monitoramento
                    where fkSensor = ${idSensor}
                    order by idMonitoramento desc
                    limit ${limite_linhas};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(veiculo, vacina, qtdVacina, origem, destino) {
  
  var instrucaoSql = `INSERT INTO viagem (fkTransporte, fkVacina, qtdVacina, origem, destino) VALUES (${veiculo}, ${vacina}, ${qtdVacina}, '${origem}', '${destino}')`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarRotasPorEmpresa,
  tudoDashIndividual,
  buscarUltimasTemp,
  cadastrar,
}
