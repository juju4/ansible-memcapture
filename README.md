[![Build Status - Master](https://travis-ci.org/juju4/ansible-memcapture.svg?branch=master)](https://travis-ci.org/juju4/ansible-memcapture)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-memcapture.svg?branch=devel)](https://travis-ci.org/juju4/ansible-memcapture/branches)
# Memory capture ansible role

A simple ansible role to install and execute live memory capture tools.
Rekall pmem suite (linux/macos/win) https://github.com/google/rekall/releases
Linux Lmg https://github.com/halpomeranz/lmg
Linux Fmem http://hysteria.sk/~niekt0/foriana/fmem_current.tgz

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9
 * 2.0
 * 2.2

### Operating systems

Tested initially with vagrant on Ubuntu 14.04
Verified with kitchen

## Example Playbook

Just include this role in your list.
For example

```
- host: myhost
  roles:
    - juju4.memcapture
```

you probably want to review variables

Example of execution
```
$ time ansible-playbook -i inventory -e TARGETIP=myhost -e ROLE=memcapture -e memcapture_capture=true -e memcapture_pull=true -e dst_mount=/opt/tmp/cases -e bin_path=/opt/tmp/ir-bin roles/run_role.yml
```

Volatility profile is generated in the following cases:
* lmg
* osxpmem, only if Apple Kernel Debug Kit is installed (not default)

## Variables

```
prefix: "{{ ansible_fqdn }}"
dst_mount: "/tmp/cases"
dst_path: "{{ dst_mount }}/{{ prefix }}-incidentreport"

## do we want to install new packages? might be required if building kernel module for example
## allow ansible to download stuff which does not exist, eventually build it?
## more impacting the evidence but sometimes have no choice...
memcapture_download: true
memcapture_build: true
memcapture_install: true

bin_path: "/tmp/ir-bin"
```

* bin_path: can be a network path or removable media. If local and 
  download/build/install is enabled, the role will add everything necessary.
  Of course, from a forensic perspective, better if everything is setup either
  before locally (but can be altered) or a network read-only share
  Ensure mount path has not noexec mount flags, for example /tmp.
* dst_path: where to store the output. again, came be local or remote.

## Continuous integration

you can test this role with test kitchen or travis.
```
$ cd /path/to/roles/juju4.memcapture
$ kitchen verify
$ kitchen login
```

Known bugs
* fmem is more fitted for older distribution and unmaintained it seems
* Travis CI is not testing execution as there is no kernel modules support
https://github.com/travis-ci/travis-ci/issues/2291

## Troubleshooting & Known issues

N/A

## License

BSD 2-clause


