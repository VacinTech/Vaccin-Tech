# 💉 VacinTech

![Node.js](https://img.shields.io/badge/Node.js-22.x-green)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)
![Arduino](https://img.shields.io/badge/Arduino-Uno_R3-teal)
![Chart.js](https://img.shields.io/badge/Chart.js-4.x-orange)
![License](https://img.shields.io/badge/License-MIT-yellow)

## 📖 Visão Geral

O **VacinTech** é uma solução baseada em **Internet das Coisas (IoT)** desenvolvida para monitorar a temperatura de vacinas em tempo real durante o transporte logístico.

O projeto foi criado para combater um problema crítico da cadeia de frio farmacêutica. Entre 2021 e 2023, o Brasil registrou perdas estimadas em aproximadamente **R$ 1,6 bilhão em vacinas**, muitas delas associadas a falhas no controle térmico durante armazenamento e transporte.

Como vacinas biológicas exigem conservação rigorosa entre **+2°C e +8°C**, qualquer desvio pode comprometer sua eficácia, gerar desperdícios e impactar diretamente a saúde pública.

O VacinTech utiliza sensores conectados a um Arduino para realizar leituras contínuas da temperatura, transmitindo os dados para uma API Node.js responsável pela validação, armazenamento e disponibilização das informações para uma dashboard web em tempo real.

---

# 🚀 Funcionalidades Principais

✅ Monitoramento contínuo da temperatura

✅ Captura automática de dados a cada **2 segundos**

✅ Persistência dos dados em banco MySQL

✅ Histórico completo para auditoria

✅ Dashboard com atualização em tempo real

✅ Gráficos dinâmicos utilizando Chart.js

✅ Alertas automáticos para desvios térmicos

✅ Monitoramento da faixa crítica de:

```text
+2°C até +8°C
```

✅ Registro contínuo para rastreabilidade logística

---

# 🏗️ Arquitetura do Sistema

O fluxo de funcionamento do sistema segue a seguinte arquitetura:

```text
┌────────────┐
│ Sensor LM35│
└─────┬──────┘
      │
      ▼
┌────────────┐
│ Arduino Uno│
└─────┬──────┘
      │ Serial
      ▼
┌────────────┐
│ API NodeJS │
└─────┬──────┘
      │
      ▼
┌────────────┐
│   MySQL    │
└─────┬──────┘
      │
      ▼
┌────────────┐
│ Dashboard  │
└────────────┘
```

### Fluxo de Dados

1. O sensor LM35 realiza a leitura da temperatura.
2. O Arduino Uno processa o valor analógico.
3. Os dados são enviados pela porta serial.
4. A API Node.js recebe e valida as informações.
5. Os registros são armazenados no MySQL.
6. A dashboard consulta os dados e exibe gráficos em tempo real.

---

# 🛠️ Tecnologias Utilizadas

## Hardware

* Arduino Uno R3
* Sensor LM35
* Protoboard
* Cabos Jumpers
* Fonte de alimentação

## Backend

* Node.js
* Express.js
* SerialPort

## Banco de Dados

* MySQL

## Frontend

* HTML5
* CSS3
* JavaScript
* Chart.js

---

# 📋 Pré-requisitos

Antes de iniciar o projeto, certifique-se de possuir:

* Node.js (Versão LTS)
* MySQL Server
* Git
* Arduino IDE
* Arduino Uno conectado via USB

Verifique as instalações:

```bash
node -v
```

```bash
npm -v
```

```bash
git --version
```

---

# ⚙️ Instalação e Configuração

## 1. Clonar o Repositório

```bash
git clone https://github.com/VaccinTech/Vaccin-Tech.git
```

```bash
cd Vaccin-Tech
```

---

## 2. Instalar Dependências

```bash
npm install
```

---

## 3. Configurar Banco de Dados

Criar banco:

```sql
CREATE DATABASE vaccintech;
```

Configurar conexão no arquivo da aplicação:

```javascript
host: 'seu_host',
user: 'seu_usuário',
password: 'sua_senha',
database: 'vaccintech'
```

---

## 4. Configurar Porta Serial

Identifique a porta utilizada pelo Arduino.

### Windows

```text
COM3
COM4
COM5
```

### Linux

```text
/dev/ttyUSB0
/dev/ttyACM0
```

Exemplo de configuração:

```javascript
const portaSerial = 'COM3';
```

---

# ▶️ Como Executar

Inicie a API:

```bash
npm start
```

Saída esperada:

```text
Servidor iniciado
Porta serial conectada
Aguardando dados do sensor...
```

---

# 🔎 Testando a API

Acesse:

```text
http://localhost:3300/sensores/analogico
```

Resposta esperada:

```json
{
  "temperatura": 5.8,
  "dataHora": "2026-06-09 14:32:00"
}
```

---

# 📊 Dashboard

Abra o arquivo:

```text
index.html
```

A dashboard exibirá:

* Temperatura atual
* Histórico de leituras
* Alertas térmicos
* Gráfico de variação em tempo real

Exemplo de visualização:

```text
Temperatura Atual: 5.8°C

Status: NORMAL
```

---

# 📈 Monitoramento e Alertas

## Faixa Segura

```text
+2°C até +8°C
```

## Faixa de Alerta

```text
Menor que +2°C
Maior que +8°C
```

Ao detectar uma anomalia o sistema:

* Registra o evento
* Atualiza a dashboard
* Gera alerta para acompanhamento

---

# 🔒 Regras de Negócio e Compliance

O VaccinTech foi projetado considerando boas práticas de rastreabilidade e monitoramento de produtos biológicos.

### Regras de Negócio

* Temperatura monitorada continuamente.
* Coleta obrigatória a cada 2 segundos.
* Todos os registros devem ser armazenados.
* Leituras históricas não podem ser removidas sem auditoria.
* Alertas devem ser gerados imediatamente após desvios térmicos.

### Compliance

O sistema foi desenvolvido para auxiliar processos alinhados às recomendações de:

* ANVISA
* Ministério da Saúde
* Cadeia de Frio para Imunobiológicos

---

# 🧪 Calibração do Sensor

O LM35 possui precisão aproximada de:

```text
±0.5°C
```

Recomenda-se:

* Calibração periódica
* Comparação com termômetro certificado
* Registro das manutenções realizadas

---

# 🚨 Troubleshooting

## Porta Serial Ocupada

Erro:

```text
Port is already open
```

Solução:

* Feche o Monitor Serial da IDE Arduino.
* Reinicie a API.

---

## Arduino Não Encontrado

Erro:

```text
No serial port found
```

Solução:

* Verifique o cabo USB.
* Confirme a porta configurada.
* Reinstale os drivers do Arduino.

---

## Erro de Conexão com Banco

Erro:

```text
Access denied for user
```

Solução:

* Verifique usuário e senha.
* Confirme se o MySQL está em execução.

---

# 👥 Equipe

Projeto acadêmico desenvolvido para monitoramento inteligente da cadeia de frio de vacinas utilizando IoT, análise de dados e sistemas web.

---

# 📄 Licença

Este projeto está licenciado sob a licença MIT.

```text
MIT License
Copyright (c) 2026
```

Consulte o arquivo LICENSE para mais informações.

---

## 🌎 Impacto

O VacinTech busca contribuir para a redução do desperdício de vacinas, aumento da confiabilidade logística e fortalecimento da saúde pública por meio do uso de tecnologias IoT, monitoramento em tempo real e análise de dados.
