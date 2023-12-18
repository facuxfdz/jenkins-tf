resource "aws_ebs_volume" "ebs" {
    availability_zone = aws_instance.jenkins.availability_zone
    size = 10
}

resource "aws_volume_attachment" "ebs_att" {
    device_name = "/dev/sdh"
    volume_id = aws_ebs_volume.ebs.id
    instance_id = aws_instance.jenkins.id
}