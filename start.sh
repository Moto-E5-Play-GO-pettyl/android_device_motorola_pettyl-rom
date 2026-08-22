#!/bin/bash
#
# start.sh - Script de Compilación Local para LineageOS 17.1 (pettyl)
# Diseñado para entornos locales (WSL / Ubuntu PC).
#

set -e # Salir en caso de error

# Directorio donde se encuentra este script (repositorio local)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Directorio principal de fuentes de LineageOS en local
ANDROID_TOP_DIR="${HOME}/android/lineage"

# Colores para salida interactiva
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${BLUE}INFO:${NC} $1"; }
warn() { echo -e "${YELLOW}AVISO:${NC} $1"; }
success() { echo -e "${GREEN}ÉXITO:${NC} $1"; }
error() { echo -e "${RED}ERROR:${NC} $1"; }

clear
echo -e "${GREEN}=====================================================${NC}"
echo -e "${GREEN}    Script Local de Compilación LineageOS 17.1       ${NC}"
echo -e "${GREEN}              Dispositivo: pettyl                    ${NC}"
echo -e "${GREEN}=====================================================${NC}"
echo

# --- FASE 1: Verificación de Herramientas Locales ---
info "FASE 1: Verificando herramientas del sistema..."

mkdir -p ~/bin
if [[ ":$PATH:" != *":${HOME}/bin:"* ]]; then
    export PATH="${HOME}/bin:${PATH}"
fi

if ! command -v repo &> /dev/null; then
    info "Instalando la herramienta 'repo'..."
    curl -s https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
    chmod a+x ~/bin/repo
fi

git lfs install >/dev/null 2>&1 || true
success "Herramientas de entorno verificadas."

# --- FASE 2: Sincronización de Fuentes ---
info "FASE 2: Sincronizando fuentes de LineageOS 17.1 en '${ANDROID_TOP_DIR}'..."

mkdir -p "${ANDROID_TOP_DIR}"
cd "${ANDROID_TOP_DIR}"

if [ ! -d ".repo" ]; then
    info "Inicializando repositorio de LineageOS 17.1..."
    repo init -u https://github.com/LineageOS/android.git -b lineage-17.1 --depth=1
fi

CPUS=$(nproc --all)
info "Sincronizando fuentes con ${CPUS} hilos (-j${CPUS})..."
repo sync -c -j${CPUS} --force-sync --no-clone-bundle --no-tags

success "Sincronización completada."

# --- FASE 3: Copiado de Fuentes Locales del Dispositivo ---
info "FASE 3: Copiando fuentes locales desde '${SCRIPT_DIR}'..."

mkdir -p device/motorola/pettyl
mkdir -p vendor/motorola/pettyl

if [ -d "${SCRIPT_DIR}/pettyl" ]; then
    cp -r "${SCRIPT_DIR}/pettyl/"* device/motorola/pettyl/
fi

if [ -d "${SCRIPT_DIR}/vendor_pettyl" ]; then
    cp -r "${SCRIPT_DIR}/vendor_pettyl/"* vendor/motorola/pettyl/
fi

success "Fuentes del dispositivo y vendor copiadas desde el árbol local."

# --- Verificación y Corrección de WebView Prebuilt ---
info "Verificando estado de WebView..."
WEBVIEW_APK="${ANDROID_TOP_DIR}/external/chromium-webview/prebuilt/arm/webview.apk"

if [ -d "${ANDROID_TOP_DIR}/external/chromium-webview" ]; then
    cd "${ANDROID_TOP_DIR}/external/chromium-webview"
    git lfs install >/dev/null 2>&1 || true
    git lfs pull >/dev/null 2>&1 || true
    cd "${ANDROID_TOP_DIR}"
fi

if [ -f "$WEBVIEW_APK" ] && ! zipinfo "$WEBVIEW_APK" >/dev/null 2>&1; then
    warn "webview.apk corrupto o no válido. Reemplazando..."
    rm -rf "${ANDROID_TOP_DIR}/out/target/product/pettyl/obj/APPS/webview_intermediates/"
    rm -f "$WEBVIEW_APK"
    mkdir -p "$(dirname "$WEBVIEW_APK")"
    curl -sSL "https://raw.githubusercontent.com/LineageOS/android_external_chromium-webview/lineage-17.1/prebuilt/arm/webview.apk" -o "$WEBVIEW_APK" || true
    if ! zipinfo "$WEBVIEW_APK" >/dev/null 2>&1; then
        curl -sSL "https://github.com/LineageOS/android_external_chromium-webview/raw/lineage-17.1/prebuilt/arm/webview.apk" -L -o "$WEBVIEW_APK" || true
    fi
fi

if zipinfo "$WEBVIEW_APK" >/dev/null 2>&1; then
    success "WebView preconstruido verificado correctamente."
else
    warn "Atención: Si falla la compilación en WebView, coloca un APK válido en external/chromium-webview/prebuilt/arm/webview.apk"
fi

# --- FASE 4: Compilación local ---
info "FASE 4: Iniciando compilación de LineageOS..."
cd "${ANDROID_TOP_DIR}"

export USE_CCACHE=1
export CCACHE_DIR="${HOME}/.ccache"
ccache -M 25G >/dev/null 2>&1 || true

source build/envsetup.sh
lunch lineage_pettyl-userdebug

export UNSAFE_DISABLE_HIDDENAPI_FLAGS=true
info "Compilando con mka bacon -j${CPUS}..."
mka bacon -j${CPUS} 2>&1 | tee build_log.txt
BUILD_STATUS=${PIPESTATUS[0]}

# --- FASE 5: Resultado ---
echo
if [ "$BUILD_STATUS" -eq 0 ]; then
    ROM_PATH=$(find ${ANDROID_TOP_DIR}/out/target/product/pettyl/ -name "lineage-*.zip" | head -n 1)
    success "¡Compilación exitosa!"
    success "ROM guardada en: ${ROM_PATH}"
else
    error "La compilación ha fallado."
    warn "Revisa 'build_log.txt' en ${ANDROID_TOP_DIR} para ver los detalles del error."
    exit 1
fi

exit 0
