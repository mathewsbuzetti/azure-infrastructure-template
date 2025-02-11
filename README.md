# 🚀 Implantação de Infraestrutura do Azure no BrazilSouth

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Mathews_Buzetti-blue)](https://www.linkedin.com/in/mathewsbuzetti)
![Azure](https://img.shields.io/badge/Azure-blue?style=flat-square&logo=microsoftazure)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat-square&logo=powershell&logoColor=white)
![Status](https://img.shields.io/badge/Status-Production-green?style=flat-square)

**Aplica-se a:** ✔️ VMs do Windows

## 📋 Metadados

| Metadado | Descrição |
|----------|-----------|
| **Título** | Template de Infraestrutura Azure para Ambiente Corporativo com Alta Disponibilidade |
| **Assunto** | Azure Virtual Machines |
| **Versão** | 1.0.0 |
| **Data** | 08/02/2025 |
| **Autor** | Mathews Buzetti |
| **Tags** | `azure-automation`, `windows-server`, `high-availability`, `infrastructure-as-code` |

## 📋 Índice

1. [Metadados](#-metadados)
2. [Especificações Técnicas](#-especificações-técnicas)
3. [Automação e Monitoramento](#-automation-e-monitoramento)
4. [Pré-requisitos](#-pré-requisitos)
5. [Como Usar](#-como-usar)
6. [Avisos Importantes e Pós-Instalação](#️-avisos-importantes-e-pós-instalação)
7. [Procedimento de Rollback](#-procedimento-de-rollback)
8. [Resource Groups e Organização](#️-resource-groups-e-organização)
9. [Tagging e Governança](#️-tagging-e-governança)
10. [Logs e Feedback](#-logs-e-feedback)
11. [Parâmetros do Script](#-parâmetros-do-script)
12. [Versionamento](#-versionamento)

## 💻 Especificações Técnicas

### 💻 Máquina Virtual
* Windows Server 2022 Datacenter
* Tamanho: Standard_B2ms
* Disco OS: 127GB StandardSSD_LRS
* Opção de criar uma segunda VM com as mesmas configurações

### 🌐 Networking
* VNET (Configurável via parâmetro VNetIPRange)
  * SNET-Internal (Configurável via parâmetro SubnetInternalIPRange)
  * GatewaySubnet (Configurável via parâmetro GatewaySubnetIPRange)
* NSG com regras para:
  * RDP (porta 3389)

> ⚠️ **ATENÇÃO**: Por questões de segurança, após configurar a VPN, é altamente recomendado fechar a porta 3389 (RDP) para acesso externo. O acesso à VM deve ser feito através da VPN.

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

### 💾 Armazenamento e Backup
* Storage Account (Standard_LRS)
* Recovery Services Vault
* Availability Set

### 🤖 Automation e Monitoramento

#### Automation Account
* Configuração do START/STOP VMs:
  * Runbook para automação de horários
  * Suporte para agendamentos personalizados
  * Execução baseada em tags nas VMs
  * Monitoramento de execução via Log Analytics

#### Log Analytics Workspace
* Integração com Automation Account para:
  * Monitoramento de jobs do Runbook
  * Alertas por email em caso de falhas
  * Coleta de logs de execução
  * Métricas de performance

#### Diagnóstico e Logs
* Diagnostic settings configuráveis:
  * JobLogs - Logs de execução dos jobs
  * JobStreams - Output detalhado dos jobs
  * AuditEvent - Registro de alterações
* Diagnósticos de Boot:
  * Desabilitado por padrão
  * Configurável via Storage Account
  * Permite troubleshooting de problemas de inicialização

> 💡 **Dica**: Configure os alertas do Log Analytics para receber notificações em caso de falhas no START/STOP das VMs.

## 📋 Pré-requisitos

1. Você precisará de uma assinatura ativa do Azure.
2. Você pode executar este script diretamente no Azure CloudShell. Não é necessário ter o PowerShell instalado localmente.
3. O usuário que executar o script deve ter as seguintes permissões na assinatura do Azure:
   - Contribuidor (Contributor) ou Proprietário (Owner) na assinatura

## 🚀 Como Usar

1. Baixe o script Deploy-AzureInfrastructure-BrazilSouth.ps1
   
   [![Download Script](https://img.shields.io/badge/Download%20Script-blue?style=flat-square)](https://github.com/mathewsbuzetti/deployazure/blob/main/Deploy-AzureInfrastructure-BrazilSouth.ps1)

2. Acesse o portal do Azure e abra o Azure CloudShell:
   
   [![Azure CloudShell](https://img.shields.io/badge/Abrir%20Azure%20CloudShell-blue?style=flat-square&logo=microsoftazure)](https://shell.azure.com)

3. Faça o upload do script Deploy-AzureInfrastructure-BrazilSouth.ps1 no CloudShell.

![image](https://github.com/user-attachments/assets/4b607995-c850-45c3-9270-e7e865faf3bf)

4. Navegue até o diretório onde você fez o upload do script.

5. Acesse nosso site para gerar o código de execução do script:
   
   [![Gerador de Código](https://img.shields.io/badge/Gerador%20de%20C%C3%B3digo-blue?style=flat-square&logo=microsoftazure)](https://mathewsbuzetti.github.io/azure-infrastructure-template/)

   No site, você deverá preencher todos os parâmetros necessários:

   **Informações Básicas:**
   * ID da Assinatura Azure
   * Nome do Cliente (maiúsculo)
   * Nome do Cliente (minúsculo)
   * Nome da Máquina Virtual
   * Usuário e senha para login nas máquinas virtuais

   **Configurações de Rede:**
   * VNET IP Range
   * Subnet Internal IP Range
   * Gateway Subnet IP Range

   **Opções Adicionais:**
   * Criar Segunda VM (Sim/Não)
     - Se sim, informar nome da segunda VM
   * Instalar VPN Gateway (Sim/Não)

7. Copie o comando gerado.

8. Cole o comando gerado no Azure CloudShell e pressione Enter.

O script iniciará a implantação dos recursos do Azure.

### ⏱️ Tempo de Execução
- Deploy completo sem VPN: 30 minutos
- Deploy com VPN: 60 minutos


## ⚠️ Avisos Importantes e Pós-Instalação

### Troubleshooting VPN Gateway
Se durante o deploy você encontrar o erro:
```powershell
New-AzVirtualNetworkGateway: /home/mathews/Deploy-AzureInfrastructure-BrazilSouth.ps1:575
Line | 575 | $vpnGateway = New-AzVirtualNetworkGateway ` | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
| ManagedIdentityCredential authentication failed: [Managed Identity]
Error Code: invalid_request
Error Message: Timeout waiting for token from portal.
Audience: https://management.core.windows.net/
See the troubleshooting guide | for more information: https://aka.ms/azsdk/net/identity/managedidentitycredential/troubleshoot
A criação do VPN Gateway 'VNG-MATHEWS' falhou.
```
Não se preocupe! Este erro ocorre quando a sessão do CloudShell expira, mas o deploy continuará normalmente. Para verificar:
1. Acesse o Resource Group da VPN
2. Abra o recurso de VPN Gateway
3. Você verá uma mensagem de "Updating", indicando que a implantação está em andamento

### Diagnóstico da VM
- Após a criação da VM, é necessário ativar o Diagnóstico utilizando a conta de armazenamento que foi criada durante o processo.

![image](https://github.com/user-attachments/assets/22375a24-4e82-400f-8c4f-3e05a0ad312f)

### Configuração de Backup
1. Alterar a redundância para Locally-redundant (LRS)
   
   > 💰 **Recomendação**: A alteração para LRS é recomendada para redução de custos, pois oferece redundância suficiente para a maioria dos cenários com um custo menor.
   
![image](https://github.com/user-attachments/assets/bfabecec-1d52-4f64-959e-a904fb637e07)

3. Definir a política de retenção conforme necessidade
   
   > ⚙️ **Recomendação**: A política abaixo é uma recomendação amplamente utilizada por empresas. Caso deseje seguir este modelo:
   
![image](https://github.com/user-attachments/assets/0adee237-3151-4de4-a38f-3ea6b362be36)

### Configuração do Start/Stop de VMs
1. Baixe o script Start/Stop:
   
   [![Download Script Start/Stop](https://img.shields.io/badge/Download%20Script%20Start%2FStop-blue?style=flat-square&logo=powershell)](https://github.com/mathewsbuzetti/deployazure/blob/main/Script%20Start%20e%20Stop%20de%20VMs.ps1)

2. No Automation Account, acesse o Runbook "START_STOP_VMs"
3. Importe o conteúdo do script baixado
   
![image](https://github.com/user-attachments/assets/6b321a34-4421-4816-b4aa-f783cedea4ec)

5. Configure as políticas de execução:
   
   * Crie um agendamento para Start (ex: dias úteis às 9h)
     
![image](https://github.com/user-attachments/assets/a49a51f6-c229-4d40-b235-19f4bdae45e6)

   * Crie um agendamento para Stop (ex: dias úteis às 19h)
     
![image](https://github.com/user-attachments/assets/6bb4c703-8a6c-4a1a-8714-b6f5274792e9)

   * Configure os parâmetros:
     - TagName: nome da tag para identificar VMs
     - TagValue: valor da tag
     - Shutdown: true (para parar) ou false (para iniciar)

### Configuração de Tags na VM
1. Acesse a VM que deseja configurar o Start/Stop automático
2. Na seção "Tags", adicione uma nova tag:
   
   > ⚙️ **Configuração**: A tag deve corresponder aos parâmetros configurados no Runbook
   
   * Nome da tag: [TagName configurado no Runbook]
   * Valor da tag: [TagValue configurado no Runbook]
     
![image](https://github.com/user-attachments/assets/881e769c-8a4e-41a9-8218-942059ce02b0)

### 📧 Configuração de Alertas para o Start/Stop de VMs

#### 1. Configuração do Diagnostic Settings 
1. No portal Azure, acesse o **Automation Account**
2. Na seção Monitoring, clique em **Diagnostic settings**

![Diagnostic Settings](https://github.com/user-attachments/assets/9ec9d390-2e4f-471c-9904-c002f29d411c)

3. Configure as categorias:
   * Marque JobLogs, JobStreams e AuditEvent
   * Em "Destination details", ative "Send to Log Analytics workspace"
   * Selecione seu workspace

![Diagnostic Categories](https://github.com/user-attachments/assets/a3b213d1-566c-4b53-bd84-c1c02c937e4f)

#### 2. Criação do Alerta por E-mail
1. No Log Analytics workspace:
   * Acesse a seção Monitoring
   * Clique em **Alerts**
   * Clique em "New alert rule"

![Novo Alerta](https://github.com/user-attachments/assets/c0fc8eed-8a69-40e8-b4e1-585c93db8574)

2. Em "Scope":
   * Selecione o Automation Account

![Seleção Scope](https://github.com/user-attachments/assets/0a0a0a3f-d8d1-41a0-9742-fe4afa1aa2d7)

3. Em "Condition":
   * Selecione "Custom log search"

![Custom Log Search](https://github.com/user-attachments/assets/46b53ede-1edc-496f-b015-c8d77f02c546)

4. Cole a seguinte query:
```kql
// Azure Automation jobs that are failed, suspended, or stopped 
// List all the automation jobs that failed, suspended or stopped in the last 24 hours.
let jobLogs = AzureDiagnostics
    | where ResourceProvider == "MICROSOFT.AUTOMATION"
        and Category == "JobLogs"
        and (ResultType == "Failed" or ResultType == "Stopped" or ResultType == "Suspended")
    | project
        TimeGenerated,
        RunbookName_s,
        ResultType,
        _ResourceId,
        JobId_g,
        OperationName,
        Category;
let auditEvents = AzureDiagnostics
    | where ResourceProvider == "MICROSOFT.AUTOMATION"
        and Category == "AuditEvent"
        and OperationName == "Delete"
    | project
        TimeGenerated,
        RunbookName_s,
        ResultType,
        _ResourceId,
        JobId_g,
        OperationName,
        Category;
jobLogs
| union auditEvents
| order by TimeGenerated desc
```

![query](https://github.com/user-attachments/assets/287872f9-060e-4fa1-beb5-feee15c1bd81)

5. Configure a Measurement e Alert Logic:

![Configuração Measurement e Alert Logic](https://github.com/user-attachments/assets/f1f3d5af-cc85-4fdc-90f2-d80d7aeaf52b)

#### 3. Configuração do Action Group
1. Clique em "Create action group"

![Criar Action Group](https://github.com/user-attachments/assets/32c6bddb-58dc-4a59-809a-6919a8e68c50)

2. Configure os detalhes básicos:
   * Action group name: "JobErrorsGrp001"
   * Display name: "JobErrorsGrp"
   * Resource group: RG de Automation

![Configurar Email](https://github.com/user-attachments/assets/3aa89cfa-4bfb-4944-9cb3-0d506cab5269)

3. Configure as notificações:
   * Tipo: Email/SMS message/Push/Voice
   * Adicione o email desejado

![Configurar Email](https://github.com/user-attachments/assets/bd54df3c-8430-44b4-a069-886f4c1cd27b)

4. Revise as configurações do Action Group

![Review Action Group](https://github.com/user-attachments/assets/323b8638-7602-4df4-96f7-28dc44de3ef7)

5. Selecione o Action Group criado

![Select Action Group](https://github.com/user-attachments/assets/7a321391-d45d-4418-ae0b-2b2416cd199c)

#### 4. Finalização do Alerta
1. Configure os detalhes do alerta:
   * Severity: 1 - Error
   * Alert rule name: "RunbookFailureAlert"
   * Region: East US

![Alert Details](https://github.com/user-attachments/assets/69c197f6-1a33-47f4-9347-a0473cb7efad)

3. Revise todas as configurações

![Review Alert](https://github.com/user-attachments/assets/3c3c2305-d274-447d-a50e-e163d83c5ebf)
   
   > ⚠️ **Importante**: 
   > - Após configuração, você receberá emails em caso de falhas no Start/Stop das VMs
   > - Monitore o Log Analytics workspace periodicamente
   > - Mantenha o email de notificação sempre atualizado

## 🔄 Procedimento de Rollback

Se for necessário fazer rollback da infraestrutura, siga estes passos:

1. Baixe o script Script_Delete_Resource_Groups:
   
   [![Download Script Rollback](https://img.shields.io/badge/Download%20Script%20Rollback-blue?style=flat-square&logo=powershell)](https://github.com/mathewsbuzetti/azure-infrastructure-template/blob/main/Script_Delete_Resource_Groups)

2. Acesse o portal do Azure e abra o Azure CloudShell:
   
   [![Azure CloudShell](https://img.shields.io/badge/Abrir%20Azure%20CloudShell-blue?style=flat-square&logo=microsoftazure)](https://shell.azure.com)

3. Faça o upload do Script_Delete_Resource_Groups no CloudShell.

4. No CloudShell, execute o comando abaixo substituindo os parâmetros:

```powershell
./Script_Delete_Resource_Groups.ps1 -SubscriptionId "sua-subscription-id" -ClientNameUpper "NOME-CLIENTE"
```

⚠️ Demostração da execução:

![image](https://github.com/user-attachments/assets/31c98d31-0d76-4bcb-85bf-a03ede100bd7)

![image](https://github.com/user-attachments/assets/18f9115f-3801-4464-a49f-5837850fd11d)
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

## 🔧 Parâmetros do Script

| Parâmetro | Descrição | Exemplo | Obrigatório |
|-----------|-----------|---------|-------------|
| SubscriptionId | ID da Assinatura Azure | "e875c481-..." | Sim |
| LocationBrazil | Região do Azure Brasil | "brazilsouth" | Sim |
| LocationUS | Região do Azure EUA | "eastus" | Sim |
| ClientNameUpper | Nome do Cliente (Maiúsculo) | "MATHEWSB" | Sim |
| ClientNameLower | Nome do Cliente (Minúsculo) | "mathewsb" | Sim |
| Environment | Ambiente do Deploy | "production" | Não |
| VMName | Nome da Máquina Virtual Principal | "MATHEWS-DC01" | Sim |
| SecondVMName | Nome da Segunda Máquina Virtual | "MATHEWS-DC02" | Não |
| CriarSegundaVM | Criar Segunda VM | $true/$false | Não |
| InstalarVPN | Instalar Gateway VPN | $true/$false | Não |
| VMUsername | Nome do Usuário Admin | "admaz" | Sim |
| VMPassword | Senha do Usuário Admin | "Sua@Senha123" | Sim |
| VNetIPRange | Range de IP da VNET | "10.1.0.0/16" | Sim |
| SubnetInternalIPRange | Range de IP da Subnet Interna | "10.1.1.0/24" | Sim |
| GatewaySubnetIPRange | Range de IP da Gateway Subnet | "10.1.253.0/27" | Sim |

## 🔄 Versionamento

- Versão: 1.0.0
- Última atualização: 08/02/2025

_Nota: As principais linguagens de programação não fazem declarações sobre habilidades pessoais ou similares, é apenas uma figura-chave com base nas estatísticas do GitHub do usuário indicando a frequência com que cada uma foi utilizada._

> :warning: **Importante:**
> Nomes de linguagens devem ser uma sequência escapada de URI, como específicado em [Codificação por cento](https://pt.wikipedia.org/wiki/Codificação_por_cento)
> (Ou seja: `c++` deve se tornar `c%2B%2B`, `jupyter notebook` deve se tornar `jupyter%20notebook`, etc.)
