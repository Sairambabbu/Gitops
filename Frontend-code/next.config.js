/** @type {import('next').NextConfig} */
const nextConfig = {
    reactStrictMode: true,
    // Disable static replacement so runtime env can be used
    env: {
      NEXT_PUBLIC_API_BASE_URL: process.env.NEXT_PUBLIC_API_BASE_URL || "http://localhost:8000"
    }
  };
  
  module.exports = nextConfig;
  