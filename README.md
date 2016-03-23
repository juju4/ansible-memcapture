[![Build Status](https://travis-ci.org/juju4/ansible-memcapture.svg?branch=master)](https://travis-ci.org/juju4/ansible-memcapture)
# Memory capture ansible role

A simple ansible role to install and execute live memory capture tools.
Rekall pmem suite https://github.com/google/rekall/releases
Linux Lmg https://github.com/halpomeranz/lmg
Linux Fmem http://hysteria.sk/~niekt0/foriana/fmem_current.tgz

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9
 * 2.0

### Operating systems

Tested initially with vagrant on Ubuntu 14.04
Verified with kitchen

## Example Playbook

Just include this role in your list.
For example

```
- host: myhost
  roles:
    - memcapture
```

you probably want to review variables


## Variables

```
prefix: "{{ ansible_fqdn }}"
dst_mount: "/tmp/cases"
dst_path: "{{ dst_mount }}/{{ prefix }}-incidentreport"

## do we want to install new packages? might be required if building kernel module for example
## allow ansible to download stuff which does not exist, eventually build it?
## more impacting the evidence but sometimes have no choice...
do_download: true
do_build: true
do_install: true

bin_path: "/tmp/ir-bin"
```

* bin_path: can be a network path or removable media. If local and 
  download/build/install is enabled, the role will add everything necessary.
  Of course, from a forensic perspective, better if everything is setup either
  before locally (but can be altered) or a network read-only share
* dst_path: where to store the output. again, came be local or remote.

## Continuous integration

you can test this role with test kitchen.
In the role folder, run
```
$ kitchen verify
```

Known bugs
* fmem is more fitted for older distribution and unmaintained it seems

## Troubleshooting & Known issues

N/A

## License

BSD 2-clause


