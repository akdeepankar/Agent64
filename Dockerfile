FROM node:22-alpine

WORKDIR /inkeep-agents

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY turbo.json drizzle.config.ts ./

COPY apps/ ./apps/
COPY scripts/ ./scripts/

RUN npm install -g pnpm@10.17.0

RUN pnpm install --frozen-lockfile


# Build the TypeScript output for all apps
RUN pnpm run build

EXPOSE 3000 3002 3003

# Use pnpm start for production (change path if needed)
CMD ["pnpm", "start", "--filter", "manage-api-quickstart"]
