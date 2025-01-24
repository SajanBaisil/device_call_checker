Pod::Spec.new do |s|
  s.name             = 'device_call_checker'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin to check if a device is in a call'
  s.description      = <<-DESC
                       A plugin for Flutter to determine if the device is currently in a call,
                       including calls via any app like WhatsApp, regular phone, or others.
                       DESC
  s.homepage         = 'https://example.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'sajanbaisil12@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.ios.deployment_target = '11.0'
  s.dependency 'Flutter'
end
