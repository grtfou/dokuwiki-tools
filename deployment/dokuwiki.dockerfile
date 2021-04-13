# Lastest updated: 210311
# It's for ARM CPU (ex. AWS Graviton2 processors)
FROM arm64v8/nginx:alpine

# ex. DOKUWIKI_RELEASE=2020-07-29
# ARG DOKUWIKI_RELEASE
ENV DOKUWIKI_RELEASE=2020-07-29

# Install packages
RUN \
 echo "**** install build packages ****" && \
 apk update \
 apk add --no-cache \
    curl  \
	openssl \
	php7 \
	php7-fileinfo \
	php7-fpm \
	php7-json \
	php7-mbstring \
	php7-openssl \
	php7-session \
	php7-simplexml \
	php7-xml \
	php7-xmlwriter \
	php7-zlib && \
 echo "**** install dokuwiki ****" && \
 if [ -z ${DOKUWIKI_RELEASE+x} ]; then \
	DOKUWIKI_RELEASE=$(wget https://download.dokuwiki.org/rss -O - 2>/dev/null | \
		xmlstarlet sel -T -t -v '/rss/channel/item[1]/link' | \
		cut -d'-' -f2-4 | cut -d'.' -f1 ); \
 fi && \
 echo "https://github.com/splitbrain/dokuwiki/archive/release_stable_${DOKUWIKI_RELEASE}.tar.gz" && \
 curl -o \
 /tmp/dokuwiki.tar.gz -L \
	"https://github.com/splitbrain/dokuwiki/archive/release_stable_${DOKUWIKI_RELEASE}.tar.gz" && \
 mkdir -p \
	/work/dokuwiki && \
 tar xf \
 	/tmp/dokuwiki.tar.gz -C \
	/work/dokuwiki --strip-components=1

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
