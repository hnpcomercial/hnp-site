#!/usr/bin/env bash
# =====================================================================
# HNP Representação Comercial — Download Assets (one-shot script)
# =====================================================================
# Baixa todas as imagens das marcas que ainda estão em hotlink para a
# pasta assets/, eliminando dependência dos servidores Sulfisa/Kofisa.
#
# DEPOIS DE EXECUTAR ESTE SCRIPT, rode também:
#   ./use-local-assets.sh
#
# que substitui as URLs no index.html pelos caminhos locais.
#
# REQUISITOS: curl (já vem em macOS e Linux; no Windows use Git Bash)
# =====================================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

if ! command -v curl &> /dev/null; then
  echo -e "${RED}✗ Erro: curl não encontrado.${NC}"
  echo "  Instale curl ou use Git Bash (Windows)."
  exit 1
fi

BRANDS="assets/brands"
PRODUTOS="assets/produtos"

mkdir -p "$BRANDS"
mkdir -p "$PRODUTOS"

TOTAL=14
COUNT=0
FAILED=0

download() {
  local url="$1"
  local dest="$2"
  COUNT=$((COUNT + 1))
  printf "  [%2d/%d] " "$COUNT" "$TOTAL"
  if curl -fsSL --max-time 30 -o "$dest" "$url"; then
    echo -e "${GREEN}✓${NC} $dest"
  else
    echo -e "${RED}✗${NC} FALHOU: $url"
    FAILED=$((FAILED + 1))
  fi
}

echo -e "${BLUE}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  HNP — Download das imagens das marcas representadas    ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Baixando $TOTAL imagens (logo Sulfisa + 5 produtos Sulfisa + 8 produtos Kofisa)...${NC}"
echo ""

echo -e "${BLUE}━━━ Sulfisa: logo ━━━${NC}"
download "https://lp.sulfisa.com/wp-content/uploads/2025/08/Group-4.png" \
         "$BRANDS/sulfisa.png"

echo ""
echo -e "${BLUE}━━━ Sulfisa: produtos ━━━${NC}"
download "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-13-1024x1024.jpg" \
         "$PRODUTOS/sulfisa-fogao.jpg"
download "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-12-1024x1024.jpg" \
         "$PRODUTOS/sulfisa-fritadeira.jpg"
download "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-14-1024x1024.jpg" \
         "$PRODUTOS/sulfisa-caldeirao.jpg"
download "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-15-1024x1024.jpg" \
         "$PRODUTOS/sulfisa-mini-camara.jpg"
download "https://lp.sulfisa.com/wp-content/uploads/2025/08/equipamento-11-1024x1024.jpg" \
         "$PRODUTOS/sulfisa-estante.jpg"

echo ""
echo -e "${BLUE}━━━ Kofisa: produtos ━━━${NC}"
download "https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-2-Portas-Linha-Professionale_0004_4-800x800.png" \
         "$PRODUTOS/kofisa-refrig-2p.png"
download "https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-4-Portas-Linha-Professionale_0004_4-800x800.png" \
         "$PRODUTOS/kofisa-refrig-4p.png"
download "https://kofisa.com.br/wp-content/uploads/2023/01/Refrigerador-Vertical-6-Portas-Linha-Professionale_0004_4-1-800x800.png" \
         "$PRODUTOS/kofisa-refrig-6p.png"
download "https://kofisa.com.br/wp-content/uploads/2023/01/Balcao-de-Servico-2-Portas-Com-Pia-Linha-Professionale_0009_3-800x800.png" \
         "$PRODUTOS/kofisa-balcao-pia.png"
download "https://kofisa.com.br/wp-content/uploads/2023/01/Balcao-Condimentador-2-Portas-Linha-Professionale_0009_1-800x800.png" \
         "$PRODUTOS/kofisa-condimentador.png"
download "https://kofisa.com.br/wp-content/uploads/2023/01/Expositor-Auto-Servico-Cinza-2-Portas-Frios-e-Laticinios-Linha-Blanc_0000_7-800x800.png" \
         "$PRODUTOS/kofisa-expositor-blanc.png"
download "https://kofisa.com.br/wp-content/uploads/2023/01/Mini-Camara-para-Panificacao-2-Portas_0006_2-800x800.png" \
         "$PRODUTOS/kofisa-camara-panificacao.png"
download "https://kofisa.com.br/wp-content/uploads/2023/01/Mini-Camara-para-Cubas-Gastronomicas_0002_10-800x800.png" \
         "$PRODUTOS/kofisa-camara-gn.png"

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════${NC}"
if [ $FAILED -eq 0 ]; then
  echo -e "${GREEN}✓ Todas as $TOTAL imagens baixadas com sucesso.${NC}"
  echo ""
  echo "Próximo passo: substituir as URLs no index.html"
  echo ""
  echo -e "${YELLOW}  ./use-local-assets.sh${NC}"
  echo ""
else
  echo -e "${RED}✗ $FAILED download(s) falharam.${NC}"
  echo "  Verifique sua conexão e tente novamente, ou baixe manualmente"
  echo "  as URLs que falharam."
  exit 1
fi
