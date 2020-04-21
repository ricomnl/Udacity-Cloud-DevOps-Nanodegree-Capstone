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
			  	docker {
			  		image 'hadolint/hadolint:latest-debian'
			  	}
			  }
              steps {
              	  sh 'echo "Linting..."'
                  sh 'hadolint Dockerfile'
              }
        } 
         stage('Build') {
			steps {
				sh 'echo "Building Docker Image..."'
				script {
					docker.withRegistry("${REPO}", "ecr:us-east-1:aws-capstone") {
					 	docker.image("${udacity-capstone}").push()
					}
				}
			}
		}    
	}
}