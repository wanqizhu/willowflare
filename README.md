Deployed to AWS: http://willowflare-live-ruby-2-1.us-west-2.elasticbeanstalk.com/

~

If there's memory issues during deployment, check the swap file created:
http://stackoverflow.com/questions/11013755/rails-assets-pipeline-cannot-allocate-memory-nodejs


	-- ssh into the server

	-- do this:

		# Turn it on
		sudo swapon -s

		# Create a swap file
		# 512k --> Swapfile of 512 MB
		sudo dd if=/dev/zero of=/swapfile bs=1024 count=512k

		# Use the swap file
		sudo mkswap /swapfile
		sudo swapon /swapfile

		# make sure the swap is present after reboot:
		sudo echo " /swapfile       none    swap    sw      0       0 " >> /etc/fstab

		# Set the swappiness (performance - aware)
		echo 10 | sudo tee /proc/sys/vm/swappiness
		echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf           

		# Change the permission to non-world-readable
		sudo chown root:root /swapfile 
		sudo chmod 0600 /swapfile


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