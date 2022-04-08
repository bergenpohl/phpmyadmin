# Debian v11
FROM debian:bullseye

COPY srcs /root/srcs/

RUN apt-get update
RUN apt-get -y install	\
	sudo		\
	vim man		\
	curl wget	\
	passwd		\
	adduser		\
	unzip		\
	nginx		\
	mariadb-server	\
	mariadb-client	\
	php php-fpm	\
	php-mysql	\
	php-mbstring	\
	php-zip php-gd

# Run config on startup
ENTRYPOINT ["bash", "/root/srcs/startup.sh"]
