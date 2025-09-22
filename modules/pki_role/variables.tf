variable "pki_mount_path" {
  description = "Path to the PKI backend (intermediate)"
  type        = string
}

variable "role_name" {
  description = "PKI role name"
  type        = string
}

variable "allowed_domains" {
  description = "Allowed domains for certs"
  type        = list(string)
}

variable "issuing_certificates" {
  description = "URLs for issuing certs"
  type        = list(string)
  default     = []
}

variable "crl_distribution_points" {
  description = "URLs for CRL distribution"
  type        = list(string)
  default     = []
}

# Optional: cert issuance
variable "issue_cert" {
  description = "Whether to request a cert"
  type        = bool
  default     = false
}

variable "common_name" {
  description = "CN for a test cert (optional)"
  type        = string
  default     = ""
}

variable "ttl" {
  description = "TTL for issued certificate"
  type        = string
  default     = 31536000  // 1 year
}

variable "key_type" {
  description = "Key type (rsa, ec)"
  type        = string
  default     = "rsa"
}

variable "key_bits" {
  description = "Key size"
  type        = number
  default     = 4096
}

variable "key_usage" {
  description = "List of key usages"
  type        = list(string)
  default     = []
}

variable "ext_key_usage" {
  description = "List of extended key usages (EKUs)"
  type        = list(string)
  default     = []
}

variable "allow_any_name" {
  description = "Allow any certificate name? (for clientAuth)"
  type        = bool
  default     = false
}

