#!/usr/bin/env bash

shopt -s expand_aliases

alias grey-grep="GREP_COLOR='1;30' grep -E --color=always --line-buffered"
alias red-grep="GREP_COLOR='1;31' grep -E --color=always --line-buffered"
alias green-grep="GREP_COLOR='1;32' grep -E --color=always --line-buffered"
alias yellow-grep="GREP_COLOR='1;33' grep -E --color=always --line-buffered"
alias cyan-grep="GREP_COLOR='1;36' grep -E --color=always --line-buffered"

tail -1000f /var/log/apache2/error.log | grey-grep ".*PerformanceLogger.*|$" | cyan-grep "INFO|$" | yellow-grep "WARN|$" | red-grep "[ERROR].*|[FATAL].*|$" | green-grep "***|$"