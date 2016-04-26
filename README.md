Deployed to AWS: http://willowflare-dev.us-west-2.elasticbeanstalk.com/


~

Installing nokogiri on Yosimete 10.10:

sudo env ARCHFLAGS="-arch x86_64" gem install nokogiri -- --use-system-libraries  -- --with-xml2-include=/usr/local/Cellar/libxml2/2.9.2/include/libxml2 --with-xml2-lib=/usr/local/Cellar/libxml2/2.9.2/lib --with-xslt-lib=/usr/local/lib --with-xslt-include=/usr/local/include