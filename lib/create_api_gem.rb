require 'json'
require 'rest-client'
Gem.find_files("create_api_gem/**/*.rb").each do |path|
    require path
end
