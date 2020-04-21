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
	 	sh 'wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 && chmod +x /bin/hadolint'
    } 
	stage('Lint') {
  		sh 'echo "Linting..."'
     	sh 'make lint'
    } 
    stage('Build') {
		sh 'echo "Building Docker Image..."'
		docker.build('udacity-capstone')
		docker.withRegistry('51004051173.dkr.ecr.us-east-1.amazonaws.com/udacity-capstone', 'ecr:us-east-1:aws-capstone') {
			docker.image('udacity-capstone').push('latest')
		}
	}    
}