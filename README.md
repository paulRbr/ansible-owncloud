## Ansible playbook to setup your Owncloud instance

This repo contains a `setup.yml`  playbook to setup:

* An nginx webserver serving traffic in https (thanks to a let's encrypt SSL cert)
* A PostgreSQL database
* A php-fpm application server with the [Owncloud](https://owncloud.org/) code base

The best way to use it is to fork it and adapt it for your own hosts infrastructure.

## Dependencies

Roles are all taken from Ansible's public galaxy repositories. They are described in the `requirements.yml` file:

* nginx
* php-fpm
* postgresql
* cerbot

Install dependencies by

    make install

## Prepare

You will need to change mainly two things:

* your `hosts` inventory to target your own hosts.

```
edit hosts
```

* adapt the related `host_vars`. Typically the postgresql admin password.

## Secrets

I personnaly manage secrets thanks to [`pass`](https://www.passwordstore.org/) so the password is automatically taken from my store using the `pass-hosts.sh` script.

In order to vault your secrets you will thus need to adapt this file to output your vault passphrase

    edit pass-hosts.sh

## Run

You can now setup everything by simply calling:

    make run playbook=setup
  
## License

See [MIT License file](https://gitlab.com/paulrbr/ansible-owncloud-setup/blob/master/LICENSE)
