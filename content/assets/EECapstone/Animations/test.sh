#!/bin/bash

# Usage: ./compress_mp4s.sh /path/to/folder
TARGET_DIR="${1:-.}"

python3 - <<EOF
import subprocess
import os

target_dir = os.environ.get("TARGET_DIR", ".")

for filename in os.listdir(target_dir):
    if filename.lower().endswith(".mp4"):
        input_path = os.path.join(target_dir, filename)
        temp_output = os.path.join(target_dir, f"compressed_{filename}")
        backup_path = os.path.join(target_dir, f"old_{filename}")

        print(f"Compressing: {filename}")
        result = subprocess.run([
            "ffmpeg",
            "-i", input_path,
            "-vcodec", "libx264",
            "-crf", "28",
            "-preset", "slow",
            "-acodec", "aac",
            "-b:a", "96k",
            temp_output
        ])

        if result.returncode == 0:
            print(f"Compression successful. Replacing original {filename}")
            os.rename(input_path, backup_path)
            os.rename(temp_output, input_path)
        else:
            print(f"Failed to compress {filename}, skipping replacement.")
            if os.path.exists(temp_output):
                os.remove(temp_output)
EOF
