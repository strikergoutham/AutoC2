resource "aws_key_pair" "pubkey" {
  key_name   = "pubkey"
  public_key = file(var.PUBLIC_KEY)
}

resource "aws_instance" "deployc2" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = aws_key_pair.pubkey.key_name
  

    provisioner "file" {
    source      = "docker_delivery.rc"
    destination = "/tmp/docker_delivery.rc"
  }

   provisioner "remote-exec" {
    inline = [
      "chmod +rwx /tmp/docker_delivery.rc",
      "sudo sed -i 's/AWS_IP/${aws_instance.deployc2.public_ip}/g' /tmp/docker_delivery.rc"
      
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PRIVATE_KEY)
  }

   provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i '${self.public_ip},' --private-key ${var.PRIVATE_KEY} playbook_deployc2.yml" 
  }


}

  output "C2_IP" {
  value = aws_instance.deployc2.public_ip
}
