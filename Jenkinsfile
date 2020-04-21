node {
	stage('Checking out Repository...') {
  	 	sh 'echo "Check out git repo..."'
     	checkout scm
    } 
	stage('Installing Dependencies') {
  		sh 'echo "Installing Dependencies..."'
    	sh '''
      		python3 -m venv ~/.udacity-capstone
	  		source ~/.udacity-capstone/bin/activate
	  		make install
	 	'''
    } 
    stage ("Linting") {
    	sh 'echo "Linting..."'
    	docker.image('hadolint/hadolint:latest-debian').inside {
	        sh 'hadolint Dockerfile'
		}
	    sh 'pylint --disable=R,C,W1203 app.py'
	}
    stage('Build') {
		sh 'echo "Building Docker Image..."'
		docker.build('udacity-capstone')
		docker.withRegistry('51004051173.dkr.ecr.us-east-1.amazonaws.com/udacity-capstone', 'ecr:us-east-1:aws-capstone') {
			docker.image('udacity-capstone').push('latest')
		}
	}    
}