terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone     = "ru-central1-a"
  token    = "t1.9euelZrKmJ2elpqMys6RypiJjs6UlO3rnpWal46Skoycx8-Xi8bHy5qRnZbl8_dPU1tI-e9FFU8M_t3z9w8CWUj570UVTwz-zef1656VmpaWm4qTks6ZyM3HmJiNy4zP7_zN5_XrnpWakZSdx86KzcyOzM2Qypacj83v_cXrnpWalpabipOSzpnIzceYmI3LjM8.s-t0Enw_ZcqKNfPok4ZgU9EBQR6fflRB-as-HynKmspMKxWoQWwN06RFx5KIVn41uThLhcl4iY8xQKcYsqFYBg"
  folder_id = "b1glg70bmof2sv4vnguv"
}

resource "yandex_compute_instance" "vm" {
  count        = 3
  name         = "centos-vm-${count.index + 1}"
  zone         = "ru-central1-a"

  resources {
    cores        = 2
    core_fraction = 20
    memory       = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd88d018b9a937uli9bn" 
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = "e9bv5jac27pidjpijd6j"
    nat       = true
  }

  scheduling_policy {
    preemptible = true  
  }

  metadata = {
    user-data = <<-EOF
      #cloud-config
      users:
        - name: user
          groups: sudo
          shell: /bin/bash
          sudo: 'ALL=(ALL) NOPASSWD:ALL'
          ssh-authorized-keys:
            - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkP0JFeY57vYWcQJ3cSn+Gg1tfcG57TVTSbalRY2P9PruuSj6Mb8MiwQ0Q6Gb6ziS3p6v8o+YDRpIOUNxPfUfR/kQxjrUUtNvopY4e2FuN/FL8TE16+f1RmzUTBEgq0Y0gCew0XqKS41RbDQzC/CJ4Fr9i4dJfhfxcbJYjHqKP0jtqCnThX2tRLAlhFQlO3DdaTdi90XgOqhdqLEibjVWODFKDUc1c6yeCOgfceS+CY9KrBc4ftXku02D71RypjOHeLtQ1bfy2MPEvoeJerk1KEipz+W9FeciGt+VDtGsGimuzvKsEgT5vmwx+kEn18PO6zEqbuCZz+9DC+ZfwsGl8b6txXtTSdCMa2I+KL4lVgLngqKI56FXApuuqCiNFMh+eMZ2I3/WqEazDV/2ph9MPR0L+Cbg5CWZcRf9fnviTmqxuApe1YPhDMrKjDbdRFobyFVqfNG4T5cC0VYpuvPCo689JdLkAlDfIHpyG85/PAZE8bO5chRSOxcX9K/i0Rdk= bakhtinpa@ws01
      EOF
  }