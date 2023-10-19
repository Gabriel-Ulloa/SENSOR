#!/bin/bash

semana="week"

dias=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday")

mkdir "$semana"

for dia in "${dias[@]}"; do
    mkdir -p "$semana/$dia"
done


date +%a