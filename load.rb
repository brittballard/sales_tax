Dir[File.dirname(__FILE__) + "/app/*.rb"].each do |file|
  load file if !file.include?(File.basename(__FILE__))
end

File.open(File.dirname(__FILE__) + "/shopping_carts.txt", "r") do |infile|
  OpenStore.process_file(infile)
end