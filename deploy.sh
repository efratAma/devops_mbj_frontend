#!/bin/bash

# Check for changes
git status -s

# If there are changes, stage them, commit, and push
if [ $? -eq 0 ]; then
  git add .
  git commit -m "Automated commit"
  git push origin main
fi

npm install
npm run build


gsutil cp -r build/ gs://your-bucket-name

#!/bin/bash

# ... (שאר הקוד שלך)

# טיפול בשגיאות ולוגים
function handle_error() {
  error_message="$1"
  echo "$(date +"%Y-%m-%d %H:%M:%S") - ERROR: $error_message" >> error.log
  exit 1
}

# דוגמה לשימוש בפונקציה:
if ! git push origin main; then
  handle_error "Failed to push to GitHub"
fi

chmod +x your_script.sh