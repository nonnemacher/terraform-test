provider "google" {
    credentials = "${GCLOUD_PROJECT_KEY}"
    project     = "${GCLOUD_PROJECT_ID}"  
    region      = "us-central1"
}

resource "google_container_cluster" "primary" {
  name               = "kuberntes-primary"
  zone               = "us-central1-a"
  initial_node_count = 3

  additional_zones = [
    "us-central1-b",
    "us-central1-c",
  ]

  master_auth {
    username = "teste"
    password = "teste"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      foo = "bar"
    }

    tags = ["foo", "bar"]
  }
}

# The following outputs allow authentication and connectivity to the GKE Cluster.
output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}