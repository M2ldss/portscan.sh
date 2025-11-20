#!/bin/bash 

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [$# -eq 0]; then
    echo -e "${RED}Erro: Forneça um IP como argumento${NC}"
    echo "Uso: $0 <IP>"
    exit 1
fi
target=$1

Ports_TCP(
    21   22   23   25   53   80   110  111  135  139
    143  443  445  993  995  1433 1521 1723 2049 3306
    3389 5432 5900 6379 8080 8443 9092 9200 27017
)
Ports_UDP(
    21   22   23   25   53   80   110  111  135  139
    143  443  445  993  995  1433 1521 1723 2049 3306
    3389 5432 5900 6379 8080 8443 9092 9200 27017
)

echo -e "${YELLOW}Iniciando scan TCP para $TARGET${NC}"
echo "=========================================="

test_tcp_port() {
    local port=$1
    if timeout 2 bash -c "echo > /dev/tcp/$TARGET/$port" 2>/dev/null; then
        echo -e "${GREEN}Porta TCP $port - ABERTA${NC}"
    fi
}

for port in "${PORTS_TCP[@]}"; do
    teste_tcp_port $port &
done

wait

echo "=========================================="
echo -e "${YELLOW}Scan Finalizado${NC}"