require 'csv'
require "webshot"

IMAGES_PATH = 'tmp'

ws = Webshot::Screenshot.instance

i = 0
CSV.foreach('council_waste_recycling.csv', :headers => true, :header_converters => :symbol, :converters => :all) do |row|
  name = row[:name].downcase
  puts "Capturing webshot for #{name}"
  
  begin
    if row[:page] && row[:page].include?('http')
      ws.capture(row[:page], "#{IMAGES_PATH}/#{name}.png", width: 1028) do |magick|
        magick.combine_options do |c|
          # c.thumbnail "100x"
          c.background "white"
          # c.extent "100x90"
          c.gravity "north"
          c.quality 85
        end
      end
    end
  rescue => detail
    print 'Exception getting screenshot'
  end
  i += 1
  # exit if i > 10
end
