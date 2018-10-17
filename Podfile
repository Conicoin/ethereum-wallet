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
  pod 'PullToDismiss'
  pod 'lottie-ios'
  pod 'Dwifft'
  pod 'FirebaseAnalytics'
  pod 'EmptyDataSet-Swift', '~> 4.2.0'
  pod 'JSONRPCKit'
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

