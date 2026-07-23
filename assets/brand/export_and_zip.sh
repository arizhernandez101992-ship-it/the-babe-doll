#!/usr/bin/env bash
set -e
OUTDIR="THE_BABE_DOLL_assets"
rm -rf "$OUTDIR"
mkdir -p "$OUTDIR"/png
echo "Convirtiendo SVG a PNG..."

# --- Recomendado: Inkscape (v1+) CLI
# Si tienes Inkscape instalado:
for svg in *.svg; do
  name="${svg%.*}"
  echo "Exportando $svg -> ${OUTDIR}/png/${name}.png (2000px wide)"
  inkscape "$svg" --export-filename="${OUTDIR}/png/${name}.png" --export-width=2000
done

# --- Alternativa con rsvg-convert (librsvg):
# for svg in *.svg; do
#   name="${svg%.*}"
#   rsvg-convert -w 2000 -o "${OUTDIR}/png/${name}.png" "$svg"
# done

# --- Redimensionar logos a tamaños comunes (usando ImageMagick convert)
echo "Generando tamaños adicionales para logos..."
mkdir -p "${OUTDIR}/png/logos"
# ejemplo para tipographic
if [ -f logo_typographic_blackgold.svg ]; then
  convert -background none -resize 1200x logo_typographic_blackgold.svg "${OUTDIR}/png/logos/logo_typographic_1200.png"
  convert -background none -resize 600x  logo_typographic_blackgold.svg "${OUTDIR}/png/logos/logo_typographic_600.png"
  convert -background none -resize 300x  logo_typographic_blackgold.svg "${OUTDIR}/png/logos/logo_typographic_300.png"
fi

# Crear ZIP
echo "Creando ZIP..."
zip -r "${OUTDIR}.zip" "$OUTDIR" >/dev/null
echo "Hecho: ${OUTDIR}.zip"
