# Vault HA with integrated storage on AWS

This project is an implementation of [Andre's great module](https://github.com/andrefcpimentel2/terraform-vault-raft-ha)

this takes a couple of minutes to get up and running correctly but should leave you with an 

### Terraform Variables

```bash
# Module Configuration Variables
zone_id="<AWS_ZONE53_ZONE_ID>"
license_file="<VAULT_ENT_LICENSE_TEXT>"
namespace="guyvault"
owner="guybarros"
```

### Terraform Outputs

the Terraform code outputs what you need to run this session, including the URL to access the Consul UI and a facilitator to ssh into each of the boxes.
```bash
Apply complete! Resources: 36 added, 0 changed, 0 destroyed.

Outputs:


endpoints = 
  vault_transit (3.8.126.208) | internal: (10.0.1.21)
    - Initialized and unsealed.
    - The root token creates a transit key that enables the other Vaults to auto-unseal.
    - Does not join the High-Availability (HA) cluster.

  vault_leader (3.8.49.29) | internal: (10.0.1.22)
    - Initialized and unsealed.
    - The root token and recovery key is stored in /tmp/key.json.
    - K/V-V2 secret engine enabled and secret stored.
    - Leader of HA cluster
    $ ssh -l ubuntu 3.8.49.29 -i ~/.ssh/id_rsa.pub
    # Root token:
    $ ssh -l ubuntu 3.8.49.29 -i ~/.ssh/id_rsa.pub "cat ~/root_token"
    # Recovery key:
    $ ssh -l ubuntu 3.8.49.29 -i ~/.ssh/id_rsa.pub "cat ~/recovery_key"

  vault_3 (3.8.156.170) | internal: (10.0.1.23)
    - Started
    $ ssh -l ubuntu 3.8.156.170 -i ~/.ssh/id_rsa.pub

  vault_4 (18.130.180.207) | internal: (10.0.1.24)
    - Started
    $ ssh -l ubuntu 18.130.180.207 -i ~/.ssh/id_rsa.pub

  Vault LB for GUI HTTPS:
  https://vault.guyvault.guy.aws.hashidemos.io:8200
```

---

## Running the demo

### Pre requisites

there is a little bit of a set up that we need to be able to run this demo. namely, start mongodb and start the Chat application.
