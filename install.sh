SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false

REPLACE="
"

android_check() {
 if (( $API < 29 || $API > 30)); then
    ui_print "• Sorry, support for Android 10 & 11 only."
    ui_print ""
    sleep 2
    exit 1
 fi
}

volume_keytest() {
  ui_print "• Volume Key Test"
  ui_print "  Please press any key volume:"
  (timeout 5 /system/bin/getevent -lc 1 2>&1 | /system/bin/grep VOLUME | /system/bin/grep " DOWN" > "$TMPDIR"/events) || return 1
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
  ui_print "•••••••••••••••••••••••••••••••••••••••••"
  ui_print "    Motorola One Fusion Stock Overlay"
  ui_print "•••••••••••••••••••••••••••••••••••••••••"
  ui_print ""
  ui_print "• Module by Syoker"
  ui_print ""
  sleep 2
}

on_install() {

  android_check

  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2

  case $API in
    29)
      ui_print "- Android 10 detected"
      sleep 1

      ui_print "- Extracting module files"
      sleep 2

      cp -f $MODPATH/system/product/overlay/overlay-quincetart-framework.apk $MODPATH/system/product/overlay/framework-res__auto_generated_rro_product.apk
    ;;
    30)
      if volume_keytest; then
        ui_print "  Key test function complete"
        ui_print ""
        sleep 2

        ui_print "• Android 11 detected"
        sleep 1

        ui_print "• Extracting module files"
        sleep 2

        cp -f $MODPATH/system/product/overlay/overlay-redvelvetcake-framework.apk $MODPATH/system/product/overlay/framework-res__auto_generated_rro_product.apk
        cp -f $MODPATH/system/product/overlay/overlay-rounded-corners.apk $MODPATH/system/product/overlay/RoundedCornersOverlay.apk

        ui_print "  Done"
        ui_print ""

        SELECT=volume_key

        ui_print "• Do you want to apply changes to the MotoLauncher?"
        ui_print "  Volume up(+): Yes"
        ui_print "  Volume down(-): No"

        if "$SELECT"; then
          ui_print "  Removing..."
          ui_print ""

          sleep 2

          ui_print "  Done"
          ui_print ""
        else
          ui_print "  Applying..."

          cp -f $MODPATH/system/product/overlay/overlay-oneline-appdraw.apk $MODPATH/system/product/overlay/OnelineAppdrawOverlay.apk

          sleep 2

          ui_print "  Done"
          ui_print ""
        fi

        ui_print "• Do you want to install Android 10/13 pillbar from AOSP?"
        ui_print "  Volume up(+): Yes"
        ui_print "  Volume down(-): No"

        if "$SELECT"; then
          ui_print "  Removing..."
          ui_print ""

          sleep 2

          ui_print "  Done"
          ui_print ""
        else
          ui_print "  Which pillbar do you want?"
          ui_print "  Volume up(+): Install pillbar"
          ui_print "  Volume down(-): Another pillbar"
          ui_print ""
          while (true); do
            ui_print "  1 - Android 10 pillbar"
            if "$SELECT"; then
              ui_print "  2 - Android 13 pillbar"
              if "$SELECT"; then
                ui_print ""
              else
                ui_print "      Installing..."
              
                mkdir -p $MODPATH/system/product/overlay/NavigationBarModeGestural
                cp -f $MODPATH/system/product/overlay/overlay-navigationbarmodegestural-tiramisu.apk $MODPATH/system/product/overlay/NavigationBarModeGestural/NavigationBarModeGesturalOverlay.apk
                mkdir -p $MODPATH/system/product/overlay/NavigationHandleRadius
                cp -f $MODPATH/system/product/overlay/overlay-navigationhandleradius-tiramisu.apk $MODPATH/system/product/overlay/NavigationHandleRadius/NavigationHandleRadiusOverlay.apk

                sleep 2

                ui_print "      Done"
                ui_print ""
                break
              fi
            else
              ui_print "      Installing..."

              mkdir -p $MODPATH/system/product/overlay/NavigationBarModeGestural
              cp -f $MODPATH/system/product/overlay/overlay-navigationbarmodegestural-quincetart.apk $MODPATH/system/product/overlay/NavigationBarModeGestural/NavigationBarModeGesturalOverlay.apk
              mkdir -p $MODPATH/system/product/overlay/NavigationHandleRadius
              cp -f $MODPATH/system/product/overlay/overlay-navigationhandleradius-quincetart.apk $MODPATH/system/product/overlay/NavigationHandleRadius/NavigationHandleRadiusOverlay.apk

              sleep 2

              ui_print "      Done"
              ui_print ""
              break
            fi
          done
        fi

        ui_print "• Do you want to install QuickSettings from AOSP?"
        ui_print "  Volume up(+): Yes"
        ui_print "  Volume down(-): No"

        if "$SELECT"; then
          ui_print "  Removing..."

          sleep 2

          ui_print "  Done"
          ui_print ""
        else
          ui_print "  Installing..."

          cp -f $MODPATH/system/product/overlay/overlay-quicksettings.apk $MODPATH/system/product/overlay/QuickSettingsOverlay.apk

          sleep 2

          ui_print "  Done"
          ui_print ""
        fi

        ui_print "• Do you want to install QS ScreenRecord from AOSP?"
        ui_print "  Volume up(+): Yes"
        ui_print "  Volume down(-): No"

        if "$SELECT"; then
          ui_print "  Removing..."

          sleep 2

          ui_print "  Done"
          ui_print ""
        else
          ui_print "  Installing..."

          cp -f $MODPATH/system/product/overlay/overlay-qs-screenrecord.apk $MODPATH/system/product/overlay/QuickSettingsScreenRecordOverlay.apk

          sleep 2

          ui_print "  Done"
          ui_print ""
        fi

        ui_print "• Do you want to install NavigationBar by Samsung?"
        ui_print "  Volume up(+): Yes"
        ui_print "  Volume down(-): No"

        if "$SELECT"; then
          ui_print "  Removing..."

          sleep 2

          ui_print "  Done"
          ui_print ""
        else
          ui_print "  Installing..."

          cp -f $MODPATH/system/product/overlay/overlay-oneui-navbar.apk $MODPATH/system/product/overlay/NavigationBarOneUIOverlay.apk

          sleep 2

          ui_print "  Done"
          ui_print ""
        fi

        ui_print "• Do you want to add more AccentColors?"
        ui_print "  Volume up(+): Yes"
        ui_print "  Volume down(-): No"

        if "$SELECT"; then
          ui_print "  Removing..."

          sleep 2

          ui_print "  Done"
          ui_print ""
        else
          ui_print "  Installing..."

          tar -xf $MODPATH/system/product/overlay/accent-colors.tar.xz -C $MODPATH/system/product/overlay/

          sleep 2

          ui_print "  Done"
          ui_print ""
        fi

        ui_print "• Do you want to install a new QS BrightnessSlider?"
        ui_print "  Volume up(+): Yes"
        ui_print "  Volume down(-): No"

        if "$SELECT"; then
          ui_print "  Removing..."

          sleep 2

          ui_print "  Done"
          ui_print ""
        else
          ui_print "  Installing..."

          cp -f $MODPATH/system/product/overlay/overlay-qs-brightness-slider.apk $MODPATH/system/product/overlay/QuickSettingsBrightnessSliderOverlay.apk

          sleep 2

          ui_print "  Done"
          ui_print ""
        fi

      else
        ui_print "  You have not pressed any key, aborting installation."
        ui_print ""
        sleep 2
        exit 1
      fi
    ;;
  esac

  ui_print "- Deleting package cache"
  rm $MODPATH/system/product/overlay/overlay-navigationbarmodegestural-quincetart.apk
  rm $MODPATH/system/product/overlay/overlay-navigationbarmodegestural-tiramisu.apk
  rm $MODPATH/system/product/overlay/overlay-navigationhandleradius-quincetart.apk
  rm $MODPATH/system/product/overlay/overlay-navigationhandleradius-tiramisu.apk
  rm $MODPATH/system/product/overlay/overlay-redvelvetcake-framework.apk
  rm $MODPATH/system/product/overlay/overlay-quincetart-framework.apk
  rm $MODPATH/system/product/overlay/overlay-qs-brightness-slider.apk
  rm $MODPATH/system/product/overlay/overlay-oneline-appdraw.apk
  rm $MODPATH/system/product/overlay/overlay-qs-screenrecord.apk
  rm $MODPATH/system/product/overlay/overlay-rounded-corners.apk
  rm $MODPATH/system/product/overlay/overlay-quicksettings.apk
  rm $MODPATH/system/product/overlay/overlay-oneui-navbar.apk
  rm $MODPATH/system/product/overlay/accent-colors.tar.xz
  rm -rf /data/system/package_cache/*
}

set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
}