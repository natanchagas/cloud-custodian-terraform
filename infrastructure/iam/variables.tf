variable "role" {
    type = object({
        name = string
        trust_policy = string
  })
}

variable "policy" {
    type = object({
        name = string
        policy = string
  })
}