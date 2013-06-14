# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "trisulrp"
  s.version = "1.5.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["vivek"]
  s.date = "2013-06-14"
  s.description = "This gem deals about the trisul remote protocol"
  s.email = "vivek_rajagopal@yahoo.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
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
    "lib/trisulrp/utils.rb",
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
  s.homepage = "http://github.com/vivekrajan/trisulrp"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "trisul trp"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruby-protocol-buffers>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_runtime_dependency(%q<ruby-protocol-buffers>, [">= 0.8.5"])
    else
      s.add_dependency(%q<ruby-protocol-buffers>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<ruby-protocol-buffers>, [">= 0.8.5"])
    end
  else
    s.add_dependency(%q<ruby-protocol-buffers>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<ruby-protocol-buffers>, [">= 0.8.5"])
  end
end

