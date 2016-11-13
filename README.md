## Ansible playbook to setup your Owncloud instance

This repo contains a `setup.yml`  playbook to setup:

* An nginx webserver serving traffic in https (thanks to a let's encrypt SSL cert)
* A PostgreSQL database
* A php-fpm application server with the [Owncloud](https://owncloud.org/) code base

## Dependencies

Roles are all taken from Ansible's public galaxy repositories. They are described in the `requirements.yml` file:

* nginx
* php-fpm
* postgresql
* cerbot

Install dependencies by

  make install
  
## Run

After changing your ` hosts` inventory to target your own hosts. You can setup everything by simply calling:

  make run playbook=setup
  
## License

See [MIT License file](https://gitlab.com/paulrbr/ansible-owncloud-setup/blob/master/LICENSE)