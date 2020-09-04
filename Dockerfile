FROM maven:3.6.3-jdk-11-slim
ENV DOCKERIZE_VERSION=0.12.0 \
        USERNAME=maven
ADD https://github.com/powerman/dockerize/releases/download/v${DOCKERIZE_VERSION}/dockerize-linux-x86_64 /usr/local/bin/dockerize
COPY fix-user-id.sh /
RUN groupadd docker \
   && useradd -m -G docker ${USERNAME} \
   && apt-get update \
   && apt-get install -y fontconfig libfreetype6 \
     && chmod +x /usr/local/bin/dockerize \
   && chmod +x /fix-user-id.sh
ENTRYPOINT ["/fix-user-id.sh"]
CMD ["mvn"]