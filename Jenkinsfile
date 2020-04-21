pipeline {
	agent any
	environment {
		REPO = "451004051173.dkr.ecr.us-east-1.amazonaws.com"
		IMAGE = "udacity-capstone"
	}
	stages {
		stage('Checking out Repository...') {
              steps {
              	  sh 'echo "Check out git repo..."'
                  checkout scm
              }
        } 
		stage('Lint Dockerfile...') {
			  agent {
			  	image 'hadolint/hadolint:latest-debian'
			  }
              steps {
              	  sh 'echo "Linting..."'
                  sh 'hadolint Dockerfile'
              }
        } 
         stage('Build') {
			steps {
				sh 'echo "Building Docker Image..."'
				withAWS(region:'us-east-1',credentials:'aws-capstone') {
					sh '''
						echo "ECR URI and Image: ${REPO}"
						aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${REPO}
						echo "Building the image..."
						docker build -t ${IMAGE} .
						echo "Tagging the image..."
						docker tag ${IMAGE}:latest ${REPO}:latest
						echo 'Pushing the image to ECR..."
						docker push ${REPO}:latest
					'''
				}
			}
		}    
	}
}