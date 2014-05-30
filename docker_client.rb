#!/usr/bin/env ruby
require 'socket'

port = 3000
host = "localhost"

socket = TCPSocket.new(host,port)

puts "Code:"
code = gets
puts "Tests:"
tests = gets
puts "User ID"
user_id = gets
puts "Sending: #{code}\000#{tests}\000#{user_id}\000"
socket.send("#{code}\000#{tests}\000#{user_id}\000",0)
puts socket.gets
