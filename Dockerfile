FROM mattiashem/python:3.7

#copy code
COPY code/ /app/code/
WORKDIR /app/code

#Install deps
RUN pip install --upgrade pip
RUN pip install -r requirements.txt


#base
RUN apt update && apt-get install -y curl openssh-server 
#deps 
RUN apt update && apt-get install -y default-jre

EXPOSE 80

# Start server
ENTRYPOINT [ "./entrypoint.sh" ] 
