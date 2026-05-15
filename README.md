# HNP Representação Comercial — Site Institucional

Site institucional one-page para a **HNP Representação Comercial**, representante
oficial das marcas **Sulfisa** e **Kofisa** no segmento de equipamentos para
cozinhas profissionais.

🌐 Domínio: **hnpcomercial.com.br**
📞 WhatsApp: **+55 (11) 94760-9085**

---

## Estrutura do projeto

```
hnp-site/
├── index.html              ← arquivo principal do site
├── CNAME                   ← domínio customizado (GitHub Pages)
├── README.md               ← este arquivo
├── .gitignore              ← arquivos ignorados pelo Git
├── download-assets.sh      ← baixa imagens das marcas para uso local
├── use-local-assets.sh     ← troca URLs remotas por caminhos locais
└── assets/
    ├── hamilton.jpg            ← foto do sócio-fundador (já incluída)
    └── produtos/               ← preenchida pelo download-assets.sh
```

---

# 🚀 Guia de publicação no GitHub Pages

Este é o passo-a-passo completo. Reserve 20–30 minutos.

## Etapa 1 — Criar conta no GitHub (você precisa fazer isso)

⚠️ **Importante:** o cadastro precisa ser feito por você diretamente. Não
delegue para ninguém — essa é a sua identidade digital.

1. Acesse **https://github.com/signup**
2. Informe seu e-mail (sugestão: `contato@hnpcomercial.com.br` quando o
   domínio estiver com e-mail configurado, ou um e-mail pessoal por enquanto)
3. Crie uma senha forte e guarde em local seguro (gerenciador de senhas)
4. Escolha um nome de usuário — sugestão: **`hnpcomercial`**
   - Verifique se está disponível
   - Será parte da URL: `https://hnpcomercial.github.io`
5. Valide o e-mail enviado pelo GitHub
6. (Opcional mas recomendado) Ative autenticação em dois fatores em
   Settings → Password and authentication → Two-factor authentication

## Etapa 2 — Baixar e auto-hospedar as imagens das marcas (⚠️ NÃO PULE)

⚠️ **Etapa crítica.** O site ainda referencia **14 imagens** dos servidores
Sulfisa e Kofisa via hotlink (1 logo + 5 produtos Sulfisa + 8 produtos
Kofisa). Se essas fábricas reorganizarem o servidor ou ativarem proteção
anti-hotlink, as imagens somem do seu site. Vamos eliminar essa dependência
com **dois comandos**.

**No seu computador**, abra um terminal na pasta do projeto e execute:

```bash
chmod +x download-assets.sh use-local-assets.sh
./download-assets.sh
./use-local-assets.sh
```

O que cada script faz:

- **`download-assets.sh`** baixa as 14 imagens para `assets/brands/` (logo Sulfisa) e `assets/produtos/` (todas as fotos de produto). Mostra progresso visual e contagem de sucessos/falhas.
- **`use-local-assets.sh`** substitui as 14 URLs no `index.html` pelos caminhos locais correspondentes. Faz backup automático em `index.html.backup`. No final, verifica e confirma "Zero hotlinks restantes".

**Como rodar em cada sistema operacional:**

- **macOS:** abra o app **Terminal**, navegue até a pasta com `cd /caminho/para/hnp-site/`, e cole os 3 comandos acima
- **Windows:** clique com botão direito na pasta `hnp-site` no Explorer → "Git Bash Here" (instalado junto com o Git) → cole os 3 comandos acima
- **Linux:** Terminal padrão, mesmos comandos

**Tempo total: 30 segundos** (depende da sua internet).

Depois de rodar, faça commit no GitHub Desktop e push. Pronto — seu site é
100% auto-hospedado, sem nenhuma dependência externa exceto fonts do Google.

**Direito de uso:** como representante oficial das marcas, você tem
autorização para utilizar materiais institucionais das fábricas. Boa
prática: comunicar Sulfisa e Kofisa que o site fará uso desses ativos.

## Etapa 3 — Instalar o Git (se ainda não tiver)

- **macOS:** abra Terminal e digite `git --version`. Se pedir para instalar
  as Command Line Tools, aceite. Pronto.
- **Windows:** baixe em **https://git-scm.com/download/win** e instale com
  as opções padrão. Inclui o "Git Bash".
- **Linux (Ubuntu/Debian):** `sudo apt install git`

Verifique:
```bash
git --version
```

## Etapa 4 — Criar o repositório no GitHub

1. Logado no GitHub, clique no **+** no canto superior direito → **New repository**
2. Configure:
   - **Repository name:** `hnpcomercial.github.io`
     *(usando esse nome exato, o site fica em `https://hnpcomercial.github.io`
     na raiz, sem subdiretório)*
   - **Description:** `Site institucional — HNP Representação Comercial`
   - **Public** (necessário para GitHub Pages gratuito)
   - **NÃO** marque "Add a README" (já temos um)
   - **NÃO** adicione .gitignore nem license pela interface
3. Clique em **Create repository**
4. Na tela seguinte, copie a URL do repositório
   (algo como `https://github.com/hnpcomercial/hnpcomercial.github.io.git`)

## Etapa 5 — Subir os arquivos via Git

No seu computador, dentro da pasta `hnp-site`:

```bash
# Configura sua identidade no Git (primeira vez apenas)
git config --global user.name "Seu Nome"
git config --global user.email "seu-email@example.com"

# Inicializa o repositório
git init
git add .
git commit -m "Primeira publicação do site institucional HNP"

# Conecta ao GitHub e envia
git branch -M main
git remote add origin https://github.com/SEU-USUARIO/hnpcomercial.github.io.git
git push -u origin main
```

