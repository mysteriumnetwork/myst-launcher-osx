#!/bin/sh

echo "Notarytool submit"

xcrun notarytool submit \
  --team-id "${APPLE_TEAM_ID}" \
  --apple-id ${APPLE_ID} \
  --password ${APP_SPECIFIC_PASSWORD} \
  --wait \
  ${TARGET_BINARY}

if [ $? -eq 0 ]; then
  echo "Notarization submitted successfully."
else
  echo "Notarization failed."
  exit 1
fi

xcrun stapler staple ${TARGET_BINARY}
