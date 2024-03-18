#credentials

provider "azurerm" {
  features {}
  subscription_id = "d7289b80-6ddc-46a3-a9d0-35cb7499b95e"
  client_id       = "6c9dabe6-e238-485c-a97e-dbbdc5688e76"
  client_secret   = "QXV8Q~7yURtzo8qTS3KgoF_43bI_VAkJQ3ehgc9x"
  tenant_id       = "004beac5-0dc0-4a34-9fe4-2d0eb84b7021"
}

#datasource for VNET
data "azurerm_virtual_network" "vnet" {
  name                = "vnet-go-eas-pd-connnet-01"
  resource_group_name = "rg-go-eas-pd-connnet-01"
}

#create resourcegroup
resource "azurerm_resource_group" "rg" {
  name     = "rg-go-eas-pd-zpa-01"
  location = "eastasia"
}

#create subnet to existing vnet
resource "azurerm_subnet" "subnet" {
  name                 = "vnet-go-eas-pd-connnet-01-snet-zpa-ext-01"
  virtual_network_name = "vnet-go-eas-pd-connnet-01"
  resource_group_name  = "rg-go-eas-pd-connnet-01"
  address_prefixes     = ["10.55.192.128/28"]
}

#create public IP
resource "azurerm_public_ip" "pip" {
  name                = "pip-go-eas-pd-zpa-01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["1"]

}

#create nsg
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-vnet-go-eas-pd-connnect-01-snet-zpaac-int-01"
  location            = "eastasia"
  resource_group_name = "rg-go-eas-pd-connnet-01"

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#create NIC
resource "azurerm_network_interface" "nic" {
  name                = "vmgoeaspdzpa-A-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "vmgoeaspdzpa-A-nic-ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

#associate nsg to NC
resource "azurerm_network_interface_security_group_association" "nsgbind" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id

}

# Create (and display) an SSH key
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "VM" {
  name                  = "vmgoeaspdzpa-A"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_D4s_v5"
  zone                  = 1

  os_disk {
    name                 = "vmgoeaspddc02-OsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "zscaler"
    offer     = "zscaler-private-access"
    sku       = "zpa-con-azure"
    version   = "latest"
  }

  plan {
    name      = "zpa-con-azure"
    publisher = "zscaler"
    product   = "zscaler-private-access"
  }

  computer_name                   = "vmgoeaspdzpa-A"
  admin_username                  = "zsroot"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "zsroot"
    public_key = tls_private_key.key.public_key_openssh
  }

  tags = {
    Site                = "GO"
    ApplicationId       = "zpaac"
    ApplicationName     = "Zscaler Private Access Connector"
    ApplicationOwner    = "Varun"
    BusinessCriticality = "Standard"
    BusinessUnit        = "Cybersecurity"
    CostCenter          = "Group, Security"
    DataClassification  = "Restricted"
    Enviroment          = "PROD"
  }

}