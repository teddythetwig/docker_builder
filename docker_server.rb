#!/usr/bin/env ruby
require 'socket'
require 'fileutils'
class DockerServer

  DOCKER_DIR = ENV["DOCKER_SERVER_DIR"]
  PORT = ENV["DOCKER_SERVER_PORT"]
  
  def start
    server = TCPServer.open(PORT)
    loop {
      Thread.new(server.accept) do |client|
        code = client.gets("\000").chomp("\u0000")
       	p code 
	test_code = client.gets("\000").chomp("\u0000")
        p test_code
	user_id = client.gets("\000").chomp("\u0000")
        p user_id
	unless !code.empty? && !test_code.empty? && !user_id.empty?
          puts "NOT ACCEPTED"
          client.write("400")
          client.close
        end
        puts "OK"
        client.write(build_and_run_container(code,test_code,user_id))
        client.close
      end
    }
  end
  
  # Executes the build.sh script at the top of the docker directory
  def build_and_run_container(code,test_code,user_id)
    puts "Building and running docker container"
    formatted_code = format_code(code,test_code)
    p formatted_code
    command = ["#{DOCKER_DIR}/build.sh",%Q[\"#{formatted_code}\"],user_id].join(" ").chomp
    %x[#{command}]
  end
  
  # Adds requires and class structure for tests and executing
  def format_code(code,test)
    <<-EOS
#!/usr/bin/env ruby
require \'minitest/autorun\'
  
#{code}

class UserCodeTest < Minitest::Test
    
  def test_assertions 
    #{test}
  end
end
    EOS
  end
end

if __FILE__ == $0
  server = DockerServer.new
  server.start
end
