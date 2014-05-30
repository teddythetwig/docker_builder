#!/usr/bin/env ruby
require 'socket'
require 'fileutils'
class DockerServer

  DOCKER_DIR = "/home/tfunger/ruby/docker"
  PORT = 3000
  
  def start
    server = TCPServer.open(PORT)
    loop {
      Thread.new(server.accept) do |client|
        code = client.gets("\000").chomp("\n\x00")
        tests = client.gets("\000").chomp("\n\x00")
        user_id = client.gets("\000").chomp("\n\x00")
        unless !code.empty? && !tests.empty? && !user_id.empty?
          puts "NOT ACCEPTED"
          client.write("400")
          client.close
        end
        puts "OK"
        client.write("202")
        puts build_and_run_container(code,tests,user_id)
        client.close
      end
    }
  end
  
  # Executes the build.sh script at the top of the docker directory
  def build_and_run_container(code,test_code,user_id)
    puts "Building and running docker container"
    formatted_code = format_code(code,test_code).chomp
    command = ["#{DOCKER_DIR}/build.sh","\"#{formatted_code}\"",user_id].join(" ").chomp
    %x[#{command}]
  end
  
  # Adds requires and class structure for tests and executing
  def format_code(code,test)
    <<-EOS
#!/usr/bin/env ruby
require 'minitest/autorun'
  
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
