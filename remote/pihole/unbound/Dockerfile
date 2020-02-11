FROM alpine
RUN apk add unbound
COPY unbound.conf /etc/unbound/
EXPOSE 53
ENTRYPOINT ["unbound", "-p","-d"]
