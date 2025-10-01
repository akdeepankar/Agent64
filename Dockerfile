FROM node:22-alpine

WORKDIR /inkeep-agents

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY turbo.json drizzle.config.ts ./

COPY apps/ ./apps/
COPY scripts/ ./scripts/

RUN npm install -g pnpm@10.17.0



# Set TURSO_DATABASE_URL for setup script with Turso authToken
ENV TURSO_DATABASE_URL=libsql://database-violet-window-vercel-icfg-tbuxyiynqplgcvoedgrddlgd.aws-us-east-1.turso.io?authToken=eyJhbGciOiJFZERTQSIsInR5cCI6IkpXVCJ9.eyJhIjoicnciLCJpYXQiOjE3NTkxMjg4NjMsImlkIjoiZDJkYjk2MTgtYWYzZS00MDI2LWExODYtOWY3ZmQ5OWZmNTU5IiwicmlkIjoiYjY3ZGY3OTMtZmU3Yy00ZWEzLThmZDEtOTQ2Y2VhODdmYjExIn0.f7-P0pKBj8dMP2Lmd0jdbeNJYkEG2zfogiUV-KFoGfSAJx06PQDWmcleic75NeeZEk-hRPNlJDYsyAoKvtaYBg

RUN pnpm install --frozen-lockfile


# Build the TypeScript output for all apps
RUN pnpm run build

EXPOSE 3000 3002 3003

# Use pnpm start for production (change path if needed)
CMD ["pnpm", "start", "--filter", "manage-api-quickstart"]
