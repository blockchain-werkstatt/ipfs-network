#!/bin/bash
ipfs init --empty-repo || true && ipfs daemon --migrate --enable-gc --enable-pubsub-experiment
 