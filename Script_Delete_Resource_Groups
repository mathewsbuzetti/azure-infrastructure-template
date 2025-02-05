param (
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $true)]
    [string]$ClientNameUpper
)

# Função para criar banners visuais
function Write-Banner {
    param (
        [string]$Titulo
    )
    $largura = 80
    $borda = "=" * $largura
    Write-Host "`n$borda" -ForegroundColor Magenta
    Write-Host ((" " * (($largura - $Titulo.Length) / 2)) + $Titulo) -ForegroundColor Magenta
    Write-Host "$borda`n" -ForegroundColor Magenta
}

# Função de log aprimorada com timestamps e ícones
function Write-Log {
    param (
        [string]$Mensagem,
        [string]$Tipo
    )
    
    $timestamp = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    $icone = switch ($Tipo) {
        "INFO"    { "ℹ️" }
        "SUCESSO" { "✅" }
        "ERRO"    { "❌" }
        "ALERTA"  { "⚠️" }
        default   { "➡️" }
    }
    
    $cor = switch ($Tipo) {
        "INFO"    { "Cyan" }
        "SUCESSO" { "Green" }
        "ERRO"    { "Red" }
        "ALERTA"  { "Yellow" }
        default   { "White" }
    }

    Write-Host "[$timestamp] " -NoNewline -ForegroundColor DarkGray
    Write-Host "$icone " -NoNewline
    Write-Host $Mensagem -ForegroundColor $cor
}

# Função para validar recursos antes da exclusão
function Test-ResourceGroupContents {
    param (
        [string]$ResourceGroupName
    )
    
    $recursos = Get-AzResource -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue
    if ($recursos) {
        Write-Host "`nRecursos encontrados em ${ResourceGroupName}:" -ForegroundColor Yellow
        $recursos | ForEach-Object {
            Write-Host " - $($_.Name) ($($_.ResourceType))" -ForegroundColor Gray
        }
        return $true
    }
    return $false
}

# Cabeçalho do script
Clear-Host
Write-Banner "Ferramenta de Exclusão de Grupos de Recursos do Azure"

# Verificar conexão com o Azure
Write-Log "Verificando conexão com o Azure..." "INFO"
try {
    $contexto = Get-AzContext
    if (-not $contexto) {
        throw "Não conectado ao Azure"
    }
    Write-Log "Conexão com o Azure verificada com sucesso" "SUCESSO"
} catch {
    Write-Log "Erro ao verificar conexão com o Azure. Execute 'Connect-AzAccount' primeiro." "ERRO"
    exit 1
}

# Seleção da assinatura
Write-Log "Conectando à assinatura Azure..." "INFO"
try {
    $assinatura = Select-AzSubscription -SubscriptionId $SubscriptionId -ErrorAction Stop
    Write-Log "Conectado com sucesso à assinatura Azure" "SUCESSO"
    
    Write-Host "`nDetalhes da Assinatura:" -ForegroundColor Cyan
    $assinatura | Format-Table -Property @{
        Label = "Nome"; Expression = {$_.Subscription.Name}
    }, @{
        Label = "ID"; Expression = {$_.Subscription.Id}
    }, @{
        Label = "Estado"; Expression = {$_.Subscription.State}
    }, @{
        Label = "ID do Tenant"; Expression = {$_.Tenant.Id}
    } -AutoSize
} catch {
    Write-Log "Falha ao conectar à assinatura Azure: $_" "ERRO"
    exit 1
}

# Função de exclusão de grupo de recursos aprimorada
function Remove-ResourceGroupSafely {
    param (
        [string]$ResourceGroupName
    )
    
    Write-Host "`n> Processando: " -NoNewline
    Write-Host $ResourceGroupName -ForegroundColor Cyan
    
    if (Get-AzResourceGroup -Name $ResourceGroupName -ErrorAction SilentlyContinue) {
        # Verificar conteúdo do grupo de recursos
        $temRecursos = Test-ResourceGroupContents -ResourceGroupName $ResourceGroupName
        
        try {
            Write-Progress -Activity "Excluindo Grupo de Recursos" -Status $ResourceGroupName
            Remove-AzResourceGroup -Name $ResourceGroupName -Force -ErrorAction Stop
            Write-Log "Grupo de recursos excluído com sucesso: $ResourceGroupName" "SUCESSO"
        } catch {
            Write-Log "Falha ao excluir grupo de recursos: $ResourceGroupName`nErro: $_" "ERRO"
        }
    } else {
        Write-Log "Grupo de recursos não encontrado: $ResourceGroupName" "ALERTA"
    }
    Write-Progress -Activity "Excluindo Grupo de Recursos" -Completed
}

