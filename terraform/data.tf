data "aws_subnet" "selected" {
  filter {
    name   = "tag:Tier"
    values = ["public"]
  }
}
