Балансировщик нагрузки: ip 51.250.74.144
Бэкенд 1: ip 89.169.129.1
Бэкенд 2: ip 89.169.155.210

Приватный ключ для входа: TESTTL\id_rsa
Пользователь: user

Конфигурация terraform: TESTTL\terraform3vm\main.tf

Inventory Ansible: TESTtravelline\ansilbe-projects\inventory.yml
Playbook Ansible: TESTtravelline\ansilbe-projects\playbook.yml

Код для развертывание инфраструктуры: https://github.com/pavel-kdp/TESTTL

По безопасности, у меня есть представление как сделать, но не уверен что правильно, вот что бы я сделал:
У бэкенда отключить доступ в интернет, оставить только внутреннюю сеть.
Оставить 443 и 80 у балансировщика, 80 оставить у бэкенда для общения с балансировщиком. 
