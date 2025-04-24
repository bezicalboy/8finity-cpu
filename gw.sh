#!/bin/bash

echo "Setup Miner Infinity (CPU Version) srepet pet pet pettt"

# 1. Minta input private key
read -p "Masukin PRIVATE_KEY (64 karakter, tanpa 0x): " PRIVATE_KEY

# Validasi panjang key
if [ ${#PRIVATE_KEY} -ne 64 ]; then
  echo "PRIVATE_KEY harus 64 karakter (tanpa 0x)"
  exit 1
fi

# 2. Kloning repo
echo "Lagi ngambil repo miner-cpu..."
git clone https://github.com/8finity-xyz/miner-cpu.git || { echo "Gagal clone repo."; exit 1; }
cd miner-cpu || { echo "Gagal masuk ke folder miner-cpu."; exit 1; }

# 3. Cek dan install Go kalo belum ada
if ! command -v go &> /dev/null; then
    echo "Go belum keinstall,Install dlu ngab"
    sudo apt update
    sudo apt install -y golang
else
    echo "Go udah ada, lanjut..."
fi

# 4. Build program
echo "Build program dulu pake Go..."
go build || { echo "Build gagal, coba cek error-nya."; exit 1; }

# 5. Bikin file .env
echo "Bikin file .env..."
cp .env.example .env 2>/dev/null || touch .env
echo "INFINITY_RPC=https://rpc.soniclabs.com" > .env
echo "INFINITY_WS=wss://rpc.soniclabs.com" >> .env
echo "INFINITY_PRIVATE_KEY=$PRIVATE_KEY" >> .env

# 6. Langsung jalanin minernya
echo "Jalanin miner sekarang..."
chmod +x miner
./miner
