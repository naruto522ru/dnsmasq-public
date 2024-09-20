#!/bin/bash

function cidr2ip {
    # Разделение IP-адреса и маски подсети на отдельные переменные
    IP="${1%/*}"
    MASK="${1#*/}"

    # Количество битов, используемых для маски
    let bits=32-$MASK

    # Конвертация IP-адреса в 32-битное число
    IFS=. read -r i1 i2 i3 i4 <<< "$IP"
    ip=$((i1*256**3+i2*256**2+i3*256+i4))

    # Вычисление первого и последнего IP-адреса в диапазоне
    first=$((ip & ~(2**bits-1)))
    last=$((ip | 2**bits-1))

    # Вывод IP-адресов в диапазоне
    for ((i=$first; i<=$last; i++)); do
        echo $((i>>24)).$(((i>>16)&255)).$(((i>>8)&255)).$((i&255))
    done
}

export -f cidr2ip