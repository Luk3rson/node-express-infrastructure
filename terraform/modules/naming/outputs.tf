output "id" {
  value       = "${join("", null_resource.default.*.triggers.id)}"
  description = "Disambiguated ID"
}

# Merge input tags with our tags.
# Note: `Name` has a special meaning in AWS and we need to disamgiuate it by using the computed `id`
output "tags" {
  value = "${
    merge(
      map(
        "Name", "${join("", null_resource.default.*.triggers.id)}",
      ), var.tags
    )
  }"

  description = "Normalized Tag map"
}

output "cf_friendly_tags" {
  value = "${
    list(
      map("Key", "Name", "Value", "${join("", null_resource.default.*.triggers.id)}"),
    )
  }"

  description = "Normalized Tag map"
}

# TODO: Add additional Tags to List
output "tag_list" {
  value = [{
    key                 = "Name"
    value               = "${join("", null_resource.default.*.triggers.id)}"
    propagate_at_launch = true
    }
  ]
}

output "cf_friendly_asg_tag_list" {
  value = [{
    Key               = "Name"
    Value             = "${join("", null_resource.default.*.triggers.id)}"
    PropagateAtLaunch = true
    }
  ]
}
