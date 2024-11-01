FROM alpine

WORKDIR /app
RUN apk update
RUN apk --no-cache add ffmpeg
RUN apk --no-cache add python3

COPY entrypoint.sh .
RUN chmod +x entrypoint.sh
VOLUME [ "/data" ]
ENTRYPOINT [ "/app/entrypoint.sh" ]