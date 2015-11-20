class Language < ActiveHash::Base
  self.data = JSON.parse(File.read(File.join(Rails.root, 'lib', 'data.json')))
end
