resource "helm_release" "argocd" {
  name = "argocd"

  repository = ""

  chart = "argo-cd"

  namespace = kubernetes_namespace.argocd.metadata[0].name

  create_namespace = false

  version = "8.4.5"

  timeout = 600

  depends_on = [ kubernetes_namespace ]
}

resource "kubectl_manifest" "argocd_projects" {
  for_each   = fileset("${path.module}/../argocd/projects", "*.yaml")
  yaml_body  = file("${path.module}/../argocd/projects/${each.value}")
  depends_on = [helm_release.argocd]
}

resource "kubectl_manifest" "argocd_apps" {
  for_each   = fileset("${path.module}/../argocd/applications", "*.yaml")
  yaml_body  = file("${path.module}/../argocd/applications/${each.value}")
  depends_on = [kubectl_manifest.argocd_projects]
}