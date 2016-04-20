require 'mustache'

class Index < Mustache
  self.template_path = File.dirname(__FILE__) + '/../templates'
end
