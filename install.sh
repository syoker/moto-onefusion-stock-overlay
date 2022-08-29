SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false

REPLACE="
"

print_modname() {
  ui_print ""
  ui_print "•••••••••••••••••••••••••••••"
  ui_print "    Fix Official Firmware"
  ui_print "          for Astro"
  ui_print "•••••••••••••••••••••••••••••"
  ui_print ""
  ui_print "• Module by Syoker"
  ui_print ""
  sleep 2
}

on_install() {
  ui_print "- Extracting module files"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
  ui_print "- Deleting package cache"
  rm -rf /data/system/package_cache/*
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
}