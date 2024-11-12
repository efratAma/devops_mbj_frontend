#!/bin/bash

echo "Starting the deployment process..."
echo "Checking Git status..."  
git status   
if [ $? -ne 0 ]; then
    echo "Error: git status failed!"  
    exit 1
fi

# שלב 2: הוספת כל השינויים (סטייג'ינג)
echo "Staging all changes..."    
git add .    
if [ $? -ne 0 ]; then
    echo "Error: git add failed!"   
    exit 1
fi
commit_message="Automated commit message"
echo "Committing changes with message: $commit_message"    
git commit -m "$commit_message"    
if [ $? -ne 0 ]; then
    echo "Error: nothing in commit!"   
    exit 1
fi

# שלב 4: Push ל-GitHub
echo "Pushing changes to GitHub..."    
git push origin main    
if [ $? -ne 0 ]; then
    echo "Error: git push failed!"   
    exit 1
fi
echo "Installing dependencies..."    
npm install    
if [ $? -ne 0 ]; then
    echo "Error: npm install failed!"   
    exit 1
fi
echo "Building the app..."    
npm run build   
if [ $? -ne 0 ]; then
    echo "Error: npm run build failed!"  
    exit 1
fi
echo "Uploading build to Google Cloud Storage (GCS)..."   
gsutil cp -r build/* gs://miri-mann-bucket2/
if [ $? -ne 0 ]; then
    echo "Error: gcloud storage upload failed!"  
    exit 1
fi
echo "Deployment process completed successfully!"


export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"


chmod +x your_script.sh