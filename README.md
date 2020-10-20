# terraform-ansible-docker
Subir duas instâncias na AWS usando terraform e instalar o MySQL em uma e o Wordpress na outra via Docker, usando Ansible.

### Configurar AWS CLI

Criar um usuário na AWS e configurar a AWS CLI para que o terraform consiga se conectar e realizar o deploy da infraestrutura. Usar o `aws configure` passando as credenciais do usuário para realizar a configuração.

### Execução Terraform

```bash
cd terraform
terraform plan
terraform apply
```
### Execução do Ansible

Logo após ter criado toda a infraestrutura com o Terraform, podemos configurar os hosts via Ansible. A primeira instância ficará com o MySQL e a segunda com o Wordpress.

Para isso deve-se alterar o arquivo `hosts` com os respectivos IP's públicos das máquinas. No arquivo `playbook.yml` devemos passar o IP da máquina onde será instalado o banco dados na variável `ip_banco`.

Podemos configurar nosso arquivo de configuração do ansible para que não requisite o fingerprint na primeira conexão com a máquina ou simplesmente declarar via variável de ambiente:

```bash
export ANSIBLE_HOST_KEY_CHECKING=False
```

Para executar o ansible basta executar o comando:

```bash
ansible-playbook -i hosts playbook.yml
```
