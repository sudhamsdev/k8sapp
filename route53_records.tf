resource "aws_route53_record" "alb_record" {
  zone_id = "Z0786225YHR50EIESQWB"
  name    = "k8sdevops.in"
  type    = "A"

  alias {
    name                   = aws_lb.react_alb.dns_name
    zone_id                = aws_lb.react_alb.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_ecs" {
  zone_id = "Z0786225YHR50EIESQWB"
  name    = "www.k8sdevops.in"
  type    = "CNAME"
  ttl     = 60
  records        = ["k8sdevops.in"]
}