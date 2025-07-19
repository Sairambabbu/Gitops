#!/bin/sh

# Inject runtime API URL into Next.js expected env file
echo "NEXT_PUBLIC_API_BASE_URL=${NEXT_PUBLIC_API_BASE_URL}" > .env.local

# Log what’s being injected
echo "Injected API URL: $NEXT_PUBLIC_API_BASE_URL"

# Start the app
npm start
