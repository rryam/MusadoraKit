#!/bin/bash

declare -a DESTINATIONS=("platform=iOS Simulator,name=iPhone 14" "platform=watchOS Simulator,name=Apple Watch Series 8 (45mm)" "platform=tvOS Simulator,name=Apple TV 4K (3rd generation)" "platform=macOS")

for DESTINATION in "${DESTINATIONS[@]}"
  do
    xcodebuild clean build \
      -scheme MusadoraKit \
      -destination "$DESTINATION" \
      -skipPackagePluginValidation
done
