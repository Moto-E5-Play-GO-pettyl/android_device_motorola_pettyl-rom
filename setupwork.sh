#!/bin/bash
#
# setupwork.sh - Script de Automatización para Compilar LineageOS 17.1 para 'pettyl'
#
# Inspirado en el workflow de GitHub Actions, este script automatiza los pasos
# de configuración, sincronización y compilación en un entorno local.
#
# Uso:
# 1. Guarda este archivo como 'setupwork.sh' en la raíz de tu repositorio clonado.
# 2. Dale permisos de ejecución: chmod +x setupwork.sh
# 3. Ejecútalo: ./setupwork.sh
#

# --- Configuración y Colores ---
set -e # Salir inmediatamente si un comando falla

# Directorio principal de Android
ANDROID_TOP_DIR="${HOME}/android/lineage"

# Colores para los mensajes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # Sin color

# --- Funciones de Ayuda ---
info() {
    echo -e "${BLUE}INFO:${NC} $1"
}

warn() {
    echo -e "${YELLOW}AVISO:${NC} $1"
}

success() {
    echo -e "${GREEN}ÉXITO:${NC} $1"
}

error() {
    echo -e "${RED}ERROR:${NC} $1"
}

# --- Inicio del Script ---
clear
echo -e "${GREEN}=====================================================${NC}"
echo -e "${GREEN}  Script de Compilación de LineageOS 17.1 para pettyl  ${NC}"
echo -e "${GREEN}=====================================================${NC}"
echo

# --- FASE 1: Configuración del Entorno ---
info "FASE 1: Configurando el entorno de compilación..."

info "Instalando dependencias del sistema con 'apt'. Se requerirá tu contraseña de sudo."
sudo apt-get update
sudo apt-get install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python2 python3 git-lfs
sudo ln -sf /usr/bin/python2 /usr/bin/python
success "Dependencias instaladas."

info "Instalando la herramienta 'repo' en ~/bin/..."
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

# Verificar si ~/bin está en el PATH
if [[ ":$PATH:" != *":${HOME}/bin:"* ]]; then
    warn "~/bin no está en tu PATH. Añadiéndolo para la sesión actual."
    export PATH="${HOME}/bin:${PATH}"
    warn "Para futuras sesiones, añade 'export PATH=\"\${HOME}/bin:\${PATH}\"' a tu ~/.bashrc o ~/.profile"
fi
success "'repo' instalado."

info "Configurando Git con valores genéricos para la compilación..."
git config --global user.email "elmendezz@github.com"
git config --global user.name "elmendezz (Automated Build)"
success "Git configurado."

# --- FASE 2: Sincronización de las Fuentes ---
info "FASE 2: Sincronizando las fuentes de LineageOS..."

info "Creando el directorio de trabajo en '${ANDROID_TOP_DIR}'..."
mkdir -p "${ANDROID_TOP_DIR}"
cd "${ANDROID_TOP_DIR}"
success "Directorio creado. Ahora estamos en $(pwd)"

info "Inicializando el repositorio de LineageOS 17.1 (esto puede tardar)..."
repo init -u https://github.com/LineageOS/android.git -b lineage-17.1 --depth=1

CPUS=$(nproc --all)
info "Tienes ${CPUS} núcleos de CPU. Se usarán para la sincronización con '-j${CPUS}'."
warn "La sincronización descargará ~30-40 GB. Ten paciencia, esto tardará MUCHO tiempo."
repo sync -c -j${CPUS} --force-sync --no-clone-bundle --no-tags

success "Sincronización de las fuentes completada."

# --- FASE 3: Preparación de las Fuentes del Dispositivo ---
info "FASE 3: Clonando y organizando los repositorios del dispositivo 'pettyl'..."
cd "${ANDROID_TOP_DIR}"

git clone https://github.com/elmendezz/android_device_motorola_pettyl-rom -b lineage-17.1 /tmp/pettyl_unified
git -C /tmp/pettyl_unified lfs pull
mkdir -p device/motorola/pettyl
mkdir -p vendor/motorola/pettyl

info "Copiando archivos del dispositivo a 'device/motorola/pettyl'..."
cp -r /tmp/pettyl_unified/pettyl/* device/motorola/pettyl/
info "Copiando archivos de vendor a 'vendor/motorola/pettyl'..."
cp -r /tmp/pettyl_unified/vendor_pettyl/* vendor/motorola/pettyl/
rm -rf /tmp/pettyl_unified
success "Fuentes del dispositivo organizadas."

info "TRUCO: Eliminando la carpeta .repo para liberar espacio vital (~25 GB)..."
rm -rf "${ANDROID_TOP_DIR}/.repo"
success "Espacio en disco recuperado."

# --- FASE 4: Compilación de la ROM ---
info "FASE 4: Iniciando la compilación de LineageOS..."
cd "${ANDROID_TOP_DIR}"

info "Configurando ccache para acelerar futuras compilaciones..."
export USE_CCACHE=1
export CCACHE_DIR=~/.ccache
ccache -M 25G # Puedes ajustar este valor (ej. 50G)
success "Ccache configurado con un tamaño de 25G."

info "Cargando el entorno de compilación..."
source build/envsetup.sh

info "Seleccionando el dispositivo 'pettyl' con lunch..."
lunch lineage_pettyl-userdebug

CPUS=$(nproc --all)
info "Tienes ${CPUS} núcleos de CPU. Se iniciará la compilación con 'mka bacon -j${CPUS}'."
warn "La compilación puede tardar varias horas. El progreso se mostrará aquí y se guardará en 'build_log.txt'."
export UNSAFE_DISABLE_HIDDENAPI_FLAGS=true
mka bacon -j${CPUS} 2>&1 | tee build_log.txt
BUILD_STATUS=${PIPESTATUS[0]}

# --- FASE 5: Finalización ---
echo
info "FASE 5: Proceso finalizado."

if [ "$BUILD_STATUS" -eq 0 ]; then
    ROM_PATH=$(find ${ANDROID_TOP_DIR}/out/target/product/pettyl/ -name "lineage-*.zip" | head -n 1)
    success "¡Compilación completada con éxito!"
    success "Tu ROM está en: ${ROM_PATH}"
    success "También encontrarás las imágenes (.img) en el mismo directorio."
else
    error "La compilación ha fallado."
    warn "Revisa el final del archivo 'build_log.txt' en ${ANDROID_TOP_DIR} para identificar el error."
    exit 1
fi

exit 0