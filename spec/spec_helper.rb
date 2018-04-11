require_relative "../config/environment.rb"
require "pry"
require "json"

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html,
                                    # :json, CustomFormatterClass

  config.after(:suite) do
    Dir["temp"].each do |file|
      File.delete(file)
    end
  end

end