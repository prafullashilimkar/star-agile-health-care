resource "aws_instance" "test-server" {
  ami           = "ami-02eb7a4783e7e9317" 
  instance_type = "t2.medium" 
  availability_zone = "ap-south-1a"
  vpc_security_group_ids= [aws_security_group.my_sg.id]
  key_name = "serverkey"
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("serverkey.pem")
    host     = self.public_ip
  }  
  
  tags = {
    Name = "test-server"
  }
  
  }
   provisioner "remote-exec" {
     inline = [
               "sudo apt upadte -y",
               "sudo apt install docker.io -y",
               "sudo snap install microk8s --clasic",
               "sudo sleep 30",
               "sudo microk8s status",
               "sudo microk8s kubectl create deployment medicure-deploy --image=prafullla/healthcare-app:latest",
               "sudo microk8s kubectl expose deployment medicure-deploy --port=8084 --type=NodePort",
               "sudo microk8s kubectl get svc",
               "sudo echo public IP Address of the Instance",
               "sudo curl http://checkip.amazonaws.com",
       ]
   } 
}
