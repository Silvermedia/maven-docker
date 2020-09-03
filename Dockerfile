FROM maven:3.6.3-jdk-11-slim

ENV DOCKERIZE_VERSION=0.11.1

ADD https://github.com/powerman/dockerize/releases/download/v${DOCKERIZE_VERSION}/dockerize-linux-x86_64 /usr/local/bin/dockerize
RUN chmod +x /usr/local/bin/dockerize

ENV USERNAME=maven

RUN groupadd docker
RUN useradd -m -G docker ${USERNAME}

COPY fix-user-id.sh /
RUN chmod +x /fix-user-id.sh

RUN apt-get update \
    && apt-get install -y fontconfig libfreetype6

ENTRYPOINT ["/fix-user-id.sh"]
CMD ["mvn"]

