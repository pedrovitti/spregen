
module Spregen
  module Template
    module_function

    def build(binding)
      template = File.read(File.expand_path('../../templates/default.erb', __FILE__))
      ERB.new(template).result(binding)
    end
  end
end
