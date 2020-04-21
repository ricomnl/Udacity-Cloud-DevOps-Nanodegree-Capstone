pipeline {
	agent { 
		docker { 
			label 'dockerserver'
			image 'python:3.7.3-stretch' 
		} 
	}
	stages {
		stage('Checking out Repository...') {
              steps {
              	  sh 'echo "Check out git repo..."'
                  checkout scm
              }
        } 
		stage('Installing Dependencies') {
              steps {
              	  sh 'echo "Installing Dependencies..."'
                  sh '''
                  		python3 -m venv ~/.udacity-capstone
				  		source ~/.udacity-capstone/bin/activate
				  		make install
				  '''
              }
        } 
		stage('Lint') {
              steps {
              	  sh 'echo "Linting..."'
                  sh 'make lint'
              }
        } 
         stage('Build') {
			steps {
				sh 'echo "Building Docker Image..."'
				withAWS(region:'us-east-1',credentials:'aws-capstone') {
					sh '''
						REPO=451004051173.dkr.ecr.us-east-1.amazonaws.com/udacity-capstone
						echo "ECR URI and Image: $REPO"
						aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $REPO
						echo "Building the image..."
						docker build -t udacity-capstone .
						echo "Tagging the image..."
						docker tag udacity-capstone:latest $REPO:latest
						echo 'Pushing the image to ECR..."
						docker push $REPO:latest
					'''
				}
			}
		}    
	}
}