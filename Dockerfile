FROM node:16 AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:16 AS production

WORKDIR /app
COPY --from=builder /app/build ./build
RUN npm install -g serve

EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000", "--host", "0.0.0.0"]
