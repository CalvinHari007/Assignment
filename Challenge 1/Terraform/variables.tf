variable "project_id" {
  description = "The ID of the Google Cloud project"
  default     = "three-tier-en-build"
}

variable "region" {
  description = "The region in which to deploy the Google Cloud project"
  default     = "us-west1"
}

variable "region_zone" {
  description = "The region zone in which to deploy the Google Cloud project"
  default     = "us-west1-a"
}

variable "machine_type" {
  description = "The type of virtual machine "
  default     = "f1-micro"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
  default     = "~/.gcloud/gcloud_credentials.json"
}

variable "env_name" {
  description = "Env name - dev, prod, test."
  type        = string
  validation {
    condition     = length(var.suffix) <= 14
    error_message = "A max of 14 character(s) are allowed."
  }
}

variable "instance_id" {
  type        = string
  description = "A unique identifier for the instance, which cannot be changed after the instance is created."
}

variable "num_nodes" {
  type        = number
  description = "The number of nodes allocated to this instance. "
}

variable "instance_display_name" {
  type        = string
  default     = ""
  description = "The descriptive name for this instance as it appears in UIs. Must be unique per project and between 4 and 30 characters in length."
}

variable "config" {
  type        = string
  description = "Cloud Spanner Instance config - Regional / multi-region. For allowed configurations, check: https://cloud.google.com/spanner/docs/instances#available-configurations-regional"
  default     = "Regional"
}

variable "spanner_instance_timeout" {
  type        = string
  default     = "10m"
  description = "How long a Google Spanner Instance creation operation is allowed to take before being considered a failure."
}

variable "spanner_dbname" {
  type        = string
  description = "A unique identifier for the database, which cannot be changed after the instance is created."
}

variable "app_service_name" {
  type        = string
  description = "Name of Google Cloud Run Service that being created."

}

variable "firestore_id" {
  type      =string
}

variable "storage_size" {
  type      = number
  default   = 500
}


variable "container_image_path" {
  type        = string
  description = "Container Path of an application." // if using gcr, must be something: gcr.io/[PROJECT_NAME]/[APP]
}

variable "container_port" {
  type        = number
  default     = 8080
  description = "Port on which the container is listening for incoming HTTP requests."
}

variable "cloud_run_timeout" {
  type        = string
  default     = "20m"
  description = "How long a Cloud Run operation is allowed to take before being considered a failure."
}

#Variables for Front End

variable "source_url" {
  type        = string
  description = "Where application Front-End source code is"
}

variable "app_eng_port" {
  type        = number 
  default     = 80
  description = "Where Front-End listens for incoming requests"
}

variable "app_version" {
  type      = string
  default   = "v1"
}

variable "front_service_name" {
  type      = string
}

variable "front_runtime" {
  type      = string
}

variable "front_entrypoint" {
  type      = string
}