Pod::Spec.new do |s|
  s.name         = 'SingleChoiceController'
  s.version      = '0.0.1'
  s.authors      = {'Kevin Wong' => 'kevin.wl.02@gmail.com'}
  s.summary      = 'Single choice selection component.'
  s.homepage     = 'https://github.com/kevinwl02/SingleChoiceController.git'
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.platform     =  :ios, '7.0'
  s.source       =  {:git => 'https://github.com/kevinwl02/SingleChoiceController.git', :tag => '0.0.1'}
  s.public_header_files = 'SingleChoiceController/.h'
  s.source_files = 'Library/*.{h,m,mm}'
  s.requires_arc = true
end
