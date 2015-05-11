
module Spregen::Template

  def self.build(binding)
    template = File.read(File.join(File.expand_path(File.dirname(__FILE__)), 'template', 'default.erb'))
    ERB.new(template).result(binding)
  end

end
