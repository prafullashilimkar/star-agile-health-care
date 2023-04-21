resource "aws_instance" "test-server" {
  ami           = "ami-02eb7a4783e7e9317" 
  instance_type = "t2.medium" 
  key_name = "frstkey"
  vpc_security_group_ids= ["sg-0347106857582df29"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("frstkey.pem")
    # host     = self.public_ip
    host = aws_instance.instance.public_ip
   
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
   provisioner "remote-exec" {
     inline = [
               "sudo apt upadte -y",
               "sudo apt install docker.io -y",
               "sudo snap install microk8s --clasic",
               "sudo sleep 30",
               "sudo microk8s status",
               "sudo microk8s kubectl create deployment medicure-deploy --image=shankerchauhan/projects:healthcare1",
               "sudo microk8s kubectl expose deployment medicure-deploy --port=8082 --type=NodePort",
               "sudo microk8s kubectl get svc",
               "sudo echo public IP Address of the Instance",
               "sudo curl http://checkip.amazonaws.com",
       ]
   } 
}
