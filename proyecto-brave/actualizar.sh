#!/bin/bash
# ============================================================
# actualizar.sh — Guarda y sube los cambios de la página a GitHub
# Uso:
#   ./actualizar.sh "mensaje describiendo el cambio"
# Ejemplo:
#   ./actualizar.sh "Actualizo menu de nutricion semana 2"
# ============================================================

set -e

MENSAJE="$1"

if [ -z "$MENSAJE" ]; then
  echo "❌ Debes escribir un mensaje describiendo el cambio."
  echo "   Ejemplo: ./actualizar.sh \"Actualizo rutina de martes\""
  exit 1
fi

echo "📦 Guardando cambios..."
git add .
git commit -m "$MENSAJE"

echo "🚀 Subiendo a GitHub..."
git push

echo "✅ Listo. Vercel detectará el cambio y desplegará la nueva versión en 1-2 minutos."
echo "   Revisa el progreso en: https://vercel.com/dashboard"
