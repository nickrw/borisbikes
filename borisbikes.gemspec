Gem::Specification.new do |s|
  s.name = 'borisbikes'
  s.version = '1.0'
  s.summary = 'Boris bikes!'
  s.authors = ['Nicholas Robinson-Wall']
  s.email = ['nick@robinson-wall.com']
  s.required_ruby_version = '>= 1.9.1'
  s.files = Dir['{lib}/**/*']

  s.add_dependency 'cinch', '>= 2.0.4'
  s.add_dependency 'cinchize'
end
