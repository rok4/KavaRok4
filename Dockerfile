FROM dduportal/docker-compose
MAINTAINER thibault.coupin gmail

RUN mkdir /kavarok4
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/kavarok4

ADD scripts /kavarok4/
ADD KavaRok4 /kavarok4/KavaRok4
RUN chmod +x /kavarok4/*

ENTRYPOINT ["KavaRok4"]
CMD ["up"]