FROM node:latest

# Install Rust and Cargo
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Tauri depedencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    pkg-config \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    libgdk-pixbuf2.0-dev \
    libglib2.0-dev \
    libnotify-dev \
    libappindicator3-dev \
    libssl-dev


WORKDIR /app

COPY . .

RUN npm install
RUN npm run tauri run
