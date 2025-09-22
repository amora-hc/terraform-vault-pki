variable "path" {
  description = "Path for intermediate PKI mount"
  type        = string
  default     = "pki-int"
}

variable "common_name" {
  description = "Intermediate CA common name"
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

variable "root_mount_path" {
  description = "Root CA mount path for signing"
  type        = string
}

variable "root_sign_common_name" {
  description = "Common Name used for signature (usually same as intermediate CA common name)"
  type        = string
}
