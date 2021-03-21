locals {
  command               = jsonencode(var.command)
  dnsSearchDomains      = jsonencode(var.dnsSearchDomains)
  dnsServers            = jsonencode(var.dnsServers)
  dockerLabels          = jsonencode(var.dockerLabels)
  dockerSecurityOptions = jsonencode(var.dockerSecurityOptions)
  entryPoint            = jsonencode(var.entryPoint)
  environment           = jsonencode(var.environment)
  extraHosts            = jsonencode(var.extraHosts)
  dependsOn             = jsonencode(var.dependsOn)

  healthCheck = var.healthCheck == null ? "{}" : replace(jsonencode(var.healthCheck), local.classes["digit"], "$1")

  links = jsonencode(var.links)

  linuxParameters = replace(
    replace(
      replace(jsonencode(var.linuxParameters), "/\"1\"/", "true"),
      "/\"0\"/",
      "false",
    ),
    local.classes["digit"],
    "$1",
  )

  logConfiguration = jsonencode(var.logConfiguration)

  mountPoints = replace(
    replace(jsonencode(var.mountPoints), "/\"1\"/", "true"),
    "/\"0\"/",
    "false",
  )

  portMappings = replace(jsonencode(var.portMappings), local.classes["digit"], "$1")

  resourceRequirements = jsonencode(var.resourceRequirements)
  secrets              = jsonencode(var.secrets)
  systemControls       = jsonencode(var.systemControls)

  ulimits = replace(jsonencode(var.ulimits), local.classes["digit"], "$1")

  volumesFrom = replace(
    replace(jsonencode(var.volumesFrom), "/\"1\"/", "true"),
    "/\"0\"/",
    "false",
  )


  classes = {
    digit = "/\"(-[[:digit:]]|[[:digit:]]+)\"/"
  }

  container_definition = format("%s", data.template_file.container_definition.rendered)

  container_definitions = replace(local.container_definition, "/\"(null)\"/", "$1")
}
