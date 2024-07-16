#!/bin/bash

# Ativar modo de depuração
set -x

# Função para verificar a versão do Go
check_go_version() {
    required_version=$1
    current_version=$(go version | awk '{print $3}' | cut -d 'o' -f 2)

    if [ "$(printf '%s\n' "$required_version" "$current_version" | sort -V | head -n1)" != "$required_version" ]; then
        echo "Go version $required_version or higher is required. Please update your Go installation."
        exit 1
    fi
}

# Função para instalar programas Go
install_go_program() {
    package=$1
    go install -v $package
}

# Instalar dependências de sistema
echo "Installing system dependencies..."
sudo apt update
sudo apt install -y libpcap-dev

# Verificar e instalar subfinder
echo "Installing subfinder..."
check_go_version "1.21"
install_go_program "github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"

# Instalar naabu
echo "Installing naabu..."
sudo apt install -y libpcap-dev
install_go_program "github.com/projectdiscovery/naabu/v2/cmd/naabu@latest"

# Instalar anew
echo "Installing anew..."
install_go_program "github.com/tomnomnom/anew@latest"

# Verificar e instalar httpx
echo "Installing httpx..."
check_go_version "1.21"
install_go_program "github.com/projectdiscovery/httpx/cmd/httpx@latest"

# Verificar e instalar katana
echo "Installing katana..."
check_go_version "1.18"
install_go_program "github.com/projectdiscovery/katana/cmd/katana@latest"

# Instalar unfurl
echo "Installing unfurl..."
install_go_program "github.com/tomnomnom/unfurl@latest"

# Verificar e instalar nuclei
echo "Installing nuclei..."
check_go_version "1.21"
install_go_program "github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"

echo "All programs have been installed successfully."

# Desativar modo de depuração
set +x

