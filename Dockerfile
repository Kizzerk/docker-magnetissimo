#Magnetissmo Test Build
#Set locale
#storage of passwords and such
#automae mix setup stuff


#Use a debain base
FROM debian:latest

#Set locales
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8



#Add repos and get required packages for magnetissimo
RUN apt-get update && apt-get install -y curl wget gnupg gnupg1 gnupg2
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
Run dpkg -i erlang-solutions_1.0_all.deb
RUN apt-get update && apt-get install -y redis-server esl-erlang elixir git postgresql 

########

#Setup postgres
USER postgres
RUN /etc/init.d/postgresql start &&\
     psql --command "CREATE USER magnet WITH PASSWORD 'torrentz';" &&\
     psql --command "CREATE DATABASE torrent OWNER magnet;" &&\
     psql --command "ALTER USER magnet CREATEDB;"

USER root

#RUN adduser --disabled-password --gecos "" magnetissimo

#WORKDIR /home/magnetissimo

#USER magnetissimo

RUN git clone -b feature/general-cleanup https://github.com/sergiotapia/magnetissimo.git

COPY dev.exs /magnetissimo/config/dev.exs

COPY setupmix.sh /magnetissimo/setupmix.sh

RUN chmod +x /magnetissimo/setupmix.sh

#USER magnetissimo
RUN /magnetissimo/setupmix.sh

EXPOSE 4000

COPY start.sh /magnetissimo/start.sh


RUN chmod +x /magnetissimo/start.sh


CMD ["/magnetissimo/start.sh"]

#CMD ["/usr/bin/local/mix", "phoenix.server"]


