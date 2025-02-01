# 🚀 Implantação de Infraestrutura do Azure no Brasil Sul

![Azure](https://img.shields.io/badge/Azure-blue?style=flat-square&logo=microsoftazure)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat-square&logo=powershell&logoColor=white)

Este script PowerShell automatiza a implantação de recursos de infraestrutura do Azure na região do Brasil Sul. Ele cria os seguintes recursos:

- 🗂️ Grupos de Recursos
- 🌐 Rede Virtual (VNET) e Sub-redes 
- 🛡️ Grupo de Segurança de Rede (NSG) com regra para RDP
- 🌍 Endereços IP Públicos
- 🤖 Conta de Automação
- 📊 Espaço de Trabalho do Log Analytics
- 💾 Cofre de Serviços de Backup (provisionado, mas não configurado)
- ⚙️ Conjunto de Disponibilidade
- 💻 Máquina Virtual

## 📋 Pré-requisitos

1. Você precisará de uma assinatura ativa do Azure.
2. Você pode executar este script diretamente no Azure CloudShell. Não é necessário ter o PowerShell instalado localmente.
3. O usuário que executar o script deve ter as seguintes permissões na assinatura do Azure:
   - Contribuidor (Contributor) ou Proprietário (Owner) na assinatura

## 🚀 Como Usar
### Via Interface Web (Recomendado)
1. Acesse nossa interface web https://mathewsbuzetti.github.io/deployazure/
2. Preencha os parâmetros necessários:
   - ID da Assinatura Azure
   - Nome do Cliente (maiúsculo)
   - Nome do Cliente (minúsculo)
   - Ambiente (ex: production, development)
   - Nome da Máquina Virtual
3. Copie o comando gerado
4. Execute no Azure CloudShell

### Via Azure CloudShell
1. Baixar o script no git https://github.com/mathewsbuzetti/deployazure/blob/main/Deploy-AzureInfrastructure-BrazilSouth.ps1
2. Abra o Azure CloudShell em seu portal do Azure link My Dashboard - Microsoft Azure
3. Faz uplound do script CloudShell Deploy-AzureInfrastructure-BrazilSouth.ps1
4. Navega até o diretorio que você fez o uplound do script.
5. Cole o comando gerado na etapa anterior e pressione Enter.

O script iniciará a implantação dos recursos do Azure. Esse processo pode levar de 30 minutos a uma hora, então tenha paciência. Após a conclusão da implantação, o script exibirá informações sobre os recursos criados, incluindo o endereço IP público da Máquina Virtual.

## 🔐 Segurança
- 🛡️ NSG configurado com regras básicas de segurança
- 🏷️ Todos os recursos tagueados para melhor governança
- 💾 Cofre de Backup provisionado (configuração adicional necessária)
- 📊 Monitoramento via Log Analytics

## 🔧 Parâmetros do Script

| Parâmetro | Descrição | Exemplo |
|-----------|-----------|---------|
| SubscriptionId | ID da Assinatura Azure | "e875c481-..." |
| LocationBrazil | Região do Azure Brasil | "brazilsouth" |
| LocationUS | Região do Azure EUA | "eastus" |
| ClientNameUpper | Nome do Cliente (Maiúsculo) | "MATHEWSB" |
| ClientNameLower | Nome do Cliente (Minúsculo) | "mathewsb" |
| Environment | Ambiente do Deploy | "production" |
| VMName | Nome da Máquina Virtual | "MATHEWS-DC01" |

## 📦 Recursos Criados

| Recurso | Localização | Propósito |
|---------|------------|-----------|
| Resource Groups | Brazil South/East US | Organização de recursos |
| VNet + Subnets | Brazil South | Networking |
| NSG | Brazil South | Segurança de rede |
| Storage Account | Brazil South | Armazenamento |
| Log Analytics | East US | Monitoramento |
| Automation Account | East US | Automação |
| Backup Vault | Brazil South | Backup (provisionado) |
| VM | Brazil South | Computação |
