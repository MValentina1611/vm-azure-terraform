variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "location" {
  description = "Ubicación donde se creará la VM"
  type        = string
}

variable "vm_size" {
  description = "El tamaño de la máquina virtual"
  type        = string
}

variable "admin_username" {
  description = "Nombre del usuario administrador"
  type        = string
}

variable "admin_password" {
  description = "Contraseña del usuario administrador"
  type        = string
}

variable "network_interface_id" {
  description = "ID de la interfaz de red"
  type        = string
}

variable "prefix" {
  description = "Prefijo para los nombres de los recursos"
  type        = string
}
