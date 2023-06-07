# Using official python runtime base image 
FROM ubuntu

# Set the application directory
WORKDIR /app

# Install our requirements.txt
ADD requirements.txt /app/requirements.tx
RUN sudo apt install python3-dev python3-pip python3-virtualenv sqlitebrowser \
&& sudo pip install -r requirements.txt \ 
&& python3 manage.py migrate \ 
&& python3 manage.py createsuperuser --username admin --email admin@mail.com --Password valery123

# Copy our code from the current folder to /app inside the container
COPY . /app
# Make port 8000 available for links and/or publish
ENV PORT 8000
EXPOSE 8000

# Define our command to be run when launching the container
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:8000", "--log-file", "-", "--access-logfile", "-", "--workers", "4", "--keep-alive", "0"]
