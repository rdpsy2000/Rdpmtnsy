# Use the base image
FROM fredblgr/ubuntu-novnc:20.04

# Expose the port on which NoVNC runs (80 inside the container)
EXPOSE 80

# Set the environment variable for screen resolution
ENV RESOLUTION=1707x1067

# Install Google Chrome
RUN apt-get update && 
    apt-get install -y wget gnupg && 
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && 
    sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/stable main" >> /etc/apt/sources.list.d/google-chrome.list' && 
    apt-get update && 
    apt-get install -y google-chrome-stable

# Copy the supervisord.conf file into the container
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Start the command to run NoVNC and Google Chrome
CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
