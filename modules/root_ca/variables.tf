variable "path" {
  description = "Path for the PKI mount"
  type        = string
  default     = "pki-root"
}

variable "common_name" {
  description = "Root CA common name"
  type        = string
}

variable "ttl" {
  description = "Certificate validity (in seconds)"
  type        = string
}

variable "default_lease_ttl" {
  description = "Default lease duration for certificate issuance (in seconds)"
  type        = string
}

variable "max_lease_ttl" {
  description = "Maximum lease duration for certificate issuance (in seconds)"
  type        = string
}

variable "key_bits" {
  description = "Key length (bits)"
  type        = number
  default     = 4096
}

variable "ou" {
  description = "Organizational Unit"
  type        = string
  default     = ""
}

variable "organization" {
  description = "Organization"
  type        = string
  default     = ""
}
