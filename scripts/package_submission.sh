#!/bin/bash
set -e
root_dir="$(cd "$(dirname "$0")/.."; pwd)"
zip_file="$root_dir/lasavopay_submission.zip"
rm -f "$zip_file"
cd "$root_dir"
zip -r "$zip_file" README.md DORAHACKS_SUBMISSION.md architecture.md contracts frontend backend telegram-bot infra demo_plan.md demo_video_script.md scripts
echo "Created $zip_file"
