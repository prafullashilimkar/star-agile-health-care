 resource "aws_instance" "deployment-server" {
 ami = "ami-02eb7a4783e7e9317"
 instance_type = "t2.medium"
 availability_zone = "ap-south-1"
 vpc_security_group_ids = "sg-08285106aef78eb40"
 key_name = "jenkinskey1"
 tags = {
 name = "kubernetes_instance"
 }
 provisioner "remote-exec" {
 inline = [
 "sudo apt-get update -y",
 "sudo apt-get install docker.io -y",
 "sudo wget https://storage.googleapis.com/minikube/releases/latest/minikube-linuxamd64",
 "sudo chmod +x /home/ubuntu/minikube-linux-amd64",
 "sudo cp minikube-linux-amd64 /usr/local/bin/minikube",
 "curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s 
  https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl",
 "sudo chmod +x /home/ubuntu/kubectl",
 "sudo cp kubectl /
 

