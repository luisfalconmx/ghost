FROM ghost:3-alpine
WORKDIR /var/lib/ghost/
ENTRYPOINT sh -c 'sh -c "npx ghata --auto" && node current/index.js'
EXPOSE 2368