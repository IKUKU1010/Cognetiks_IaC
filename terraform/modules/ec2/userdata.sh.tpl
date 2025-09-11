#!/bin/bash
set -e
exec > >(tee /var/log/userdata.log|logger -t userdata -s 2>/dev/console) 2>&1

# Update system
apt-get update -y
apt-get upgrade -y

# Install dependencies
apt-get install -y python3-pip python3-venv python3-dev git curl unzip \
                   build-essential libpq-dev nginx

# Clone repo
PROJECT_DIR="/home/ubuntu/Cognetiks_DevOps_App"
rm -rf $PROJECT_DIR
git clone https://github.com/IKUKU1010/Cognetiks_DevOps_App.git $PROJECT_DIR

# Setup venv
cd $PROJECT_DIR
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt gunicorn boto3

# Django setup
python manage.py migrate
python manage.py collectstatic --noinput

# Systemd service for Gunicorn
cat > /etc/systemd/system/gunicorn.service <<EOF
[Unit]
Description=gunicorn daemon for Django
After=network.target

[Service]
User=ubuntu
Group=www-data
WorkingDirectory=$PROJECT_DIR
ExecStart=$PROJECT_DIR/venv/bin/gunicorn --workers 3 --bind 0.0.0.0:8000 Cognetiks_DevOps_App.wsgi:application

[Install]
WantedBy=multi-user.target
EOF

# Enable and start Gunicorn
systemctl daemon-reload
systemctl enable gunicorn
systemctl start gunicorn
