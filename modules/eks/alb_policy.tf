#create policy that k8s service account will bind to
resource "aws_iam_policy" "alb-policy" {
  name        = "ALBIngressControllerIAMPolicy"
  description = "policy required for eks albs to launch"
  policy      = file("modules/eks/policies/alb_policy.json")
}
