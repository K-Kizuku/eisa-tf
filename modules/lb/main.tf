resource "google_compute_backend_service" "eisa_backend_service" {
  name      = "${var.common.prefix}-backend-service-eisa-${var.common.environment}"
  protocol  = "HTTP"
  port_name = "http"
  backend {
    group = var.eisa_service_url
  }
}

resource "google_compute_backend_service" "hoge_backend_service" {
  name      = "${var.common.prefix}-backend-service-hoge-${var.common.environment}"
  protocol  = "HTTP"
  port_name = "http"
  backend {
    group = var.hoge_service_url
  }
}


resource "google_compute_url_map" "url_map" {
  name = "${var.common.prefix}-cloud-run-url-map-${var.common.environment}"

  default_service = google_compute_backend_service.eisa_backend_service.self_link

  host_rule {
    hosts        = [var.lb.custom_domain]
    path_matcher = "path-matcher"
  }

  path_matcher {
    name            = "path-matcher"
    default_service = google_compute_backend_service.eisa_backend_service.self_link

    path_rule {
      paths   = ["/hoge"]
      service = google_compute_backend_service.eisa_backend_service.self_link
    }

    path_rule {
      paths   = ["/fuga"]
      service = google_compute_backend_service.hoge_backend_service.self_link
    }
  }
}

resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "${var.common.prefix}-https-proxy-${var.common.environment}"
  url_map          = google_compute_url_map.url_map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl_cert.self_link]
}

resource "google_compute_managed_ssl_certificate" "ssl_cert" {
  name = "${var.common.prefix}-ssl-cert-${var.common.environment}"
  managed {
    domains = [var.lb.custom_domain]
  }
}

resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  name       = "${var.common.prefix}-https-forwarding-rule-${var.common.environment}"
  target     = google_compute_target_https_proxy.https_proxy.self_link
  port_range = "443"
}