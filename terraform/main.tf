terraform {
  backend "s3" {
    bucket = "testk8sdemo"
    key    = "k8s/demo/terraform.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}
provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_network_policy_v1" "app" {
  count = var.enable_network_policy ? 1 : 0

  metadata {
    name      = "allow-app"
    namespace = "default"
  }

  spec {
    pod_selector {
      match_labels = {
        app = "my-app"
      }
    }

    policy_types = ["Ingress"]

    ingress {
      from {
        pod_selector {
          match_labels = {
            app = "frontend"
          }
        }
      }
    }
  }
}