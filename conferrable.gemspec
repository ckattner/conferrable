require "./lib/conferrable/version"

Gem::Specification.new do |s|
  s.name        = 'conferrable'
  s.version     = Conferrable::VERSION
  s.summary     = "Simple YAML file-based configuration management"

  s.description = <<-EOS
    We have seen our applications gain more and more static configuration files over time.
    A common library we use on a daily basis is these configuration file loaders.
    Conferrable standardizes how we interact with these static YAML configuration files.
  EOS

  s.authors     = [ 'Matthew Ruggio' ]
  s.email       = [ 'mruggio@bluemarblepayroll.com' ]
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.homepage    = 'https://github.com/bluemarblepayroll/conferrale'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.3.1'

  s.add_development_dependency('rspec')
end
