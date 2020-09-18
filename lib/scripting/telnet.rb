# frozen_string_literal: true

require "socket"

begin
  STDOUT.print "Connecting..." # Say what we're doing
  STDOUT.flush # Make it visible right away
  s = TCPSocket.open("192.168.101.51", "23") # Connect
  STDOUT.puts "done" # And say we did it
  # Now display information about the connection.

  local = s.addr
  peer = s.peeraddr
  STDOUT.print "Connected to #{peer[2]}:#{peer[1]}"
  STDOUT.puts " using local port #{local[1]}"
  # Wait just a bit, to see if the server sends any initial message.
  begin
    sleep(0.5) # Wait half a second
    msg = s.read_nonblock(4096) # Read whatever is ready
    STDOUT.puts msg.chop # And display it
  rescue SystemCallError
    # If nothing was ready to read, just ignore the exception.
  end

  # Now begin a loop of client/server interaction.
  loop do
    response = s.readpartial(4096) # Read server's response
    puts(response)
    s.puts(gets) # Send the line to the server
  end
rescue StandardError # If anything goes wrong
  puts $ERROR_INFO # Display the exception to the user
ensure # And no matter what happens
  s&.close # Don't forget to close the socket
end
