FROM node:lts-alpine AS builder

ENV NODE_ENV=production
WORKDIR /app

RUN apk add --no-cache git
RUN wget "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" -O /bin/pnpm && chmod +x /bin/pnpm

COPY . .
RUN pnpm install
RUN pnpm run sass:build

FROM node:lts-alpine

ENV NODE_ENV=production
WORKDIR /app
COPY --from=builder /app /app

EXPOSE 3000

CMD ["node", "server.js"]
