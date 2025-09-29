FROM node:22-alpine

WORKDIR /inkeep-agents

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY turbo.json drizzle.config.ts ./

COPY apps/ ./apps/
COPY scripts/ ./scripts/

RUN npm install -g pnpm@10.17.0


# Set DB_FILE_NAME for setup script
ENV DB_FILE_NAME=libsql://database-violet-window-vercel-icfg-tbuxyiynqplgcvoedgrddlgd.aws-us-east-1.turso.io

RUN pnpm install --frozen-lockfile


# Build the TypeScript output for all apps
RUN pnpm run build

EXPOSE 3000 3002 3003

# Use pnpm start for production (change path if needed)
CMD ["pnpm", "start", "--filter", "manage-api-quickstart"]
