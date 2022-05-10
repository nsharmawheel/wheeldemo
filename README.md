# wheeldemo
demo code for terraform deployment

## PREREQS

* aws credentials/profile for account in question
* terraform

## Initialize

Begin by creating you network resources first (the vpc module), update the demo-eks.tf to name the cluster you INTEND to create

```bash
terraform apply -target="module.vpc"
```
This allows us to prescriptively define the subnets and security groups our cluster will be using, which allows us to use terraform not just for templates of dynamic resource creation, but as a static source of truth of what is defined and deployed (and allows us to use git to detail versioning history)

**NOTE ** I know this is an unpopular opinion , however this motivation is to create the smallest changes as possible as clearly as possible

## Deployment

Now we can build the cluster. Update the demo-eks.tf file with the specified vpc configurations, which will include subnets for eks (public), subnets for fargate (private), the security groups, and the cluster name

```bash
terraform apply -target="module.eks"
```

## Caveat

You will need to update the coredns annotations because of a bug in the terraform driver for eks, before the cluster will deploy them. Those instructions can be found in the kube-deployments repo
