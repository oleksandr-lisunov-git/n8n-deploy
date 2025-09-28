FROM n8nio/n8n:latest

# Optional: copy your custom nodes/workflows into /data
# COPY ./custom /data/custom

WORKDIR /data
EXPOSE 5678

CMD ["n8n", "start"]
