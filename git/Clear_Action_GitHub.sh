#!/bin/bash

# # Για Debian/Ubuntu sudo apt-get install jq

# Ορίστε το αποθετήριο και το προσωπικό σας token
REPO="USERNAME/REPOSITORY"
TOKEN="YOUR_GITHUB_TOKEN"

# Fetch all workflow runs, sorted by descending run number (most recent first)
echo "Fetching workflow runs"
RESPONSE=$(curl -s -H "Accept: application/vnd.github.v3+json" \
                -H "Authorization: token $TOKEN" \
                "https://api.github.com/repos/$REPO/actions/runs?per_page=100")

# Εξαγωγή του ID του πιο πρόσφατου workflow run
LATEST_RUN_ID=$(echo "$RESPONSE" | jq -r '.workflow_runs[0].id')

if [ -z "$LATEST_RUN_ID" ]; then
  echo "No workflow runs found."
  exit 1
fi

echo "Most recent workflow run ID: $LATEST_RUN_ID"

# Εξαγωγή IDs όλων των workflow runs εκτός από το πιο πρόσφατο
RUNS_TO_DELETE=$(echo "$RESPONSE" | jq -r --arg LATEST_RUN_ID "$LATEST_RUN_ID" '.workflow_runs[] | select(.id != ($LATEST_RUN_ID | tonumber)) | .id')
# Διαγραφή των workflow runs εκτός από το πιο πρόσφατο
for RUN_ID in $RUNS_TO_DELETE; do
  echo "Deleting workflow run $RUN_ID"
  curl -s -X DELETE \
       -H "Accept: application/vnd.github.v3+json" \
       -H "Authorization: token $TOKEN" \
       "https://api.github.com/repos/$REPO/actions/runs/$RUN_ID"
done
