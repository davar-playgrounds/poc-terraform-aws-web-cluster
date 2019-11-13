sudo rm -f /usr/share/nginx/html/*
sudo sh -c 'mv /src/* /usr/share/nginx/html/'
sudo chown -R root:root /usr/share/nginx/html/
sudo rm -rf /src
ls -l /usr/share/nginx/html/