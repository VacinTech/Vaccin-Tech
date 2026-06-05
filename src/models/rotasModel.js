var database = require("../database/config");

function  (empresaId) {

  var instrucaoSql = `select vi.idViagem, vi.origem, vi.destino,
	tr.placa,
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
        where vi.statusViagem = 'Trânsito' and tr.fkEmpresa = ${empresaId};`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}

function cadastrar(empresaId, descricao) {
  
  var instrucaoSql = `INSERT INTO (descricao, fk_empresa) aquario VALUES (${descricao}, ${empresaId})`;

  console.log("Executando a instrução SQL: \n" + instrucaoSql);
  return database.executar(instrucaoSql);
}


module.exports = {
  buscarRotasPorEmpresa ,
  cadastrar,
}
