# 🚀 Implantação de Infraestrutura do Azure no BrazilSouth

![Azure](https://img.shields.io/badge/Azure-blue?style=flat-square&logo=microsoftazure)
![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat-square&logo=powershell&logoColor=white)
![Status](https://img.shields.io/badge/Status-Production-green?style=flat-square)

**Aplica-se a:** ✔️ VMs do Windows

## 📋 Metadados

| Metadado | Descrição |
|----------|-----------|
| Título | Template de Infraestrutura Azure para Ambiente Corporativo com Alta Disponibilidade |
| Assunto | Azure Virtual Machines |
| Tipo | Início Rápido |
| Data | 02/02/2025 |
| Autor | Mathews Buzetti |
| Tags | azure-automation, windows-server, high-availability, infrastructure-as-code |

## 💻 Especificações Técnicas

### 💻 Máquina Virtual
* Windows Server 2022 Datacenter
* Tamanho: Standard_B2ms
* Disco OS: 127GB StandardSSD_LRS
* Opção de criar uma segunda VM com as mesmas configurações

### 🌐 Networking
* VNET (10.1.0.0/16)
  * SNET-Internal (10.1.1.0/24)
  * GatewaySubnet (10.1.253.0/27)
* NSG com regras para:
  * RDP (porta 3389)

⚠️ **ATENÇÃO**: Por questões de segurança, após configurar a VPN, é altamente recomendado fechar a porta 3389 (RDP) para acesso externo. O acesso à VM deve ser feito através da VPN.

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
* Automation Account
  * Runbook: START_STOP_VMs (requer configuração adicional)
* Log Analytics Workspace
* Diagnósticos de Boot (desabilitado por padrão)

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

   No site web será pedido os parâmetros necessários:
   * ID da Assinatura Azure
   * Nome do Cliente (maiúsculo)
   * Nome do Cliente (minúsculo)
   * Ambiente (ex: production, development)
   * Nome da Máquina Virtual
   * Nome da Segunda VM (opcional)
   * Usuário e senha para login nas máquinas virtuais
   * Selecione se deseja criar segunda VM
   * Selecione se deseja instalar VPN **GW1**

7. Copie o comando gerado.

8. Cole o comando gerado no Azure CloudShell e pressione Enter.

O script iniciará a implantação dos recursos do Azure.

### ⏱️ Tempo de Execução
- Deploy completo sem VPN: 30 minutos
- Deploy com VPN: 60 minutos


## ⚠️ Avisos Importantes e Pós-Instalação

#### Troubleshooting VPN Gateway
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
3. Você verá uma mensagem de "upgrading", indicando que a implantação está em andamento

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

### 🔐 Credenciais
- **Username**: Definido durante a execução do script
- **Password**: Definido durante a execução do script

⚠️ **IMPORTANTE**: Use uma senha forte que atenda aos requisitos de segurança do Azure!

## 🔄 Procedimento de Rollback

Se for necessário fazer rollback da infraestrutura, siga estes passos:

1. Baixe o script Script_Delete_Resource_Groups:
   
   [![Download Script Rollback](https://img.shields.io/badge/Download%20Script%20Rollback-blue?style=flat-square&logo=powershell)](https://github.com/mathewsbuzetti/deployazure/blob/main/Script_Delete_Resource_Groups.ps1)

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

## 🔄 Versionamento

- Versão: 1.0.0
- Última atualização: 02/02/2025
