[![Actions Status - Master](https://github.com/juju4/ansible-memcapture/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-memcapture/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-memcapture/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-memcapture/actions?query=branch%3Adevel)

# Memory capture ansible role

A simple ansible role to install and execute live memory capture tools.

* [Rekall pmem suite (linux/macos/win)](https://github.com/google/rekall/releases)
* [Linux Lmg](https://github.com/halpomeranz/lmg)
* [Linux Fmem](http://hysteria.sk/~niekt0/foriana/fmem_current.tgz)
* [Microsoft AVML](https://github.com/microsoft/avml/)

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 1.9
 * 2.0
 * 2.2
 * 2.5
 * 2.8

### Operating systems

Tested on Ubuntu 14.04, 16.04 and 18.04, Centos 6 and 7.
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
$ time ansible-playbook -i inventory -e TARGETIP=myhost -e ROLE=memcapture -e memcapture_capture=true -e memcapture_pull=true -e dst_mount=/opt/tmp/cases -e memcapture_bin_path=/opt/tmp/ir-bin roles/run_role.yml
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

memcapture_bin_path: "/tmp/ir-bin"
```

* memcapture_bin_path: can be a network path or removable media. If local and
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
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```

Known bugs
* fmem is more fitted for older distribution and unmaintained it seems
* Travis CI is not testing execution as there is no kernel modules support
https://github.com/travis-ci/travis-ci/issues/2291

## Troubleshooting & Known issues

* Latest osxpmem from Velocidex is 3.2 but is in [deprecated kernel extension since macos 10.15](https://developer.apple.com/support/kernel-extensions/). A system extension option has yet to available.

* Linux/Macos volatility processing requires manual dwarf collection. See [Mac/Linux symbol tables](https://volatility3.readthedocs.io/en/stable/symbol-tables.html#mac-linux-symbol-tables) and [dwarf2json](https://github.com/volatilityfoundation/dwarf2json/)

* dwarf2json get killed. When under strace, it ends on futex syscall.

## License

BSD 2-clause
