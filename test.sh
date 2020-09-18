#!/usr/bin/env sh

for sdir in combinacionales secuenciales manejo_de_archivos; do
  echo "::group::Import all sources from '$sdir'"
  ghdl -i "$sdir"/*.vhdl
  echo '::endgroup::'

  for item in "$sdir"/*_tb.vhdl; do
      ent="$(basename $item | cut -f 1 -d '.')"
      echo "::group::Build and test $ent"
      ghdl -m "$ent"
      ghdl -r "$ent" --wave="$ent.ghw"
      echo '::endgroup::'
  done
done
