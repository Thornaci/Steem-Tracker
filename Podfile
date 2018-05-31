# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!

def shared_pods
    pod 'Firebase/Core', '~> 4.8.2'
end

target 'SteemitApp' do

  pod 'Alamofire', '~> 4.5'
  pod 'ObjectMapper', '~> 3.1'
  pod 'SDWebImage', '~> 4.2.3'
  pod 'MBProgressHUD', '~> 1.1.0'
  pod 'HockeySDK', '~> 5.1.2'
  pod 'Charts', '~> 3.0.5'
  pod 'DateToolsSwift', '~> 4.0.0'
  pod 'Firebase/Messaging', '~> 4.8.2'
  shared_pods
end

target 'SteemitAppWidget' do
    
end

target 'SteemitAppTests' do
    shared_pods
    pod 'OHHTTPStubs/Swift'
end
