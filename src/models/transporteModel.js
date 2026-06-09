var database = require("../database/config");

function listar(idUsuario) {

  var instrucaoSql = `SELECT * FROM Transporte where fkUsuario = ${idUsuario}`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(placa, modelo, tipoRefrigeramento, empresaId, userId) {

  var instrucaoSql = `
    INSERT INTO Transporte
    (placa, modelo, tipoRefrigeramento, fkEmpresa, fkUsuario)
    VALUES
    ('${placa}', '${modelo}', '${tipoRefrigeramento}', ${empresaId}, ${userId});
  `;

  return database.executar(instrucaoSql)
    .then(function(resultado) {

      var idTransporte = resultado.insertId;

      var instrucaoSensor = `
        INSERT INTO Sensor
        (modelo, dataInstalacao, fkTransporte)
        VALUES
        ('LM35', CURDATE(), ${idTransporte});
      `;

      return database.executar(instrucaoSensor);
    });
}

module.exports = {
  listar,
  cadastrar
}
