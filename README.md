Deployed to AWS: http://willowflare-live-ruby-2-1.us-west-2.elasticbeanstalk.com/

~

If there's memory issues during deployment, check the swap file created:
http://stackoverflow.com/questions/11013755/rails-assets-pipeline-cannot-allocate-memory-nodejs


~


Accessing the app in aws:

eb ssh
sudo su
cd /var/app/current


~

Installing nokogiri on Yosimete 10.10:

sudo env ARCHFLAGS="-arch x86_64" gem install nokogiri -- --use-system-libraries  -- --with-xml2-include=/usr/local/Cellar/libxml2/2.9.2/include/libxml2 --with-xml2-lib=/usr/local/Cellar/libxml2/2.9.2/lib --with-xslt-lib=/usr/local/lib --with-xslt-include=/usr/local/include



~

getting email list from mailchimp csv export using python:

import pandas
import numpy as np
df = pandas.read_csv("/Users/wanqi/Downloads/FILENAME.csv")
email = df.loc[:, 'Email']
email = np.asarray(email)
f = open("/Users/wanqi/Downloads/wf_email.txt", 'w')
f.write('\n'.join(k for k in email))
f.close()