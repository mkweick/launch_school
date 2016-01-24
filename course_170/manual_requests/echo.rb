require 'socket'

server = TCPServer.new('0.0.0.0', $PORT)
loop do
  client = server.accept
  
  request_line = client.gets
  puts request_line
  
  client.puts request_line
  client.close
end