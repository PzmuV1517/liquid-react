require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "liquid-react"
  s.version      = package['version']
  s.summary      = package['description']
  s.description  = <<-DESC
                   Production-ready React Native iOS module that exposes Apple's native UIKit components 
                   for authentic Liquid Glass rendering. Uses only public APIs.
                   DESC
  s.homepage     = package['repository']['url']
  s.license      = package['license']
  s.author       = package['author']
  s.platform     = :ios, "13.0"
  s.source       = { :git => package['repository']['url'], :tag => "v#{s.version}" }
  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true
  s.swift_version = "5.0"

  s.dependency 'React-Core'
end
