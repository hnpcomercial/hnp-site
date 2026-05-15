#!/usr/bin/env bash
# =====================================================================
# HNP Representação Comercial — Download Assets Script
# =====================================================================
# Este script baixa todas as logos e fotos de produto das marcas Sulfisa
# e Kofisa para a pasta assets/, evitando dependência de hotlink.
#
# REQUISITOS: curl (já vem instalado em macOS e Linux; no Windows, use
# Git Bash, WSL ou PowerShell com Invoke-WebRequest).
#
# USO:
#   chmod +x download-assets.sh
#   ./download-assets.sh
#
# DEPOIS:
#   Execute o script de auto-substituição (./use-local-assets.sh) OU
#   substitua manualmente as URLs no index.html (instruções no README).
# =====================================================================

set -e
ASSETS="assets/produtos"
LOGOS="assets"

mkdir -p "$ASSETS"
mkdir -p "$LOGOS"

echo "==> Baixando logos das marcas..."
echo "    (Kofisa já está em assets/brands/kofisa.png — fornecida pela fábrica)"
curl -fsSL -o "$LOGOS/logo-sulfisa.png" \
  "https://lp.sulfisa.com/wp-content/uploads/2025/08/Group-4.png"
echo "    ✓ $LOGOS/logo-sulfisa.png"

echo ""
echo "==> Baixando fotos de produtos Sulfisa..."
declare -A SULFISA=(
  ["sulfisa-fogao.jpg"]="https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-13-1024x1024.jpg"
  ["sulfisa-fritadeira.jpg"]="https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-12-1024x1024.jpg"
  ["sulfisa-caldeirao.jpg"]="https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-14-1024x1024.jpg"
  ["sulfisa-mini-camara.jpg"]="https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-15-1024x1024.jpg"
  ["sulfisa-estante.jpg"]="https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-11-1024x1024.jpg"
)

for filename in "${!SULFISA[@]}"; do
  curl -fsSL -o "$ASSETS/$filename" "${SULFISA[$filename]}"
  echo "    ✓ $ASSETS/$filename"
done

echo ""
echo "==> Baixando fotos de produtos Kofisa..."
declare -A KOFISA=(
  ["kofisa-refrig-2p.png"]="https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-2-Portas-Linha-Professionale_0004_4-800x800.png"
  ["kofisa-refrig-4p.png"]="https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-4-Portas-Linha-Professionale_0004_4-800x800.png"
  ["kofisa-refrig-6p.png"]="https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-6-Portas-Linha-Professionale_0004_4-1-800x800.png"
  ["kofisa-balcao-pia.png"]="https://kofisa.com.br/wp-content/uploads/2023/01/Balcao-de-Servico-2-Portas-Com-Pia-Linha-Professionale_0009_3-800x800.png"
  ["kofisa-condimentador.png"]="https://kofisa.com.br/wp-content/uploads/2023/01/Balcao-Condimentador-2-Portas-Linha-Professionale_0009_1-800x800.png"
  ["kofisa-expositor-blanc.png"]="https://kofisa.com.br/wp-content/uploads/2023/01/Expositor-Auto-Servico-Cinza-2-Portas-Frios-e-Laticinios-Linha-Blanc_0000_7-800x800.png"
  ["kofisa-camara-panificacao.png"]="https://kofisa.com.br/wp-content/uploads/2023/01/Mini-Camara-para-Panificacao-2-Portas_0006_2-800x800.png"
  ["kofisa-camara-gn.png"]="https://kofisa.com.br/wp-content/uploads/2023/01/Mini-Camara-para-Cubas-Gastronomicas_0002_10-800x800.png"
)

for filename in "${!KOFISA[@]}"; do
  curl -fsSL -o "$ASSETS/$filename" "${KOFISA[$filename]}"
  echo "    ✓ $ASSETS/$filename"
done

echo ""
echo "✓ Todas as imagens baixadas com sucesso."
echo ""
echo "Próximo passo: execute ./use-local-assets.sh para atualizar"
echo "automaticamente o index.html para usar as imagens locais."
