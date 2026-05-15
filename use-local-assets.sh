#!/usr/bin/env bash
# =====================================================================
# HNP Representação Comercial — Switch to Local Assets
# =====================================================================
# Substitui as URLs remotas (Sulfisa e Kofisa) por caminhos locais no
# index.html. Execute APÓS rodar ./download-assets.sh.
#
# USO:
#   chmod +x use-local-assets.sh
#   ./use-local-assets.sh
# =====================================================================

set -e

if [ ! -f "assets/logo-sulfisa.png" ] || [ ! -f "assets/logo-kofisa.png" ]; then
  echo "✗ Erro: imagens locais não encontradas em assets/"
  echo "  Execute primeiro: ./download-assets.sh"
  exit 1
fi

# Backup
cp index.html index.html.backup
echo "✓ Backup salvo em index.html.backup"

# Detect sed flavor (BSD on macOS vs GNU on Linux)
if [[ "$OSTYPE" == "darwin"* ]]; then
  SED="sed -i ''"
else
  SED="sed -i"
fi

# ---- Logos ----
$SED 's|https://lp.sulfisa.com/wp-content/uploads/2025/08/Group-4.png|assets/logo-sulfisa.png|g' index.html
$SED 's|https://kofisa.com.br/wp-content/uploads/2023/01/KFS_logo1.png|assets/logo-kofisa.png|g' index.html

# ---- Produtos Sulfisa ----
$SED 's|https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-13-1024x1024.jpg|assets/produtos/sulfisa-fogao.jpg|g' index.html
$SED 's|https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-12-1024x1024.jpg|assets/produtos/sulfisa-fritadeira.jpg|g' index.html
$SED 's|https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-14-1024x1024.jpg|assets/produtos/sulfisa-caldeirao.jpg|g' index.html
$SED 's|https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-15-1024x1024.jpg|assets/produtos/sulfisa-mini-camara.jpg|g' index.html
$SED 's|https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-11-1024x1024.jpg|assets/produtos/sulfisa-estante.jpg|g' index.html

# ---- Produtos Kofisa ----
$SED 's|https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-2-Portas-Linha-Professionale_0004_4-800x800.png|assets/produtos/kofisa-refrig-2p.png|g' index.html
$SED 's|https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-4-Portas-Linha-Professionale_0004_4-800x800.png|assets/produtos/kofisa-refrig-4p.png|g' index.html
$SED 's|https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-6-Portas-Linha-Professionale_0004_4-1-800x800.png|assets/produtos/kofisa-refrig-6p.png|g' index.html
$SED 's|https://kofisa.com.br/wp-content/uploads/2023/01/Balcao-de-Servico-2-Portas-Com-Pia-Linha-Professionale_0009_3-800x800.png|assets/produtos/kofisa-balcao-pia.png|g' index.html
$SED 's|https://kofisa.com.br/wp-content/uploads/2023/01/Balcao-Condimentador-2-Portas-Linha-Professionale_0009_1-800x800.png|assets/produtos/kofisa-condimentador.png|g' index.html
$SED 's|https://kofisa.com.br/wp-content/uploads/2023/01/Expositor-Auto-Servico-Cinza-2-Portas-Frios-e-Laticinios-Linha-Blanc_0000_7-800x800.png|assets/produtos/kofisa-expositor-blanc.png|g' index.html
$SED 's|https://kofisa.com.br/wp-content/uploads/2023/01/Mini-Camara-para-Panificacao-2-Portas_0006_2-800x800.png|assets/produtos/kofisa-camara-panificacao.png|g' index.html
$SED 's|https://kofisa.com.br/wp-content/uploads/2023/01/Mini-Camara-para-Cubas-Gastronomicas_0002_10-800x800.png|assets/produtos/kofisa-camara-gn.png|g' index.html

echo "✓ index.html atualizado para usar imagens locais"
echo "  (backup em index.html.backup caso queira reverter)"
