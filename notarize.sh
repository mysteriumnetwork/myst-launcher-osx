#!/bin/sh

# Submit the dmg and get REQUEST_UUID
SUBMISSION_INFO=$(xcrun altool --notarize-app --primary-bundle-id=${PRIMARY_BUNDLE_ID} -u ${APPLE_ID} -p ${APP_SPECIFIC_PASSWORD} --file ${TARGET_BINARY} 2>&1) ;

if [ $? != 0 ]; then
    printf "Submission failed: $SUBMISSION_INFO \n"
    exit 5
fi

REQUEST_UUID=$(echo ${SUBMISSION_INFO} | awk -F ' = ' '/RequestUUID/ {print $2}')
if [ -z "${REQUEST_UUID}" ]; then
    echo "Errors trying to upload ${TARGET_BINARY}.zip: ${SUBMISSION_INFO}"
    exit 6
fi

# Wait for "Package Approved"
while ! xcrun altool --notarization-info ${REQUEST_UUID} --username ${APPLE_ID} --password ${APP_SPECIFIC_PASSWORD} --output-format xml | grep -q 'Package Approved' ; do
    sleep 60;
done

echo "Package Approved: REQUEST_UUID=$REQUEST_UUID can be accessed with this query: xcrun altool --notarization-info $REQUEST_UUID --username ${APPLE_ID} --output-format xml --password app_specific_password"

xcrun stapler staple ${TARGET_BINARY}
