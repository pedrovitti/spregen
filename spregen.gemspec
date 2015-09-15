Gem::Specification.new do |s|
  s.name        = 'spregen'
  s.version     = '0.0.1'
  s.summary     = 'Spregen!'
  s.description = 'A simple trello report generation gem'
  s.executables = ['spregen']
  s.authors     = ['Pedro Vitti', 'Geison Biazus', 'Murillo Flores', 'Luciano Medeiros']
  s.files       = ['lib/spregen.rb', 'lib/spregen/board.rb', 'lib/spregen/burndown.rb', 'lib/spregen/config.rb', 'lib/spregen/helpers.rb', 'lib/spregen/report.rb', 'lib/spregen/template.rb', 'lib/templates/default.erb', 'lib/templates/spregen-config.yml.erb']
  s.license     = 'MIT'
  s.add_runtime_dependency 'commander', '4.3.4'
  s.add_runtime_dependency 'ruby-trello', '1.2.1'
end
