platform :ios, '13.0'

plugin 'cocoapods-keys'

target 'Cats' do
  use_frameworks!

  pod 'Kingfisher', '~> 5.0'
  pod 'SnapKit', '~> 5.0'
  pod 'SwiftGen', '~> 6.0'
  pod 'SwiftLint'

  target 'CatsTests' do
    pod 'OHHTTPStubs/Swift'
  end

  target 'CatsUITests' do
    pod 'KIF'
    pod 'KIF/IdentifierTests'
  end

end
