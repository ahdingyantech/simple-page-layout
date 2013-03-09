# coding: utf-8
Gem::Specification.new do |s|
  s.name          = 'simple-page-layout'
  s.version       = '0.0.1'
  s.platform      = Gem::Platform::RUBY
  s.date          = '2013-03-09'
  s.summary       = 'simple page layout helpers'
  s.description   = 'layouts made easy for rails 3.'
  s.authors       = 'ben7th'
  s.email         = 'ben7th@sina.com'
  s.homepage      = 'https://github.com/mindpin/simple-page-layout'
  s.licenses      = 'MIT'

  s.files         = Dir.glob("lib/**/*") + %w(README.md)
  s.require_paths = ['lib']
end