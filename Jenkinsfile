stage 'Checkout' 
 git 'https://github.com/jayjagtap007/ecs.git'


 stage ("Docker build") {
sh "docker build --no-cache -t nginx:${BUILD_NUMBER}" ."
}

stage("Docker push") {
docker.withRegistry('634842168668.dkr.ecr.ap-south-1.amazonaws.com/nginx', 'ecr:regopm:ecr-credentials') {
    docker.image("nginx:${BUILD_NUMBER}").push(remoteImageTag) 
    }
}

stage ("Deploy") {
sh "sed -e 's;BUILD_TAG;${BUILD_NUMBER};g' aws/task-definition.json >            aws/task-definition-${remoteImageTag}.json"


sh  "                                                                     \
      aws ecs register-task-definition  --family ${taskFamily}                \
                                        --cli-input-json ${taskDefile}        \
    "


  def taskRevision = sh (
      returnStdout: true,
      script: " aws ecs describe-task-definition  --task-definition  ${taskFamily} | egrep 'revision' | tr ',' ' '| awk '{print \$2}' "
 ).trim()



 sh  "                                                                     \
      aws ecs update-service  --cluster ${clusterName}                        \
                              --service ${serviceName}                        \
                              --task-definition ${taskFamily}:${taskRevision} \
                              --desired-count 1                               \
    "
 }
