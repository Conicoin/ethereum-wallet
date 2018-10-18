platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

target 'ethereum-wallet' do
  # Pods for ethereum-wallet
  pod 'R.swift', '4.0.0'
  pod 'Geth', '1.8.17'
  pod 'RealmSwift', '3.11.0'
  pod 'SpringIndicator', '4.0.1'
  pod 'AlamofireObjectMapper', '5.1.0'
  pod 'CryptoSwift', '0.12.0'
  pod 'secp256k1_ios', '0.1.3'
  pod 'PullToDismiss', '2.1'
  pod 'lottie-ios', '2.5.2'
  pod 'Dwifft', '0.9'
  pod 'FirebaseAnalytics'
  pod 'EmptyDataSet-Swift', '~> 4.2.0'
end

target 'ConicoinTests' do
  pod 'CryptoSwift'
  pod 'secp256k1_ios'
end

swift4 = ['PullToDismiss', 'R.swift.Library']

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if swift4.include?(target.name)
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
end

