# Laboratorio: VM en Azure con Terraform

## Introducción
En esta práctica, desplegamos una máquina virtual (VM) en Azure usando Terraform. El objetivo es comprender el uso de Terraform como herramienta de IaC (Infraestructura como Código), permitiendo la automatización y gestión eficiente de recursos en la nube. Se incluyen la creación de una red virtual, una subred, un grupo de seguridad de red, y la configuración de una máquina virtual Ubuntu.

---

## Configuración de la Infraestructura

### Proveedor de Azure
Utilizamos el **provider** de `azurerm` para interactuar con los recursos de Azure. Este se define con las siguientes características:

```hcl
provider "azurerm" {
  features {}
  subscription_id = ""
}
```
El `subscription_id` especifica el identificador de la suscripción de Azure donde se crearán los recursos.

### Grupo de Recursos
El primer recurso creado es un **Resource Group** en la región de "West Europe", donde se agruparán todos los componentes de la infraestructura:

```hcl
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
```

### Red Virtual y Subred
Se crea una **red virtual** para conectar los recursos dentro de un rango de IP específico. Dentro de esta red, se define una subred para la VM:

```hcl
resource "azurerm_virtual_network" "vnet" {
  name          = var.vnet_name
  address_space = ["10.0.0.0/16"]
  location      = azurerm_resource_group.rg.location
}

resource "azurerm_subnet" "subnet" {
  name           = var.subnet_name
  address_prefixes = ["10.0.1.0/24"]
}
```

### Seguridad de Red
El **Network Security Group (NSG)** establece reglas de seguridad, permitiendo conexiones SSH (puerto 22):

```hcl
resource "azurerm_network_security_group" "nsg" {
  security_rule {
    name     = "SSH"
    priority = 1000
    protocol = "Tcp"
    access   = "Allow"
    direction = "Inbound"
    destination_port_range = "22"
  }
}
```

---

## Configuración de la Máquina Virtual

### Interfaz de Red y IP Pública
Se configura la interfaz de red y se asigna una IP pública estática para acceder a la VM desde el exterior:

```hcl
resource "azurerm_public_ip" "public_ip" {
  name              = "${var.prefix}-public-ip"
  allocation_method = "Static"
}

resource "azurerm_network_interface" "nic" {
  ip_configuration {
    subnet_id            = azurerm_subnet.subnet.id
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}
```

### Creación de la Máquina Virtual
Finalmente, la máquina virtual se configura con una imagen de Ubuntu 18.04-LTS. Se establecen las credenciales de acceso (usuario y contraseña) y se selecciona el tipo de disco y tamaño de la máquina:

```hcl
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.prefix}-vm"
  vm_size               = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
}
```

---

## Conexión a la VM
Una vez completada la creación de la infraestructura, se puede conectar a la VM mediante SSH usando la IP pública:

```bash
ssh user_admin@<public_ip>
```
### Conexión por ssh
![](docs/connect)

![](docs/connect2)

### Virtual Machine en Azure

![](docs/vm)

![](docs/vm2)

---

## Conclusión
En esta práctica, desplegamos exitosamente una máquina virtual en Azure utilizando Terraform. Este proceso nos permitió automatizar la creación de recursos de red y seguridad, facilitando el despliegue de infraestructura repetible y escalable. Conectar y gestionar la VM por SSH fue el paso final para validar el éxito de la configuración.

---
