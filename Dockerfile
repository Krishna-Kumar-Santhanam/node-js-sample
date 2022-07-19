FROM alpine:3
WORKDIR /app
COPY . .
RUN apk add --update nodejs npm && npm install
CMD ["npm", "start"]
EXPOSE 5000