> Na hora do `push`, o GitHub vai pedir autenticação. **Não use sua senha
> direta — não funciona mais.** Use uma das opções abaixo:
>
> **Opção A (mais simples):** instale o **GitHub Desktop**
> (https://desktop.github.com) — interface gráfica, faz login automático.
>
> **Opção B:** crie um **Personal Access Token** em
> Settings → Developer settings → Personal access tokens → Tokens (classic)
> → Generate new token → marque "repo" → cole o token quando o terminal
> pedir senha.

## Etapa 6 — Ativar o GitHub Pages

1. No repositório no GitHub, vá em **Settings** (engrenagem no topo)
2. Menu lateral → **Pages**
3. Em "Build and deployment":
   - **Source:** Deploy from a branch
   - **Branch:** `main` / `/ (root)`
   - Salvar
4. Aguarde 1–2 minutos
5. Volte na página, deve aparecer:
   `Your site is live at https://hnpcomercial.github.io`
6. Abra essa URL para conferir ✓

## Etapa 7 — Apontar o domínio hnpcomercial.com.br

O arquivo `CNAME` já está no repositório com o domínio correto.

### 7.1 — No GitHub

1. Em **Settings → Pages**
2. Em "Custom domain", confirme que está preenchido com `hnpcomercial.com.br`
   (caso não esteja, escreva e salve)
3. Marque **Enforce HTTPS** (espere alguns minutos se o checkbox estiver
   desabilitado — o GitHub precisa emitir o certificado SSL primeiro)

### 7.2 — No Registro.br (onde você comprou o domínio)

1. Acesse **https://registro.br** e faça login
2. Vá em "Meus Domínios" → clique em **hnpcomercial.com.br**
3. Em "DNS", configure:

   **Registros A (raiz `@`):**
   - `185.199.108.153`
   - `185.199.109.153`
   - `185.199.110.153`
   - `185.199.111.153`

   **Registro CNAME (subdomínio `www`):**
   - Nome: `www`
   - Valor: `hnpcomercial.github.io`

4. Salve as alterações
5. **Aguarde a propagação DNS:** geralmente 15 minutos a 4 horas; em casos
   raros até 48h
6. Teste em https://hnpcomercial.com.br

> **Dica:** confira o status da propagação em
> https://dnschecker.org/#A/hnpcomercial.com.br

---

# 📝 Edições futuras

Depois que tudo estiver no ar, qualquer mudança segue o mesmo fluxo:

```bash
# Edite o arquivo desejado (index.html, etc.)
git add .
git commit -m "Descrição clara da mudança"
git push
```

O GitHub Pages redeploya automaticamente em ~1 minuto.

**Usando GitHub Desktop:** abra o app, ele detecta as mudanças
automaticamente. Escreva uma mensagem de commit, clique em "Commit to main"
e depois em "Push origin". Pronto.

---

# 🎨 Personalização

### Cores e tipografia

Centralizadas no bloco `:root` do `<style>` no `index.html`:

```css
:root {
  --bg:          #EFE7D9;    /* cream parchment */
  --ink:         #14110D;    /* deep ink */
  --accent:      #C2521E;    /* burnt copper */
  --serif:       'Fraunces', serif;
  --sans:        'Manrope', sans-serif;
}
```

### Textos institucionais

Tudo em português, dentro de `<section>` claramente nomeadas no HTML
(Hero, Manifesto, Founder, Brands, Equipment, Segments, Diff, Contact,
Footer). Abra em qualquer editor de texto (VS Code recomendado:
https://code.visualstudio.com).

### Substituir a foto do Hamilton

A foto atual está em `assets/hamilton.jpg`. Para trocar:

1. Salve a nova foto em formato JPG, proporção 4:5 (vertical), ~800×1000 px
2. Substitua o arquivo `assets/hamilton.jpg`
3. Commit + push

---

# 📈 SEO e analytics

### Já configurado no HTML

- `<title>` otimizado
- Meta description
- Open Graph (compartilhamento em redes sociais)
- Canonical URL
- Idioma: pt-BR

### Recomendado adicionar futuramente

- **Google Analytics 4** — criar conta em https://analytics.google.com
  e inserir o snippet antes de `</head>`
- **Google Search Console** — verificar propriedade em
  https://search.google.com/search-console
- **Open Graph image** — criar `assets/og-image.jpg` (1200×630 px) e
  adicionar `<meta property="og:image" content="https://hnpcomercial.com.br/assets/og-image.jpg" />`
  no `<head>`

---

# ❓ Problemas comuns

**"Permission denied" ao rodar os scripts (.sh)**
```bash
chmod +x download-assets.sh use-local-assets.sh
```

**"git push" pede senha e nada funciona**
Use GitHub Desktop (Opção A da Etapa 5) ou crie um Personal Access Token.

**Site não aparece em hnpcomercial.com.br após 4h**
1. Verifique no DNS Checker (link na Etapa 7.2)
2. Confirme que o `CNAME` está no repositório
3. Em GitHub Settings → Pages, remova e re-adicione o custom domain

**Imagens das marcas não carregam**
Execute `./download-assets.sh && ./use-local-assets.sh` e faça commit + push.

---

**HNP Representação Comercial**
São Paulo · Brasil
hnpcomercial.com.br · +55 (11) 94760-9085
