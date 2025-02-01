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
- 💾 Cofre de Serviços de Backup
- ⚙️ Conjunto de Disponibilidade
- 💻 Máquina Virtual

## 📋 Pré-requisitos

1. Você precisará de uma assinatura ativa do Azure.
2. Você deve ter o PowerShell 5.1 ou versão posterior instalado em sua máquina local.
3. O usuário que executar o script deve ter as permissões necessárias para criar recursos na assinatura do Azure de destino.

## 🚀 Como Usar
### Via Interface Web (Recomendado)
1. Acesse nossa interface web https://mathewsbuzetti.github.io/deployazure/
2. Preencha os parâmetros necessários:
   - ID da Assinatura Azure
   - Nome do Cliente (maiúsculo e minúsculo)
   - Ambiente (ex: production, development)
   - Nome da VM
3. Copie o comando gerado
4. Execute no PowerShell do Azure

### Via PowerShell
1. Baixe o script `Deploy-AzureInfrastructure-BrazilSouth.ps1` do repositório.
2. Abra um console do PowerShell e navegue até a pasta que contém o script.
3. Execute o seguinte comando, substituindo os `<parameters>` pelos valores que você copiou do site:

   ```powershell
   .\Deploy-AzureInfrastructure-BrazilSouth.ps1 -SubscriptionId <SubscriptionId> -LocationBrazil <LocationBrazil> -LocationUS <LocationUS> -ClientNameUpper <ClientNameUpper> -ClientNameLower <ClientNameLower> -Environment <Environment> -VMName <VMName>
   ```

4. O script solicitará que você confirme se deseja instalar o Gateway VPN. Digite "Yes" se quiser criar o Gateway VPN ou "No" se não quiser.
5. O script iniciará a implantação dos recursos do Azure. Esse processo pode levar de 30 minutos a uma hora, então tenha paciência.
6. Após a conclusão da implantação, o script exibirá informações sobre os recursos criados, incluindo o endereço IP público da Máquina Virtual.

## 🔐 Segurança
- 🛡️ NSG configurado com regras básicas de segurança
- 🏷️ Todos os recursos tagueados para melhor governança
- 💾 Backup automatizado configurado
- 📊 Monitoramento via Log Analytics

## 🔧 Parâmetros do Script

| Parâmetro | Descrição | Exemplo |
|-----------|-----------|---------|
| SubscriptionId | ID da Assinatura Azure | "e875c481-..." |
| LocationBrazil | Região do Azure Brasil | "brazilsouth" |
| LocationUS | Região do Azure EUA | "eastus" |
| ClientNameUpper | Nome do Cliente (Maiúsculo) | "CLIENTE" |
| ClientNameLower | Nome do Cliente (Minúsculo) | "cliente" |
| Environment | Ambiente do Deploy | "production" |
| VMName | Nome da Máquina Virtual | "VM-CLIENT01" |

## 📦 Recursos Criados

| Recurso | Localização | Propósito |
|---------|------------|-----------|
| Resource Groups | Brazil South/East US | Organização de recursos |
| VNet + Subnets | Brazil South | Networking |
| NSG | Brazil South | Segurança de rede |
| Storage Account | Brazil South | Armazenamento |
| Log Analytics | East US | Monitoramento |
| Automation Account | East US | Automação |
| Backup Vault | Brazil South | Backup |
| VM | Brazil South | Computação |
