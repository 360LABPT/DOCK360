# DOCK360 · 360LAB

Produção portuguesa. Versão 0.6.0 para Raspberry Pi OS de 64 bits (Bookworm ou Trixie).

## Publicar no GitHub

Extraia este ZIP e envie **o conteúdo da pasta DOCK360-GitHub** para a raiz do ramo `main` de https://github.com/360LABPT/Dock360.
Substitua o pacote `DOCK360-RaspberryPi.tar.gz` já existente. Não extraia os pacotes tar.gz ou zip.
O repositório tem de ser público para o comando sem autenticação funcionar.

## Instalar no Raspberry Pi

Depois de publicar todos os ficheiros:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/360LABPT/Dock360/main/install.sh)"
```

Alternativa para consultar o script antes de executar:

```bash
curl -fSL https://raw.githubusercontent.com/360LABPT/Dock360/main/install.sh -o install-dock360.sh
less install-dock360.sh
bash install-dock360.sh
```

O assistente descarrega e verifica o pacote com SHA256, instala as dependências,
pede as credenciais e configura o arranque automático. As palavras-passe não
aparecem durante a escrita. No final, abra o endereço indicado na rede local.
O terminal tem de permitir interação e sudo.

## Atualizações pelo painel

Em Sistema → Atualizações, configure o manifesto:

https://raw.githubusercontent.com/360LABPT/Dock360/main/release.json

Este manifesto descreve a versão atual; não cria uma atualização mais recente.
Para uma nova versão, publique o novo ZIP de servidor e atualize a versão e o
SHA256 do manifesto. Atualize também o pacote Raspberry e o SHA256 embutido em
install.sh se alterar esse pacote. Publique os ficheiros no mesmo commit.

## Dados existentes

Mantêm-se os identificadores técnicos `36odock` e `dock36` para compatibilidade.
As instalações geridas pelo assistente preservam as contas e os ficheiros.
Instalações feitas por outro método precisam de migração prévia.

Estado: pacote recuperado da versão publicada 0.6.0. O novo lançador foi testado
com descargas simuladas, integridade e passagem de argumentos. A instalação
completa, Docker, Samba, discos e Tailscale requerem validação num Raspberry Pi físico.
Não publique dados pessoais, credenciais ou pastas de uma instalação real.
