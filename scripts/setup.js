#!/usr/bin/env node

import { createDatabaseClient, createProject, getProject } from '@inkeep/agents-core';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

const dbUrl = process.env.TURSO_DATABASE_URL || 'file:local.db';
const tenantId = 'default';
const projectId = 'default';
const projectName = 'default';
const projectDescription = 'Generated Inkeep Agents project';

async function setupProject() {
  console.log('🚀 Setting up your Inkeep Agents project...');

  try {
    const dbClient = createDatabaseClient({ url: dbUrl });
    // Check if project already exists
    console.log('📋 Checking if project already exists...');
    let alreadyExists = false;
    try {
      const existingProject = await getProject(dbClient)({
        id: projectId,
        tenantId: tenantId
      });
      if (existingProject) {
        alreadyExists = true;
        console.log('✅ Project already exists in database:', existingProject.name);
        console.log('🎯 Project ID:', projectId);
        console.log('🏢 Tenant ID:', tenantId);
      }
    } catch (error) {
      // Project doesn't exist, continue with creation
    }
    if (!alreadyExists) {
      // Create the project in the database
      console.log('📦 Creating project in database...');
      try {
        await createProject(dbClient)({
          id: projectId,
          tenantId: tenantId,
          name: projectName,
          description: projectDescription,
          models: {
            "base": {
              "model": "anthropic/claude-sonnet-4-20250514"
            },
            "structuredOutput": {
              "model": "openai/gpt-4.1-mini-2025-04-14"
            },
            "summarizer": {
              "model": "openai/gpt-4.1-nano-2025-04-14"
            }
          },
        });
        console.log('✅ Project created successfully!');
      } catch (error) {
        // If UNIQUE constraint fails, treat as success
        if (error && (error.message?.includes('UNIQUE constraint failed') || error.code === 'SQLITE_CONSTRAINT')) {
          console.log('✅ Project already exists (caught UNIQUE constraint).');
        } else {
          throw error;
        }
      }
      console.log('🎯 Project ID:', projectId);
      console.log('🏢 Tenant ID:', tenantId);
    }
    console.log('');
    console.log('🎉 Setup complete! Your development servers are running.');
    console.log('');
    console.log('📋 Available URLs:');
    console.log('   - Management UI: http://localhost:3002');
    console.log('   - Runtime API:   http://localhost:3003');
    console.log('');
    console.log('🚀 Ready to build agents!');
  } catch (error) {
    console.error('❌ Failed to setup project:', error);
    process.exit(1);
  }
}

setupProject();
