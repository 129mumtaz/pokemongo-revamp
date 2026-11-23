#!/bin/bash
set -e

echo "=== Starting Flutter Web Build on Vercel ==="

# Avoid Git dubious ownership warnings in CI
git config --global --add safe.directory "*" || true

# Clone Flutter stable if not already installed in cache
if [ ! -d "flutter" ]; then
  echo "Cloning Flutter repository (stable branch)..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable flutter
else
  echo "Flutter directory found, reusing cached Flutter..."
fi

# Add Flutter binary to PATH
export PATH="$(pwd)/flutter/bin:$PATH"

echo "Checking Flutter version..."
flutter --version

echo "Configuring Flutter Web..."
flutter config --enable-web

echo "Fetching dependencies..."
flutter pub get

echo "Building Flutter Web for Release..."
flutter build web --release

echo "=== Build finished successfully! Output generated in build/web ==="
