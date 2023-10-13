variable "region_code" {
    description = "Provide Region code to run resources"
    type = string
    default = "us-east-1"
}

variable "s3_policy_name" {
    description = "Provide S3 bucket IAM policy name"
    type = string
    default = "k8sapps3policy"
}

variable "ssm_policy_name" {
    description = "Provide SSM policy name"
    type = string
    default = "k8sappssmpolicy"
}

variable "cw_policy_name" {
    description = "Provide CloudWatch policy name"
    type = string
    default = "k8sappcwlogpolicyname"
}

variable "task_role_name" {
    description = "Provide k8sapp Task role name for app deployment"
    type = string
    default = "k8sapprole"
}

variable "alb_sg_name" {
    description = "Provide ALB Security group resource name for K8SEngineers app"
    type = string
    default = "k8sappalbsecurity"
}

variable "react_svc_sg_name" {
    description = "Provide ReactJS application security group name"
    type = string
    default = "k8sappreactsecurity"
}

variable "node_svc_sg_name" {
    description = "Provide NodeJS application security group name"
    type = string
    default = "k8sappnodesecurity"
}

variable "alb_name" {
    description = "Provide ALB name for K8SEngineers app"
    type = string
    default = "k8sappalb"
}

variable "rjs_targetgroup_name" {
    description = "Provide ReactJS targetgroup name for ALB"
    type = string
    default = "ks8appreactgroup"
}

variable "njs_targetgroup_name" {
    description = "Provide NodeJS targetgroup name for ALB"
    type = string
    default = "ks8appnodegroup"
}

variable "node_task_name" {
    description = "Provide NodeJS task definition name"
    type = string
    default = "k8sappnode"
}

variable "node_service_name" {
    description = "Provide Node Service name"
    type = string
    default = "k8sappnode"
}

variable "node_container_name" {
    description = "Provide NodeJS container name as per task definition"
    type = string
    default = "k8snode"
}

variable "react_task_name" {
    description = "Provide ReactJS task definition name"
    type = string
    default = "k8sappreact"
}

variable "react_service_name" {
    description = "Provide React Service name"
    type = string
    default = "k8sappreact"
}

variable "react_container_name" {
    description = "Provide ReactJS container name as per task definition"
    type = string
    default = "k8sreact"
}

locals {
  common_tags = {
    "Environment" = "Production"
    "Type" = "Fullstack"
  }
}