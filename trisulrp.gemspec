# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name = "trisulrp"
  s.version = File.read(File.expand_path("../VERSION", __FILE__)).strip

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["vivek"]
  s.description = "This gem deals about the trisul remote protocol"
  s.email = "info@unleashnetworks.com"
  s.homepage = "http://github.com/vivekrajan/trisulrp"
  s.licenses = ["MIT"]
  s.summary = "trisul trp"

  s.files = `git ls-files -z`.split("\x0")
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]

  s.add_dependency "protobuf"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "bundler"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "rdoc"
  s.add_development_dependency "rake"
end
