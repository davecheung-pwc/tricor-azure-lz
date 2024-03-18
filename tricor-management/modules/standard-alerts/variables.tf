# Input variable definitions
variable "action_group_id" {
  description = "Id of alert rule action group"
  type        = string
}

variable "site" {
  description = "Tricor site code e.g. HK, GO"
  type        = string
}

variable "subscription_name" {
  description = "Name of subscription to be monitored"
  type        = string
}

variable "subscription_id" {
  description = "Id of subscription to be monitored"
  type        = string
}

variable "locations" {
  description = "List of Azure region"
  type        = list(string)
}

variable "resource_group_name" {
  description = "Name of resource group to host the action group and alert rules"
  type        = string
}