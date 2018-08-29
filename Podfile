platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

target 'ethereum-wallet' do
  # Pods for ethereum-wallet
  pod 'R.swift'
  pod 'Geth'
  pod 'RealmSwift'
  pod 'SpringIndicator'
  pod 'AlamofireObjectMapper'
  pod 'CryptoSwift'
  pod 'secp256k1_ios'
  pod 'PullToDismiss', '~> 2.1'
  pod 'lottie-ios'
  pod 'Dwifft'
  pod 'FirebaseAnalytics'
  pod 'EmptyDataSet-Swift', '~> 4.0.5'
end

target 'ConicoinTests' do
  pod 'CryptoSwift'
  pod 'secp256k1_ios'
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end

