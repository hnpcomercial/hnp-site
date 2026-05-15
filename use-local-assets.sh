#!/usr/bin/env bash
# =====================================================================
# HNP Representação Comercial — Switch to Local Assets
# =====================================================================
# Substitui as URLs remotas restantes (Sulfisa logo + 14 produtos) por
# caminhos locais no index.html.
#
# PRÉ-REQUISITO: rodar antes ./download-assets.sh
#
# USO: ./use-local-assets.sh
# =====================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Pré-checagem: as imagens devem ter sido baixadas
REQUIRED=(
  "assets/brands/sulfisa.png"
  "assets/produtos/sulfisa-fogao.jpg"
  "assets/produtos/sulfisa-fritadeira.jpg"
  "assets/produtos/sulfisa-caldeirao.jpg"
  "assets/produtos/sulfisa-mini-camara.jpg"
  "assets/produtos/sulfisa-estante.jpg"
  "assets/produtos/kofisa-refrig-2p.png"
  "assets/produtos/kofisa-refrig-4p.png"
  "assets/produtos/kofisa-refrig-6p.png"
  "assets/produtos/kofisa-balcao-pia.png"
  "assets/produtos/kofisa-condimentador.png"
  "assets/produtos/kofisa-expositor-blanc.png"
  "assets/produtos/kofisa-camara-panificacao.png"
  "assets/produtos/kofisa-camara-gn.png"
)
MISSING=0
for f in "${REQUIRED[@]}"; do
  if [ ! -f "$f" ]; then
    echo -e "${RED}✗ Falta: $f${NC}"
    MISSING=$((MISSING + 1))
  fi
done

if [ $MISSING -gt 0 ]; then
  echo ""
  echo -e "${RED}Erro: $MISSING arquivo(s) não encontrados.${NC}"
  echo -e "${YELLOW}Execute primeiro: ./download-assets.sh${NC}"
  exit 1
fi

# Backup
cp index.html index.html.backup
echo -e "${GREEN}✓ Backup salvo em index.html.backup${NC}"
echo ""

# Detect sed flavor (BSD on macOS vs GNU on Linux)
if [[ "$OSTYPE" == "darwin"* ]]; then
  SED_INPLACE=(sed -i '')
else
  SED_INPLACE=(sed -i)
fi

swap() {
  local from="$1"
  local to="$2"
  "${SED_INPLACE[@]}" "s|${from}|${to}|g" index.html
  echo -e "  ${GREEN}✓${NC} ${to}"
}

echo "Substituindo URLs no index.html..."
echo ""

# ---- Logo Sulfisa ----
swap "https://lp.sulfisa.com/wp-content/uploads/2025/08/Group-4.png" \
     "assets/brands/sulfisa.png"

# ---- Produtos Sulfisa ----
swap "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-13-1024x1024.jpg" \
     "assets/produtos/sulfisa-fogao.jpg"
swap "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-12-1024x1024.jpg" \
     "assets/produtos/sulfisa-fritadeira.jpg"
swap "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-14-1024x1024.jpg" \
     "assets/produtos/sulfisa-caldeirao.jpg"
swap "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-15-1024x1024.jpg" \
     "assets/produtos/sulfisa-mini-camara.jpg"
swap "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-11-1024x1024.jpg" \
     "assets/produtos/sulfisa-estante.jpg"

# ---- Produtos Kofisa ----
swap "https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-2-Portas-Linha-Professionale_0004_4-800x800.png" \
     "assets/produtos/kofisa-refrig-2p.png"
swap "https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-4-Portas-Linha-Professionale_0004_4-800x800.png" \
     "assets/produtos/kofisa-refrig-4p.png"
swap "https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-6-Portas-Linha-Professionale_0004_4-1-800x800.png" \
     "assets/produtos/kofisa-refrig-6p.png"
swap "https://kofisa.com.br/wp-content/uploads/2023/01/Balcao-de-Servico-2-Portas-Com-Pia-Linha-Professionale_0009_3-800x800.png" \
     "assets/produtos/kofisa-balcao-pia.png"
swap "https://kofisa.com.br/wp-content/uploads/2023/01/Balcao-Condimentador-2-Portas-Linha-Professionale_0009_1-800x800.png" \
     "assets/produtos/kofisa-condimentador.png"
swap "https://kofisa.com.br/wp-content/uploads/2023/01/Expositor-Auto-Servico-Cinza-2-Portas-Frios-e-Laticinios-Linha-Blanc_0000_7-800x800.png" \
     "assets/produtos/kofisa-expositor-blanc.png"
swap "https://kofisa.com.br/wp-content/uploads/2023/01/Mini-Camara-para-Panificacao-2-Portas_0006_2-800x800.png" \
     "assets/produtos/kofisa-camara-panificacao.png"
swap "https://kofisa.com.br/wp-content/uploads/2023/01/Mini-Camara-para-Cubas-Gastronomicas_0002_10-800x800.png" \
     "assets/produtos/kofisa-camara-gn.png"

# Verificação final
echo ""
REMAINING=$(grep -oE 'src="https://(kofisa\.com\.br|lp\.sulfisa\.com)/[^"]*"' index.html | wc -l | tr -d ' ')

if [ "$REMAINING" -eq 0 ]; then
  echo -e "${GREEN}✓ index.html atualizado. Zero hotlinks restantes para Sulfisa/Kofisa.${NC}"
  echo ""
  echo "Próximos passos:"
  echo "  1. Abra index.html no navegador para conferir que tudo carregou"
  echo "  2. Faça commit no GitHub Desktop"
  echo "  3. Push para publicar"
else
  echo -e "${YELLOW}⚠ Atenção: $REMAINING hotlink(s) ainda permanecem no index.html.${NC}"
  echo "  Inspecione manualmente com:"
  echo -e "    ${YELLOW}grep 'kofisa.com.br\\|lp.sulfisa.com' index.html${NC}"
fi
echo ""
echo "(backup do arquivo original em index.html.backup caso queira reverter)"
