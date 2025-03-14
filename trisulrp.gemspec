# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: trisulrp 3.2.50 ruby lib

Gem::Specification.new do |s|
  s.name = "trisulrp".freeze
  s.version = "3.2.50"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["vivek".freeze]
  s.date = "2025-03-11"
  s.description = "This gem deals about the trisul remote protocol".freeze
  s.email = "vivek_rajagopal@yahoo.com".freeze
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".ruby-version",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "examples/strp.rb",
    "lib/trisulrp.rb",
    "lib/trisulrp/guids.rb",
    "lib/trisulrp/keys.rb",
    "lib/trisulrp/protocol.rb",
    "lib/trisulrp/trp.pb.rb",
    "lib/trisulrp/trp.proto",
    "test/Demo_Client.crt",
    "test/Demo_Client.key",
    "test/cginfo.rb",
    "test/helper.rb",
    "test/test_alerts.rb",
    "test/test_cap.rb",
    "test/test_cg.rb",
    "test/test_grep.rb",
    "test/test_http_volume.rb",
    "test/test_key.rb",
    "test/test_key_flows.rb",
    "test/test_resources.rb",
    "test/test_trisulrp.rb",
    "trisulrp.gemspec"
  ]
  s.homepage = "http://github.com/vivekrajan/trisulrp".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.32".freeze
  s.summary = "trisul trp".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<protobuf>.freeze, [">= 0"])
    s.add_development_dependency(%q<shoulda>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<juwelier>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<protobuf>.freeze, [">= 0"])
    s.add_dependency(%q<shoulda>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<juwelier>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end

