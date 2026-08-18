# Motorola Moto E5 Play GO (pettyl) - LineageOS 17.1
![Moto E5 Play GO Banner](https://github.com/user-attachments/assets/565a3313-7d59-4df9-a8a0-0e5582f25d86)
[![Build LineageOS 17.1 System IMG for pettyl](https://github.com/elmendezz/android_device_motorola_pettyl-rom/actions/workflows/systemimg.yml/badge.svg)](https://github.com/elmendezz/android_device_motorola_pettyl-rom/actions/workflows/systemimg.yml)
----
This repository contains the device configuration and sources for the **Motorola Moto E5 Play GO** (codenamed pettyl).

## Device Specifications

| Component | Specification |
|:----------|:--------------|
| SoC | Qualcomm MSM8917 Snapdragon 425 |
| CPU | Quad-core (4x1.4 GHz Cortex-A53) |
| GPU | Adreno 308 |
| Memory | 1 GB RAM |
| Storage | 16 GB |
| Battery | Li-Ion 2100 mAh |
| Display | 960 x 480 pixels, 18:9 ratio (5.34") |
| Camera | 8 MP, LED flash |
| Shipped Android | 8.0 (Oreo) |

---
![Motorola Moto E5 Play GO](https://cdn2.gsmarena.com/vv/pics/motorola/motorola-moto-e5-play-android-go-edition-2.jpg "Moto E5 Play GO")
## Source Structure

To build LineageOS 17.1 for this device, you need to set up your workspace as follows:

* Device Tree: device/motorola/pettyl
* Vendor Tree: vendor/motorola/pettyl

## How to Build

1. Initialize the LineageOS source:
   repo init -u https://github.com/LineageOS/android.git -b lineage-17.1 --depth=1

2. Sync the source code:
   repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

3. Set up the environment:
   source build/envsetup.sh
   lunch lineage_pettyl-userdebug

4. Start the build:
   mka bacon -j$(nproc --all)

---

# Versión en Español

Este repositorio contiene la configuración del dispositivo y las fuentes para el **Motorola Moto E5 Play GO** (nombre clave pettyl).

## Especificaciones del Dispositivo

| Componente | Especificación |
|:-----------|:---------------|
| SoC | Qualcomm MSM8917 Snapdragon 425 |
| CPU | Quad-core (4x1.4 GHz Cortex-A53) |
| GPU | Adreno 308 |
| Memoria | 1 GB RAM |
| Almacenamiento | 16 GB |
| Batería | Li-Ion 2100 mAh |
| Pantalla | 960 x 480 píxeles, relación 18:9 (5.34") |
| Cámara | 8 MP, flash LED |
| Android de Fábrica | 8.0 (Oreo) |

---
![Motorola Moto E5 Play GO](https://cdn2.gsmarena.com/vv/pics/motorola/motorola-moto-e5-play-android-go-edition-2.jpg "Moto E5 Play GO")
## Estructura de las Fuentes

Para compilar LineageOS 17.1 para este dispositivo, debes configurar tu espacio de trabajo de la siguiente manera:

* Device Tree: device/motorola/pettyl
* Vendor Tree: vendor/motorola/pettyl

## Cómo Compilar

1. Inicializar las fuentes de LineageOS:
   repo init -u https://github.com/LineageOS/android.git -b lineage-17.1 --depth=1

2. Sincronizar el código fuente:
   repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

3. Configurar el entorno:
   source build/envsetup.sh
   lunch lineage_pettyl-userdebug

4. Iniciar la compilación:
   mka bacon -j$(nproc --all)

---

# We need you’re help please join to our telegram channel 

[Telegram Link](https://t.me/motoe5playgodev)
## License & Copyright
* Copyright (C) 2019 - 2026: The LineageOS Project.
* Device Maintainer: elmendezz (https://github.com/elmendezz)
* Copyright (C) 2026 - elmendezz.

```
# =================================================================
# =================================================================
# =================================================================
# ======================    elmendezz    ==========================
# =================================================================
# =================================================================
# =================================================================
```
