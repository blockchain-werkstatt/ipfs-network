#!/bin/bash
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["http://ipfs-daemon-identity-system-blockchain.okd.fokus.fraunhofer.de", "http://127.0.0.1:5001", "https://webui.ipfs.io"]'
ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST"]'