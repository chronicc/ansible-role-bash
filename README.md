# Ansible Role: nebula

![pre-commit](https://github.com/chronicc/ansible-role-nebula/actions/workflows/pre-commit.yml/badge.svg?branch=main)
![molecule](https://github.com/chronicc/ansible-role-nebula/actions/workflows/molecule.yml/badge.svg?branch=main)

Setup slackhq/nebula and manage certificates with autorenewal and revoking targets.

## Requirements

- github3.py >= 1.0.0a3

## Role Variables

ToDo

## Dependencies

None.

## Example Playbook

The role must always be run against all nodes that are part of the nebula network in one run. Otherwise the role can not reliable determine the ca and all lighthouses which will lead to a broken configuration.

```yaml
---
- name: Setup the nebula network.
  hosts: nebula
  become: yes
  roles:
    - role: chronicc.nebula
```

# Credits

This role was inspired by [utkuozdemir/ansible-role-nebula](https://github.com/utkuozdemir/ansible-role-nebula). However I wanted to have a role that is leaning more towards automating all processes related to nebula.

# License

MIT / BSD

# Author Information

This role was created in 2023 by [Kurt Thomas Steinert](https://www.linkedin.com/in/contact-steinert/).
