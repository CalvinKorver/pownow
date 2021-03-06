# As Scrapy runs on Python, I choose the official Python 3 Docker image.
FROM python:3

# Copy the file from the local host to the filesystem of the container at the working directory.
COPY requirements.txt ./

# Install Scrapy specified in requirements.txt.
RUN pip3 install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y cron

# Copy the project source code from the local host to the filesystem of the container at the working directory.
COPY . .

# Run the crawler when the container launches with cron
# COPY hello-cron /etc/cron.d/hello-cron
# RUN chmod 0644 /etc/cron.d/hello-cron
# RUN crontab /etc/cron.d/hello-cron
# # CMD cron
CMD python ./go-spider.py



