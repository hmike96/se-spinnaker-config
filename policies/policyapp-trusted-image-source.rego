# enforce containers deployed are from "trusted" registry
package opa.pipelines

deny[msg] {
  input.pipeline.application == "policyapp"
  stages := [s | s:=input.pipeline.stages[_]; s.type == "deployManifest"]
  images := stages[_].manifests[_].spec.template.spec.containers[_].image
  not startswith(images, "away168")
  not startswith(images, "justinrlee")
  msg := sprintf("PolicyApp requires image(s): [%v] being deployed to be from a trusted registry (away168 or justinrlee)", [images]) 
}