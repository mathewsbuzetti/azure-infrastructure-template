# 🚀 Implantação de Infraestrutura do Azure no BrazilSouth

![Azure](https://img.shields.io/badge/Azure-blue?style=flat-square&logo=microsoftazure)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat-square&logo=powershell&logoColor=white)
![Status](https://img.shields.io/badge/Status-Production-green?style=flat-square)

Este script PowerShell automatiza a implantação de recursos de infraestrutura do Azure na região do BrazilSouth.

## 💻 Especificações Técnicas

### 🌐 Networking
* VNET (10.1.0.0/16)
  * SNET-Internal (10.1.1.0/24)
  * GatewaySubnet (10.1.253.0/27)
* NSG com regras para:
  * RDP (porta 3389)

### 🌍 IPs Públicos
* VM: PIP-VM-[NOME-DA-VM]
* VPN Gateway (opcional):
  * PIP-S2S-PRIMARY (Site-to-Site Primário)
  * PIP-S2S-SECONDARY (Site-to-Site Secundário)
  * PIP-P2S-PRIMARY (Point-to-Site)
* Todos configurados como:
  * Tipo: Static
  * SKU: Standard

### 🔒 VPN Gateway (Opcional)
* Gateway VPN Ativo-Ativo
* Suporte para conexões S2S e P2S
* SKU: VpnGw1

### 💻 Máquina Virtual
* Windows Server 2022 Datacenter
* Tamanho: Standard_B2ms
* Disco OS: 127GB StandardSSD_LRS

### 💾 Armazenamento e Backup
* Storage Account (Standard_LRS)
* Recovery Services Vault
* Availability Set

### 📊 Monitoramento
* Automation Account com Runbook START_STOP_VMs
* Log Analytics Workspace
* Diagnósticos de Boot (desabilitado por padrão)

## 📋 Pré-requisitos

1. Você precisará de uma assinatura ativa do Azure.
2. Você pode executar este script diretamente no Azure CloudShell. Não é necessário ter o PowerShell instalado localmente.
3. O usuário que executar o script deve ter as seguintes permissões na assinatura do Azure:
   - Contribuidor (Contributor) ou Proprietário (Owner) na assinatura

## 🚀 Como Usar

1. Baixe o script Deploy-AzureInfrastructure-BrazilSouth.ps1:
   [![Download Script](https://img.shields.io/badge/Download%20Script-blue?style=flat-square)](https://github.com/mathewsbuzetti/deployazure/blob/main/Deploy-AzureInfrastructure-BrazilSouth.ps1)

2. Acesse o portal do Azure e abra o Azure CloudShell.

3. Faça o upload do script Deploy-AzureInfrastructure-BrazilSouth.ps1 no CloudShell.

4. Navegue até o diretório onde você fez o upload do script.

5. Acesse nossa interface web https://mathewsbuzetti.github.io/deployazure/

6. Preencha os parâmetros necessários:
   - ID da Assinatura Azure
   - Nome do Cliente (maiúsculo)
   - Nome do Cliente (minúsculo)
   - Ambiente (ex: production, development)
   - Nome da Máquina Virtual

7. Copie o comando gerado.

8. Cole o comando gerado no Azure CloudShell e pressione Enter.

O script iniciará a implantação dos recursos do Azure.

### ⏱️ Tempo de Execução
- Deploy completo sem VPN: ~30 minutos
- Deploy com VPN: ~60 minutos

## ⚠️ Avisos Importantes e Pós-Instalação

### Diagnóstico da VM
- Após a criação da VM, é necessário ativar o Diagnóstico utilizando a conta de armazenamento que foi criada durante o processo.

### Configuração de Backup
1. Alterar a redundância para Locally-redundant (LRS)
2. Configurar o backup para a VM criada
3. Definir a política de retenção conforme necessidade

### 🔐 Credenciais Padrão
- **Username**: admaz
- **Password**: BaucCr@f#PgU

⚠️ **IMPORTANTE**: Altere a senha após o primeiro login!

## 🏗️ Resource Groups e Organização

### Grupos de Recursos
- RG-[CLIENT]-VM (BrazilSouth)
- RG-[CLIENT]-Storage (BrazilSouth)
- RG-[CLIENT]-Networks (BrazilSouth)
- RG-[CLIENT]-Backup (BrazilSouth)
- RG-[CLIENT]-Automation (East US) 
- RG-[CLIENT]-LogAnalytics (East US)

## 🏷️ Tagging e Governança

Todos os recursos são automaticamente tagueados com:
- client: [nome-cliente]
- environment: [ambiente]
- technology: [tipo-recurso]

## 🔄 Logs e Feedback

O script fornece feedback em tempo real com cores:
- 🟦 Cyan: Informação
- 🟩 Verde: Sucesso
- 🟨 Amarelo: Aviso
- 🟥 Vermelho: Erro

## 👨‍💻 Suporte e Versionamento

Script desenvolvido por Mathews Buzetti.

### Suporte
- 📧 Email: [seu-email]
- 🌐 GitHub: [seu-github]

### Versão
- Versão: 1.0.0
- Última atualização: 01/02/2025
