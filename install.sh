SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false

REPLACE="
"

android_check() {
 if (( $API < 30 )); then
    ui_print "• Sorry, support for Android 11 only."
    ui_print ""
    sleep 2
    exit 1
 fi
 if (( $API > 30 )); then
    ui_print "• Sorry, support for Android 11 only."
    ui_print ""
    sleep 2
    exit 1
  fi
}

volume_keytest() {
  ui_print "• Volume Key Test"
  ui_print "  Please press any key volume:"
  (/system/bin/getevent -lc 1 2>&1 | /system/bin/grep VOLUME | /system/bin/grep " DOWN" > "$TMPDIR"/events) || return 1
  return 0
}

volume_key() {
  while (true); do
    /system/bin/getevent -lc 1 2>&1 | /system/bin/grep VOLUME | /system/bin/grep " DOWN" > "$TMPDIR"/events
      if $(cat "$TMPDIR"/events 2>/dev/null | /system/bin/grep VOLUME >/dev/null); then
          break
      fi
  done
  if $(cat "$TMPDIR"/events 2>/dev/null | /system/bin/grep VOLUMEUP >/dev/null); then
      return 1
  else
      return 0
  fi
}

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

  android_check

  ui_print "• Extracting module files"
  ui_print ""
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2

  if volume_keytest; then
    ui_print "  Key test function complete"
    ui_print ""
    sleep 2

    ui_print "• Do you want to apply changes to the launcher?"
    ui_print "  Volume up(+): Yes"
    ui_print "  Volume down(-): No"

    SELECT=volume_key
    
    if "$SELECT"; then
      ui_print "  Removing changes to the launcher"
      ui_print ""
      rm $MODPATH/system/system_ext/priv-app/Launcher3QuickStep/Launcher3QuickStep.apk
      sleep 2
    else
      ui_print "  Applying changes to the launcher"
      ui_print ""
      sleep 2
    fi

  else
    ui_print "  You have not pressed any key, aborting installation."
    ui_print ""
    sleep 2
    exit 1
  fi
  
  ui_print "- Deleting package cache"
  rm -rf /data/system/package_cache/*
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
}