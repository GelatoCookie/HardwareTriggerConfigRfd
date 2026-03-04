#!/bin/bash
# build_deploy_launch.sh
# Automates build, deploy, and launch for Zebra RFID SDK Sample Application

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Optional device override:
# 1) DEVICE_ID env var
# 2) ANDROID_SERIAL env var
DEVICE_ID="${DEVICE_ID:-${ANDROID_SERIAL:-}}"

ensure_android_sdk() {
  if [ -n "${ANDROID_SDK_ROOT:-}" ] && [ -d "${ANDROID_SDK_ROOT}" ]; then
    export ANDROID_HOME="${ANDROID_HOME:-${ANDROID_SDK_ROOT}}"
    return
  fi

  if [ -n "${ANDROID_HOME:-}" ] && [ -d "${ANDROID_HOME}" ]; then
    export ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-${ANDROID_HOME}}"
    return
  fi

  for candidate in "$HOME/Library/Android/sdk" "$HOME/Android/Sdk"; do
    if [ -d "$candidate" ]; then
      export ANDROID_HOME="$candidate"
      export ANDROID_SDK_ROOT="$candidate"
      echo "Using Android SDK: $candidate"
      return
    fi
  done

  echo "Android SDK not found. Set ANDROID_HOME or ANDROID_SDK_ROOT to a valid SDK path."
  exit 1
}

ensure_adb_available() {
  if command -v adb >/dev/null 2>&1; then
    return
  fi

  sdk_platform_tools="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}/platform-tools"
  if [ -n "$sdk_platform_tools" ] && [ -x "$sdk_platform_tools/adb" ]; then
    export PATH="$sdk_platform_tools:$PATH"
    return
  fi

  echo "adb not found in PATH. Install Android platform-tools or add adb to PATH."
  exit 1
}

ensure_java_17() {
  java_major_from_home() {
    home="$1"
    if [ -z "$home" ] || [ ! -x "$home/bin/java" ]; then
      echo ""
      return
    fi
    version_raw="$($home/bin/java -version 2>&1 | awk -F '"' '/version/ {print $2; exit}')"
    if [ -z "$version_raw" ]; then
      echo ""
      return
    fi
    echo "$version_raw" | awk -F. '{if ($1 == 1) print $2; else print $1}'
  }

  if [ -n "${JAVA_HOME:-}" ]; then
    java_major="$(java_major_from_home "$JAVA_HOME")"
    if [ -n "$java_major" ] && [ "$java_major" -ge 17 ] 2>/dev/null; then
      export PATH="$JAVA_HOME/bin:$PATH"
      echo "Using Java from JAVA_HOME: $JAVA_HOME"
      return
    fi
  fi

  if command -v java >/dev/null 2>&1; then
    current_java_home="$(command -v java | sed 's#/bin/java$##')"
    java_major="$(java_major_from_home "$current_java_home")"
    if [ -n "$java_major" ] && [ "$java_major" -ge 17 ] 2>/dev/null; then
      return
    fi
  fi

  candidate_homes=""

  if command -v /usr/libexec/java_home >/dev/null 2>&1; then
    java17_home="$(/usr/libexec/java_home -v 17+ 2>/dev/null || true)"
    if [ -n "$java17_home" ]; then
      candidate_homes="$candidate_homes
$java17_home"
    fi
  fi

  for brew_home in \
    "/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home" \
    "/usr/local/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"; do
    if [ -d "$brew_home" ]; then
      candidate_homes="$candidate_homes
$brew_home"
    fi
  done

  while IFS= read -r home; do
    [ -z "$home" ] && continue
    java_major="$(java_major_from_home "$home")"
    if [ -n "$java_major" ] && [ "$java_major" -ge 17 ] 2>/dev/null; then
      export JAVA_HOME="$home"
      export PATH="$JAVA_HOME/bin:$PATH"
      echo "Using Java from JAVA_HOME: $JAVA_HOME"
      return
    fi
  done <<EOF
$candidate_homes
EOF

  echo "Java 17+ is required. Install JDK 17 or newer and ensure it is available to this script."
  echo "On macOS, install via Android Studio JDK or: brew install openjdk@17"
  exit 1
}

resolve_device_id() {
  if [ -n "$DEVICE_ID" ]; then
    echo "$DEVICE_ID"
    return
  fi

  devices_raw="$(adb devices | awk '/\tdevice$/{print $1}')"
  if [ -z "$devices_raw" ]; then
    echo ""
    return
  fi

  first_device="$(printf '%s\n' "$devices_raw" | head -n 1)"
  device_count="$(printf '%s\n' "$devices_raw" | wc -l | tr -d ' ')"

  if [ "$device_count" -gt 1 ]; then
    echo "Multiple devices detected; using first device: $first_device" >&2
    echo "Set DEVICE_ID or ANDROID_SERIAL to choose a different target." >&2
  fi

  echo "$first_device"
}

# Build the project
ensure_android_sdk
ensure_adb_available
ensure_java_17
./gradlew assembleDebug

# Find the APK path
echo "Locating APK..."
APK_PATH=$(find ./app/build/outputs/apk/debug -name "*.apk" | head -n 1)
if [ ! -f "$APK_PATH" ]; then
  echo "APK not found! Build may have failed."
  exit 1
fi

echo "APK found at $APK_PATH"

TARGET_DEVICE_ID="$(resolve_device_id)"
if [ -z "$TARGET_DEVICE_ID" ]; then
  echo "No connected Android device found (adb devices returned none in 'device' state)."
  echo "Build completed and APK is ready at $APK_PATH"
  exit 0
fi

echo "Using device: $TARGET_DEVICE_ID"

# Deploy to device
echo "Deploying APK to device..."
adb -s "$TARGET_DEVICE_ID" install -r "$APK_PATH"

echo "APK deployed. Launching app..."

# Launch the app (replace with your actual package/activity)
PACKAGE="com.zebra.rfid.demo.sdksample"
ACTIVITY=".MainActivity"
adb -s "$TARGET_DEVICE_ID" shell am start -n "$PACKAGE/$ACTIVITY"

echo "App launched!"
