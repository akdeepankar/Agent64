import { defineConfig } from '@inkeep/agents-cli/config';

  const config = defineConfig({
    tenantId: "default",
    projectId: "weather-project",
    agentsManageApiUrl: 'https://manage-api-quickstart-production.up.railway.app',
    agentsRunApiUrl: 'https://run-api-quickstart-production.up.railway.app',
    modelSettings: {
  "base": {
    "model": "openai/gpt-5-2025-08-07"
  },
  "structuredOutput": {
    "model": "openai/gpt-4.1-mini-2025-04-14"
  },
  "summarizer": {
    "model": "openai/gpt-4.1-nano-2025-04-14"
  }
},
  });
      
  export default config;