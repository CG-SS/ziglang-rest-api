FROM alpine:latest

RUN apk add zig --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

RUN mkdir /builder
WORKDIR /builder

COPY ./build.zig .

RUN mkdir /src
COPY ./src ./src

RUN zig build
RUN mkdir /app

WORKDIR /app

RUN ls -l /builder/zig-out/bin
RUN cp /builder/zig-out/bin/ziglang-rest-api .
RUN rm -rf /builder
RUN apk del zig

ENTRYPOINT [ "/app/ziglang-rest-api" ]