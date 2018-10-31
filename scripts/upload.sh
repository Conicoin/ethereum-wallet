#!/bin/bash

upload() {
    _file_name=$1
    _build_dir=$2
    _username=$3
    _password=$4

    altool="$(dirname "$(xcode-select -p)")/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Support/altool"
    ipa="$_build_dir/$_file_name.ipa"

    echo "Validating app..."
    time "$altool" --validate-app --type ios --file "$ipa" --username "$_username" --password "$_password"
    echo "Uploading app to iTC..."
    time "$altool" --upload-app --type ios --file "$ipa" --username "$_username" --password "$_password"
}

prepareBuild () {
    _workspace=$1
    _scheme=$2
    _configuration=$3
    _build_dir=$4
    _filename=_scheme

    xcodebuild -workspace "$_workspace" -scheme "$_scheme" -configuration "$_configuration" clean analyze
    xcodebuild -workspace "$_workspace" -scheme "$_scheme" -destination generic/platform=iOS build
    xcodebuild -workspace "$_workspace" -scheme "$_scheme" -sdk iphoneos -configuration "$_configuration" archive -archivePath "$_build_dir"/"$_filename".xcarchive
    xcodebuild -allowProvisioningUpdates -exportArchive -archivePath "$_build_dir"/"$_filename".xcarchive -exportOptionsPlist exportOptions.plist -exportPath "$_build_dir"
}

workspace="../ethereum-wallet.xcworkspace"
scheme_mainnet="Conicoin-Mainnet"
scheme_testnet="Conicoin-Testnet"
configuration_mainnet="Release-Mainnet"
configuration_testnet="Release-Testnet"
build_dir="../builds"

set -e
set -u

echo "Enter iTunes Connect Username..."
read -s -p "Username: " USERNAME
echo "Enter iTunes Connect Password..."
read -s -p "Password: " PASSWORD

start=`date +%s`

# prepareBuild "$workspace" "$scheme_mainnet" "$configuration_mainnet" "$build_dir"
# prepareBuild "$workspace" "$scheme_testnet" "$configuration_testnet" "$build_dir"

upload "$scheme_mainnet" "$build_dir" "$USERNAME" "$PASSWORD"
upload "$scheme_testnet" "$build_dir" "$USERNAME" "$PASSWORD"

end=`date +%s`

echo Execution time was "expr $end - $start" seconds.
