FROM alpine

### RUN #sed -i s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g /etc/apk/repositories && \

RUN apk update && \
    apk add --no-cache wget

RUN cd /tmp && \
    wget https://github.com/ehang-io/nps/releases/download/v0.26.9/linux_amd64_server.tar.gz 

# 80与443端口为域名解析模式默认端口
# 8080为web管理访问端口
# 8024为网桥端口，用于客户端与服务器通信

# COPY ./linux_amd64_server.tar.gz /tmp/linux_amd64_server.tar.gz
RUN cd /tmp && \
    tar -zxf linux_amd64_server.tar.gz && \
    ./nps install && \
    rm -rf /tmp/linux_amd64_server.tar.gz
    
EXPOSE 8080
EXPOSE 80
EXPOSE 8024

CMD ["nps","service"]
