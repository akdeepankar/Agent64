FROM node:22-alpine

WORKDIR /inkeep-agents

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY turbo.json drizzle.config.ts ./

COPY apps/ ./apps/
COPY scripts/ ./scripts/

RUN npm install -g pnpm@10.17.0

RUN pnpm install --frozen-lockfile

EXPOSE 8080

CMD ["pnpm", "--filter", "run-api-quickstart", "start"]