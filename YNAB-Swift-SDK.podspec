Pod::Spec.new do |s|
  s.name = 'YNAB'
  s.version = '1.0'
  s.license = 'MIT'
  s.summary = 'An unofficial SDK for the You Need A Budget API'
  s.homepage = 'https://github.com/roelspruit/YNAB-Swift-SDK'
  s.authors = { 'Roel Spruit' => 'roel@roelspruit.com' }
  s.source = { :git => 'https://github.com/roelspruit/YNAB-Swift-SDK.git', :tag => s.version }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Source/*', 'Source/UI/*', 'Source/API/*', 'Source/API/Models/*'

  s.requires_arc = true
end