{% set host = grains['host'] %}
{% set init = [grains['name_prefix'], '01']|join %}

install_qdevice_packages:
    pkg.latest:
        - pkgs:
            - crmsh
            - expect
            - corosync-qdevice

copy_sshkey_qdevice:
    cmd.run:
        - name: expect -f /tmp/salt/copy_sshkey_qdevice {{grains['qdevice_ip']}}

{% if host == init %}
corosync_qdevice:
    cmd.run:
        - name: crm cluster init qdevice --qnetd-hostname={{grains['qdevice_ip']}} -y
{% endif %}