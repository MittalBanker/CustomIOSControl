source 'https://github.com/CocoaPods/Specs.git'

# Uncomment this line to define a global platform for your project
platform :ios, '8.0'

# Uncomment this line if you're using Swift
# use_frameworks!

# ===== common =====
target "Template" do
pod 'AFNetworking', '~> 2.5'      # networking lib
pod 'SDWebImage', '~> 3.7'        # image loading lib
pod 'MBProgressHUD', '~> 0.8’   # progress/toast mesage display lib
pod 'TWMessageBarManager'         # app messages like 'success', 'failure', 'info'. https://github.com/terryworona/TWMessageBarManager
# pod 'Appirater', '~> 2.0'         # rate the app https://github.com/arashpayan/appirater
# ===== END common =====

# ===== database =====
pod 'FMDB'                        # database lib
# ===== END database =====

# ===== social =====

# facebook
# pod 'FBSDKCoreKit',  '4.6.0'      # facebook core kit
# pod 'FBSDKLoginKit',  '4.6.0'     # facebook login kit
# pod 'FBSDKShareKit',  '4.6.0'     # facebook sharing kit

# google
# pod 'Google/SignIn'               # google login kit https://developers.google.com/identity/sign-in/ios/start-integrating

# twitter using STTwitter
# pod 'STTwitter'                   # twitter sharing lib https://github.com/nst/STTwitter/

# twitter using fabric
# pod 'Fabric', '~> 1.6'
# pod 'Crashlytics'
# pod 'Answers'
# pod 'Digits'
# pod 'TwitterKit'

# instagram
# pod 'InstagramKit', '~> 3.7'      # https://github.com/shyambhat/InstagramKit

# ===== END social =====

# ===== utility =====
pod 'ObjectiveSugar', '~> 1.1'    # https://github.com/supermarin/ObjectiveSugar
# pod 'YLMoment', '~> 0.2.0'        # Date time utility https://github.com/kvnadesara/YLMoment
# pod 'BlocksKit', '~> 2.2'         # Blocks utility https://github.com/zwaldowski/BlocksKit
# pod 'NSDate-Escort', '~> 1.7'     # Date utility https://github.com/azu/NSDate-Escort
# ===== END social =====
end


post_install do |installer|
  installer.pods_project.build_configuration_list.build_configurations.each do |configuration|
    configuration.build_settings['CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'] = 'YES'
  end
end