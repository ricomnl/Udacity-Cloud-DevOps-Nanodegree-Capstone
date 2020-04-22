pipeline {
	agent any
	environment {
		REPO = "https://451004051173.dkr.ecr.us-east-1.amazonaws.com"
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
					 	docker.image("${IMAGE}").push('latest')
					}
				}
			}
		}
		stage('Deploying') {
      		steps {
          		sh 'echo "Deploying to AWS..."'
	            withAWS(credentials: 'aws-capstone', region: 'us-east-1') {
	                sh 'aws eks --region us-east-1 update-kubeconfig --name CapstoneEKS-Oln500r9NoXs'
	                sh 'kubectl apply -f "aws/aws-auth-cm.yml"'
	                sh 'kubectl set image deployments/udacity-capstone udacity-capstone="${REPO}/${IMAGE}:latest"'
	                sh 'kubectl apply -f "aws/app-deployment.yml"'
	            	sh 'kubectl get nodes'
            		sh 'kubectl get pods'
        		}
        	}
        }
	}
}