alias ssh-aws="ssh -i '~/.ssh/aws.ragingwind@gmail.com.pem' ubuntu@52.79.163.166"

scp-aws() {
  scp -i "~/.ssh/aws.ragingwind@gmail.com.pem" $1 ubuntu@52.79.163.166:~/downloads
}

alias ssh-pps="ssh ubuntu@speech-temp.protopie.io -i ~/.ssh/ec2-xid-seoul.pem"

scp-pps() {
  scp -i "~/.ssh/ec2-xid-seoul.pem" ubuntu@speech-temp.protopie.io:$1 $2
}

alias gcp-pss="ssh gcp-xid-engine@35.200.78.237 -i ~/.ssh/gcp-xid-engine"

scp-arm() {
  scp pi@192.168.0.44:/home/pi/Workspace/protopie-connect/dist/pc-arm-$1.zip ./
}
