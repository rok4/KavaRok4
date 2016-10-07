FROM dduportal/docker-compose
MAINTAINER thibault.coupin gmail

RUN mkdir /kavarok4
ADD KavaRok4.sh /kavarok4/KavaRok4.sh

ENTRYPOINT /kavarok4/KavaRok4.sh
CMD up