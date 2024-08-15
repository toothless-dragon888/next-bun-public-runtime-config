/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  publicRuntimeConfig: {
    NAME: process.env.NEXT_PUBLIC_NAME
  }

};

export default nextConfig;
