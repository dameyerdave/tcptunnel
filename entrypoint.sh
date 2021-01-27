#!/bin/sh

/usr/bin/tcptunnel --local-port $LPORT --remote-port $RPORT --remote-host $RHOST --bind-address $LHOST --fork --stay-alive