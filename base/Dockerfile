FROM astral1/rvm

RUN rvm get head
RUN /bin/bash -c -l "rvm install 2.0.0"
RUN /bin/bash -c -l "rvm rubygems current"
RUN /bin/bash -c -l "gem install minitest"
CMD /bin/bash -l -c "/ruby/user_code.rb"
