#!/usr/bin/env bash
# DOCK360 0.6.0 — 360LABPT/Dock360
set -Eeuo pipefail
umask 077
BASE_URL='https://raw.githubusercontent.com/360LABPT/Dock360/main'
PACKAGE='DOCK360-RaspberryPi.tar.gz'
EXPECTED_SHA256='ddb4fcf79ecab5acace6fc0d330e3bc42cea373776791e6b9cec4ac3b67aaaf1'
fail(){ printf '\nDOCK360: %s\n' "$*" >&2; exit 1; }
if [[ ${1:-} == --help ]]; then
 printf 'DOCK360 — instalador GitHub\nUso: bash install.sh [--check]\nRequer Raspberry Pi OS 64 bits Bookworm/Trixie, Internet e sudo.\n'; exit 0
fi
[[ $# -eq 0 || ( $# -eq 1 && $1 == --check ) ]] || fail 'Opção desconhecida. Use --help.'
for tool in curl tar sha256sum mktemp; do command -v "$tool" >/dev/null || fail "Falta o comando $tool."; done
TASK_TMP=$(mktemp -d "${TMPDIR:-/tmp}/dock360-download.XXXXXXXX")
cleanup(){ rm -rf -- "$TASK_TMP"; }
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
printf 'DOCK360 — a descarregar a versão 0.6.0…\n'
curl --fail --silent --show-error --location --retry 3 --connect-timeout 20 --max-time 900 --proto '=https' --proto-redir '=https' --tlsv1.2 "$BASE_URL/$PACKAGE" -o "$TASK_TMP/$PACKAGE" || fail 'Descarga falhou. Verifique a Internet e se os ficheiros estão no ramo main de um repositório público.'
printf '%s  %s\n' "$EXPECTED_SHA256" "$TASK_TMP/$PACKAGE" | sha256sum --status -c - || fail 'SHA256 incorreto. Não foi executado o instalador.'
tar -xzf "$TASK_TMP/$PACKAGE" -C "$TASK_TMP" --no-same-owner
[[ -f "$TASK_TMP/DOCK360-RaspberryPi/install.sh" ]] || fail 'Pacote inválido.'
bash "$TASK_TMP/DOCK360-RaspberryPi/install.sh" "$@"
