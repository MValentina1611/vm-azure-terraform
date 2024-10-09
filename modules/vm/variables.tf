variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
  default     = "distri-castro"
}

variable "location" {
  description = "Ubicación donde se creará el recurso"
  type        = string
  default     = "West Europe"
}

variable "vm_size" {
  description = "El tamaño de la máquina virtual"
  type        = string
  default     = "Standard_F2"
}

variable "admin_username" {
  description = "Nombre del usuario administrador para la VM"
  type        = string
  default     = "user_admin"
}

variable "admin_password" {
  description = "Contraseña del usuario administrador"
  type        = string
  default     = "Admin123456$"
}

variable "vnet_name" {
  description = "El nombre de la red virtual"
  type        = string
  default     = "mi-vnet"
}

variable "subnet_name" {
  description = "El nombre de la subred"
  type        = string
  default     = "mi-subnet"
}
