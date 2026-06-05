var database = require("../database/config");

function  buscarRotasPorEmpresa(empresaId) {

  var instrucaoSql = `select vi.idViagem, vi.origem, vi.destino,
	tr.placa,
  v.temperaturaMin,
  v.temperaturaMax,
	(
    select m.temperatura 
	from Monitoramento m 
    join Sensor s on m.fkSensor = s.idSensor
    where s.fkTransporte = tr.idTransporte
	order by m.idMonitoramento desc
	limit 1
    ) as temperaturaAtual
		from viagem vi
        join transporte tr on vi.fkTransporte = tr.idTransporte
        join vacina v on vi.fkVacina = v.idVacina
        where vi.statusViagem = 'Trânsito' and tr.fkEmpresa = ${empresaId};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(veiculo, vacina, qtdVacina, origem, destino) {
  
  var instrucaoSql = `INSERT INTO viagem (fkTransporte, fkVacina, qtdVacina, origem, destino) VALUES (${veiculo}, ${vacina}, ${qtdVacina}, '${origem}', '${destino}')`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarRotasPorEmpresa ,
  cadastrar,
}
