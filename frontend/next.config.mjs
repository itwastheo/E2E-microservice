/** @type {import('next').NextConfig} */
const nextConfig = {
  typescript: {
    ignoreBuildErrors: true, // Keeping this from your current config
  },
  output: 'standalone', // CHANGE THIS from 'export'
  images: {
    unoptimized: true,
  },
}

export default nextConfig