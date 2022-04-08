# Debian v11
FROM debian:bullseye

COPY srcs /root/srcs/

RUN apt-get update
RUN apt-get -y install	\
	sudo		\
	vim man		\
	git curl wget	\
	passwd openssl	\
	adduser		\
	unzip		\
	openssh-server	\
	openssh-client	\
	ufw vsftpd	\
	nginx		\
	mariadb-server	\
	mariadb-client	\
	php php-fpm php-mbstring php-mysql \
	php-gd php-curl php-dom \
	php-imagick php-zip php-intl

# Run config on startup
ENTRYPOINT ["bash", "/root/srcs/startup.sh"]
