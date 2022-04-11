resource "kubernetes_manifest" "clusterissuer_letsencrypt_staging" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = "letsencrypt-staging"
    }
    "spec" = {
      "acme" = {
        "email"          = var.letsencrypt_email
        "preferredChain" = ""
        "privateKeySecretRef" = {
          "name" = "letsencrypt-staging"
        }
        "server" = "https://acme-staging-v02.api.letsencrypt.org/directory"
        "solvers" = [
          {
            "dns01" = {
              "azureDNS" = {
                "hostedZoneName"    = var.azure_zone_name
                "resourceGroupName" = var.azure_resource_group_name
                "subscriptionID"    = var.azure_subscription_id
              }
            }
            "selector" = {
              "matchLabels" = {
                "use-azuredns-solver" = "true"
              }
            }
          },
        ]
      }
    }
  }
}
