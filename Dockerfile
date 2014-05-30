# Test Docker running short ruby code

FROM ubuntu

RUN apt-get install -qy ruby1.9.3 rubygems
RUN gem install minitest
CMD ./user_code.rb

ADD ./user_code.rb /ruby/

WORKDIR /ruby
RUN chmod +x ruby_code.rb
