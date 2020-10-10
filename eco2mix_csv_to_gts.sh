#!/bin/bash

# Fonction URL Encode
# https://gist.github.com/cdown/1163649
# https://unix.stackexchange.com/questions/159253/decoding-url-encoding-percent-encoding
urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:$i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf '%s' "$c" ;;
            *) printf "$c" | xxd -p -c1 | while read x;do printf "%%%s" "$x";done ;;
        esac
    done
    LC_COLLATE=$old_lc_collate
}

# Def separateur
IFS=";"

# Boucle sur les lignes du CSV
while read f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 f13 f14 f15 f16 f17 f18 f19 f20 f21 f22 f23 f24 f25 f26 f27 f28 f29 f30 f31 f32 f33 f34 f35 f36 f37 f38 f39 f40 f41 f42 f43 f44 f45 f46 f47 f48 f49 f50 f51 f52 f53 f54 f55 f56 f57 f58 f59 f60 f61 f62 f63 f64 f65 f66
do
#echo "Code INSEE région					: $f1"
#echo "Région							: $f2"
#echo "Nature							: $f3"
#echo "Date							: $f4"
#echo "Heure							: $f5"
#echo "Date - Heure						: $f6"
#echo "Consommation (MW)					: $f7"
#echo "Thermique (MW)						: $f8"
#echo "Nucléaire (MW)						: $f9"
#echo "Eolien (MW)						: $f10"
#echo "Solaire (MW)						: $f11"
#echo "Hydraulique (MW)						: $f12"
#echo "Pompage (MW)						: $f13"
#echo "Bioénergies (MW)						: $f14"
#echo "Ech. physiques (MW)					: $f15"
#echo "Flux physiques d'Auvergne-Rhône-Alpes vers Grand-Est	: $f16"
#echo "Flux physiques de Bourgogne-Franche-Comté vers Grand-Est	: $f17"
#echo "Flux physiques de Bretagne vers Grand-Est		: $f18"
#echo "Flux physiques de Centre-Val de Loire vers Grand-Est	: $f19"
#echo "Flux physiques de Grand-Est vers Grand-Est		: $f20"
#echo "Flux physiques de Hauts-de-France vers Grand-Est		: $f21"
#echo "Flux physiques d'Ile-de-France vers Grand-Est		: $f22"
#echo "Flux physiques de Normandie vers Grand-Est		: $f23"
#echo "Flux physiques de Nouvelle-Aquitaine vers Grand-Est	: $f24"
#echo "Flux physiques d'Occitanie vers Grand-Est		: $f25"
#echo "Flux physiques de Pays-de-la-Loire vers Grand-Est	: $f26"
#echo "Flux physiques de PACA vers Grand-Est			: $f27"
#echo "Flux physiques de Grand-Est vers Auvergne-Rhône-Alpes	: $f28"
#echo "Flux physiques de Grand-Est vers Bourgogne-Franche-Comté	: $f29"
#echo "Flux physiques de Grand-Est vers Bretagne		: $f30"
#echo "Flux physiques de Grand-Est vers Centre-Val de Loire	: $f31"
#echo "Flux physiques de Grand-Est vers Grand-Est		: $f32"
#echo "Flux physiques de Grand-Est vers Hauts-de-France		: $f33"
#echo "Flux physiques de Grand-Est vers Ile-de-France		: $f34"
#echo "Flux physiques de Grand-Est vers Normandie		: $f35"
#echo "Flux physiques de Grand-Est vers Nouvelle-Aquitaine	: $f36"
#echo "Flux physiques de Grand-Est vers Occitanie		: $f37"
#echo "Flux physiques de Grand-Est vers Pays-de-la-Loire	: $f38"
#echo "Flux physiques de Grand-Est vers PACA			: $f39"
#echo "Flux physiques Allemagne vers Grand-Est			: $f40"
#echo "Flux physiques Belgique vers Grand-Est			: $f41"
#echo "Flux physiques Espagne vers Grand-Est			: $f42"
#echo "Flux physiques Italie vers Grand-Est			: $f43"
#echo "Flux physiques Luxembourg vers Grand-Est			: $f44"
#echo "Flux physiques Royaume-Uni vers Grand-Est		: $f45"
#echo "Flux physiques Suisse vers Grand-Est			: $f46"
#echo "Flux physiques de Grand-Est vers Allemagne		: $f47"
#echo "Flux physiques de Grand-Est vers Belgique		: $f48"
#echo "Flux physiques de Grand-Est vers Espagne			: $f49"
#echo "Flux physiques de Grand-Est vers Italie			: $f50"
#echo "Flux physiques de Grand-Est vers Luxembourg		: $f51"
#echo "Flux physiques de Grand-Est vers Royaume-Uni		: $f52"
#echo "Flux physiques de Grand-Est vers Suisse			: $f53"
#echo "TCO Thermique (%)					: $f54"
#echo "TCH Thermique (%)					: $f55"
#echo "TCO Nucléaire (%)					: $f56"
#echo "TCH Nucléaire (%)					: $f57"
#echo "TCO Eolien (%)						: $f58"
#echo "TCH Eolien (%)						: $f59"
#echo "TCO Solaire (%)						: $f60"
#echo "TCH Solaire (%)						: $f61"
#echo "TCO Hydraulique (%)					: $f62"
#echo "TCH Hydraulique (%)					: $f63"
#echo "TCO Bioénergies (%)					: $f64"
#echo "TCH Bioénergies (%)					: $f65"
#echo "Column 64						: $f66"

# Epoch in micro seconds
epoch_us=$(date -u -d "$f4 $f5" +%s%6N)

# URL UTF8 encode Labels
# https://www.warp10.io/content/03_Documentation/03_Interacting_with_Warp_10/03_Ingesting_data/02_GTS_input_format
region=$(urlencode $f2)

# Ecriture GTS si les valeurs existent
if [ $f7 ] ; then echo "$epoch_us// eco2mix.consommation.mw{region=$region} $f7" ; fi
if [ $f8 ] ; then echo "$epoch_us// eco2mix.production.mw{region=$region,source=thermique} $f8" ; fi
if [ $f9 ] ; then echo "$epoch_us// eco2mix.production.mw{region=$region,source=nucleaire} $f9" ; fi
if [ $f10 ] ; then echo "$epoch_us// eco2mix.production.mw{region=$region,source=eolien} $f10" ; fi
if [ $f11 ] ; then echo "$epoch_us// eco2mix.production.mw{region=$region,source=solaire} $f11" ; fi
if [ $f12 ] ; then echo "$epoch_us// eco2mix.production.mw{region=$region,source=hydrolique} $f12" ; fi
if [ $f13 ] ; then echo "$epoch_us// eco2mix.production.mw{region=$region,source=pompage} $f13" ; fi
if [ $f14 ] ; then echo "$epoch_us// eco2mix.production.mw{region=$region,source=bioenergie} $f14" ; fi

done < $1
