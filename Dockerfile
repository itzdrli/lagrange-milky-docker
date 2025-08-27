FROM debian:latest

RUN apt-get update && \
    apt-get install -y ca-certificates libicu-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN update-ca-certificates

WORKDIR /data
RUN mkdir -p /lagrange

COPY Lagrange.Milky /lagrange/
RUN chmod +x /lagrange/Lagrange.Milky

# 创建启动脚本
RUN cat > /lagrange/entrypoint.sh << 'EOF'
#!/bin/bash
# 检查 /data 中是否存在 Lagrange.Milky 二进制文件
if [ ! -f "/data/Lagrange.Milky" ]; then
    echo "Binary not found in /data, copying from /lagrange..."
    cp /lagrange/Lagrange.Milky /data/
    chmod +x /data/Lagrange.Milky
fi

# 启动应用
exec ./Lagrange.Milky "$@"
EOF

RUN chmod +x /lagrange/entrypoint.sh

RUN useradd -r -s /bin/false lagrange && \
    chown -R lagrange:lagrange /lagrange

USER lagrange

ENTRYPOINT ["/lagrange/entrypoint.sh"]