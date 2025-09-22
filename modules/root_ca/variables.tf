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
  description = "Certificate validity (in hours)"
  type        = string
  default     = "87600h"
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
