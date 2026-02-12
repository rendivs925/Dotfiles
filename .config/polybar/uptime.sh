#!/bin/bash

uptime -p | sed 's/up/UP/' | sed 's/,/ /'
