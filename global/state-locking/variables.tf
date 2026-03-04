variable "bucket_name"{
    default = "multi-env-statelock-bucket"
    type = string
}

variable "table_name"{
    default = "multi-env-statelock-table"
    type = string
}

variable "region"{
    default = "us-east-2"
    type = string
}