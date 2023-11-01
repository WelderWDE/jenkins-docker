pipeline {
    agent any
    environment {
        USER = credentials('DOCKER_USER')
        PASS = credentials('DOCKER_PASS')
        HOST_USER = credentials('HOST_USER')
        HOST = credentials('HOST')
    }

    stages {
        stage('build image') {
            steps {
                sh('docker image build -t welderwd/test-apache:$BUILD_NUMBER .')
            }
        }
        stage('push container') {
            steps {
                sh '''docker login -u $USER -p $PASS;
                docker push welderwd/test-apache:$BUILD_NUMBER;
                '''
            }
        }
        stage('deploy container') {
            steps {
sh '''ssh -i ~/.ssh/id_rsa -tt ${HOST_USER}@${HOST} << EOF 

docker container stop test_apache;
docker container rm test_apache;
docker image rm -f $(docker image ls -aq)

docker pull welderwd/test-apache:$BUILD_NUMBER;
docker container run -d --name "test_apache" -p 8088:80 welderwd/test-apache:$BUILD_NUMBER;
exit;
EOF'''
            }
        }
    }
}