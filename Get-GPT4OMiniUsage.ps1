# Script para obtener el uso del recurso 'gpt-4o-mini' en Cognitive Services

# Obtener el ID de la suscripción actual de Azure
$subscriptionId = az account show --query id -o tsv

# Región a consultar
$region = 'eastus'

# Obtener el uso de los servicios cognitivos en la región especificada
$results = az cognitiveservices usage list `
    --subscription $subscriptionId `
    --location $region

# Filtrar y mostrar el uso del modelo 'gpt-4o-mini'
$results | ConvertFrom-Json | Where-Object {
    $_.name.value -match 'gpt-4o-mini'
} | Select-Object @{Name="Model";Expression={($_.name.value -split '\.')[-1]}}, currentValue, limit