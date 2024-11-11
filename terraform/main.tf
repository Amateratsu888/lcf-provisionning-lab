resource "aws_instance" "lcf_lab_instance" {
  ami                    = "ami-017d8144c10ddee8b"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0dc9e8dfa932b826c", "sg-098c74f2829f977fb"]
  subnet_id              = "subnet-08a95a77a208359c2"
  key_name               = aws_key_pair.my_key_pair.key_name

  tags = merge(local.tags, {
    Name = "aws_instance_for_nginx"
  })
}
