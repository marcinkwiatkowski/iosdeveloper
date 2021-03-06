# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__), 'lib', 'iosdeveloper', 'version'])
spec = Gem::Specification.new do |s|
  s.name = 'iosdeveloper'
  s.version = IOSDeveloper::VERSION
  s.author = 'Marcin Kwiatkowski'
  s.email = 'marcin.kwiatkowski@hotmail.com'
  s.homepage = 'https://github.com/marcinkwiatkowski/iosdeveloper'
  s.platform = Gem::Platform::RUBY
  s.summary = %q{iOS Developer Tools}
  s.description = %q{Command line tools for accessing iOS Provisioning Portal}
# Add your other files here if you make them
  s.files = %w(
bin/iosdeveloper
lib/iosdeveloper/version.rb
lib/iosdeveloper/provisioning_portal.rb
lib/iosdeveloper/profile.rb
lib/iosdeveloper.rb
lib/AppleIncRootCertificate.cer
  )
  s.require_paths << 'lib'
  s.bindir = 'bin'
  s.executables << 'iosdeveloper'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli', '2.5.3')
  s.add_runtime_dependency('plist', '3.1.0')
  s.add_runtime_dependency('mechanize', '2.5.1')
end
