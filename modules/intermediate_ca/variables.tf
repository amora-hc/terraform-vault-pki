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
  description = "Certificate validity (in hours)"
  type        = string
  default     = "43800h"
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
