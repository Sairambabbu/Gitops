resource "helm_release" "alb_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.13.3"

  values = [
    yamlencode({
      clusterName = var.cluster_name
      serviceAccount = {
        create = false
        name   = kubernetes_service_account.alb_controller.metadata[0].name
      }
      region       = var.aws_region
      vpcId        = module.vpc.vpc_id
      ingressClass = "alb"
      nodeSelector = {
        "eks.amazonaws.com/capacityType" = "ON_DEMAND"
      }
      tolerations = [
        {
          key               = "node.kubernetes.io/not-ready"
          operator          = "Exists"
          effect            = "NoExecute"
          tolerationSeconds = 300
        },
        {
          key               = "node.kubernetes.io/unreachable"
          operator          = "Exists"
          effect            = "NoExecute"
          tolerationSeconds = 300
        }
      ]
    })
  ]

  depends_on = [
    aws_eks_cluster.this, # EKS must exist
    aws_iam_role_policy_attachment.alb_ingress_attach,
    kubernetes_service_account.alb_controller # IRSA must exist
  ]
}
