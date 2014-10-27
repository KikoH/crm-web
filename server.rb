require 'socket'                                    # Require socket from Ruby Standard Library (stdlib)
require 'pry'

host = 'localhost'
port = 2000

server = TCPServer.open(host, port)                 # Socket to listen to defined host and port
puts "Server started on #{host}:#{port} ..."        # Output to stdout that server started


loop do                                             # Server runs forever
  client = server.accept                            # Wait for a client to connect. Accept returns a TCPSocket

  lines = []
  while (line = client.gets.chomp) && !line.empty?  # Read the request and collect it until it's empty
    lines << line
  end
  puts lines                                        # Output the full request to stdout

	filename = lines[0].gsub(/GET \//, '').gsub(/\ HTTP.*/, '')

	if File.exists?(filename)
		body = File.read(filename)
		header = "HTTP/1.1 200 OK\r\n"
		header += "Content-Type: text/html\r\n"
		header += "\r\n"
	else
		header = "HTTP/1.1 404 Not Found\r\n"
		header += "Content-Type: text/plain\r\n"
		header += "Content-Type: 20\r\n"
		header += "Connection: close\r\n"
	end

	
	
	response = [header, body].join("\r\n")

	# binding.pry
  client.puts(response)
                        # Output the current time to the client
  client.close                                      # Disconnect from the client
end