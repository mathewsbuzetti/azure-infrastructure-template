<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Azure Infrastructure Deployment Tool</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: all 0.3s ease;
        }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #1a1f25 0%, #2d3748 100%);
            color: #e0e0e0;
            padding: 20px;
            min-height: 100vh;
        }
        .container {
            max-width: 700px;
            margin: 20px auto;
            background: rgba(30, 30, 30, 0.95);
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
            color: #60a5fa;
            font-size: 32px;
            font-weight: 600;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            letter-spacing: 0.5px;
        }
        label {
            display: block;
            margin: 15px 0 8px;
            font-weight: 500;
            color: #e0e0e0;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        input, select {
            width: 100%;
            padding: 12px 16px;
            margin-bottom: 15px;
            border: 2px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            background: rgba(44, 44, 44, 0.8);
            color: #e0e0e0;
            font-size: 15px;
            outline: none;
        }
        input:focus, select:focus {
            border-color: #60a5fa;
            box-shadow: 0 0 0 2px rgba(96, 165, 250, 0.2);
        }
        input::placeholder {
            color: #666;
        }
        .field-info {
            color: #888;
            font-size: 0.85em;
            margin-top: -10px;
            margin-bottom: 15px;
            padding: 8px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 6px;
            border-left: 3px solid #60a5fa;
        }
        .field-info strong {
            color: #60a5fa;
        }
        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 20px;
        }
        button {
            flex: 1;
            padding: 12px;
            background: linear-gradient(135deg, #60a5fa 0%, #3b82f6 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
            font-weight: 500;
            letter-spacing: 0.5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
        }
        .output {
            margin-top: 25px;
            padding: 16px;
            background: rgba(44, 44, 44, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            font-family: 'Consolas', monospace;
            white-space: pre-wrap;
            word-break: break-all;
            font-size: 14px;
        }
        .message {
            display: none;
            margin-top: 15px;
            padding: 12px;
            background: rgba(40, 167, 69, 0.9);
            color: white;
            border-radius: 8px;
            text-align: center;
            animation: fadeIn 0.3s ease;
        }
        .reminder {
            display: none;
            margin-top: 15px;
            padding: 12px;
            background: rgba(255, 193, 7, 0.9);
            color: black;
            border-radius: 8px;
            text-align: center;
            animation: fadeIn 0.3s ease;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        footer {
            margin-top: 30px;
            text-align: center;
            font-size: 13px;
            color: #888;
        }
        footer a {
            color: #60a5fa;
            text-decoration: none;
            font-weight: 500;
        }
        footer a:hover {
            color: #3b82f6;
            text-decoration: underline;
        }
        .error {
            color: #f87171;
            margin-bottom: 15px;
            display: none;
            text-align: left;
            font-size: 14px;
            padding: 8px 12px;
            background: rgba(248, 113, 113, 0.1);
            border-radius: 6px;
        }
        .field-error {
            border-color: #f87171;
        }
        .error-detail {
            color: #f87171;
            font-size: 12px;
            margin-top: -12px;
            margin-bottom: 12px;
            opacity: 0.9;
        }
        
        @media (max-width: 768px) {
            .container {
                margin: 10px;
                padding: 20px;
            }
            .button-group {
                flex-direction: column;
            }
            button {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Azure Infrastructure Deployment Tool</h1>
        <form id="deployForm">
            <label for="subscriptionId">ID da Assinatura *</label>
            <input type="text" id="subscriptionId" placeholder="Ex.: e875c481-3a50-4369-8c6f-5c58697332e2" required>
            <div id="subscriptionId-error" class="error-detail"></div>
            
            <label for="location">Localização Brazil South</label>
            <input type="text" id="location" value="brazilsouth" readonly>
            <div id="location-error" class="error-detail"></div>
            
            <label for="locationUS">Localização US</label>
            <input type="text" id="locationUS" value="eastus" readonly>
            <div class="field-info">
                <strong>Importante:</strong> Esta região é para recurso Azure Automation account. <strong>Não pode estar na mesma região do recurso principal</strong>, pois isso impedirá o funcionamento correto do Azure Automation account.
            </div>
            
            <label for="clientNameUpper">Nome do Cliente (Maiúsculo) *</label>
            <input type="text" id="clientNameUpper" placeholder="Ex.: MATHEWSB" required>
            <div id="clientNameUpper-error" class="error-detail"></div>
            <div class="field-info">
                <strong>Por que maiúsculo?</strong> Este formato é utilizado para nomear recursos do Azure seguindo as convenções de nomenclatura. Será usado para criar grupos de recursos (Resource Groups) e outros componentes onde o padrão é utilizar letras maiúsculas.
            </div>
            
            <label for="clientNameLower">Nome do Cliente (Minúsculo) *</label>
            <input type="text" id="clientNameLower" placeholder="Ex.: mathews" required>
            <div id="clientNameLower-error" class="error-detail"></div>
            <div class="field-info">
                <strong>Por que minúsculo?</strong> Este formato é necessário para recursos do Azure que exigem nomes em letras minúsculas, como contas de armazenamento (Storage Accounts) e outros serviços que não aceitam caracteres maiúsculos.
            </div>
            
            <label for="environment">Ambiente *</label>
            <select id="environment" required>
                <option value="">Selecione o ambiente</option>
                <option value="production">production</option>
                <option value="development">development</option>
                <option value="homologation">homologation</option>
            </select>
            <div id="environment-error" class="error-detail"></div>
            
            <label for="vmName">Nome da Máquina Virtual *</label>
            <input type="text" id="vmName" placeholder="Ex.: MATHEWS-DC01" required>
            <div id="vmName-error" class="error-detail"></div>
            
            <div class="error" id="errorMessage">Por favor, preencha todos os campos obrigatórios.</div>
            
            <div class="button-group">
                <button type="button" onclick="generateCommand()">Gerar Comando</button>
                <button type="button" onclick="copyCommand()">Copiar Comando</button>
                <button type="button" onclick="openAzureCloudShell()">Acessar Azure CloudShell</button>
            </div>
        </form>
        
        <div class="output" id="output"></div>
        <div class="message" id="copyMessage">Comando copiado!</div>
        <div class="reminder" id="reminderMessage">Lembre-se de fazer o upload do script no CloudShell antes de executar o comando gerado.</div>
    </div>
    
    <footer>
        Desenvolvido por <a href="https://github.com/mathewsbuzetti" target="_blank">Mathews Buzetti</a>
    </footer>
    
    <script>
        function resetErrorStyles() {
            const inputs = document.querySelectorAll('input[required], select[required]');
            inputs.forEach(input => {
                input.classList.remove('field-error');
                document.getElementById(`${input.id}-error`).textContent = '';
            });
        }
        
        function validateForm() {
            resetErrorStyles();
            const inputs = document.querySelectorAll('input[required], select[required]');
            const errorMessage = document.getElementById('errorMessage');
            let isFormValid = true;
            
            inputs.forEach(input => {
                if (!input.value.trim()) {
                    input.classList.add('field-error');
                    document.getElementById(`${input.id}-error`).textContent = 'Este campo é obrigatório';
                    isFormValid = false;
                }
            });
            
            const clientNameUpper = document.getElementById('clientNameUpper');
            const clientNameLower = document.getElementById('clientNameLower');
            
            if (clientNameUpper.value !== clientNameUpper.value.toUpperCase()) {
                clientNameUpper.classList.add('field-error');
                document.getElementById('clientNameUpper-error').textContent = 'O nome do cliente deve estar totalmente em MAIÚSCULAS';
                isFormValid = false;
            }
            
            if (clientNameLower.value !== clientNameLower.value.toLowerCase()) {
                clientNameLower.classList.add('field-error');
                document.getElementById('clientNameLower-error').textContent = 'O nome do cliente deve estar totalmente em minúsculas';
                isFormValid = false;
            }
            
            errorMessage.style.display = isFormValid ? 'none' : 'block';
            return isFormValid;
        }
        
        function generateCommand() {
            if (!validateForm()) return;

            const subscriptionId = document.getElementById('subscriptionId').value;
            const locationBrazil = document.getElementById('location').value;
            const locationUS = document.getElementById('locationUS').value;
            const clientNameUpper = document.getElementById('clientNameUpper').value;
            const clientNameLower = document.getElementById('clientNameLower').value;
            const environment = document.getElementById('environment').value;
            const vmName = document.getElementById('vmName').value;

            const command = '.\\Deploy-AzureInfrastructure-BrazilSouth.ps1 -SubscriptionId "' + subscriptionId +
                '" -LocationBrazil "' + locationBrazil + '" -LocationUS "' + locationUS +
                '" -ClientNameUpper "' + clientNameUpper + '" -ClientNameLower "' + clientNameLower +
                '" -Environment "' + environment + '" -VMName "' + vmName + '"';

            document.getElementById('output').textContent = command;
        }
        
        function copyCommand() {
            const outputElement = document.getElementById('output');
            if (!outputElement.textContent.trim()) {
                alert('Primeiro gere um comando');
                return;
            }
            navigator.clipboard.writeText(outputElement.textContent).then(() => {
                const copyMessage = document.getElementById('copyMessage');
                const reminderMessage = document.getElementById('reminderMessage');
                copyMessage.style.display = 'block';
                reminderMessage.style.display = 'block';
                
                setTimeout(() => {
                    copyMessage.style.display = 'none';
                    reminderMessage.style.display = 'none';
                }, 3000);
            }).catch(err => {
                console.error('Erro ao copiar:', err);
                alert('Erro ao copiar o comando');
            });
        }
        
        function openAzureCloudShell() {
            window.open('https://portal.azure.com/#cloudshell/', '_blank');
        }
    </script>
</body>
</html>
