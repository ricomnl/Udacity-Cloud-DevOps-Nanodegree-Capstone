node {
	def REPO = '51004051173.dkr.ecr.us-east-1.amazonaws.com'
	def IMAGE = 'udacity-capstone'
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
    	sh 'source ~/.udacity-capstone/bin/activate'
	    sh 'pylint --disable=R,C,W1203 app.py'
	}
    stage('Build') {
		sh 'echo "Building Docker Image..."'
		sh '''
			docker build -t ${IMAGE} .
			docker tag ${IMAGE}:latest ${REPO}:latest
		'''
		withAWS(region:'us-east-1',credentials:'aws-capstone') {
			sh 'docker push ${REPO}:latest'
		}
	}    
}

