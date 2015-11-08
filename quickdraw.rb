Dir["./lib/*.rb"].each { |file| require "#{file}" }

cli = CLI.new
cli.run