# Confirmação com detalhes
Write-Banner "Confirmação de Exclusão"
Write-Host "Nome do Cliente: " -NoNewline
Write-Host $ClientNameUpper -ForegroundColor Yellow
Write-Host "Grupos de Recursos a serem excluídos:"

$gruposRecursos = @(
    "RG-$ClientNameUpper-VM",
    "RG-$ClientNameUpper-Storage",
    "RG-$ClientNameUpper-Networks",
    "RG-$ClientNameUpper-Backup",
    "RG-$ClientNameUpper-Automation",
    "RG-$ClientNameUpper-LogAnalytics"
)

# Verificar existência prévia dos grupos
$gruposExistentes = @()
foreach ($rg in $gruposRecursos) {
    if (Get-AzResourceGroup -Name $rg -ErrorAction SilentlyContinue) {
        Write-Host " - $rg" -ForegroundColor Green
        $gruposExistentes += $rg
    } else {
        Write-Host " - $rg" -ForegroundColor Gray -NoNewline
        Write-Host " (Não encontrado)" -ForegroundColor Red
    }
}

if ($gruposExistentes.Count -eq 0) {
    Write-Log "Nenhum grupo de recursos encontrado para exclusão" "ALERTA"
    exit 0
}

Write-Host "`nGrupos encontrados: " -NoNewline
Write-Host "$($gruposExistentes.Count)" -ForegroundColor Yellow -NoNewline
Write-Host " de " -NoNewline
Write-Host "$($gruposRecursos.Count)" -ForegroundColor Yellow

Write-Host "`nDeseja prosseguir com a exclusão? " -NoNewline
$confirmacao = Read-Host "(Yes/No)"

if ($confirmacao.ToLower() -eq 'yes') {
    Write-Banner "Iniciando Processo de Exclusão"
    
    $totalGrupos = $gruposExistentes.Count
    $grupoAtual = 0
    
    foreach ($rg in $gruposExistentes) {
        $grupoAtual++
        $percentualProgresso = ($grupoAtual / $totalGrupos) * 100
        Write-Progress -Activity "Progresso Geral" -Status "$grupoAtual de $totalGrupos grupos processados" -PercentComplete $percentualProgresso
        Remove-ResourceGroupSafely -ResourceGroupName $rg
    }
    
    Write-Progress -Activity "Progresso Geral" -Completed
    Write-Banner "Operação Concluída"
    Write-Log "Processo de exclusão de grupos de recursos concluído." "SUCESSO"
    Write-Host "`nScript desenvolvido por " -NoNewline
    Write-Host "Mathews Buzetti" -ForegroundColor Cyan
} else {
    Write-Log "Operação cancelada pelo usuário" "ALERTA"
    Write-Host "`nScript desenvolvido por " -NoNewline
    Write-Host "Mathews Buzetti" -ForegroundColor Cyan
}

# Gerar relatório final
Write-Banner "Relatório Final"

# Criando array para armazenar resultados
$resultados = @()

# Adicionando informações ao array
$resultados += [PSCustomObject]@{
    "Data/Hora" = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
    "Cliente" = $ClientNameUpper
    "Grupos Processados" = $gruposExistentes.Count
    "Grupos Não Encontrados" = $gruposRecursos.Count - $gruposExistentes.Count
    "Status" = if ($gruposExistentes.Count -gt 0) { "Concluído" } else { "Sem grupos para processar" }
}

# Formatando e exibindo o relatório
$resultados | Format-Table -AutoSize -Wrap

# Gerar arquivo de log
$logPath = ".\logs"
$logFile = Join-Path $logPath "deletion_log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

# Criar diretório de logs se não existir
if (-not (Test-Path $logPath)) {
    New-Item -ItemType Directory -Path $logPath | Out-Null
}

# Exportar relatório para arquivo
$resultados | Format-Table -AutoSize | Out-File $logFile -Append
Write-Log "Relatório exportado para: $logFile" "INFO"
