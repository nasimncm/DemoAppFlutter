#!/bin/bash

# Script to add SSH key to GitHub
# Usage: ./add_ssh_key_to_github.sh YOUR_GITHUB_TOKEN

PUBLIC_KEY=$(cat ~/.ssh/id_ed25519.pub)
KEY_TITLE="DemoAppFlutter-$(hostname)-$(date +%Y%m%d)"

if [ -z "$1" ]; then
    echo "Usage: $0 YOUR_GITHUB_TOKEN"
    echo ""
    echo "To get a token:"
    echo "1. Go to: https://github.com/settings/tokens"
    echo "2. Click 'Generate new token' -> 'Generate new token (classic)'"
    echo "3. Select scope: 'admin:public_key' or 'write:public_key'"
    echo "4. Generate and copy the token"
    exit 1
fi

TOKEN=$1

echo "Adding SSH key to GitHub..."
echo "Key title: $KEY_TITLE"
echo ""

RESPONSE=$(curl -s -X POST \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/keys \
  -d "{\"title\":\"$KEY_TITLE\",\"key\":\"$PUBLIC_KEY\"}")

if echo "$RESPONSE" | grep -q '"id"'; then
    echo "✓ SSH key successfully added to GitHub!"
    echo ""
    echo "Now you can push your code with:"
    echo "  git push -u origin main"
else
    echo "✗ Failed to add SSH key"
    echo "Response: $RESPONSE"
    exit 1
fi

